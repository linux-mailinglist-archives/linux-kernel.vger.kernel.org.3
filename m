Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBB4FE00E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiDLMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355413AbiDLMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:19:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5215AECB;
        Tue, 12 Apr 2022 04:21:45 -0700 (PDT)
X-UUID: d84b7cb7c5ae461ea52bdf46078bc3e3-20220412
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b6e91718-abc4-4b9e-b242-0201a4351f46,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:b6e91718-abc4-4b9e-b242-0201a4351f46,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:9d282378-0afa-4dca-bdec-ca54c998425a,C
        OID:19c63f3034d3,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: d84b7cb7c5ae461ea52bdf46078bc3e3-20220412
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 546475962; Tue, 12 Apr 2022 19:21:38 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Apr 2022 19:21:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Apr
 2022 19:21:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 19:21:36 +0800
From:   Tim Chang <jia-wei.chang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Subject: [PATCH 2/2] soc: mediatek: svs: add support for mt8186
Date:   Tue, 12 Apr 2022 19:21:27 +0800
Message-ID: <20220412112127.21570-3-jia-wei.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
References: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

MT8186 svs has a number of banks which used as optimization of opp
voltage table for corresponding dvfs drivers.
MT8186 svs big core uses 2-line high bank and low bank to optimize the
voltage of opp table for higher and lower frequency respectively.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 349 ++++++++++++++++++++++++++++++++-
 1 file changed, 342 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 83af7ac8cafb..a44176125871 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -356,6 +356,7 @@ struct svs_platform_data {
  * @dcbdet: svs efuse data
  * @dcmdet: svs efuse data
  * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
+ * @vbin_turn_pt: voltage bin turn point helps to know which svsb_volt should be overridden
  * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
  *
  * Svs bank will generate suitalbe voltages by below general math equation
@@ -419,6 +420,7 @@ struct svs_bank {
 	u32 dcbdet;
 	u32 dcmdet;
 	u32 turn_pt;
+	u32 vbin_turn_pt;
 	u32 type;
 };
 
@@ -694,11 +696,12 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 	ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
 	if (ret)
-		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
-			   svsb->name, svsb->turn_pt);
+		seq_printf(m, "%s: temperature ignore, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, svsb->vbin_turn_pt, svsb->turn_pt);
 	else
-		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
-			   svsb->name, tzone_temp, svsb->turn_pt);
+		seq_printf(m, "%s: temperature = %d, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, tzone_temp, svsb->vbin_turn_pt,
+			   svsb->turn_pt);
 
 	for (i = 0; i < svsb->opp_count; i++) {
 		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
@@ -891,9 +894,11 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 		opp_stop = svsb->opp_count;
 	}
 
-	for (i = opp_start; i < opp_stop; i++)
+	for (i = opp_start; i < opp_stop; i++) {
 		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
 			svsb->volt[i] -= svsb->dvt_fixed;
+		svsb->volt[i] += svsb->volt_od;
+	}
 }
 
 static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
@@ -984,6 +989,10 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 	struct svs_bank *svsb = svsp->pbank;
 	u32 temp, i;
 
+	if (svsb->phase == SVSB_PHASE_MON &&
+	    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
+		return;
+
 	temp = svs_readl_relaxed(svsp, VOP74);
 	svsb->volt[14] = (temp >> 24) & GENMASK(7, 0);
 	svsb->volt[12] = (temp >> 16) & GENMASK(7, 0);
@@ -1009,8 +1018,34 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 				     svsb->volt[14],
 				     svsb->freq_pct[15]);
 
