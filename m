Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59B059EAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiHWSUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiHWSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:19:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BBB6F256;
        Tue, 23 Aug 2022 09:36:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x15so13078832pfp.4;
        Tue, 23 Aug 2022 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sHsd8UJitkSZ/06E7cs7tNROVB1mkQZCDyvY2Jg+ha4=;
        b=aDMSJsZdOLMIfhq9hMqJAJGsCd2NG9uT7Y87j/3NTRbwig6fxwUaQVn+X/Yz0CDKJB
         bEueKTMN8ePgcFtiE0TkJ3RgNGIKPrPNUb/hriBZapkE9Qg09s9eMAJG3ACX5r08v6ux
         yXassIf7+70ZKOzp0auTd4ckd6uiq9UGCl+Hb/iN016WIBvS8/kQLv7ruJlQBlDXyIam
         ejoInBmZl1XEMRYKva0VPunKa0CJNeOXmsSU6PczsHjHydTEPwIjEise5QJqj1IAxEhw
         LHLCrFQE/U8eax8b2ZXQOuEKtW/vJRzPQvsj4AjvQivb9aLhbjwEJk7kJ9O73+zNERIz
         AzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sHsd8UJitkSZ/06E7cs7tNROVB1mkQZCDyvY2Jg+ha4=;
        b=qrSE9RGk9wS/9HIuSbtMNqRRXk/vtRoMaRGb1YMbUIDDZG+yM0PfE35JXNpJv2SMOJ
         0WaypZT88mjZ5bwIqOFhGIJqCo7kK4wFwija/esdnH4BIpnpYoztlJyTUp/VQih2G6JC
         +ZAE9sIoyVuP9nCxGzSJhQf9HrcqMM7YpxyhXxNWbp58dqRR4RwxT4438CPHrxgyAVCf
         LvkSdGHh+EvbrAfZjKho/aQCZ0CHTYgw763QxiF13ry9v8quxz28jaSRGQwl+JuQRVaW
         iDqNj5N9KSaLRdGRkirss9MAggRYnj6gOy4h9qTzk4eM3VwBd+AXsas2DTJSIuGR4MYq
         9+tw==
X-Gm-Message-State: ACgBeo2SJ0ukDNMx4PwhzZqAcbGZ3QQkWASTwiuYm6tNyMR13KS0I0ES
        XT02cKqt4FdnsQdloQYN1Ns=
X-Google-Smtp-Source: AA6agR7qTRzNhhRnEQPc//A/W8Gaflk+Qm332922fuNeVJHFKAc+LSxR8+zjVo5aYzlLh8KUGiX4kg==
X-Received: by 2002:a63:69c7:0:b0:41c:590a:62dc with SMTP id e190-20020a6369c7000000b0041c590a62dcmr20512812pgc.388.1661272597844;
        Tue, 23 Aug 2022 09:36:37 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b00172973d3cd9sm10853077plg.55.2022.08.23.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:36:37 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/iommu: optimize map/unmap
Date:   Tue, 23 Aug 2022 09:37:19 -0700
Message-Id: <20220823163719.90399-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Using map_pages/unmap_pages cuts down on the # of pgtable walks needed
in the process of finding where to insert/remove an entry.  The end
result is ~5-10x faster than mapping a single page at a time.

v2: Rename iommu_pgsize(), drop obsolete comments, fix error handling
    in msm_iommu_pagetable_map()

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 101 +++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index a54ed354578b..5577cea7c009 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -21,6 +21,7 @@ struct msm_iommu_pagetable {
 	struct msm_mmu base;
 	struct msm_mmu *parent;
 	struct io_pgtable_ops *pgtbl_ops;
+	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	phys_addr_t ttbr;
 	u32 asid;
 };
@@ -29,23 +30,84 @@ static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
 	return container_of(mmu, struct msm_iommu_pagetable, base);
 }
 
