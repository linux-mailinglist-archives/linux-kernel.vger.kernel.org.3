Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6209248750A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbiAGJwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:52:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48940 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237143AbiAGJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:52:07 -0500
X-UUID: 051e503f8cca4ea4ad27c6bf3376fd25-20220107
X-UUID: 051e503f8cca4ea4ad27c6bf3376fd25-20220107
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2091467111; Fri, 07 Jan 2022 17:52:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Jan 2022 17:52:01 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 17:52:01 +0800
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
        YT Lee <yt.lee@mediatek.com>,
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v21 4/8] soc: mediatek: SVS: add monitor mode
Date:   Fri, 7 Jan 2022 17:51:56 +0800
Message-ID: <20220107095200.4389-5-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220107095200.4389-1-roger.lu@mediatek.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVS monitor mode is based on different thermal temperature
to provide suitable SVS bank voltages.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 253 ++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index fc7e2ee44a92..042c6e8e9069 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/thermal.h>
 
 /* svs bank 1-line sw id */
 #define SVSB_CPU_LITTLE			BIT(0)
@@ -36,6 +37,7 @@
 #define SVSB_MODE_ALL_DISABLE		0
 #define SVSB_MODE_INIT01		BIT(1)
 #define SVSB_MODE_INIT02		BIT(2)
+#define SVSB_MODE_MON			BIT(3)
 
 /* svs bank volt flags */
 #define SVSB_INIT01_PD_REQ		BIT(0)
@@ -53,11 +55,16 @@
 #define SVSB_EN_INIT01			0x1
 #define SVSB_EN_INIT02			0x5
 #define SVSB_EN_MASK			0x7
+#define SVSB_EN_MON			0x2
 #define SVSB_EN_OFF			0x0
 #define SVSB_INTEN_INIT0x		0x00005f01
+#define SVSB_INTEN_MONVOPEN		0x00ff0000
 #define SVSB_INTSTS_CLEAN		0x00ffffff
 #define SVSB_INTSTS_COMPLETE		0x1
+#define SVSB_INTSTS_MONVOP		0x00ff0000
 #define SVSB_RUNCONFIG_DEFAULT		0x80000000
+#define SVSB_TEMP_LOWER_BOUND		0xb2
+#define SVSB_TEMP_UPPER_BOUND		0x64
 
 static DEFINE_SPINLOCK(svs_lock);
 
@@ -66,6 +73,7 @@ static DEFINE_SPINLOCK(svs_lock);
  * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
  * @SVSB_PHASE_INIT01: svs bank basic init for data calibration
  * @SVSB_PHASE_INIT02: svs bank can provide voltages to opp table
+ * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
  * @SVSB_PHASE_MAX: total number of svs bank phase (debug purpose)
  *
  * Each svs bank has its own independent phase and we enable each svs bank by
@@ -73,12 +81,13 @@ static DEFINE_SPINLOCK(svs_lock);
  * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
  *
  * svs bank general phase-enabled order:
- * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02
+ * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
  */
 enum svsb_phase {
 	SVSB_PHASE_ERROR = 0,
 	SVSB_PHASE_INIT01,
 	SVSB_PHASE_INIT02,
+	SVSB_PHASE_MON,
 	SVSB_PHASE_MAX,
 };
 