-	for (i = 0; i < svsb->opp_count; i++)
+	for (i = 0; i < svsb->opp_count; i++) {
+		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
+			svsb->volt[i] -= svsb->dvt_fixed;
 		svsb->volt[i] += svsb->volt_od;
+	}
+
+	/* For voltage bin support */
+	if (svsb->opp_dfreq[0] > svsb->freq_base) {
+		svsb->volt[0] = svs_opp_volt_to_bank_volt(svsb->opp_dvolt[0],
+							  svsb->volt_step,
+							  svsb->volt_base);
+
+		/* Find voltage bin turn point */
+		for (i = 0; i < svsb->opp_count; i++) {
+			if (svsb->opp_dfreq[i] <= svsb->freq_base) {
+				svsb->vbin_turn_pt = i;
+				break;
+			}
+		}
+
+		/* Override svs bank voltages */
+		for (i = 1; i < svsb->vbin_turn_pt; i++)
+			svsb->volt[i] =	interpolate(svsb->freq_pct[0],
+						    svsb->freq_pct[svsb->vbin_turn_pt],
+						    svsb->volt[0],
+						    svsb->volt[svsb->vbin_turn_pt],
+						    svsb->freq_pct[i]);
+	}
 }
 
 static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
@@ -1564,7 +1599,12 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 			svsb->name = "SVSB_CPU_LITTLE";
 			break;
 		case SVSB_CPU_BIG:
-			svsb->name = "SVSB_CPU_BIG";
+			if (svsb->type == SVSB_HIGH)
+				svsb->name = "SVSB_CPU_BIG_HIGH";
+			else if (svsb->type == SVSB_LOW)
+				svsb->name = "SVSB_CPU_BIG_LOW";
+			else
+				svsb->name = "SVSB_CPU_BIG";
 			break;
 		case SVSB_CCI:
 			svsb->name = "SVSB_CCI";
@@ -1726,6 +1766,102 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 	return true;
 }
 
+static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct nvmem_cell *cell;
+	u32 idx, i, golden_temp;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[0]) {
+		dev_notice(svsp->dev, "svs_efuse[0] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_BIG:
+			if (svsb->type == SVSB_HIGH) {
+				svsb->mdes = (svsp->efuse[2] >> 24) & GENMASK(7, 0);
+				svsb->bdes = (svsp->efuse[2] >> 16) & GENMASK(7, 0);
+				svsb->mtdes = svsp->efuse[2] & GENMASK(7, 0);
+				svsb->dcmdet = (svsp->efuse[13] >> 8) & GENMASK(7, 0);
+				svsb->dcbdet = svsp->efuse[13] & GENMASK(7, 0);
+			} else if (svsb->type == SVSB_LOW) {
+				svsb->mdes = (svsp->efuse[3] >> 24) & GENMASK(7, 0);
+				svsb->bdes = (svsp->efuse[3] >> 16) & GENMASK(7, 0);
+				svsb->mtdes = svsp->efuse[3] & GENMASK(7, 0);
+				svsb->dcmdet = (svsp->efuse[14] >> 24) & GENMASK(7, 0);
+				svsb->dcbdet = (svsp->efuse[14] >> 16) & GENMASK(7, 0);
+			}
+			break;
+		case SVSB_CPU_LITTLE:
+			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
+			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
+			break;
+		case SVSB_CCI:
+			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
+			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
+			break;
+		case SVSB_GPU:
+			svsb->mdes = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
+			svsb->mtdes = svsp->efuse[6] & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[15] >> 8) & GENMASK(7, 0);
+			svsb->dcbdet = svsp->efuse[15] & GENMASK(7, 0);
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			return false;
+		}
+
+		svsb->vmax += svsb->dvt_fixed;
+	}
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
+		return false;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
+	if (IS_ERR(svsp->tefuse)) {
+		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
+			PTR_ERR(svsp->tefuse));
+		nvmem_cell_put(cell);
+		return false;
+	}
+
+	svsp->tefuse_max /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+	if (!golden_temp)
+		golden_temp = 50;
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = 409;
+		svsb->bts = (((500 * golden_temp + 204650) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
@@ -2041,6 +2177,49 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 	return 0;
 }
 
+static int svs_mt8186_platform_probe(struct svs_platform *svsp)
+{
+	struct device *dev;
+	struct svs_bank *svsb;
+	u32 idx;
+
+	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
+	if (IS_ERR(svsp->rst)) {
+		dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
+			      "cannot get svs reset control\n");
+		return PTR_ERR(svsp->rst);
+	}
+
+	dev = svs_add_device_link(svsp, "lvts");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+		case SVSB_CPU_BIG:
+			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
+			break;
+		case SVSB_CCI:
+			svsb->opp_dev = svs_add_device_link(svsp, "cci");
+			break;
+		case SVSB_GPU:
+			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			return -EINVAL;
+		}
+
+		if (IS_ERR(svsb->opp_dev))
+			return PTR_ERR(svsb->opp_dev);
+	}
+
+	return 0;
+}
+
 static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
