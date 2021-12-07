Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAC46C7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbhLGWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232475AbhLGWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638916850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIhkMCJnn2yFvoJxZaF9lAiC+isHKZni958UvtYyAek=;
        b=hXZjgvxZQZqh9Zo05+pdpgqzbeE0134EjvtDYFctDALRVKD0T118Gd7IiY3Ej9h0pnYovP
        no67bXmnDohspr9ojft9nK/VnjhqycKAtxq0rDGeYX7gNT8MhbImVW4WPNRNsIJQEelzOa
        P1UhOonzLJrVLJSvjFUefWg8FZ7wXJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-nbOMdyCZNRORpIXZ-gTCZw-1; Tue, 07 Dec 2021 17:40:45 -0500
X-MC-Unique: nbOMdyCZNRORpIXZ-gTCZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2148102CB73;
        Tue,  7 Dec 2021 22:40:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.32.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1072A19C59;
        Tue,  7 Dec 2021 22:40:41 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, mhocko@suse.com, david@redhat.com
Subject: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on offlined nodes
Date:   Tue,  7 Dec 2021 17:40:13 -0500
Message-Id: <20211207224013.880775-2-npache@redhat.com>
In-Reply-To: <20211207224013.880775-1-npache@redhat.com>
References: <20211207224013.880775-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have run into a panic caused by a shrinker allocation being attempted
on an offlined node.

Our crash analysis has determined that the issue originates from trying
to allocate pages on an offlined node in expand_one_shrinker_info. This
function makes the incorrect assumption that we can allocate on any node.
To correct this we make sure the node is online before tempting an
allocation. If it is not online choose the closest node.

This assumption can lead to an incorrect address being assigned to ac->zonelist
in the following callchain:
	__alloc_pages
	-> prepare_alloc_pages
	 -> node_zonelist

static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
{
        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
}
if the node is not online the return of node_zonelist will evaluate to a
invalid pointer of 0x00000 + offset_of(node_zonelists) + (1|0)

This address is then dereferenced further down the callchain in:
	prepare_alloc_pages
	-> first_zones_zonelist
  	 -> next_zones_zonelist
	  -> zonelist_zone_idx

static inline int zonelist_zone_idx(struct zoneref *zoneref)
{
        return zoneref->zone_idx;
}

Leading the system to panic.

[  362.132167] BUG: unable to handle page fault for address: 0000000000002088
[  362.139854] #PF: supervisor read access in kernel mode
[  362.145595] #PF: error_code(0x0000) - not-present page
[  362.151334] PGD 0 P4D 0
[  362.154166] Oops: 0000 [#1] SMP PTI
[  362.158064] CPU: 62 PID: 16612 Comm: stress-ng Kdump:
[  362.167876] Hardware name:
[  362.179917] RIP: 0010:prepare_alloc_pages.constprop.0+0xc6/0x150
[  362.207604] RSP: 0018:ffffb4ba31427bc0 EFLAGS: 00010246
[  362.213443] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000081
[  362.221412] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
[  362.229380] RBP: ffffb4ba31427bf8 R08: 0000000000000000 R09: ffffb4ba31427bf4
[  362.237347] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb4ba31427bf0
[  362.245316] R13: 0000000000000002 R14: ffff9f2fb3788000 R15: 0000000000000078
[  362.253285] FS:  00007fbc57bfd740(0000) GS:ffff9f4c7d780000(0000) knlGS:0000000000000000
[  362.262322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  362.268739] CR2: 0000000000002088 CR3: 000002004cb58002 CR4: 00000000007706e0
[  362.276707] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  362.284675] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  362.292644] PKRU: 55555554
[  362.295669] Call Trace:
[  362.298402]  __alloc_pages+0x9d/0x210
[  362.302501]  kmalloc_large_node+0x40/0x90
[  362.306988]  __kmalloc_node+0x3ac/0x480
[  362.311279]  kvmalloc_node+0x46/0x80
[  362.315276]  expand_one_shrinker_info+0x84/0x190
[  362.320437]  prealloc_shrinker+0x166/0x1c0
[  362.325015]  alloc_super+0x2ba/0x330
[  362.329011]  ? __fput_sync+0x30/0x30
[  362.333003]  ? set_anon_super+0x40/0x40
[  362.337288]  sget_fc+0x6c/0x2f0
[  362.340798]  ? mqueue_create+0x20/0x20
[  362.344992]  get_tree_keyed+0x2f/0xc0
[  362.349086]  vfs_get_tree+0x25/0xb0
[  362.352982]  fc_mount+0xe/0x30
[  362.356397]  mq_init_ns+0x105/0x1a0
[  362.360291]  copy_ipcs+0x129/0x220
[  362.364093]  create_new_namespaces+0xa1/0x2e0
[  362.368960]  unshare_nsproxy_namespaces+0x55/0xa0
[  362.374216]  ksys_unshare+0x198/0x380
[  362.378310]  __x64_sys_unshare+0xe/0x20
[  362.382595]  do_syscall_64+0x3b/0x90
[  362.386597]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  362.392247] RIP: 0033:0x7fbc57d14d7b
[  362.417204] RSP: 002b:00007fbc4dc73f88 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
[  362.425664] RAX: ffffffffffffffda RBX: 0000560144b09578 RCX: 00007fbc57d14d7b
[  362.433634] RDX: 0000000000000010 RSI: 00007fbc4dc73f90 RDI: 0000000008000000
[  362.441602] RBP: 0000560144b095a0 R08: 0000000000000000 R09: 0000000000000000
[  362.449573] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fbc4dc73f90
[  362.457542] R13: 000000000000006a R14: 0000560144e7e5a0 R15: 00007fff5dec8e10

Fixes: 86daf94efb11 ("mm/memcontrol.c: allocate shrinker_map on appropriate NUMA node")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..5ed5b5d29d47 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int size = map_size + defer_size;
 
 	for_each_node(nid) {
+		int tmp = nid;
 		pn = memcg->nodeinfo[nid];
 		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
 
-		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
+		if(!node_online(nid))
+			tmp = numa_mem_id();
+		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
 		if (!new)
 			return -ENOMEM;
 
-- 
2.33.1

