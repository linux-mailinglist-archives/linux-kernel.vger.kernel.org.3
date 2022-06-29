Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A055FA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiF2I0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiF2I0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4B3CA53
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x20so7815437plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhASuSf86HbeQ+sQa6ckHpYaDHR8uGVnKtFMqMlSbWE=;
        b=ijVNYIep5SiF0mPLPhtKMC8BtZGfnHwrMHTwGw6rvniNAq3EA0x3la2HJ1EINSlXPg
         W5MtgwXuB+lywZklO8gK+VZ1HbHYUK/hmwGN4WajG5VFLHZhLuNB8gRPwORGNnk/Hvuj
         zcKiimI6UsZpzfJ3PR1qtb6BRjkIcqbzmxrruNtCezSRytAsD6POio1R1csCpRAsRuHr
         uPxH9wlXUaoX3TTkssq75UhiH3EQr6wdJj1amsmtijd2z6SSd2p2v8Viyr2Y6d1orScV
         f3qdtE1nqBRVY2cemDuXZ9vc8xgZCWs6gJBAhWqysBxWcaoARYbQFEbPB9YE81cRuX2k
         5RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhASuSf86HbeQ+sQa6ckHpYaDHR8uGVnKtFMqMlSbWE=;
        b=jo/01WhZ01gaeNZFZZb8FymDktW+vo4AF3sPeyX1+P3rhJgDcc5tcJu86RLp5/ZZvu
         HjKeG2Ps6OdZ9M7mnRKLinVM1l9BNKweWa317xBGKGz/u7NVtiuhlM4WWpswUDyAOTl6
         iSTToPpopllvKimQWY+U4f6mK0sCy05rbF56xPQwJ7tsWeYqww4XA+H9zjQ6hhhrEeAv
         jhm7nktpFX2jesRgvNDsVAheRWkL9N4uzjXw+yZQsDoYrlXCsF2ntDYnPOp2tlF9iMSM
         WZ9q/1aqiXbsuc9fH8YY/Dx74+l07L3VXQ9qayZpTmz9XVRnwW3LvCVZtI4SNZeqlVro
         BxyA==
X-Gm-Message-State: AJIora/BqVqI02inAVj4omiq2GZoX4BVTPiXNjRvGnLRVZaC+Ry+g4yB
        oVhF8F83fRmMoWnR1RZMMvz0
X-Google-Smtp-Source: AGRyM1tIfs3D5R4ysJgznj49WD5wzW8aF0KYh76TiHlwByEtbHIbouE0AjYIZ6eUhmWYXoTNlt3iRQ==
X-Received: by 2002:a17:902:f543:b0:16a:54c6:78d0 with SMTP id h3-20020a170902f54300b0016a54c678d0mr8055604plf.28.1656491201679;
        Wed, 29 Jun 2022 01:26:41 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b0016a11e839fcsm10727725pln.208.2022.06.29.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] vduse: Support using userspace pages as bounce buffer
Date:   Wed, 29 Jun 2022 16:25:38 +0800
Message-Id: <20220629082541.118-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/vdpa/vdpa_user/iova_domain.c | 128 +++++++++++++++++++++++++--
 drivers/vdpa/vdpa_user/iova_domain.h |   9 ++
 2 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 50d7c08d5450..2ae29341228e 100644
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
@@ -243,6 +247,81 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
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
+	ret = -EBUSY;
+	/*
+	 * Make sure nobody maps the kernel bounce pages,
+	 * then we can free them.
+	 */
+	if (domain->mapped)
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
@@ -318,13 +397,18 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
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
@@ -336,10 +420,12 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 {
 	struct iova_domain *iovad = &domain->stream_iovad;
 
+	read_lock(&domain->bounce_lock);
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
 		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
 
 	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
+	read_unlock(&domain->bounce_lock);
 	vduse_domain_free_iova(iovad, dma_addr, size);
 }
 
@@ -404,6 +490,24 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	free_pages_exact(phys_to_virt(pa), size);
 }
 
+static void vduse_domain_mmap_open(struct vm_area_struct *vma)
+{
+	struct vduse_iova_domain *domain = vma->vm_private_data;
+
+	write_lock(&domain->bounce_lock);
+	domain->mapped++;
+	write_unlock(&domain->bounce_lock);
+}
+
+static void vduse_domain_mmap_close(struct vm_area_struct *vma)
+{
+	struct vduse_iova_domain *domain = vma->vm_private_data;
+
+	write_lock(&domain->bounce_lock);
+	domain->mapped--;
+	write_unlock(&domain->bounce_lock);
+}
+
 static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
 {
 	struct vduse_iova_domain *domain = vmf->vma->vm_private_data;
@@ -427,6 +531,8 @@ static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct vduse_domain_mmap_ops = {
+	.open =	vduse_domain_mmap_open,
+	.close = vduse_domain_mmap_close,
 	.fault = vduse_domain_mmap_fault,
 };
 
@@ -438,6 +544,10 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_private_data = domain;
 	vma->vm_ops = &vduse_domain_mmap_ops;
 
+	write_lock(&domain->bounce_lock);
+	domain->mapped++;
+	write_unlock(&domain->bounce_lock);
+
 	return 0;
 }
 
@@ -447,7 +557,8 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
 
 	spin_lock(&domain->iotlb_lock);
 	vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
-	vduse_domain_free_bounce_pages(domain);
+	vduse_domain_remove_user_bounce_pages(domain);
+	vduse_domain_free_kernel_bounce_pages(domain);
 	spin_unlock(&domain->iotlb_lock);
 	put_iova_domain(&domain->stream_iovad);
 	put_iova_domain(&domain->consistent_iovad);
@@ -507,6 +618,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 		goto err_file;
 
 	domain->file = file;
+	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
 			PAGE_SIZE, IOVA_START_PFN);
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 2722d9b8e21a..4a47615346ac 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -14,6 +14,7 @@
 #include <linux/iova.h>
 #include <linux/dma-mapping.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/rwlock.h>
 
 #define IOVA_START_PFN 1
 
@@ -34,6 +35,9 @@ struct vduse_iova_domain {
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
 	struct file *file;
+	int mapped;
+	bool user_bounce_pages;
+	rwlock_t bounce_lock;
 };
 
 int vduse_domain_set_map(struct vduse_iova_domain *domain,
@@ -61,6 +65,11 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 
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

