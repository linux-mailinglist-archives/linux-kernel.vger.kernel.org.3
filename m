Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF9575386
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiGNQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiGNQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:55:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522114B0EF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z12so3368783wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ay55aei4xTrkHOP8ZwisRNILeuMCaqkFFuCni3Xut2k=;
        b=n/n3e8j6bJWOXrP95ItdWQVXPuQ0bCFwqzgIEykBYyxN3XjVeTR1h2M0DL/r3D8+I3
         /wlwQamJPhfWq2SMEaES+gscw97bq95Af/SwrUZ2xpihPH0LoDtjSyx5KZ6OX7VHh74Y
         2ThjifUbf5gBCXdAxi6cnn/9ECyQgHcx/tFyUwbKgSYON23z/QjPXt+UL4mCPvkiiaZB
         BfzF+kdEOK7IsC22SKqdZgxtyODLUH00aerRHytO8EVmLyMQvKNSH8tlkSRlFMtdPxel
         VtKnZSYceBp0ZlmE4s7lh/U+Mu4GNt0iBnfIIbXLxlDhGzjC/okAk+Tc/d5AcgkHDnqB
         b8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ay55aei4xTrkHOP8ZwisRNILeuMCaqkFFuCni3Xut2k=;
        b=JlfuaIMdlqRjgoQfpioiYl9RnAoaEl7UNO6GmxcH94VWwa99W0fiFlDEHlTDv3Y+92
         yFw+dkEWte6ofre/2CDNFeX3t6Hmu7LnNyigTgzMcEAReM9HwmRxvaJJPTg+wlrlsX2M
         26Iwv0JggvlUy1WFp0TaC8ykEyEcTmVKKDZzuQTB3yOg/uZ1SGW/7oLDMNL2gPZZ/H/k
         Ar6weXGpI6Jr6oWm34+6zPazbv7CrbjUg/tZYUg/FFCoQtx3/sxCYpbyjqna/Ws2jwcm
         RVxpWjTe8BbTIQUrJPQxJtrs3zhqff3pvFHBV3Dh3RPHkIvmX13dwxcI0Ay9hG/A5f2g
         zUPA==
X-Gm-Message-State: AJIora9WRUg2GHGDjPwGVFRLGcAdCxwoMgltMx1z/WLMB1qs5A0PZcZp
        q5W7pLbHj8WtD1T93JFWxxeZ1oj6qkX17IH+
X-Google-Smtp-Source: AGRyM1vl2oDUNW33308hydkFGVWAVq3Dvpg9TwiwSGovoYQ89wJOF+Z1+82DoJM6Mkt65ij0+18yVw==
X-Received: by 2002:a05:6000:381:b0:21d:bb54:ae2c with SMTP id u1-20020a056000038100b0021dbb54ae2cmr8677229wrf.222.1657817753512;
        Thu, 14 Jul 2022 09:55:53 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0039db31f6372sm7440915wmq.2.2022.07.14.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:53 -0700 (PDT)
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
Subject: [PATCH v3 1/6] iommu/exynos: Reuse SysMMU constants for page size and order
Date:   Thu, 14 Jul 2022 19:55:45 +0300
Message-Id: <20220714165550.8884-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes in v3:
  - Added Marek's Acked-by tag
  - Added Krzysztof's R-b tag

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

