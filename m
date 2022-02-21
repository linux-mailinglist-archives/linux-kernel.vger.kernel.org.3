Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C64BD660
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbiBUGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:41:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiBUGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:40:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F5443C0;
        Sun, 20 Feb 2022 22:39:46 -0800 (PST)
X-UUID: 99cdbd6f087e4930a90adce24e860438-20220221
X-UUID: 99cdbd6f087e4930a90adce24e860438-20220221
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 611477841; Mon, 21 Feb 2022 14:39:43 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Feb 2022 14:39:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Feb
 2022 14:39:41 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Feb 2022 14:39:41 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: [PATCH v23 7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
Date:   Mon, 21 Feb 2022 14:39:39 +0800
Message-ID: <20220221063939.14969-8-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220221063939.14969-1-roger.lu@mediatek.com>
References: <20220221063939.14969-1-roger.lu@mediatek.com>
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

mt8192 SVS GPU uses 2-line (high/low bank) HW architecture to provide
bank voltages. High bank helps update higher frequency's voltage
and low bank helps update lower frequency's voltage.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 471 ++++++++++++++++++++++++++++++++-
 1 file changed, 466 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 9cdb0f9a4f75..83af7ac8cafb 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -24,6 +24,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -35,6 +36,10 @@
 #define SVSB_CCI			BIT(2)
 #define SVSB_GPU			BIT(3)
 
+/* svs bank 2-line type */
+#define SVSB_LOW			BIT(8)
+#define SVSB_HIGH			BIT(9)
+
 /* svs bank mode support */
 #define SVSB_MODE_ALL_DISABLE		0
 #define SVSB_MODE_INIT01		BIT(1)
@@ -45,6 +50,8 @@
 #define SVSB_INIT01_PD_REQ		BIT(0)
 #define SVSB_INIT01_VOLT_IGNORE		BIT(1)
 #define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
+#define SVSB_MON_VOLT_IGNORE		BIT(16)
+#define SVSB_REMOVE_DVTFIXED_VOLT	BIT(24)
 
 /* svs bank register common configuration */
 #define SVSB_DET_MAX			0xffff
@@ -63,7 +70,9 @@
 #define SVSB_RUNCONFIG_DEFAULT		0x80000000
 
 /* svs bank related setting */
+#define BITS8				8
 #define MAX_OPP_ENTRIES			16
+#define REG_BYTES			4
 #define SVSB_DC_SIGNED_BIT		BIT(15)
 #define SVSB_DET_CLK_EN			BIT(31)
 #define SVSB_TEMP_LOWER_BOUND		0xb2
@@ -250,6 +259,7 @@ static const u32 svs_regs_v2[] = {
  * @main_clk: main clock for svs bank
  * @pbank: svs bank pointer needing to be protected by spin_lock section
  * @banks: svs banks that svs platform supports
+ * @rst: svs platform reset control
  * @efuse_parsing: svs platform efuse parsing function pointer
  * @probe: svs platform probe function pointer
  * @irqflags: svs platform irq settings flags
@@ -267,6 +277,7 @@ struct svs_platform {
 	struct clk *main_clk;
 	struct svs_bank *pbank;
 	struct svs_bank *banks;
+	struct reset_control *rst;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
 	int (*probe)(struct svs_platform *svsp);
 	unsigned long irqflags;
@@ -308,6 +319,7 @@ struct svs_platform_data {
  * @pm_runtime_enabled_count: bank pm runtime enabled count
  * @mode_support: bank mode support.
  * @freq_base: reference frequency for bank init
+ * @turn_freq_base: refenrece frequency for 2-line turn point
  * @vboot: voltage request for bank init01 only
  * @opp_dfreq: default opp frequency table
  * @opp_dvolt: default opp voltage table
@@ -343,6 +355,8 @@ struct svs_platform_data {
  * @mtdes: svs efuse data
  * @dcbdet: svs efuse data
  * @dcmdet: svs efuse data
+ * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
+ * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
  *
  * Svs bank will generate suitalbe voltages by below general math equation
  * and provide these voltages to opp voltage table.
@@ -368,6 +382,7 @@ struct svs_bank {
 	u32 pm_runtime_enabled_count;
 	u32 mode_support;
 	u32 freq_base;
+	u32 turn_freq_base;
 	u32 vboot;
 	u32 opp_dfreq[MAX_OPP_ENTRIES];
 	u32 opp_dvolt[MAX_OPP_ENTRIES];
@@ -403,6 +418,8 @@ struct svs_bank {
 	u32 mtdes;
 	u32 dcbdet;
 	u32 dcmdet;
+	u32 turn_pt;
+	u32 type;
 };
 
 static u32 percent(u32 numerator, u32 denominator)
@@ -438,13 +455,59 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
 	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
 }
 
+static u32 svs_opp_volt_to_bank_volt(u32 opp_u_volt, u32 svsb_volt_step,
+				     u32 svsb_volt_base)
+{
+	return (opp_u_volt - svsb_volt_base) / svsb_volt_step;
+}
+
+static int svs_sync_bank_volts_from_opp(struct svs_bank *svsb)
+{
+	struct dev_pm_opp *opp;
+	u32 i, opp_u_volt;
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
+						 svsb->opp_dfreq[i],
+						 true);
+		if (IS_ERR(opp)) {
+			dev_err(svsb->dev, "cannot find freq = %u (%ld)\n",
+				svsb->opp_dfreq[i], PTR_ERR(opp));
+			return PTR_ERR(opp);
+		}
+
+		opp_u_volt = dev_pm_opp_get_voltage(opp);
+		svsb->volt[i] = svs_opp_volt_to_bank_volt(opp_u_volt,
+							  svsb->volt_step,
+							  svsb->volt_base);
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+}
+
 static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 {
 	int ret = -EPERM, tzone_temp = 0;
-	u32 i, svsb_volt, opp_volt, temp_voffset = 0;
+	u32 i, svsb_volt, opp_volt, temp_voffset = 0, opp_start, opp_stop;
 
 	mutex_lock(&svsb->lock);
 
+	/*
+	 * 2-line bank updates its corresponding opp volts.
+	 * 1-line bank updates all opp volts.
+	 */
+	if (svsb->type == SVSB_HIGH) {
+		opp_start = 0;
+		opp_stop = svsb->turn_pt;
+	} else if (svsb->type == SVSB_LOW) {
+		opp_start = svsb->turn_pt;
+		opp_stop = svsb->opp_count;
+	} else {
+		opp_start = 0;
+		opp_stop = svsb->opp_count;
+	}
+
 	/* Get thermal effect */
 	if (svsb->phase == SVSB_PHASE_MON) {
 		ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
@@ -459,10 +522,16 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 			temp_voffset += svsb->tzone_htemp_voffset;
 		else if (tzone_temp <= svsb->tzone_ltemp)
 			temp_voffset += svsb->tzone_ltemp_voffset;
+
+		/* 2-line bank update all opp volts when running mon mode */
+		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+			opp_start = 0;
+			opp_stop = svsb->opp_count;
+		}
 	}
 
 	/* vmin <= svsb_volt (opp_volt) <= default opp voltage */
-	for (i = 0; i < svsb->opp_count; i++) {
+	for (i = opp_start; i < opp_stop; i++) {
 		switch (svsb->phase) {
 		case SVSB_PHASE_ERROR:
 			opp_volt = svsb->opp_dvolt[i];
@@ -625,9 +694,11 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 	ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
 	if (ret)
-		seq_printf(m, "%s: temperature ignore\n", svsb->name);
+		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
+			   svsb->name, svsb->turn_pt);
 	else
-		seq_printf(m, "%s: temperature = %d\n", svsb->name, tzone_temp);
+		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
+			   svsb->name, tzone_temp, svsb->turn_pt);
 
 	for (i = 0; i < svsb->opp_count; i++) {
 		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
@@ -733,6 +804,181 @@ static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
 	return DIV_ROUND_UP(vx, 100);
 }
 
+static void svs_get_bank_volts_v3(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+	u32 i, j, *vop, vop74, vop30, turn_pt = svsb->turn_pt;
+	u32 b_sft, shift_byte = 0, opp_start = 0, opp_stop = 0;
+	u32 middle_index = (svsb->opp_count / 2);
+
+	if (svsb->phase == SVSB_PHASE_MON &&
+	    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
+		return;
+
+	vop74 = svs_readl_relaxed(svsp, VOP74);
+	vop30 = svs_readl_relaxed(svsp, VOP30);
+
+	/* Target is to set svsb->volt[] by algorithm */
+	if (turn_pt < middle_index) {
+		if (svsb->type == SVSB_HIGH) {
+			/* volt[0] ~ volt[turn_pt - 1] */
+			for (i = 0; i < turn_pt; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				vop = (shift_byte < REG_BYTES) ? &vop30 :
+								 &vop74;
+				svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/* volt[turn_pt] + volt[j] ~ volt[opp_count - 1] */
+			j = svsb->opp_count - 7;
+			svsb->volt[turn_pt] = vop30 & GENMASK(7, 0);
+			shift_byte++;
+			for (i = j; i < svsb->opp_count; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				vop = (shift_byte < REG_BYTES) ? &vop30 :
+								 &vop74;
+				svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
+				shift_byte++;
+			}
+
+			/* volt[turn_pt + 1] ~ volt[j - 1] by interpolate */
+			for (i = turn_pt + 1; i < j; i++)
+				svsb->volt[i] = interpolate(svsb->freq_pct[turn_pt],
+							    svsb->freq_pct[j],
+							    svsb->volt[turn_pt],
+							    svsb->volt[j],
+							    svsb->freq_pct[i]);
+		}
+	} else {
+		if (svsb->type == SVSB_HIGH) {
+			/* volt[0] + volt[j] ~ volt[turn_pt - 1] */
+			j = turn_pt - 7;
+			svsb->volt[0] = vop30 & GENMASK(7, 0);
+			shift_byte++;
+			for (i = j; i < turn_pt; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				vop = (shift_byte < REG_BYTES) ? &vop30 :
+								 &vop74;
+				svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
+				shift_byte++;
+			}
+
+			/* volt[1] ~ volt[j - 1] by interpolate */
+			for (i = 1; i < j; i++)
+				svsb->volt[i] = interpolate(svsb->freq_pct[0],
+							    svsb->freq_pct[j],
+							    svsb->volt[0],
+							    svsb->volt[j],
+							    svsb->freq_pct[i]);
+		} else if (svsb->type == SVSB_LOW) {
+			/* volt[turn_pt] ~ volt[opp_count - 1] */
+			for (i = turn_pt; i < svsb->opp_count; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				vop = (shift_byte < REG_BYTES) ? &vop30 :
+								 &vop74;
+				svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
+				shift_byte++;
+			}
+		}
+	}
+
+	if (svsb->type == SVSB_HIGH) {
+		opp_start = 0;
+		opp_stop = svsb->turn_pt;
+	} else if (svsb->type == SVSB_LOW) {
+		opp_start = svsb->turn_pt;
+		opp_stop = svsb->opp_count;
+	}
+
+	for (i = opp_start; i < opp_stop; i++)
+		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
+			svsb->volt[i] -= svsb->dvt_fixed;
+}
+
+static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+	u32 i, j, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
+	u32 b_sft, shift_byte = 0, turn_pt;
+	u32 middle_index = (svsb->opp_count / 2);
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		if (svsb->opp_dfreq[i] <= svsb->turn_freq_base) {
+			svsb->turn_pt = i;
+			break;
+		}
+	}
+
+	turn_pt = svsb->turn_pt;
+
+	/* Target is to fill out freq_pct74 / freq_pct30 by algorithm */
+	if (turn_pt < middle_index) {
+		if (svsb->type == SVSB_HIGH) {
+			/*
+			 * If we don't handle this situation,
+			 * SVSB_HIGH's FREQPCT74 / FREQPCT30 would keep "0"
+			 * and this leads SVSB_LOW to work abnormally.
+			 */
+			if (turn_pt == 0)
+				freq_pct30 = svsb->freq_pct[0];
+
+			/* freq_pct[0] ~ freq_pct[turn_pt - 1] */
+			for (i = 0; i < turn_pt; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				freq_pct = (shift_byte < REG_BYTES) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freq_pct[i] << b_sft);
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/*
+			 * freq_pct[turn_pt] +
+			 * freq_pct[opp_count - 7] ~ freq_pct[opp_count -1]
+			 */
+			freq_pct30 = svsb->freq_pct[turn_pt];
+			shift_byte++;
+			j = svsb->opp_count - 7;
+			for (i = j; i < svsb->opp_count; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				freq_pct = (shift_byte < REG_BYTES) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freq_pct[i] << b_sft);
+				shift_byte++;
+			}
+		}
+	} else {
+		if (svsb->type == SVSB_HIGH) {
+			/*
+			 * freq_pct[0] +
+			 * freq_pct[turn_pt - 7] ~ freq_pct[turn_pt - 1]
+			 */
+			freq_pct30 = svsb->freq_pct[0];
+			shift_byte++;
+			j = turn_pt - 7;
+			for (i = j; i < turn_pt; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				freq_pct = (shift_byte < REG_BYTES) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freq_pct[i] << b_sft);
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/* freq_pct[turn_pt] ~ freq_pct[opp_count - 1] */
+			for (i = turn_pt; i < svsb->opp_count; i++) {
+				b_sft = BITS8 * (shift_byte % REG_BYTES);
+				freq_pct = (shift_byte < REG_BYTES) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freq_pct[i] << b_sft);
+				shift_byte++;
+			}
+		}
+	}
+
+	svs_writel_relaxed(svsp, freq_pct74, FREQPCT74);
+	svs_writel_relaxed(svsp, freq_pct30, FREQPCT30);
+}
+
 static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
@@ -1182,6 +1428,25 @@ static int svs_init02(struct svs_platform *svsp)
 		}
 	}
 
+	/*
+	 * 2-line high/low bank update its corresponding opp voltages only.
+	 * Therefore, we sync voltages from opp for high/low bank voltages
+	 * consistency.
+	 */
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (!(svsb->mode_support & SVSB_MODE_INIT02))
+			continue;
+
+		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+			if (svs_sync_bank_volts_from_opp(svsb)) {
+				dev_err(svsb->dev, "sync volt fail\n");
+				return -EPERM;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -1226,6 +1491,7 @@ static int svs_suspend(struct device *dev)
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
 	unsigned long flags;
+	int ret;
 	u32 idx;
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
@@ -1243,6 +1509,12 @@ static int svs_suspend(struct device *dev)
 		svs_adjust_pm_opp_volts(svsb);
 	}
 
+	ret = reset_control_assert(svsp->rst);
+	if (ret) {
+		dev_err(svsp->dev, "cannot assert reset %d\n", ret);
+		return ret;
+	}
+
 	clk_disable_unprepare(svsp->main_clk);
 
 	return 0;
@@ -1259,6 +1531,12 @@ static int svs_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = reset_control_deassert(svsp->rst);
+	if (ret) {
+		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
+		return ret;
+	}
+
 	ret = svs_init02(svsp);
 	if (ret)
 		return ret;
@@ -1292,7 +1570,12 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 			svsb->name = "SVSB_CCI";
 			break;
 		case SVSB_GPU:
-			svsb->name = "SVSB_GPU";
+			if (svsb->type == SVSB_HIGH)
+				svsb->name = "SVSB_GPU_HIGH";
+			else if (svsb->type == SVSB_LOW)
+				svsb->name = "SVSB_GPU_LOW";
+			else
+				svsb->name = "SVSB_GPU";
 			break;
 		default:
 			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
@@ -1365,6 +1648,84 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
+static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct nvmem_cell *cell;
+	u32 idx, i, vmin, golden_temp;
+
+	for (i = 0; i < svsp->efuse_max; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	if (!svsp->efuse[9]) {
+		dev_notice(svsp->dev, "svs_efuse[9] = 0x0?\n");
+		return false;
+	}
+
+	/* Svs efuse parsing */
+	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (vmin == 0x1)
+			svsb->vmin = 0x1e;
+
+		if (svsb->type == SVSB_LOW) {
+			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
+		} else if (svsb->type == SVSB_HIGH) {
+			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
+		}
+
+		svsb->vmax += svsb->dvt_fixed;
+	}
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
+			PTR_ERR(cell));
+		return false;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
+	if (IS_ERR(svsp->tefuse)) {
+		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
+			PTR_ERR(svsp->tefuse));
+		return false;
+	}
+
+	svsp->tefuse_max /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	for (i = 0; i < svsp->tefuse_max; i++)
+		if (svsp->tefuse[i] != 0)
+			break;
+
+	if (i == svsp->tefuse_max)
+		golden_temp = 50; /* All thermal efuse data are 0 */
+	else
+		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = 500;
+		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
@@ -1648,6 +2009,38 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	return dev;
 }
 