@@ -209,9 +218,11 @@ static const u32 svs_regs_v2[] = {
  * @probe: svs platform probe function pointer
  * @irqflags: svs platform irq settings flags
  * @efuse_max: total number of svs efuse
+ * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
  * @bank_max: total number of svs banks
  * @efuse: svs efuse data received from NVMEM framework
+ * @tefuse: thermal efuse data received from NVMEM framework
  */
 struct svs_platform {
 	char *name;
@@ -224,9 +235,11 @@ struct svs_platform {
 	int (*probe)(struct svs_platform *svsp);
 	unsigned long irqflags;
 	size_t efuse_max;
+	size_t tefuse_max;
 	const u32 *regs;
 	u32 bank_max;
 	u32 *efuse;
+	u32 *tefuse;
 };
 
 /**
@@ -241,6 +254,7 @@ struct svs_platform {
  * @get_volts: function pointer to get bank voltages
  * @name: bank name
  * @buck_name: regulator name
+ * @tzone_name: thermal zone name
  * @suspended: suspend flag of this bank
  * @phase: bank current phase
  * @volt_od: bank voltage overdrive
@@ -270,6 +284,13 @@ struct svs_platform {
  * @sw_id: bank software identification
  * @cpu_id: cpu core id for SVS CPU bank use only
  * @ctl0: TS-x selection
+ * @temp: bank temperature
+ * @tzone_htemp: thermal zone high temperature threshold
+ * @tzone_htemp_voffset: thermal zone high temperature voltage offset
+ * @tzone_ltemp: thermal zone low temperature threshold
+ * @tzone_ltemp_voffset: thermal zone low temperature voltage offset
+ * @bts: svs efuse data
+ * @mts: svs efuse data
  * @bdes: svs efuse data
  * @mdes: svs efuse data
  * @mtdes: svs efuse data
@@ -292,6 +313,7 @@ struct svs_bank {
 	void (*get_volts)(struct svs_platform *svsp);
 	char *name;
 	char *buck_name;
+	char *tzone_name;
 	bool suspended;
 	enum svsb_phase phase;
 	s32 volt_od;
@@ -321,6 +343,13 @@ struct svs_bank {
 	u32 sw_id;
 	u32 cpu_id;
 	u32 ctl0;
+	u32 temp;
+	u32 tzone_htemp;
+	u32 tzone_htemp_voffset;
+	u32 tzone_ltemp;
+	u32 tzone_ltemp_voffset;
+	u32 bts;
+	u32 mts;
 	u32 bdes;
 	u32 mdes;
 	u32 mtdes;
@@ -361,10 +390,21 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
 	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
 }
 
+static int svs_get_zone_temperature(const char *tzone_name, int *tzone_temp)
+{
+	struct thermal_zone_device *tzd;
+
+	tzd = thermal_zone_get_zone_by_name(tzone_name);
+	if (IS_ERR(tzd))
+		return PTR_ERR(tzd);
+
+	return thermal_zone_get_temp(tzd, tzone_temp);
+}
+
 static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 {
-	int ret = -EPERM;
-	u32 i, svsb_volt, opp_volt;
+	int ret = -EPERM, tzone_temp = 0;
+	u32 i, svsb_volt, opp_volt, temp_voffset = 0;
 
 	mutex_lock(&svsb->lock);
 
@@ -378,6 +418,22 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 		goto unlock_mutex;
 	}
 
+	/* Get thermal effect */
+	if (svsb->phase == SVSB_PHASE_MON) {
+		ret = svs_get_zone_temperature(svsb->tzone_name, &tzone_temp);
+		if (ret || (svsb->temp > SVSB_TEMP_UPPER_BOUND &&
+			    svsb->temp < SVSB_TEMP_LOWER_BOUND)) {
+			dev_err(svsb->dev, "%s: %d (0x%x), run default volts\n",
+				svsb->tzone_name, ret, svsb->temp);
+			svsb->phase = SVSB_PHASE_ERROR;
+		}
+
+		if (tzone_temp >= svsb->tzone_htemp)
+			temp_voffset += svsb->tzone_htemp_voffset;
+		else if (tzone_temp <= svsb->tzone_ltemp)
+			temp_voffset += svsb->tzone_ltemp_voffset;
+	}
+
 	/* vmin <= svsb_volt (opp_volt) <= default opp voltage */
 	for (i = 0; i < svsb->opp_count; i++) {
 		switch (svsb->phase) {
@@ -393,6 +449,13 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 							     svsb->volt_step,
 							     svsb->volt_base);
 			break;
+		case SVSB_PHASE_MON:
+			svsb_volt = max(svsb->volt[i] + temp_voffset,
+					svsb->vmin);
+			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
+							     svsb->volt_step,
+							     svsb->volt_base);
+			break;
 		default:
 			dev_err(svsb->dev, "unknown phase: %u\n", svsb->phase);
 			ret = -EINVAL;
@@ -488,7 +551,7 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 {
 	struct svs_bank *svsb = svsp->pbank;
 	u32 des_char, temp_char, det_char, limit_vals;
-	u32 init2vals;
+	u32 init2vals, ts_calcs;
 
 	svs_switch_bank(svsp);
 
@@ -529,6 +592,12 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 		svs_writel_relaxed(svsp, init2vals, INIT2VALS);
 		svs_writel_relaxed(svsp, SVSB_EN_INIT02, SVSEN);
 		break;
+	case SVSB_PHASE_MON:
+		ts_calcs = (svsb->bts << 12) | svsb->mts;
+		svs_writel_relaxed(svsp, ts_calcs, TSCALCS);
+		svs_writel_relaxed(svsp, SVSB_INTEN_MONVOPEN, INTEN);
+		svs_writel_relaxed(svsp, SVSB_EN_MON, SVSEN);
+		break;
 	default:
 		dev_err(svsb->dev, "requested unknown target phase: %u\n",
 			target_phase);
@@ -548,6 +617,7 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 	dev_err(svsb->dev, "SMSTATE0 = 0x%08x, SMSTATE1 = 0x%08x\n",
 		svs_readl_relaxed(svsp, SMSTATE0),
 		svs_readl_relaxed(svsp, SMSTATE1));
+	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
 
 	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	svsb->phase = SVSB_PHASE_ERROR;
@@ -599,6 +669,17 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
 	svs_writel_relaxed(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
 }
 
+static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+
+	svsb->phase = SVSB_PHASE_MON;
+	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
+	svsb->get_volts(svsp);
+
+	svs_writel_relaxed(svsp, SVSB_INTSTS_MONVOP, INTSTS);
+}
+
 static irqreturn_t svs_isr(int irq, void *data)
 {
 	struct svs_platform *svsp = data;
@@ -629,6 +710,8 @@ static irqreturn_t svs_isr(int irq, void *data)
 		else if (int_sts == SVSB_INTSTS_COMPLETE &&
 			 svs_en == SVSB_EN_INIT02)
 			svs_init02_isr_handler(svsp);
+		else if (int_sts & SVSB_INTSTS_MONVOP)
+			svs_mon_mode_isr_handler(svsp);
 		else
 			svs_error_isr_handler(svsp);
 
@@ -858,6 +941,25 @@ static int svs_init02(struct svs_platform *svsp)
 	return 0;
 }
 
+static void svs_mon_mode(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	unsigned long flags;
+	u32 idx;
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (!(svsb->mode_support & SVSB_MODE_MON))
+			continue;
+
+		spin_lock_irqsave(&svs_lock, flags);
+		svsp->pbank = svsb;
+		svs_set_bank_phase(svsp, SVSB_PHASE_MON);
+		spin_unlock_irqrestore(&svs_lock, flags);
+	}
+}
+
 static int svs_start(struct svs_platform *svsp)
 {
 	int ret;
@@ -870,6 +972,8 @@ static int svs_start(struct svs_platform *svsp)
 	if (ret)
 		return ret;
 
+	svs_mon_mode(svsp);
+
 	return 0;
 }
 
@@ -923,6 +1027,8 @@ static int svs_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	svs_mon_mode(svsp);
+
 	return 0;
 }
 
