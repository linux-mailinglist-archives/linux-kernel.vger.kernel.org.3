Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015359B5FF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiHUSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiHUSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:19:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422311E3DF;
        Sun, 21 Aug 2022 11:19:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 1so1222847pfu.0;
        Sun, 21 Aug 2022 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KXO1+rEYcOhr3W13ew7JJG2ZdVZOdgDfophycm+/cI0=;
        b=h1aW2/zXYwlI9VvEyEDwQ9nir0RGoIYAQo3OYZ+A3Sp5OunvV1JlLiVC1VKPARnRSp
         3CIOd5VGLg3RTOWctI8KMhDLNAaTyAMXGiqLBkVTj0nVK8Ad7WA401gjUBqpO+VbSp7/
         k3KsR+5F/A14QIdl0m0StrFVoo0dqJG+EBJ/vQazrR2VyW+lCOKuIdcS1pYFGgMbgEu0
         jPxgEl07gjPZKxHW8S7qYp68TPn8xBJxrS+XeLPRklEflMigP36Auo0NvLUJ7IQ3vWM/
         80CH9dxNboipowi+j4daxl4cF6EBBaaS/4KStd9ixV5QyUjbftbikbaZ0wMyhLiQx/H3
         zSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KXO1+rEYcOhr3W13ew7JJG2ZdVZOdgDfophycm+/cI0=;
        b=SytQtU3suzdc7VZTUYLdUTL5IvOE05qu9nFTGin5j7rtEE79dCFvO3CKy+MrVkrhlv
         mwMM73bYZaXpKSXyAhH1QSm7F8wt/AdWYdCW6SvSg3hq7GjQWpXpG1W4EKpefvk69XGu
         yL6wvZGZdKy1W1um1XQE/QDHa9BkBsAQsBxF2l6Q6S7+KwgGf4cBCwW2PMRb1BR/qnFg
         bdf5027yXLIWwZU/yS0c5JBVfARbJwXX8yFeoPquh5IxyABlXijnCleTg/GBlJflsuOW
         nRKtJnyNqwRVPqCLih64zSVri1XxO9UFFXp+IuRfygUkP3RuMDB7g8wGx5KZYSQ2OcUs
         zhsA==
X-Gm-Message-State: ACgBeo0hc95je4wJlAvJ+2CzRlNGxjOI4gCgbJreFWAQGQWOZ4Pgj83k
        DbY/6Z7EelrA0qRSnpRw18M=
X-Google-Smtp-Source: AA6agR6i0s4MALSYERHLBE5fmy618sONp39l+osO9fV7k/dJmjUVOWdy1MMzZG71HDJc5xKgxOAxbQ==
X-Received: by 2002:a63:88c8:0:b0:41d:260c:ea29 with SMTP id l191-20020a6388c8000000b0041d260cea29mr14004283pgd.284.1661105943530;
        Sun, 21 Aug 2022 11:19:03 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id r6-20020a634406000000b0042a6dde1d66sm2711467pga.43.2022.08.21.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:19:01 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/msm: Use separate ASID for each set of pgtables
Date:   Sun, 21 Aug 2022 11:19:05 -0700
Message-Id: <20220821181917.1188021-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181917.1188021-1-robdclark@gmail.com>
References: <20220821181917.1188021-1-robdclark@gmail.com>
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

Optimize TLB invalidation by using different ASID for each set of
pgtables.  There can be scenarios where multiple processes end up
with the same ASID (such as >256 processes using the GPU), but this
is harmless, it will only result in some over-invalidation (but
less over-invalidation compared to using ASID=0 for all processes)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index a54ed354578b..94c8c09980d1 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -33,6 +33,8 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size_t size)
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct adreno_smmu_priv *adreno_smmu =
+		dev_get_drvdata(pagetable->parent->dev);
 	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
 	size_t unmapped = 0;
 
@@ -43,7 +45,7 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size -= 4096;
 	}
 
-	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
+	adreno_smmu->tlb_inv_by_id(adreno_smmu->cookie, pagetable->asid);
 
 	return (unmapped == size) ? 0 : -EINVAL;
 }
@@ -147,6 +149,7 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 
 struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 {
+	static atomic_t asid = ATOMIC_INIT(1);
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(parent->dev);
 	struct msm_iommu *iommu = to_msm_iommu(parent);
 	struct msm_iommu_pagetable *pagetable;
@@ -210,12 +213,14 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
 
 	/*
-	 * TODO we would like each set of page tables to have a unique ASID
-	 * to optimize TLB invalidation.  But iommu_flush_iotlb_all() will
-	 * end up flushing the ASID used for TTBR1 pagetables, which is not
-	 * what we want.  So for now just use the same ASID as TTBR1.
+	 * ASID 0 is used for kernel mapped buffers in TTBR1, which we
+	 * do not need to invalidate when unmapping from TTBR0 pgtables.
+	 * The hw ASID is at *least* 8b, but can be 16b.  We just assume
+	 * the worst:
 	 */
 	pagetable->asid = 0;
+	while (!pagetable->asid)
+		pagetable->asid = atomic_inc_return(&asid) & 0xff;
 
 	return &pagetable->base;
 }
-- 
2.37.2

