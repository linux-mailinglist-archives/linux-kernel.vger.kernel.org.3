Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB553FCD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiFGLDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbiFGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 121E411173
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654599620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EB7GwryEyDPq35R/651FMtX/rDT7w7U5JPPzzXnqVmY=;
        b=H+sAN0ORtBd6DjdlP2W6iZPKlpmVnrNlpTv4hbTjOg1rmneFKtlF34ojsK9pkBlhr8t1r9
        QvZ9JFbdAe0dX+ESTnfrNH48MmMf+4HrnUKybv7NUfyzP339hczzQm3NkbiIjkhKmCH3mF
        5FdC5uvm383WGmcCtcLTqLvbpMtuFl8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-br1ElAR2O7-tNvwtj7Xspw-1; Tue, 07 Jun 2022 07:00:17 -0400
X-MC-Unique: br1ElAR2O7-tNvwtj7Xspw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BA9A3C01D80;
        Tue,  7 Jun 2022 11:00:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 435181121314;
        Tue,  7 Jun 2022 11:00:12 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, urezki@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/4] mm/vmalloc: fix typo in local variable name
Date:   Tue,  7 Jun 2022 18:59:57 +0800
Message-Id: <20220607105958.382076-4-bhe@redhat.com>
In-Reply-To: <20220607105958.382076-1-bhe@redhat.com>
References: <20220607105958.382076-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __purge_vmap_area_lazy(), rename local_pure_list to local_purge_list.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b711bf82fd5d..b9bf7dfe71ec 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1669,32 +1669,32 @@ static void purge_fragmented_blocks_allcpus(void);
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
 	unsigned long resched_threshold;
-	struct list_head local_pure_list;
+	struct list_head local_purge_list;
 	struct vmap_area *va, *n_va;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
 	spin_lock(&purge_vmap_area_lock);
 	purge_vmap_area_root = RB_ROOT;
-	list_replace_init(&purge_vmap_area_list, &local_pure_list);
+	list_replace_init(&purge_vmap_area_list, &local_purge_list);
 	spin_unlock(&purge_vmap_area_lock);
 
-	if (unlikely(list_empty(&local_pure_list)))
+	if (unlikely(list_empty(&local_purge_list)))
 		return false;
 
 	start = min(start,
-		list_first_entry(&local_pure_list,
+		list_first_entry(&local_purge_list,
 			struct vmap_area, list)->va_start);
 
 	end = max(end,
-		list_last_entry(&local_pure_list,
+		list_last_entry(&local_purge_list,
 			struct vmap_area, list)->va_end);
 
 	flush_tlb_kernel_range(start, end);
 	resched_threshold = lazy_max_pages() << 1;
 
 	spin_lock(&free_vmap_area_lock);
-	list_for_each_entry_safe(va, n_va, &local_pure_list, list) {
+	list_for_each_entry_safe(va, n_va, &local_purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
-- 
2.34.1

