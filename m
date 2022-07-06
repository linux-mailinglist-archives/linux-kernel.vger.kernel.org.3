Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404B567D99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiGFFGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiGFFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:06:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9EC192A6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:06:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so10164273pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhASuSf86HbeQ+sQa6ckHpYaDHR8uGVnKtFMqMlSbWE=;
        b=qcWqV3VkYF3MqYwNMEVHm0iHHIyXGMupi8rCrBULB+y0HCFpzCxHfVfdNpu0noUbkH
         50SbmiNeeusRxdiBT9HpiVbgg6Z9rCogucIAr1Hg8xJtmRTM2cXFIrlGpOXS4eKS7NSC
         jxHuMVRVOgjvkqZ78+4ANyNXDuntycbvgqFIDNVoQUsKS971b680/ES2N7iDDj0B+4l8
         sYRTvrun2wDP3GrZ3XOG8QlP8P4nYdgBZom79XPvJlUq3zEL4VWB+4o7NtZhA2E+W3/0
         YCLCWEWhbwSfkSHo8rqUubPMlNauPq5GKaXPZXrBvPmte1wX5youDLwS0kjY42TTsScK
         0f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhASuSf86HbeQ+sQa6ckHpYaDHR8uGVnKtFMqMlSbWE=;
        b=B6cmkIH1Vsw8ypZ4AQkWFQJbz69XnFbAqeTNmPmBTU+e5xXxmZ7FpzzUyFjTSm9i/n
         ItwD3vSxoMhr7DpSZVl1M67C8MTI+tmGIcmqsdjL0B615GPEzscEZO5YeMvoF+aO5rG2
         bBBlShnHxNjjIkyX328X7Nz/Tq9TcbgczQEtl5OSflxQ6myOm5LzCtrQ/X2bT6Juo5FN
         lLffImSM3H+A9tO9CEWohcQcIC/5iM06C/2E0ZGiDkybFgjQh7Vb38n1BSninzHz5/Mr
         RpZ2m8JC3RE7kVMnxFn1uEGJMGBxJeHKR0+k6TZixtCRyAuPYxZCg25q8jU8U8yGbVcD
         1adg==
X-Gm-Message-State: AJIora+XILU0ujLVAVNGRZe9dFqZLBHhhzSrGDTsS3vcddpQiyBeLNUA
        DQvtppZAcoQ1qod6z0uCyXQv
X-Google-Smtp-Source: AGRyM1spsXCY1vRAQAPIsn23qYYe27tbJyTeDk4DEuDnW4xeHA4ouJ9+jI4AUq8mlaH3zu33skfujw==
X-Received: by 2002:a17:902:f683:b0:16a:6456:5369 with SMTP id l3-20020a170902f68300b0016a64565369mr43483414plg.136.1657083960652;
        Tue, 05 Jul 2022 22:06:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0016be527753bsm5217757plg.264.2022.07.05.22.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 22:06:00 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] vduse: Support using userspace pages as bounce buffer
Date:   Wed,  6 Jul 2022 13:05:01 +0800
Message-Id: <20220706050503.171-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
References: <20220706050503.171-1-xieyongji@bytedance.com>
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

