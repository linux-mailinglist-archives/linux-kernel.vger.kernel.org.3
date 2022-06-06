Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F253E3C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiFFImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiFFIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927E14FC67
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6b3MXuQh7jibWh2fry5PjeJCVzizfhoHgFIUHZ3584=;
        b=FI79vBYWuvOsKx8mfiimDOfvRwgDb4pZCJ4/PrGOYUb+7SoJRP8zOFMJl24IVmS/LRZtjn
        9rypK2Do54SyCFGAE4N7SqFMCUUAqVrr5O1rph0RosiJBNjlTh174l3jXqR+AS54ML7qIO
        wKFWgpRO950eBXtBpZlqtHRVTYNq/Bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-S9oXEJ7aOYmzlAcPWRBeOg-1; Mon, 06 Jun 2022 04:39:42 -0400
X-MC-Unique: S9oXEJ7aOYmzlAcPWRBeOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98C8D811E75;
        Mon,  6 Jun 2022 08:39:41 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E20D1121315;
        Mon,  6 Jun 2022 08:39:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, urezki@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/5] mm/vmalloc: Add code comment for find_vmap_area_exceed_addr()
Date:   Mon,  6 Jun 2022 16:39:08 +0800
Message-Id: <20220606083909.363350-5-bhe@redhat.com>
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

Its behaviour is like find_vma() which finds an area above the specified
address, add comment to make it easier to understand.

And also fix two places of grammer mistake/typo.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 11dfc897de40..860ed9986775 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -790,6 +790,7 @@ unsigned long vmalloc_nr_pages(void)
 	return atomic_long_read(&nr_vmalloc_pages);
 }
 
+/* Look up the first VA which satisfies  addr < va_end,  NULL if none. */
 static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
 {
 	struct vmap_area *va = NULL;
@@ -929,7 +930,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
 		 * Some explanation here. Just perform simple insertion
 		 * to the tree. We do not set va->subtree_max_size to
 		 * its current size before calling rb_insert_augmented().
-		 * It is because of we populate the tree from the bottom
+		 * It is because we populate the tree from the bottom
 		 * to parent levels when the node _is_ in the tree.
 		 *
 		 * Therefore we set subtree_max_size to zero after insertion,
@@ -1659,7 +1660,7 @@ static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
 
 /*
  * Serialize vmap purging.  There is no actual critical section protected
- * by this look, but we want to avoid concurrent calls for performance
+ * by this lock, but we want to avoid concurrent calls for performance
  * reasons and to make the pcpu_get_vm_areas more deterministic.
  */
 static DEFINE_MUTEX(vmap_purge_lock);
-- 
2.34.1

