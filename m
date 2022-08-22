Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795859C6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiHVSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiHVSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:47:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0A13D69;
        Mon, 22 Aug 2022 11:47:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso12242946pjj.4;
        Mon, 22 Aug 2022 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hNJnoLv/5u03Gc3FZcUv6HW87BdWPdf/MJiQ6bgU6aY=;
        b=Z5hQ4f1KZHVn6Rf56bcS2ztHd9S+0zc6FX/vOx0CCPu5n3DbqdZYPx7/o2zuHulWnM
         Z6kx+u4iAQa7FlF8joSXLKfDW6tGYYATW9Ko68JT0aeppcUontfTKm2vzPKuqU/MgeZj
         n4LGLPbTs6yu+n5Q6XhAbiU5EbmuUUIzlgIhKHMs7gd2gyHOgGZZhcGXqWRr4Rlbaguy
         0ln7iT0Kwmp1/otcTXU76/SiwuyK5Jw0A0R1zdIo4nNDF2Kkor4XCz8y2/Sf1d9wbX8k
         3lyOjdWmSa/JPRFPeFmUscPqQnkAckSQAvkZ+HYgysTVrqQ4xtacCDzFcb+g3X3KG2J9
         3CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hNJnoLv/5u03Gc3FZcUv6HW87BdWPdf/MJiQ6bgU6aY=;
        b=qR3gBtzRQMFQCsvGm4PrIBUSiA79kpndFBC9Opj+Z3cSTHESgesIm2lfvHu6JfUplM
         B7V7G0SPoReT9UyjXJw5++uH+iDz5WL56KaEa0Nn85q9pIMYISynG9z9O6g+JO29w3oK
         8oDGzhXJnSKGk6R8bFLQeHVV/LAyJ6wNfqw4nMmU0N21wmgQKgRm/ktaZufzaWUW9mGx
         LTiEwVrvfFGaqoLb23jTKp9yx3owxzLLDPov460tZ/VnmpyDwipCawBGAImzY3eTzgXp
         fjTVMczG7Ox6clP/Fq3+wfgPhEw/IirBeqWk7usMgGo00hm8zQdZps1Zd39s7+7C+ps0
         NKlA==
X-Gm-Message-State: ACgBeo2Se/des24il0o/8aD7huJBDPJRas3np/P51bmpVv9kXAPLtO/Z
        Xkd3mURC33vNCWXlw8N/KNU=
X-Google-Smtp-Source: AA6agR46jPCWWebDm8SZ5Yrt/HRYcHDiSjarv2sCQh1INfDofeZ1UMWIAczIxOKgDWaprj82bfTc/w==
X-Received: by 2002:a17:90a:cf89:b0:1fa:a98a:c61 with SMTP id i9-20020a17090acf8900b001faa98a0c61mr29779451pju.69.1661194024504;
        Mon, 22 Aug 2022 11:47:04 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z18-20020aa79492000000b005367a03d56csm3459616pfk.104.2022.08.22.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:47:03 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/iommu: optimize map/unmap
Date:   Mon, 22 Aug 2022 11:47:42 -0700
Message-Id: <20220822184742.32076-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 91 ++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index a54ed354578b..0f3f60da3314 100644
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
@@ -29,23 +30,85 @@ static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
 	return container_of(mmu, struct msm_iommu_pagetable, base);
 }
 
+/* based on iommu_pgsize() in iommu.c: */
+static size_t iommu_pgsize(struct msm_iommu_pagetable *pagetable,
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
 
 	/* Unmap the block one page at a time */
 	while (size) {
-		unmapped += ops->unmap(ops, iova, 4096, NULL);
-		iova += 4096;
-		size -= 4096;
+		size_t unmapped, pgsize, count;
+
+		pgsize = iommu_pgsize(pagetable, iova, iova, size, &count);
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
@@ -54,7 +117,6 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
 	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
 	struct scatterlist *sg;
-	size_t mapped = 0;
 	u64 addr = iova;
 	unsigned int i;
 
@@ -64,15 +126,19 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 
 		/* Map the block one page at a time */
 		while (size) {
-			if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
-				msm_iommu_pagetable_unmap(mmu, iova, mapped);
+			size_t pgsize, count, mapped;
+
+			pgsize = iommu_pgsize(pagetable, addr, phys, size, &count);
+
+			if (ops->map_pages(ops, addr, phys, pgsize, count,
+					   prot, GFP_KERNEL, &mapped)) {
+				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
 				return -EINVAL;
 			}
 
-			phys += 4096;
-			addr += 4096;
-			size -= 4096;
-			mapped += 4096;
+			phys += mapped;
+			addr += mapped;
+			size -= mapped;
 		}
 	}
 
@@ -207,6 +273,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* Needed later for TLB flush */
 	pagetable->parent = parent;
+	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
 
 	/*
-- 
2.37.2