@@ -1007,7 +1113,11 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
-	u32 idx, i, ft_pgm;
+	struct nvmem_cell *cell;
+	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
+	int adc_ge_t, adc_oe_t, ge, oe, gain, degc_cali, adc_cali_en_t;
+	int o_slope, o_slope_sign, ts_id;
+	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
 
 	for (i = 0; i < svsp->efuse_max; i++)
 		if (svsp->efuse[i])
@@ -1083,6 +1193,126 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		}
 	}
 
+	/* Get thermal efuse by nvmem */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR(cell)) {
+		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n",
+			PTR_ERR(cell));
+		goto remove_mt8183_svsb_mon_mode;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
+	if (IS_ERR(svsp->tefuse)) {
+		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
+			PTR_ERR(svsp->tefuse));
+		goto remove_mt8183_svsb_mon_mode;
+	}
+
+	svsp->tefuse_max /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	/* Thermal efuse parsing */
+	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
+	adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
+
+	o_vtsmcu[0] = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
+	o_vtsmcu[1] = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
+	o_vtsmcu[2] = svsp->tefuse[1] & GENMASK(8, 0);
+	o_vtsmcu[3] = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
+	o_vtsmcu[4] = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
+	o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
+
+	degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
+	adc_cali_en_t = svsp->tefuse[0] & BIT(0);
+	o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
+
+	ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
+	o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
+
+	if (adc_cali_en_t == 1) {
+		if (!ts_id)
+			o_slope = 0;
+
+		if (adc_ge_t < 265 || adc_ge_t > 758 ||
+		    adc_oe_t < 265 || adc_oe_t > 758 ||
+		    o_vtsmcu[0] < -8 || o_vtsmcu[0] > 484 ||
+		    o_vtsmcu[1] < -8 || o_vtsmcu[1] > 484 ||
+		    o_vtsmcu[2] < -8 || o_vtsmcu[2] > 484 ||
+		    o_vtsmcu[3] < -8 || o_vtsmcu[3] > 484 ||
+		    o_vtsmcu[4] < -8 || o_vtsmcu[4] > 484 ||
+		    o_vtsabb < -8 || o_vtsabb > 484 ||
+		    degc_cali < 1 || degc_cali > 63) {
+			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
+			goto remove_mt8183_svsb_mon_mode;
+		}
+	} else {
+		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
+		goto remove_mt8183_svsb_mon_mode;
+	}
+
+	ge = ((adc_ge_t - 512) * 10000) / 4096;
+	oe = (adc_oe_t - 512);
+	gain = (10000 + ge);
+
+	format[0] = (o_vtsmcu[0] + 3350 - oe);
+	format[1] = (o_vtsmcu[1] + 3350 - oe);
+	format[2] = (o_vtsmcu[2] + 3350 - oe);
+	format[3] = (o_vtsmcu[3] + 3350 - oe);
+	format[4] = (o_vtsmcu[4] + 3350 - oe);
+	format[5] = (o_vtsabb + 3350 - oe);
+
+	for (i = 0; i < 6; i++)
+		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / gain;
+
+	temp0 = (10000 * 100000 / gain) * 15 / 18;
+
+	if (!o_slope_sign)
+		mts = (temp0 * 10) / (1534 + o_slope * 10);
+	else
+		mts = (temp0 * 10) / (1534 - o_slope * 10);
+
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mts = mts;
+
+		switch (svsb->sw_id) {
+		case SVSB_CPU_LITTLE:
+			tb_roomt = x_roomt[3];
+			break;
+		case SVSB_CPU_BIG:
+			tb_roomt = x_roomt[4];
+			break;
+		case SVSB_CCI:
+			tb_roomt = x_roomt[3];
+			break;
+		case SVSB_GPU:
+			tb_roomt = x_roomt[1];
+			break;
+		default:
+			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			goto remove_mt8183_svsb_mon_mode;
+		}
+
+		temp0 = (degc_cali * 10 / 2);
+		temp1 = ((10000 * 100000 / 4096 / gain) *
+			 oe + tb_roomt * 10) * 15 / 18;
+
+		if (!o_slope_sign)
+			temp2 = temp1 * 100 / (1534 + o_slope * 10);
+		else
+			temp2 = temp1 * 100 / (1534 - o_slope * 10);
+
+		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
+	}
+
+	return true;
+
+remove_mt8183_svsb_mon_mode:
+	for (idx = 0; idx < svsp->bank_max; idx++) {
+		svsb = &svsp->banks[idx];
+		svsb->mode_support &= ~SVSB_MODE_MON;
+	}
+
 	return true;
 }
 
