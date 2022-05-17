Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A91529FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiEQKsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344636AbiEQKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:47:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8435853
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:47:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 582F51F444DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784438;
        bh=fFBuEj9it3bKjIfSO2Q+GWzpRq0QQDUPa5eSWf1Ae70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ixr02VzPS45ngUIUk42xC7tC3nDNzSiN1x4ALt9txJ7hhcU/qQIiaTumOP1hCFV8J
         K5Yax9yOrDRgsHWhJspYzLhNdqBs+rMDL/NTqapYRktYpAe5yvxKsDKT72foNvAhy+
         XfvSj92KsBL8igfyKAM7aJVqcHPVWY3cRgPXYZwqfBce5uJeB/fTLCCR3p0E8Tat34
         R2NQWtP0nOBfIr20koupWnsdlntgS8iZV1FBI3WR5edSzflD+EKDMcLAVi9c3vv1lV
         FDe8gLH4EBdC3tAyVFN1blqHbCDT7vgcR78jENY6ffJBGnOVM5IMO8tw2p/zMSpMdn
         Aq4UhzbnY05gQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 4/5] soc: mediatek: pwrap: Move IO pointers to new structure
Date:   Tue, 17 May 2022 12:47:11 +0200
Message-Id: <20220517104712.24579-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
References: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the PMIC Wrapper driver each PMIC has its own regmap configuration
and its own pwrap_{read/write}() callbacks, but it's just about either
a 32 bits vs 16 bits register, and only one of them uses 32bits regs:
this means that the same ops are assigned over and over again to all
of the supported PMICs.

It is therefore possible to avoid reassigning the same things over
and over, reducing the amount of lines, without any impact on human
readability of this driver: add a pwrap_slv_regops structure and
move the callbacks and regmap_config pointer in there instead.
This allows to assign just one pointer to that shared data in the
per-pmic struct pwrap_slv_type.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 61 +++++++++++++++-------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 04b51d21a5b0..14f31a9fc792 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1143,12 +1143,9 @@ enum pwrap_type {
 };
 
 struct pmic_wrapper;
-struct pwrap_slv_type {
-	const u32 *dew_regs;
-	enum pmic_type type;
+
+struct pwrap_slv_regops {
 	const struct regmap_config *regmap;
-	/* Flags indicating the capability for the target slave */
-	u32 caps;
 	/*
 	 * pwrap operations are highly associated with the PMIC types,
 	 * so the pointers added increases flexibility allowing determination
@@ -1158,6 +1155,14 @@ struct pwrap_slv_type {
 	int (*pwrap_write)(struct pmic_wrapper *wrp, u32 adr, u32 wdata);
 };
 
+struct pwrap_slv_type {
+	const u32 *dew_regs;
+	enum pmic_type type;
+	const struct pwrap_slv_regops *regops;
+	/* Flags indicating the capability for the target slave */
+	u32 caps;
+};
+
 struct pmic_wrapper {
 	struct device *dev;
 	void __iomem *base;
@@ -1313,7 +1318,7 @@ static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 
 static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
-	return wrp->slave->pwrap_read(wrp, adr, rdata);
+	return wrp->slave->regops->pwrap_read(wrp, adr, rdata);
 }
 
 static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
@@ -1372,7 +1377,7 @@ static int pwrap_write32(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 
 static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 {
-	return wrp->slave->pwrap_write(wrp, adr, wdata);
+	return wrp->slave->regops->pwrap_write(wrp, adr, wdata);
 }
 
 static int pwrap_regmap_read(void *context, u32 adr, u32 *rdata)
@@ -1891,69 +1896,67 @@ static const struct regmap_config pwrap_regmap_config32 = {
 	.max_register = 0xffff,
 };
 
+static const struct pwrap_slv_regops pwrap_regops16 = {
+	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
+	.regmap = &pwrap_regmap_config16,
+};
+
+static const struct pwrap_slv_regops pwrap_regops32 = {
+	.pwrap_read = pwrap_read32,
+	.pwrap_write = pwrap_write32,
+	.regmap = &pwrap_regmap_config32,
+};
+
 static const struct pwrap_slv_type pmic_mt6323 = {
 	.dew_regs = mt6323_regs,
 	.type = PMIC_MT6323,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
 		PWRAP_SLV_CAP_SECURITY,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6351 = {
 	.dew_regs = mt6351_regs,
 	.type = PMIC_MT6351,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = 0,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6357 = {
 	.dew_regs = mt6357_regs,
 	.type = PMIC_MT6357,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = 0,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6358 = {
 	.dew_regs = mt6358_regs,
 	.type = PMIC_MT6358,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6359 = {
 	.dew_regs = mt6359_regs,
 	.type = PMIC_MT6359,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = PWRAP_SLV_CAP_DUALIO,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
-	.regmap = &pwrap_regmap_config32,
+	.regops = &pwrap_regops32,
 	.caps = 0,
-	.pwrap_read = pwrap_read32,
-	.pwrap_write = pwrap_write32,
 };
 
 static const struct pwrap_slv_type pmic_mt6397 = {
 	.dew_regs = mt6397_regs,
 	.type = PMIC_MT6397,
-	.regmap = &pwrap_regmap_config16,
+	.regops = &pwrap_regops16,
 	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
 		PWRAP_SLV_CAP_SECURITY,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
 };
 
 static const struct of_device_id of_slave_match_tbl[] = {
@@ -2328,7 +2331,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_out2;
 
-	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regmap);
+	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regops->regmap);
 	if (IS_ERR(wrp->regmap)) {
 		ret = PTR_ERR(wrp->regmap);
 		goto err_out2;
-- 
2.35.1