@@ -2135,6 +2314,149 @@ static struct svs_bank svs_mt8192_banks[] = {
 	},
 };
 
+static struct svs_bank svs_mt8186_banks[] = {
+	{
+		.sw_id			= SVSB_CPU_BIG,
+		.type			= SVSB_LOW,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.cpu_id			= 6,
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 1670000000,
+		.turn_freq_base		= 1670000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_od		= 4,
+		.vmax			= 0x59,
+		.vmin			= 0x20,
+		.age_config		= 0x1,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x3,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0100,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00540003,
+	},
+	{
+		.sw_id			= SVSB_CPU_BIG,
+		.type			= SVSB_HIGH,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.cpu_id			= 6,
+		.tzone_name		= "cpu_big0",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 2050000000,
+		.turn_freq_base		= 1670000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_od		= 4,
+		.vmax			= 0x73,
+		.vmin			= 0x20,
+		.age_config		= 0x1,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0101,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00540003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 8,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 8,
+	},
+	{
+		.sw_id			= SVSB_CPU_LITTLE,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.cpu_id			= 0,
+		.tzone_name		= "cpu_zone0",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 2000000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_od		= 3,
+		.vmax			= 0x65,
+		.vmin			= 0x20,
+		.age_config		= 0x1,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0102,
+		.int_st			= BIT(2),
+		.ctl0			= 0x3210000f,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 8,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 8,
+	},
+	{
+		.sw_id			= SVSB_CCI,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.tzone_name		= "cpu_zone0",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 1400000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_od		= 3,
+		.vmax			= 0x65,
+		.vmin			= 0x20,
+		.age_config		= 0x1,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0103,
+		.int_st			= BIT(3),
+		.ctl0			= 0x3210000f,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 8,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 8,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freq_pct		= svs_set_bank_freq_pct_v2,
+		.get_volts		= svs_get_bank_volts_v2,
+		.tzone_name		= "mfg",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 850000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x58,
+		.vmin			= 0x20,
+		.age_config		= 0x555555,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x4,
+		.vco			= 0x10,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0104,
+		.int_st			= BIT(4),
+		.ctl0			= 0x00100003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 8,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 7,
+	},
+};
+
 static struct svs_bank svs_mt8183_banks[] = {
 	{
 		.sw_id			= SVSB_CPU_LITTLE,
@@ -2249,6 +2571,16 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
 	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
 };
 
+static const struct svs_platform_data svs_mt8186_platform_data = {
+	.name = "mt8186-svs",
+	.banks = svs_mt8186_banks,
+	.efuse_parsing = svs_mt8186_efuse_parsing,
+	.probe = svs_mt8186_platform_probe,
+	.irqflags = IRQF_TRIGGER_HIGH,
+	.regs = svs_regs_v2,
+	.bank_max = ARRAY_SIZE(svs_mt8186_banks),
+};
+
 static const struct svs_platform_data svs_mt8183_platform_data = {
 	.name = "mt8183-svs",
 	.banks = svs_mt8183_banks,
@@ -2263,6 +2595,9 @@ static const struct of_device_id svs_of_match[] = {
 	{
 		.compatible = "mediatek,mt8192-svs",
 		.data = &svs_mt8192_platform_data,
+	}, {
+		.compatible = "mediatek,mt8186-svs",
+		.data = &svs_mt8186_platform_data,
 	}, {
 		.compatible = "mediatek,mt8183-svs",
 		.data = &svs_mt8183_platform_data,
-- 
2.18.0

