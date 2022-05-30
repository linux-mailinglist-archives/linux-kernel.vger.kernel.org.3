Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67EC538702
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiE3SEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiE3SEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:04:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58959A205F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:04:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s24so8350213wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmIAgX4stP7tbN1utudJdCwbmHGl9Wqirrw9D2YXhxA=;
        b=sj37xc3nASZ+YCXla39Pf94LuVNA1E3wbnpESKap4+mtZJkHFXPsMp7U6qzSqZUvSP
         Zkbt24QW2ES5ClbIchtBy19300ZLdqUNMSmmUTpB6UYympcjd01q1M0KrPM9xHbQ1Qxw
         GHrOPXCT+kGQ4dB/KttIVWVEUjPvL6qWZSfqcDa2MSh2XvY34u/O4j3wXJ/4xhzDGdS4
         KDD0P2RkI/tv81gLON3wHXZdLn5dCEoFpv7k5Jf/+ktP9RymmXCa2CHYVACXJiwm6ZVm
         HPCp8Ul/ru2dIS28/dji4srbNBakB6xMGNuUeH94i8RGl8OD1U0q+N7faTgqNzcaWwdG
         6aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmIAgX4stP7tbN1utudJdCwbmHGl9Wqirrw9D2YXhxA=;
        b=qHJUZ7mCH+jQxwlEhGxmV7cO0bOL5kePJObnfRv2c+Onfo0g1Ac5Te2m0tfzsxNiYD
         P5Ky6dKMEHK6lnDmUofrwkxmWu7HLrxN4pUYeF77V+kKWxJm7o2tHmu9qV7bYLMArScz
         NZwQC7UTFlP4jsk9sVkAdcDSuTdLaEYpkaQrnGsV44Wv4h2TUGEGfUZwIQ5DsDR/gQjm
         CfYGiUU+8700rAaP8Qe1974SmCwgjOk4U4QyiCs8Oegnwn1Purzbv5+cGtGNo0g4pCU0
         TA1E6JiV4NOS89LYWuysmuwhZX6+mf7VkAQCmTxVFzCW9k6Gvpsx0AvvQX41VmIM1e5s
         SyvA==
X-Gm-Message-State: AOAM531FX9u83GR69scZLohg/QbxnWXgscq8LBvt+aEDOU2CAWmXrtjA
        g/r1WMeoyXZxv/0MoZfUlbi7bw==
X-Google-Smtp-Source: ABdhPJzbbLY65ueNfiMy634xwWX8GhshgQaMx9qx3BJ/rdkq+iVkOzEljqVwWPwdzKhOxGv1GHmSOg==
X-Received: by 2002:a05:6000:1247:b0:210:1f6c:b1cb with SMTP id j7-20020a056000124700b002101f6cb1cbmr12912728wrx.709.1653933839926;
        Mon, 30 May 2022 11:03:59 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b00397550b387bsm1647wmc.23.2022.05.30.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:03:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu: mtk_iommu: add support for MT8365 SoC
Date:   Mon, 30 May 2022 20:03:28 +0200
Message-Id: <20220530180328.845692-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530180328.845692-1-fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
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

Add IOMMU support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 11 +++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b692347d8d56..039b8f9d5022 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1093,6 +1093,16 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.port_width     = 5,
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat     = M4U_MT8365,
+	.flags	      = RESET_AXI,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.port_width   = 6,
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1100,6 +1110,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 84cecaf6d61c..cb174fa6f2ab 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,6 +46,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8192,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.36.1