@@ -1165,9 +1395,14 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 
 static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 {
+	struct device *dev;
 	struct svs_bank *svsb;
 	u32 idx;
 
+	dev = svs_add_device_link(svsp, "thermal");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
 
@@ -1275,9 +1510,11 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.set_freq_pct		= svs_set_bank_freq_pct_v2,
 		.get_volts		= svs_get_bank_volts_v2,
 		.buck_name		= "mali",
+		.tzone_name		= "tzts2",
 		.volt_flags		= SVSB_INIT01_PD_REQ |
 					  SVSB_INIT01_VOLT_INC_ONLY,
-		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
+		.mode_support		= SVSB_MODE_INIT01 | SVSB_MODE_INIT02 |
+					  SVSB_MODE_MON,
 		.opp_count		= MAX_OPP_ENTRIES,
 		.freq_base		= 900000000,
 		.vboot			= 0x30,
@@ -1293,6 +1530,10 @@ static struct svs_bank svs_mt8183_banks[] = {
 		.core_sel		= 0x8fff0003,
 		.int_st			= BIT(3),
 		.ctl0			= 0x00050001,
+		.tzone_htemp		= 85000,
+		.tzone_htemp_voffset	= 0,
+		.tzone_ltemp		= 25000,
+		.tzone_ltemp_voffset	= 3,
 	},
 };
 
-- 
2.18.0

