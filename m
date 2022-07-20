Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BEE57B016
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiGTEmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiGTEmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD20691C5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j12so13899129plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeWgvHDRHWZn+DoRaxWOIjRe7JEa4Bj9/yuG68KCgS0=;
        b=Bdwy4IdoCQI1l+5CqJbESqz0Tmo3v/4ux/jcvzj+eiCUlka2MC2zeeAydN4bRz32S3
         09s1n7dg3WXU9uGDITjEaoiobD5BJJSvKHNjkDBgBwD+UcbREGZmzpRJq7Lg+arqTLZC
         NKAvxoDof5f1CdgPUIilEjNPanqLu6q2Koe6xzb4BnEvDeP75vDipVmJ3xL//wM0/+Fb
         5QIrzSAeZfna7Y60jsC8c3fji1ffAX4dUHLdOXjDgAdyhxjR3WxhpSbfcUSGYdUqOVQ3
         DKqL3MI2ufKUD07psKJL0DqJsGRy+2TFju4maETpCcG0O7V3RkbKAi9w+CU5QSFEtqP9
         mYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeWgvHDRHWZn+DoRaxWOIjRe7JEa4Bj9/yuG68KCgS0=;
        b=1W8fDrmktgHncOFM0Bj1l27tiQJAzpO6T5y/hoKHWETl1xtsnKu0Y9+ZkT1/ZsLo+7
         cTSUn8zmDK90rVNp9cI1ezQ/exZob9YdqSNRjNkikSzUDFv0IXrtWECs8F2j5b9tUeS1
         HqJGD6otyWwrqXGEgontjGtFQ6OqC4mraZepxmX7AjLFM8GKmvVkxqYeZK2L7851ktLz
         ny4fdRSY4dRDlgObHaDnHP3xhsW6EFQkKdsZ91EYQeqPhI4+YCux4JKvm/5tSBNVX5ti
         ouKH9nsjOAJY4BrbEnYUli6gLY4g1v8r6TaeBMeMyQXSX0JUYT3zivNxtQvqD4nPRrPC
         b5Cg==
X-Gm-Message-State: AJIora9TlQByE5dS9pmePXsAqKz9KCjNouQBJVlLoTssVpIrubOPLetJ
        PMVdNOxlfhDU8rV4/j8hANtK
X-Google-Smtp-Source: AGRyM1tPfnqbVqOQ4Rfd/JdhNMcY5p7IuErHd9seobSWd/lMrJty//OtMqcFKBMLKKH79eHTgzQqwA==
X-Received: by 2002:a17:903:18b:b0:16c:4026:610 with SMTP id z11-20020a170903018b00b0016c40260610mr37226332plg.122.1658292134774;
        Tue, 19 Jul 2022 21:42:14 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b00525442ac579sm12373748pfl.212.2022.07.19.21.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:14 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] vduse: Support using userspace pages as bounce buffer
Date:   Wed, 20 Jul 2022 12:41:42 +0800
Message-Id: <20220720044144.90-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720044144.90-1-xieyongji@bytedance.com>
References: <20220720044144.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce two APIs: vduse_domain_add_user_bounce_pages()
and vduse_domain_remove_user_bounce_pages() to support
adding and removing userspace pages for bounce buffers.
During adding and removing, the DMA data would be copied
from the kernel bounce pages to the userspace bounce pages
and back.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 96 +++++++++++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.h |  8 +++
 2 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 50d7c08d5450..e682bc7ee6c9 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -178,8 +178,9 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 			    map->orig_phys == INVALID_PHYS_ADDR))
 			return;
 
-		addr = page_address(map->bounce_page) + offset;
-		do_bounce(map->orig_phys + offset, addr, sz, dir);
+		addr = kmap_local_page(map->bounce_page);
+		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
+		kunmap_local(addr);
 		size -= sz;
 		iova += sz;
 	}
@@ -210,20 +211,23 @@ static struct page *
 vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 {
 	struct vduse_bounce_map *map;
-	struct page *page;
+	struct page *page = NULL;
 
+	read_lock(&domain->bounce_lock);
 	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-	if (!map->bounce_page)
-		return NULL;
+	if (domain->user_bounce_pages || !map->bounce_page)
+		goto out;
 
 	page = map->bounce_page;
 	get_page(page);
+out:
+	read_unlock(&domain->bounce_lock);
 
 	return page;
 }
 
 static void
-vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
+vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 {
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
@@ -243,6 +247,73 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
 	}
 }
 
+int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
+				       struct page **pages, int count)
+{
+	struct vduse_bounce_map *map;
+	int i, ret;
+
+	/* Now we don't support partial mapping */
+	if (count != (domain->bounce_size >> PAGE_SHIFT))
+		return -EINVAL;
+
+	write_lock(&domain->bounce_lock);
+	ret = -EEXIST;
+	if (domain->user_bounce_pages)
+		goto out;
+
+	for (i = 0; i < count; i++) {
+		map = &domain->bounce_maps[i];
+		if (map->bounce_page) {
+			/* Copy kernel page to user page if it's in use */
+			if (map->orig_phys != INVALID_PHYS_ADDR)
+				memcpy_to_page(pages[i], 0,
+					       page_address(map->bounce_page),
+					       PAGE_SIZE);
+			__free_page(map->bounce_page);
+		}
+		map->bounce_page = pages[i];
+		get_page(pages[i]);
+	}
+	domain->user_bounce_pages = true;
+	ret = 0;
+out:
+	write_unlock(&domain->bounce_lock);
+
+	return ret;
+}
+
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
+{
+	struct vduse_bounce_map *map;
+	unsigned long i, count;
+
+	write_lock(&domain->bounce_lock);
+	if (!domain->user_bounce_pages)
+		goto out;
+
+	count = domain->bounce_size >> PAGE_SHIFT;
+	for (i = 0; i < count; i++) {
+		struct page *page = NULL;
+
+		map = &domain->bounce_maps[i];
+		if (WARN_ON(!map->bounce_page))
+			continue;
+
+		/* Copy user page to kernel page if it's in use */
+		if (map->orig_phys != INVALID_PHYS_ADDR) {
+			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
+			memcpy_from_page(page_address(page),
+					 map->bounce_page, 0, PAGE_SIZE);
+		}
+		put_page(map->bounce_page);
+		map->bounce_page = page;
+	}
+	domain->user_bounce_pages = false;
+out:
+	write_unlock(&domain->bounce_lock);
+}
+
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
 {
 	if (!domain->bounce_map)
@@ -318,13 +389,18 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 	if (vduse_domain_init_bounce_map(domain))
 		goto err;
 
+	read_lock(&domain->bounce_lock);
 	if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
-		goto err;
+		goto err_unlock;
 
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
 		vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
 
+	read_unlock(&domain->bounce_lock);
+
 	return iova;
+err_unlock:
+	read_unlock(&domain->bounce_lock);
 err:
 	vduse_domain_free_iova(iovad, iova, size);
 	return DMA_MAPPING_ERROR;
@@ -336,10 +412,12 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 {
 	struct iova_domain *iovad = &domain->stream_iovad;
 
+	read_lock(&domain->bounce_lock);
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
 		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
 
 	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
+	read_unlock(&domain->bounce_lock);
 	vduse_domain_free_iova(iovad, dma_addr, size);
 }
 
@@ -447,7 +525,8 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
 
 	spin_lock(&domain->iotlb_lock);
 	vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
-	vduse_domain_free_bounce_pages(domain);
+	vduse_domain_remove_user_bounce_pages(domain);
+	vduse_domain_free_kernel_bounce_pages(domain);
 	spin_unlock(&domain->iotlb_lock);
 	put_iova_domain(&domain->stream_iovad);
 	put_iova_domain(&domain->consistent_iovad);
@@ -507,6 +586,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 		goto err_file;
 
 	domain->file = file;
+	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
 			PAGE_SIZE, IOVA_START_PFN);
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 2722d9b8e21a..4e0e50e7ac15 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -14,6 +14,7 @@
 #include <linux/iova.h>
 #include <linux/dma-mapping.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/rwlock.h>
 
 #define IOVA_START_PFN 1
 
@@ -34,6 +35,8 @@ struct vduse_iova_domain {
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
 	struct file *file;
+	bool user_bounce_pages;
+	rwlock_t bounce_lock;
 };
 
 int vduse_domain_set_map(struct vduse_iova_domain *domain,
@@ -61,6 +64,11 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
+int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
+				       struct page **pages, int count);
+
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain);
+
 void vduse_domain_destroy(struct vduse_iova_domain *domain);
 
 struct vduse_iova_domain *vduse_domain_create(unsigned long iova_limit,
-- 
2.20.1

