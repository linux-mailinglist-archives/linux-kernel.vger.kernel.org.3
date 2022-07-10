Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9356D1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGJXGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGJXGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E610FC0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so2089658wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3ZTmvONYAL3UmGbG2MULEJQEOXDk4bgL9Jsh2UKHR0=;
        b=shjCmOtmTJr3WRbag5oJo/fGtuTm1xqY1Edpx4CJaaiZU343eW60a+82utSz3xgQ6p
         aWRh/+ep3FFT5CK/PAucz0i721CP1Tv8cjbvbTE+AhRlyVXwHm1otNklh+FMTNdiFjGu
         55b4myBFjVznKA/z4iJAZwDdSIxXuSi6gp/LWCCvEsbgcxfUZ4MfqtLHHpblqvIri1yB
         4RSYvjtpzs5XMxP29a/xlpF8IaGDvpGJYFFUEVEiNzzzu5RYpUG3VKKrJ5x5b4C4v8W/
         VUvCmv7rG2tPfBge19Ypz0vXdpnvffjH4V94S0rjZ2GonwrfU21td/QHNbZRnyGdBDo1
         n0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3ZTmvONYAL3UmGbG2MULEJQEOXDk4bgL9Jsh2UKHR0=;
        b=gFa1HFli23KGN2oioC6vuDNyVxIkrfyw5tKfv57ZLBdjJojat1n1sLzIFii8tW+998
         TuzRqFnpUEVvyX8Lvswx2BKLj7t4T5zFkwx4X+jCG05oZRSH/M94r2CKRtR3Bf7zbV91
         we9/lGKCENFCCCR5vh2W2vk5RjMqk/YNAz9jGmMIF4V85p1QqV2kYzp8O4Qu9/BQ8B3B
         pmWVQLsOMCz4dwekbm+HbZNj9KzVHM8FY39EcQL+y/Eaz12bLv1Ad7SvOQ7H6iag34dm
         l8ERNaVhmZyvrY9MqUaUq0FgBlynNCJXHtuWTL56QYpJlj0sJtAVLe3FuCtsj6CSaMx3
         V+xA==
X-Gm-Message-State: AJIora8f4Mj6B0/exR5wBsxDiLo5lnaQ4eh+ZVYUdmeg/2uXw3YXeSKC
        W2NT+C9S983kApvVGMRhIXbhCw==
X-Google-Smtp-Source: AGRyM1u43KlHkERt90c0V0mKxMDOvNBrf0leawFGzCy7FxHSo4Rkj7KffUTXFcFXeKS8Uks57TmrnA==
X-Received: by 2002:a05:600c:6024:b0:3a0:4ea4:cfa4 with SMTP id az36-20020a05600c602400b003a04ea4cfa4mr12564968wmb.119.1657494365850;
        Sun, 10 Jul 2022 16:06:05 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b0021d650e4df4sm4436047wru.87.2022.07.10.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:05 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] iommu/exynos: Reuse SysMMU constants for page size and order
Date:   Mon, 11 Jul 2022 02:05:57 +0300
Message-Id: <20220710230603.13526-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using SZ_4K in context of SysMMU driver is better than using PAGE_SIZE,
as PAGE_SIZE might have different value on different platforms. Though
it would be even better to use more specific constants, already existing
in SysMMU driver. Make the code more strict by using SPAGE_ORDER and
SPAGE_SIZE constants.

It also makes sense, as __sysmmu_tlb_invalidate_entry() also uses
SPAGE_* constants for further calculations with num_inv param, so it's
logical that num_inv should be previously calculated using also SPAGE_*
values.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 79729892eb48..8f80aaa35092 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -340,7 +340,7 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	if (MMU_MAJ_VER(data->version) < 5)
 		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
 	else
-		writel(pgd / SZ_4K, data->sfrbase + REG_V5_PT_BASE_PFN);
+		writel(pgd >> SPAGE_ORDER, data->sfrbase + REG_V5_PT_BASE_PFN);
 
 	__sysmmu_tlb_invalidate(data);
 }
@@ -550,7 +550,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 		 * 64KB page can be one of 16 consecutive sets.
 		 */
 		if (MMU_MAJ_VER(data->version) == 2)
-			num_inv = min_t(unsigned int, size / SZ_4K, 64);
+			num_inv = min_t(unsigned int, size / SPAGE_SIZE, 64);
 
 		if (sysmmu_block(data)) {
 			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
-- 
2.30.2

