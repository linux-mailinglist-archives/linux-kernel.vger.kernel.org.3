Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871375814F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiGZORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiGZORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3115FEE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91F176601B20;
        Tue, 26 Jul 2022 15:17:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845054;
        bh=uS7ApYx3lrjLcYD1pymwlYBH9OgH7HrM1kmYQvF3hBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZMfUN1hXPskmNmlXdbD1RV0XzqReyhXu4T8/VylUnoj4BRoTKBfCVCcuu814cdJe
         3taTMm78ZC8aC88P51C0QRsiHVfRJ2dB65UECGqGX08QsXr3EvSu1Y0CCRqRQDqvKm
         MLAYLTE8EcMGLpCvBpvdW3T6Sdvs4185uDqOi0Qn/qyimHNVkeo4sC9vD47nIBw3bu
         NsjvmbqMYXSHgpHkTRX09s90ttSzXGB50gPCY5wB89WBOUwNh31+ta4+kExxHehAO4
         Ve6HF8p0qPJWNej7K2ciOs5n3aHk6BZtU+CRzkYhCVV/MkovVa9OFautwaQ0DVPvr1
         +ODsVn63ZtMLw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/6] soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
Date:   Tue, 26 Jul 2022 16:16:48 +0200
Message-Id: <20220726141653.177948-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commonize the repeating pattern for reading the "t-calibration-data"
efuse data in a new function svs_thermal_efuse_get_data(), reducing
the size of this driver.

No functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 111 +++++++++++----------------------
 1 file changed, 38 insertions(+), 73 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 5ac431a04548..600492dc334c 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1684,11 +1684,36 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
+static int svs_thermal_efuse_get_data(struct svs_platform *svsp)
+{
+	struct nvmem_cell *cell;
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n", PTR_ERR(cell));
+		return PTR_ERR(cell);
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
+	if (IS_ERR(svsp->tefuse)) {
+		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
+			PTR_ERR(svsp->tefuse));
+		nvmem_cell_put(cell);
+		return PTR_ERR(svsp->tefuse);
+	}
+
+	svsp->tefuse_max /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	return 0;
+}
+
 static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	struct nvmem_cell *cell;
 	u32 idx, i, ft_pgm, vmin, golden_temp;
+	int ret;
 
 	for (i = 0; i < svsp->efuse_max; i++)
 		if (svsp->efuse[i])
@@ -1730,24 +1755,9 @@ static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	/* Thermal efuse parsing */
-	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
-	if (IS_ERR_OR_NULL(cell)) {
-		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
-			PTR_ERR(cell));
-		return false;
-	}
-
-	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
-	if (IS_ERR(svsp->tefuse)) {
-		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
-			PTR_ERR(svsp->tefuse));
-		nvmem_cell_put(cell);
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
 		return false;
-	}
-
-	svsp->tefuse_max /= sizeof(u32);
-	nvmem_cell_put(cell);
 
 	for (i = 0; i < svsp->tefuse_max; i++)
 		if (svsp->tefuse[i] != 0)
@@ -1770,8 +1780,8 @@ static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
 static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	struct nvmem_cell *cell;
 	u32 idx, i, vmin, golden_temp;
+	int ret;
 
 	for (i = 0; i < svsp->efuse_max; i++)
 		if (svsp->efuse[i])
@@ -1809,24 +1819,9 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	/* Thermal efuse parsing */
-	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
-	if (IS_ERR_OR_NULL(cell)) {
-		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
-			PTR_ERR(cell));
-		return false;
-	}
-
-	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
-	if (IS_ERR(svsp->tefuse)) {
-		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
-			PTR_ERR(svsp->tefuse));
-		nvmem_cell_put(cell);
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
 		return false;
-	}
-
-	svsp->tefuse_max /= sizeof(u32);
-	nvmem_cell_put(cell);
 
 	for (i = 0; i < svsp->tefuse_max; i++)
 		if (svsp->tefuse[i] != 0)
@@ -1849,8 +1844,8 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	struct nvmem_cell *cell;
 	u32 idx, i, golden_temp;
+	int ret;
 
 	for (i = 0; i < svsp->efuse_max; i++)
 		if (svsp->efuse[i])
@@ -1911,24 +1906,9 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	/* Thermal efuse parsing */
-	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
-	if (IS_ERR_OR_NULL(cell)) {
-		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
-			PTR_ERR(cell));
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
 		return false;
-	}
-
-	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
-	if (IS_ERR(svsp->tefuse)) {
-		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
-			PTR_ERR(svsp->tefuse));
-		nvmem_cell_put(cell);
-		return false;
-	}
-
-	svsp->tefuse_max /= sizeof(u32);
-	nvmem_cell_put(cell);
 
 	golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
 	if (!golden_temp)
@@ -1946,11 +1926,11 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	struct nvmem_cell *cell;
 	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
 	int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
 	int o_slope, o_slope_sign, ts_id;
 	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
+	int ret;
 
 	for (i = 0; i < svsp->efuse_max; i++)
 		if (svsp->efuse[i])
@@ -2026,24 +2006,9 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		}
 	}
 
-	/* Get thermal efuse by nvmem */
-	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
-	if (IS_ERR(cell)) {
-		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
-			PTR_ERR(cell));
-		goto remove_mt8183_svsb_mon_mode;
-	}
-
-	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
-	if (IS_ERR(svsp->tefuse)) {
-		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
-			PTR_ERR(svsp->tefuse));
-		nvmem_cell_put(cell);
-		goto remove_mt8183_svsb_mon_mode;
-	}
-
-	svsp->tefuse_max /= sizeof(u32);
-	nvmem_cell_put(cell);
+	ret = svs_thermal_efuse_get_data(svsp);
+	if (ret)
+		return false;
 
 	/* Thermal efuse parsing */
 	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
-- 
2.35.1

