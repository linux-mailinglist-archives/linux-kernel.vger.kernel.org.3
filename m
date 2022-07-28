Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF2583773
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiG1DUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiG1DU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01974B0D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4341925pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Bg0/hzsBzeEaLnlFG2eVMC0fwiochhIwopQzSHlnF0=;
        b=dGpaWClmzvLojQU/61Gywm4ksLFfjnQAHGHeK6sb/0gffYPi+EM8PeXQTpVea8EJHk
         6918duRCavy/V/rYMws56Zqf05jUHxZ67lK7uHl0SXgEP7jw8IjbytNNhGz/ht2J46eS
         /eJrHAaumrvNDlmBK7TMrjb/NvLSEZlHeMR3jSQXj+0kR+laczy7KvB/Q4gMiWYq6Mnv
         bIeDRvT+6BjcP9FWmhYOaI1bU3ZdxMx2tHkQ9MPcpYTUunnPO1gdALm35z4Me8XfL8bu
         Bg6fHWBGGoU6VCHv1azGjwdDc0nCrTgeO9bfQ9+AhNwgBBiXIHPfwPZZzNTvwIbZCrDs
         6F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Bg0/hzsBzeEaLnlFG2eVMC0fwiochhIwopQzSHlnF0=;
        b=c+YDYkxX+J6ui3sHvANA+5QNZOGQKB36B2+wRsYNGrWRiEBi2RrhbVFfSp2zQIMb+g
         1O6W3Oyz9fRc2D7GOwYVfCkNn8XLRQpvK/QNUuXgoRKNfNOfxj7t4rugCNrsBt4HQxCn
         u36aXk65ArhRKxSRPMG4LMMfSDzeCtbomG8MLgWQS5Ff2lXPesLHS4ThnU9SmqLR51ia
         VXO7IgnWnWkTFHKGVDE04zv8861GekLZgoYTediom/mdpAb+IlQBbqxyBPAeRH+TrQh4
         Y2ybxzX+p6jzGx2lxz5igrOxWnMivqyh1x0AXRT0iskRfqzhJZxVTsYoV+NwlIjd42KR
         oExA==
X-Gm-Message-State: AJIora+3O2yP6WyzXK9JR5mYr6rDQQyq9XUulvd/d933ldbRwef5i31I
        1jjPf/1hRqVbhjtkrAH7OR5s
X-Google-Smtp-Source: AGRyM1vs+EQNY/pX6JsXUYkBAXtpgtyKLC79IQD3IP1seqqsCaCJ4qI11IZghetZVcpYpJA4kdfbFQ==
X-Received: by 2002:a17:90b:3b82:b0:1f0:73e1:8426 with SMTP id pc2-20020a17090b3b8200b001f073e18426mr7855821pjb.209.1658978426226;
        Wed, 27 Jul 2022 20:20:26 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 7-20020a620507000000b005289f594326sm14668238pff.69.2022.07.27.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:20:25 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] vduse: Support using userspace pages as bounce buffer
Date:   Thu, 28 Jul 2022 11:19:58 +0800
Message-Id: <20220728032000.127-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728032000.127-1-xieyongji@bytedance.com>
References: <20220728032000.127-1-xieyongji@bytedance.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
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

