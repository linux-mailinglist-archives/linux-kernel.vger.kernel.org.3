Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC756D1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiGJXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGJXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39613FB6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so4977490wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2f1MNXFf/eUDAId4C2kxkA1MS+WaHjSg/obA+yddoAY=;
        b=A6jyZM7p9U0gZAji/VRrl+pDcvLiQfuijwn/6vIn34EzJwd59ehp2ngdh+WyHAtEmE
         qNo5+ArvxzxcNUU9LF1x/MjgqJxm0NAzDazGeB7ijtTcJNUNFjNnEFm9WeMoq5r8p9+k
         ODQbNzVAlRHYUpWUv7PKYdr+uX2hY4WmRAoCwYrsOIYBtPTFniOGkzGZD2+hh9dGPm6v
         YrrQJiDqdWxbHTUiGO6tKRrm5pMHfSNZQ89iJseoQCU8iJLMo5SjEp4qG517p6FuNe1E
         VCWLCy8KbJhR5KM60/QWaGe5DS3/eMRRMmTFrcBxrGXd4LRmZmrr8PG2+6miSEQTZX1b
         x1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2f1MNXFf/eUDAId4C2kxkA1MS+WaHjSg/obA+yddoAY=;
        b=0OZX8OQvg/Wdgy3pfPldDXsUyz/uVhEHSKqFJWGu4LrM8MvOdvHzzCmgPsiGPs6O3U
         LBpsW1WE/FSwmrKcSkpyGVoH7c/cDphd+7cnbMQ5BnxvTWg9r+5xu/tdXfK5Gn8OTebg
         PYJjCOJhMoGH/CrVHrK87f/OwJz5btcxZsjUwDPg7w/MJIZeN09bl2rIUu+jObBUTeM6
         fSiU+dC/V+XGZuqIfrNQpLDomhs1ntfGRyS6hjP8ruEgRfFbnnVEhABXhFownCbOYbEu
         FQXEhn39dbqrJh/ITgd9EXYqWAU1ZsxTKXbztaDJVK8gJ3TEPFD45reC+O7CpBOoCuyK
         wTAw==
X-Gm-Message-State: AJIora8yJr9djLpG1Zb42xcPRyn9dIm8EA+zhfrpKMSfd80lMxbGJxeu
        lLjrpxoFNk/15VWN2xibuqNM4w==
X-Google-Smtp-Source: AGRyM1uXSy+6O3wOe/skUDOaKGNjZhKBZ5DB1zppE9YnC4UYd9LI3XBpGotBSKS2BFKSQx6GJYIjSg==
X-Received: by 2002:a5d:434a:0:b0:21d:aa7e:b1bb with SMTP id u10-20020a5d434a000000b0021daa7eb1bbmr297352wrr.619.1657494371966;
        Sun, 10 Jul 2022 16:06:11 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b0039c747a1e8fsm9713112wmp.7.2022.07.10.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:11 -0700 (PDT)
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
Subject: [PATCH v2 6/7] iommu/exynos: Add SysMMU v7 register sets
Date:   Mon, 11 Jul 2022 02:06:02 +0300
Message-Id: <20220710230603.13526-7-semen.protsenko@linaro.org>
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

SysMMU v7 might have different register layouts (VM capable or non-VM
capable). Check which layout is implemented in current SysMMU module and
prepare the corresponding register table for futher usage.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 48681189ccf8..64bf3331064f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -166,6 +166,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 enum {
 	REG_SET_V1,
 	REG_SET_V5,
+	REG_SET_V7_NON_VM,
+	REG_SET_V7_VM,
 	MAX_REG_SET
 };
 
@@ -201,6 +203,16 @@ static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
 		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
 		0x60, 0x64,
 	},
+	/* SysMMU v7: Default register set (non-VM) */
+	{
+		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
+		0x60, 0x64,
+	},
+	/* SysMMU v7: VM capable register set */
+	{
+		0x00, 0x04, 0x08, 0x800c, 0x8010, 0x8014, 0x8018, 0x8020,
+		0x8024, 0x60, 0x64,
+	},
 };
 
 static struct device *dma_dev;
@@ -440,12 +452,18 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
 	__sysmmu_enable_clocks(data);
 
 	__sysmmu_get_version(data);
-	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
-		__sysmmu_get_vcr(data);
-	if (MMU_MAJ_VER(data->version) < 5)
+	if (MMU_MAJ_VER(data->version) < 5) {
 		data->regs = sysmmu_regs[REG_SET_V1];
-	else
+	} else if (MMU_MAJ_VER(data->version) < 7) {
 		data->regs = sysmmu_regs[REG_SET_V5];
+	} else {
+		if (__sysmmu_has_capa1(data))
+			__sysmmu_get_vcr(data);
+		if (data->has_vcr)
+			data->regs = sysmmu_regs[REG_SET_V7_VM];
+		else
+			data->regs = sysmmu_regs[REG_SET_V7_NON_VM];
+	}
 
 	__sysmmu_disable_clocks(data);
 }
-- 
2.30.2

