Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3753E23B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiFFInA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiFFIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34A6E50463
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIGHldPci9ICuMk9MFyx4EfHafP55UPltWCgM3kZNjQ=;
        b=W8UuNCPupKGobPMxyk66yzYqSJ0DJO0iy7J9caLsHPd6iIVE+/5DAzcFzfYF+hS8kt23hm
        qpH+L8L5aIw46UIw27XQUCaQfNGQ3g+bJEBS/EKOPeiYqHoKYqEPH7Z6ASuBFpQrgPslB3
        4HYgelY5xwoa9Lkq4XmO+Dh2h78Hkp0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-wnF2gOc8PN2sykLO-PlFuA-1; Mon, 06 Jun 2022 04:39:38 -0400
X-MC-Unique: wnF2gOc8PN2sykLO-PlFuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAEF3802812;
        Mon,  6 Jun 2022 08:39:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B131121314;
        Mon,  6 Jun 2022 08:39:34 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, urezki@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/5] mm/vmalloc: fix typo in local variable name
Date:   Mon,  6 Jun 2022 16:39:07 +0800
Message-Id: <20220606083909.363350-4-bhe@redhat.com>
In-Reply-To: <20220606083909.363350-1-bhe@redhat.com>
References: <20220606083909.363350-1-bhe@redhat.com>
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
---
 mm/vmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c7e1634ff2b9..11dfc897de40 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1673,32 +1673,32 @@ static void purge_fragmented_blocks_allcpus(void);
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

