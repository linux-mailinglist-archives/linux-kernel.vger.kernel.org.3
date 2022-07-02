Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B772A5642EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGBVhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:37:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FABC10
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:37:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fw3so10017620ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NerRWmIAqCEP1T7lOGIa0oD8kf3CJfnc5B6DWtDa2sE=;
        b=xsw6tvMIlFqstWxTvGLa4TpWz2DJ+yswH+8y8zk8yKzSNRHci0nEyC3BoHWzFaZV7f
         YkNV66s6p3f2RyRoAefnzdCAu3fjYzarXnk9kUmT9xcetm1kjqDEyXYV//sBpZYDjmOx
         1Bv66ppk5mjr+HngPMnZu7Z7fh6TQWlLQHzDXeJYt/R1Y0k+JjHSvzE2A6K05mUrzeuu
         oL6nqBiARDdsTcWRiGxmb6T0diWSYpnf8O5wkvHdcO+ask/LMhhsahwKKsB/ezAhQMOT
         iYwqlL0C/Wc5qu+pJCPcjusoOA7owcWSEHjnJpbv7bMsYVYqm+LgT2hM1q8YJE2+nrsK
         nZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NerRWmIAqCEP1T7lOGIa0oD8kf3CJfnc5B6DWtDa2sE=;
        b=oIl18zlu5jCPY0iiryJ2+0p+rNJrfzcjmA2/I1W0Av47HSURfXMIlH+hoKU898BegK
         40J1EgppFO9WGt1tKIxl4BtzKP+NsXpT2BQlLI2+BKErrA0cFrGMY1f4T8x5q8KLTtZA
         5RGaimNK68hDXaTQrgw5wpEp9jL37dQQ/V+4XWELl/o9VpUHUReofgtwufC33L0EVcUi
         0hVWRgxhikUKq8Uaps/F5lEmfxX3tXSWbE6Vk/YwhHFgoe4HXqbDR26dvRtR77qRrtBZ
         5kIrf82B5gjim+zEUXdpVruvAdXSAxZFkCIQlpgl4Xh3nq4j2Utsn53RBs//NW45O0oB
         UHOA==
X-Gm-Message-State: AJIora/p9fEN/BrnfCFlrVXQ4If5YImJwITLOU9vMW6+SRMXgj5vF5vT
        DTE2XsT2sfTGWt57tDcj5Glatg==
X-Google-Smtp-Source: AGRyM1vXXFFAKoyt7zObR5eXNjgaVHoYU0jAUJslw/5Qy5AQvNGbBV1vrhVRIPih14LXllVxYy7Bkg==
X-Received: by 2002:a17:906:9508:b0:723:ef49:fe4c with SMTP id u8-20020a170906950800b00723ef49fe4cmr21582570ejx.489.1656797850013;
        Sat, 02 Jul 2022 14:37:30 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090631d600b0072a3958ed33sm5021648ejf.63.2022.07.02.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:29 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/exynos: Add minimal support for SysMMU v7 with VM registers
Date:   Sun,  3 Jul 2022 00:37:24 +0300
Message-Id: <20220702213724.3949-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal viable support for SysMMU v7.x, which can be found in modern
Exynos chips (like Exynos850). SysMMU v7.x may implement VM register
set, and those registers should be initialized properly if present.
Usually 8 translation domains are supported via VM registers (0..7), but
only n=0 (default) is used for now.

Changes are as follows:
  - add enabling the default VID instance before enabling SysMMU
  - use v7 VM register for setting the page table base address
  - use v7 VM register for invalidation

Insights for those changes were taken by comparing the I/O dump
(writel() / readl() operations) for vendor driver and this upstream
driver.

It was tested on E850-96 board, which has SysMMU v7.4 with VM registers
present. The testing was done using "Emulated Translation" registers.
That allows initiating translations with no actual users of that IOMMU,
and checking the result by reading the TLB info from corresponding
registers.

Thanks to Marek, who did let me know it only takes a slight change of
registers to make this driver work with v7.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 47017e8945c5..b7b4833161bc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CTRL_VM_ENABLE			BIT(0)
+#define CTRL_VM_FAULT_MODE_STALL	BIT(3)
 #define CAPA0_CAPA1_EXIST		BIT(11)
 #define CAPA1_VCR_ENABLED		BIT(14)
 
@@ -358,8 +360,10 @@ static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
 {
 	if (MMU_MAJ_VER(data->version) < 5)
 		writel(0x1, data->sfrbase + REG_MMU_FLUSH);
-	else
+	else if (MMU_MAJ_VER(data->version) < 7)
 		writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
+	else
+		writel(0x1, MMU_VM_REG(data, IDX_ALL_INV, 0));
 }
 
 static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -391,9 +395,11 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 {
 	if (MMU_MAJ_VER(data->version) < 5)
 		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
-	else
+	else if (MMU_MAJ_VER(data->version) < 7)
 		writel(pgd >> PAGE_SHIFT,
 			     data->sfrbase + REG_V5_PT_BASE_PFN);
+	else
+		writel(pgd >> SPAGE_ORDER, MMU_VM_REG(data, IDX_FLPT_BASE, 0));
 
 	__sysmmu_tlb_invalidate(data);
 }
@@ -571,6 +577,12 @@ static void __sysmmu_enable(struct sysmmu_drvdata *data)
 	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
 	__sysmmu_init_config(data);
 	__sysmmu_set_ptbase(data, data->pgtable);
+	if (MMU_MAJ_VER(data->version) >= 7 && data->has_vcr) {
+		u32 ctrl = readl(MMU_VM_REG(data, IDX_CTRL_VM, 0));
+
+		ctrl |= CTRL_VM_ENABLE | CTRL_VM_FAULT_MODE_STALL;
+		writel(ctrl, MMU_VM_REG(data, IDX_CTRL_VM, 0));
+	}
 	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 	data->active = true;
 	spin_unlock_irqrestore(&data->lock, flags);
-- 
2.30.2