+static int svs_mt8192_platform_probe(struct svs_platform *svsp)
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
+		if (svsb->type == SVSB_HIGH)
+			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+		else if (svsb->type == SVSB_LOW)
+			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
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
@@ -1687,6 +2080,61 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 	return 0;
 }
 
+static struct svs_bank svs_mt8192_banks[] = {
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_LOW,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 688000000,
+		.turn_freq_base		= 688000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.age_config		= 0x555555,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x1,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0100,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00540003,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.type			= SVSB_HIGH,
+		.set_freq_pct		= svs_set_bank_freq_pct_v3,
+		.get_volts		= svs_get_bank_volts_v3,
+		.tzone_name		= "gpu1",
+		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= MAX_OPP_ENTRIES,
+		.freq_base		= 902000000,
+		.turn_freq_base		= 688000000,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.age_config		= 0x555555,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.core_sel		= 0x0fff0101,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00540003,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 7,
+	},
+};
+
 static struct svs_bank svs_mt8183_banks[] = {
 	{
 		.sw_id			= SVSB_CPU_LITTLE,
@@ -1791,6 +2239,16 @@ static struct svs_bank svs_mt8183_banks[] = {
 	},
 };
 
+static const struct svs_platform_data svs_mt8192_platform_data = {
+	.name = "mt8192-svs",
+	.banks = svs_mt8192_banks,
+	.efuse_parsing = svs_mt8192_efuse_parsing,
+	.probe = svs_mt8192_platform_probe,
+	.irqflags = IRQF_TRIGGER_HIGH,
+	.regs = svs_regs_v2,
+	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
+};
+
 static const struct svs_platform_data svs_mt8183_platform_data = {
 	.name = "mt8183-svs",
 	.banks = svs_mt8183_banks,
@@ -1803,6 +2261,9 @@ static const struct svs_platform_data svs_mt8183_platform_data = {
 
 static const struct of_device_id svs_of_match[] = {
 	{
+		.compatible = "mediatek,mt8192-svs",
+		.data = &svs_mt8192_platform_data,
+	}, {
 		.compatible = "mediatek,mt8183-svs",
 		.data = &svs_mt8183_platform_data,
 	}, {
-- 
2.18.0

