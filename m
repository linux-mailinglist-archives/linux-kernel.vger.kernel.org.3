Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893A249D96A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiA0DkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:40:10 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235849AbiA0DkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:40:05 -0500
X-UUID: 35c24717b9564b018508f858bfc3b82c-20220127
X-UUID: 35c24717b9564b018508f858bfc3b82c-20220127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1759557088; Thu, 27 Jan 2022 11:40:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 11:39:58 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 11:39:58 +0800
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v22 4/7] soc: mediatek: SVS: add monitor mode
Date:   Thu, 27 Jan 2022 11:39:53 +0800
Message-ID: <20220127033956.24585-5-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220127033956.24585-1-roger.lu@mediatek.com>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
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
index 2d7ea3d607c4..be53470d439c 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/thermal.h>
 
 /* svs bank 1-line software id */
 #define SVSB_CPU_LITTLE			BIT(0)
@@ -36,6 +37,7 @@
 #define SVSB_MODE_ALL_DISABLE		0
 #define SVSB_MODE_INIT01		BIT(1)
 #define SVSB_MODE_INIT02		BIT(2)
+#define SVSB_MODE_MON			BIT(3)
 
 /* svs bank volt flags */
 #define SVSB_INIT01_PD_REQ		BIT(0)
@@ -49,16 +51,21 @@
 #define SVSB_DTLO			0xfe
 #define SVSB_EN_INIT01			0x1
 #define SVSB_EN_INIT02			0x5
+#define SVSB_EN_MON			0x2
 #define SVSB_EN_OFF			0x0
 #define SVSB_INTEN_INIT0x		0x00005f01
+#define SVSB_INTEN_MONVOPEN		0x00ff0000
 #define SVSB_INTSTS_CLEAN		0x00ffffff
 #define SVSB_INTSTS_COMPLETE		0x1
+#define SVSB_INTSTS_MONVOP		0x00ff0000
 #define SVSB_RUNCONFIG_DEFAULT		0x80000000
 
 /* svs bank related setting */
 #define MAX_OPP_ENTRIES			16
 #define SVSB_DC_SIGNED_BIT		BIT(15)
 #define SVSB_DET_CLK_EN			BIT(31)
+#define SVSB_TEMP_LOWER_BOUND		0xb2
+#define SVSB_TEMP_UPPER_BOUND		0x64
 
 static DEFINE_SPINLOCK(svs_lock);
 
@@ -67,6 +74,7 @@ static DEFINE_SPINLOCK(svs_lock);
  * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
  * @SVSB_PHASE_INIT01: svs bank basic init for data calibration
  * @SVSB_PHASE_INIT02: svs bank can provide voltages to opp table
+ * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
  * @SVSB_PHASE_MAX: total number of svs bank phase (debug purpose)
  *
  * Each svs bank has its own independent phase and we enable each svs bank by
@@ -74,12 +82,13 @@ static DEFINE_SPINLOCK(svs_lock);
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
 
