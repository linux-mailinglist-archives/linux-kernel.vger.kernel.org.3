Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63156D1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGJXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGJXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9291F597
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d16so4905390wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R103erxeCCHS3ZUMewsB5C1yy+zcGyX5sa9sukmtQlA=;
        b=fLuyUwyFBhuSKQzea4YKfooN5u8vLxajhzZfJiUNNmT6fjM23kiTCm6Z5yIImksVh5
         lKbtLFd24T7ayF/oB0abItkwp0lNCG0ghAJzPh4G3postibpTtFBBvM4Fntt1BEaOWvP
         zEyhX4ho27fL4YtKz90nx849VrALn9l90CFJEKmyU41u4qcCLTP9evbyTEfAuyaBC3gN
         oKvStT4nSnB10aKgpJ29VmiNuHp8pccko5rT27B8qfz9szXra3l/v4EVewqKj/SdJbRR
         JtuV3zuxQesh8+7sU7ZHpouewD8sn/EUwkU8oDubw4Og8ir0KQ+5xlNDJ61h99y991xI
         72cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R103erxeCCHS3ZUMewsB5C1yy+zcGyX5sa9sukmtQlA=;
        b=kvP4GSNtRm1S6LqF3AI0lAk7APP3iFAwpgUWlKc0CGzH66lbf/s1vwoARDIRX+Ty45
         LEUiYb2wnWPHQgLoQKe1d+8gvFzM2wpZcxEfwufJGqM1CkUmETLPJH0ORWnASKzcW4Cp
         Z+HCGGCz5CL0EvjTrHRPSVPyF3fF8C6db8DWySjptqVc7yPPzLGr0zN/YCaYB9VJHRAm
         9L+Qrre65CjqKrRKAuZ05MO+AMl0rxCzHw9qc1PHucKIeFqS6lpxFzGn9d5nvwcyclO8
         Q1K2FirFfTxu7r5820tT4vN6IZBfeqpYy8wzuxmuuQibT/TcjYESEzmehLMLF76VCjDK
         0Vzg==
X-Gm-Message-State: AJIora+swDFz8sEsS+XGpdQhal1zY7JfjMWF3bEN6HoRw5leC2DNoP/X
        3aPe2TUmqqtw/3AkVpHB5MHoPg==
X-Google-Smtp-Source: AGRyM1vww+/EwQUG5ItTSVzcGPkgSaNRCtATWrYEb+Z/Gu6CFwsngTsI375t0lfeO503K1T635bVCg==
X-Received: by 2002:a5d:4402:0:b0:21d:8093:138c with SMTP id z2-20020a5d4402000000b0021d8093138cmr13985720wrq.535.1657494368329;
        Sun, 10 Jul 2022 16:06:08 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6244000000b0021d6e917442sm5383041wrv.72.2022.07.10.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
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
Subject: [PATCH v2 3/7] iommu/exynos: Set correct dma mask for SysMMU v5+
Date:   Mon, 11 Jul 2022 02:05:59 +0300
Message-Id: <20220710230603.13526-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
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

SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
mask to avoid falling back to SWTLBIO usage in dma_map_single() because
of failed dma_capable() check.

The original code for this fix was suggested by Marek.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Co-developed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes in v2:
  - Handled failed dma_set_mask() call
  - Replaced "Originally-by" tag by "Co-developed-by" + SoB tags

 drivers/iommu/exynos-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c85db9dab851..494f7d7aa9c5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -646,6 +646,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			goto err_dma_set_mask;
+		}
+	}
+
 	/*
 	 * use the first registered sysmmu device for performing
 	 * dma mapping operations on iommu page tables (cpu cache flush)
@@ -657,6 +665,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_dma_set_mask:
+	iommu_device_unregister(&data->iommu);
 err_iommu_register:
 	iommu_device_sysfs_remove(&data->iommu);
 	return ret;
-- 
2.30.2

