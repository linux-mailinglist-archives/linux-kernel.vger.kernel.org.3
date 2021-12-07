Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E846B142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhLGDMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbhLGDMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638846519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=D3SDEWRMNKNX06llp/mTlJpG6I82/0kSJ3d1s90jnG4=;
        b=P3TgEz5tR0paIMhajD6FN3ZPYnYSwrNsSpf38bxNohqeif/bcWB2Md/iOdJtaZXxFubF52
        SnZ1ph1cVIs2rsPvhxYQqZpbxEZpwi/IRrOSXG8cu+I7zS938fWfk5Lbp4yp384g84ikK2
        fkHOiwqVq7d2GbPDpmk1UiNjra1PbVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-3m8d_p1ZPM-7q2BkDwEujQ-1; Mon, 06 Dec 2021 22:08:37 -0500
X-MC-Unique: 3m8d_p1ZPM-7q2BkDwEujQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D022B81CCB5;
        Tue,  7 Dec 2021 03:08:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2AB119C59;
        Tue,  7 Dec 2021 03:08:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND v2 5/5] mm/slub: do not create dma-kmalloc if no managed pages in DMA zone
Date:   Tue,  7 Dec 2021 11:07:50 +0800
Message-Id: <20211207030750.30824-6-bhe@redhat.com>
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
References: <20211207030750.30824-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dma-kmalloc will be created as long as CONFIG_ZONE_DMA is enabled.
However, it will fail if DMA zone has no managed pages. The failure
can be seen in kdump kernel of x86_64 as below:

 kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0                          
 CPU: 0 PID: 36 Comm: kworker/u2:2 Not tainted 5.16.0-rc3+ #6
 Hardware name: Dell Inc. PowerEdge R815/06JC9T, BIOS 3.2.2 09/15/2014
 Workqueue: events_unbound async_run_entry_fn
 Call Trace:
  dump_stack_lvl+0x57/0x72
  warn_alloc.cold+0x72/0xd6
  __alloc_pages_slowpath.constprop.0+0xf56/0xf70
  __alloc_pages+0x23b/0x2b0
  allocate_slab+0x406/0x630
  ___slab_alloc+0x4b1/0x7e0
  ? sr_probe+0x200/0x600
  ? lock_acquire+0xc4/0x2e0
  ? fs_reclaim_acquire+0x4d/0xe0
  ? lock_is_held_type+0xa7/0x120
  ? sr_probe+0x200/0x600
  ? __slab_alloc+0x67/0x90
  __slab_alloc+0x67/0x90
  ? sr_probe+0x200/0x600
  ? sr_probe+0x200/0x600
  kmem_cache_alloc_trace+0x259/0x270
  sr_probe+0x200/0x600
  ......
  bus_probe_device+0x9f/0xb0
  device_add+0x3d2/0x970
  ......
  __scsi_add_device+0xea/0x100
  ata_scsi_scan_host+0x97/0x1d0
  async_run_entry_fn+0x30/0x130
  process_one_work+0x2b0/0x5c0
  worker_thread+0x55/0x3c0
  ? process_one_work+0x5c0/0x5c0
  kthread+0x149/0x170
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30
 Mem-Info:
 ......

The above failure happened when calling kmalloc() to allocate buffer with
GFP_DMA. It requests to allocate slab page from DMA zone while no managed
pages in there.
 sr_probe()
 --> get_capabilities()
     --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);

The DMA zone should be checked if it has managed pages, then try to create
dma-kmalloc.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5d080a93009..ae4ef0f8903a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -878,6 +878,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 {
 	int i;
 	enum kmalloc_cache_type type;
+#ifdef CONFIG_ZONE_DMA
+	bool managed_dma;
+#endif
 
 	/*
 	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
@@ -905,10 +908,16 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 
 #ifdef CONFIG_ZONE_DMA
+	managed_dma = has_managed_dma();
+
 	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
+			if (!managed_dma) {
+				kmalloc_caches[KMALLOC_DMA][i] = kmalloc_caches[KMALLOC_NORMAL][i];
+				continue;
+			}
 			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
 				kmalloc_info[i].name[KMALLOC_DMA],
 				kmalloc_info[i].size,
-- 
2.17.2