@@ -210,9 +219,11 @@ static const u32 svs_regs_v2[] = {
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
@@ -225,9 +236,11 @@ struct svs_platform {
 	int (*probe)(struct svs_platform *svsp);
 	unsigned long irqflags;
 	size_t efuse_max;
+	size_t tefuse_max;
 	const u32 *regs;
 	u32 bank_max;
 	u32 *efuse;
+	u32 *tefuse;
 };
 
 struct svs_platform_data {
@@ -247,11 +260,13 @@ struct svs_platform_data {
  * @pd_dev: power domain device for SoC mtcmos control
  * @init_completion: the timeout completion for bank init
  * @buck: regulator used by opp_dev
+ * @tzd: thermal zone device for getting temperature
  * @lock: mutex lock to protect voltage update process
  * @set_freq_pct: function pointer to set bank frequency percent table
  * @get_volts: function pointer to get bank voltages
  * @name: bank name
  * @buck_name: regulator name
+ * @tzone_name: thermal zone name
  * @phase: bank current phase
  * @volt_od: bank voltage overdrive
  * @pm_runtime_enabled_count: bank pm runtime enabled count
@@ -280,6 +295,13 @@ struct svs_platform_data {
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
@@ -297,11 +319,13 @@ struct svs_bank {
 	struct device *pd_dev;
 	struct completion init_completion;
 	struct regulator *buck;
+	struct thermal_zone_device *tzd;
 	struct mutex lock;	/* lock to protect voltage update process */
 	void (*set_freq_pct)(struct svs_platform *svsp);
 	void (*get_volts)(struct svs_platform *svsp);
 	char *name;
 	char *buck_name;
+	char *tzone_name;
 	enum svsb_phase phase;
 	s32 volt_od;
 	u32 pm_runtime_enabled_count;
@@ -330,6 +354,13 @@ struct svs_bank {
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
@@ -372,11 +403,27 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
 
 static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 {
-	int ret = -EPERM;
-	u32 i, svsb_volt, opp_volt;
+	int ret = -EPERM, tzone_temp = 0;
+	u32 i, svsb_volt, opp_volt, temp_voffset = 0;
 
 	mutex_lock(&svsb->lock);
 
+	/* Get thermal effect */
+	if (svsb->phase == SVSB_PHASE_MON) {
+		ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
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
@@ -392,6 +439,13 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
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
@@ -486,7 +540,7 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
 			       enum svsb_phase target_phase)
 {
 	struct svs_bank *svsb = svsp->pbank;
-	u32 des_char, temp_char, det_char, limit_vals, init2vals;
+	u32 des_char, temp_char, det_char, limit_vals, init2vals, ts_calcs;
 
 	svs_switch_bank(svsp);
 
@@ -527,6 +581,12 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
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
@@ -546,6 +606,7 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
 	dev_err(svsb->dev, "SMSTATE0 = 0x%08x, SMSTATE1 = 0x%08x\n",
 		svs_readl_relaxed(svsp, SMSTATE0),
 		svs_readl_relaxed(svsp, SMSTATE1));
+	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
 
 	svsb->phase = SVSB_PHASE_ERROR;
 	svs_writel_relaxed(svsp, SVSB_EN_OFF, SVSEN);
@@ -593,6 +654,17 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
 	svs_writel_relaxed(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
 }
 
+static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+
+	svsb->phase = SVSB_PHASE_MON;
+	svsb->get_volts(svsp);
+
+	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
+	svs_writel_relaxed(svsp, SVSB_INTSTS_MONVOP, INTSTS);
+}
+
 static irqreturn_t svs_isr(int irq, void *data)
 {
 	struct svs_platform *svsp = data;
@@ -623,6 +695,8 @@ static irqreturn_t svs_isr(int irq, void *data)
 		else if (int_sts == SVSB_INTSTS_COMPLETE &&
 			 svs_en == SVSB_EN_INIT02)
 			svs_init02_isr_handler(svsp);
+		else if (int_sts & SVSB_INTSTS_MONVOP)
+			svs_mon_mode_isr_handler(svsp);
 		else
 			svs_error_isr_handler(svsp);
 
@@ -843,6 +917,25 @@ static int svs_init02(struct svs_platform *svsp)
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
@@ -855,6 +948,8 @@ static int svs_start(struct svs_platform *svsp)
 	if (ret)
 		return ret;
 
+	svs_mon_mode(svsp);
+
 	return 0;
 }
 
@@ -900,6 +995,8 @@ static int svs_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	svs_mon_mode(svsp);
+
 	return 0;
 }
 
@@ -964,6 +1061,15 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 			}
 		}
 
+		if (svsb->mode_support & SVSB_MODE_MON) {
+			svsb->tzd = thermal_zone_get_zone_by_name(svsb->tzone_name);
+			if (IS_ERR(svsb->tzd)) {
+				dev_err(svsb->dev, "cannot get \"%s\" thermal zone\n",
+					svsb->tzone_name);
+				return PTR_ERR(svsb->tzd);
+			}
+		}
+
 		count = dev_pm_opp_get_opp_count(svsb->opp_dev);
 		if (svsb->opp_count != count) {
 			dev_err(svsb->dev,
@@ -994,7 +1100,11 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
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
@@ -1070,6 +1180,126 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
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
 
@@ -1152,9 +1382,14 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 
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
 
@@ -1261,9 +1496,11 @@ static struct svs_bank svs_mt8183_banks[] = {
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
@@ -1279,6 +1516,10 @@ static struct svs_bank svs_mt8183_banks[] = {
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

