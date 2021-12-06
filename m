Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00BE468FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhLFDiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236487AbhLFDiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638761682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHcZ4LUc5tD1QYK+8oGSZ7WM0x+4I9RIakYH3yFI7AQ=;
        b=FA2+4yjKJ5kSst0r7RB6fsNno1Pt4k/fs1dNtlrLSA5iwUfIoOpmZ6tv0i0ZHPPnyvdVOa
        hkJ/IECVDpubD/muEGwRl8MCdrxcvIfEsKT8rDPpHUBPZWS+AEj7Mow/jNFTnXBQy7X0sM
        Gdwkrktk1eQzGf9bdzaVYRpXFTTCQ90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-zRGYNl1NOqOpfk-hrXTYzA-1; Sun, 05 Dec 2021 22:34:39 -0500
X-MC-Unique: zRGYNl1NOqOpfk-hrXTYzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF7A8042E1;
        Mon,  6 Dec 2021 03:34:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50D655BAE2;
        Mon,  6 Dec 2021 03:34:31 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com
Subject: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on offlined nodes
Date:   Sun,  5 Dec 2021 22:33:38 -0500
Message-Id: <20211206033338.743270-3-npache@redhat.com>
In-Reply-To: <20211206033338.743270-1-npache@redhat.com>
References: <20211206033338.743270-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have run into a panic caused by a shrinker allocation being attempted
on an offlined node.

Our crash analysis has determined that the issue originates from trying
to allocate pages on an offlined node in expand_one_shrinker_info. This
function makes the incorrect assumption that we can allocate on any node.
To correct this we make sure we only itterate over online nodes.

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

We also correct this behavior in alloc_shrinker_info, free_shrinker_info,
and reparent_shrinker_deferred.

Fixes: 2bfd36374edd ("mm: vmscan: consolidate shrinker_maps handling code")
Fixes: 0a4465d34028 ("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..731564b61e3f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -221,7 +221,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int nid;
 	int size = map_size + defer_size;
 
-	for_each_node(nid) {
+	for_each_online_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
@@ -256,7 +256,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 	struct shrinker_info *info;
 	int nid;
 
-	for_each_node(nid) {
+	for_each_online_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = rcu_dereference_protected(pn->shrinker_info, true);
 		kvfree(info);
@@ -274,7 +274,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	map_size = shrinker_map_size(shrinker_nr_max);
 	defer_size = shrinker_defer_size(shrinker_nr_max);
 	size = map_size + defer_size;
-	for_each_node(nid) {
+	for_each_online_node(nid) {
 		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
 		if (!info) {
 			free_shrinker_info(memcg);
@@ -417,7 +417,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 
 	/* Prevent from concurrent shrinker_info expand */
 	down_read(&shrinker_rwsem);
-	for_each_node(nid) {
+	for_each_online_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
 		for (i = 0; i < shrinker_nr_max; i++) {
-- 
2.33.1

