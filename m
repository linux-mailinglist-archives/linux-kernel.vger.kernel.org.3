Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D15886AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiHCE4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiHCEzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:55:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182F1EEF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:55:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so15365080ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+Bg0/hzsBzeEaLnlFG2eVMC0fwiochhIwopQzSHlnF0=;
        b=eXDLsAVi/qU1zwxx8B+F0X+D+uS8Icx3KGjuoQGmVeTuQrrZAqrbiPuhXsopeqNeVm
         j/tYZjbvtabwAsrunXdo3L4/fXm6LKx+LPQhy7ZqgO9wvD2ZwRfF3AAsCJo8euubmLVR
         A3iEtpZWGBPylaGUwwi/f2PovMqqnanUiMVua4RcphStKfEE0OCdTmts7IvhcA2bA9wS
         HaQbPBmBgI73+3EPN1AZlUKU31qAeHpMVjCNLYzyDhQpj8aU5zkFjg32LgHl2+y76xNN
         tLK71zhkvBXQawus6FuQUTLgrTena8AgJKoDCKhEJq60DLc4TiOJfFOqcaA+dsaCwzmV
         XCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+Bg0/hzsBzeEaLnlFG2eVMC0fwiochhIwopQzSHlnF0=;
        b=LupabcbbCAAQKNN+MSxOrURJcxAakGVgGZ1F1R3doJX0GdDwVVUvsa+QiZYCz3vMoq
         Otn1TMsH76Z7VgtnbufJhu/9yA6n4DZczNerAGkEKjjwoHSWIvzphnLVPTMr95E+b5Hu
         S18+n5vZ/G+ha5cWNk/xNhfAymY9taOfaTASwwPiCDOoqnyG3XEejLVy6sBdz5QXUXQo
         xyS2hpHMKyRU/i+7fG8nJbhoikUVFIT6DR9k4aHbkpGoFj2ETqRx22OjNVSvmqsQCYqP
         Wtn88yDs/uxeUcrpWCDbCycisXMOgT1uOwHrf8/0O/VFlk/EdbviOpOW0b1b36bx0SmR
         wFHw==
X-Gm-Message-State: ACgBeo3sk0x80wqywPXKr8atNRXTZsW2FHPA/P/AnGQf30qPPxywtMkb
        B0HpwxlxrKdZmJYDtX92ehd4kWtyDgAB
X-Google-Smtp-Source: AA6agR5fktHznQTjXzLBMcM42kVafR5wFMM1GP/zbZInJn3lE/bJYQe8cUiuKFOcJ3KpnwZkYFUEDQ==
X-Received: by 2002:a17:902:7d89:b0:16e:f604:31b8 with SMTP id a9-20020a1709027d8900b0016ef60431b8mr10547529plm.0.1659502548236;
        Tue, 02 Aug 2022 21:55:48 -0700 (PDT)
Received: from localhost ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id n6-20020a1709026a8600b0015e8d4eb1f7sm657499plk.65.2022.08.02.21.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:55:47 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     jasowang@redhat.com, mst@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v5 3/5] vduse: Support using userspace pages as bounce buffer
Date:   Wed,  3 Aug 2022 12:55:21 +0800
Message-Id: <20220803045523.23851-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803045523.23851-1-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
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