+/* based on iommu_pgsize() in iommu.c: */
+static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
+			   unsigned long iova, phys_addr_t paddr,
+			   size_t size, size_t *count)
+{
+	unsigned int pgsize_idx, pgsize_idx_next;
+	unsigned long pgsizes;
+	size_t offset, pgsize, pgsize_next;
+	unsigned long addr_merge = paddr | iova;
+
+	/* Page sizes supported by the hardware and small enough for @size */
+	pgsizes = pagetable->pgsize_bitmap & GENMASK(__fls(size), 0);
+
+	/* Constrain the page sizes further based on the maximum alignment */
+	if (likely(addr_merge))
+		pgsizes &= GENMASK(__ffs(addr_merge), 0);
+
+	/* Make sure we have at least one suitable page size */
+	BUG_ON(!pgsizes);
+
+	/* Pick the biggest page size remaining */
+	pgsize_idx = __fls(pgsizes);
+	pgsize = BIT(pgsize_idx);
+	if (!count)
+		return pgsize;
+
+	/* Find the next biggest support page size, if it exists */
+	pgsizes = pagetable->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
+	if (!pgsizes)
+		goto out_set_count;
+
+	pgsize_idx_next = __ffs(pgsizes);
+	pgsize_next = BIT(pgsize_idx_next);
+
+	/*
+	 * There's no point trying a bigger page size unless the virtual
+	 * and physical addresses are similarly offset within the larger page.
+	 */
+	if ((iova ^ paddr) & (pgsize_next - 1))
+		goto out_set_count;
+
+	/* Calculate the offset to the next page size alignment boundary */
+	offset = pgsize_next - (addr_merge & (pgsize_next - 1));
+
+	/*
+	 * If size is big enough to accommodate the larger page, reduce
+	 * the number of smaller pages.
+	 */
+	if (offset + pgsize_next <= size)
+		size = offset;
+
+out_set_count:
+	*count = size >> pgsize_idx;
+	return pgsize;
+}
+
 static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size_t size)
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
 	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
-	size_t unmapped = 0;
 
-	/* Unmap the block one page at a time */
 	while (size) {
-		unmapped += ops->unmap(ops, iova, 4096, NULL);
-		iova += 4096;
-		size -= 4096;
+		size_t unmapped, pgsize, count;
+
+		pgsize = calc_pgsize(pagetable, iova, iova, size, &count);
+
+		unmapped = ops->unmap_pages(ops, iova, pgsize, count, NULL);
+		if (!unmapped)
+			break;
+
+		iova += unmapped;
+		size -= unmapped;
 	}
 
 	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
 
-	return (unmapped == size) ? 0 : -EINVAL;
+	return (size == 0) ? 0 : -EINVAL;
 }
 
 static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
@@ -54,7 +116,6 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
 	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
 	struct scatterlist *sg;
-	size_t mapped = 0;
 	u64 addr = iova;
 	unsigned int i;
 
@@ -62,17 +123,26 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 		size_t size = sg->length;
 		phys_addr_t phys = sg_phys(sg);
 
-		/* Map the block one page at a time */
 		while (size) {
-			if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
-				msm_iommu_pagetable_unmap(mmu, iova, mapped);
+			size_t pgsize, count, mapped = 0;
+			int ret;
+
+			pgsize = calc_pgsize(pagetable, addr, phys, size, &count);
+
+			ret = ops->map_pages(ops, addr, phys, pgsize, count,
+					     prot, GFP_KERNEL, &mapped);
+
+			/* map_pages could fail after mapping some of the pages,
+			 * so update the counters before error handling.
+			 */
+			phys += mapped;
+			addr += mapped;
+			size -= mapped;
+
+			if (ret) {
+				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
 				return -EINVAL;
 			}
-
-			phys += 4096;
-			addr += 4096;
-			size -= 4096;
-			mapped += 4096;
 		}
 	}
 
@@ -207,6 +277,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* Needed later for TLB flush */
 	pagetable->parent = parent;
+	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
 
 	/*
-- 
2.37.2

