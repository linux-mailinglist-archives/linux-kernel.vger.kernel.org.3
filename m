Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB1A4FDDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiDLLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348546AbiDLLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:35:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040B30F74;
        Tue, 12 Apr 2022 03:14:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CAEbY9065764;
        Tue, 12 Apr 2022 05:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649758477;
        bh=GrYojz+2c8sbfBkieUPvc/ubL5HuENlzr513D/n1sPw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lAfIru8Xcs18PlQ0o+dNRfjYdc4Rlumz43d3dhrkK0AEebyzGT7W9YJjh+d3BeHp2
         417QjPpgaOgvUQdM9l8mtJLtlvQ2adqBCd9COTYQjA/8Qfn7I0FjggdA96o9HC6IPE
         1oUPhFYMkOwyrnZO+Og6ZXuESKSYXOG2Fb3EVQaI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CAEb8E094840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 05:14:37 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 05:14:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 05:14:36 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CAEJmR122452;
        Tue, 12 Apr 2022 05:14:33 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Tue, 12 Apr 2022 15:44:09 +0530
Message-ID: <20220412101409.7980-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220412101409.7980-1-j-keerthy@ti.com>
References: <20220412101409.7980-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VTM thermal support. In the Voltage Thermal Management
Module(VTM), K3 J72XX supplies a voltage reference and a temperature
sensor feature that are gathered in the band gap voltage and
temperature sensor (VBGAPTS) module. The band gap provides current and
voltage reference for its internal circuits and other analog IP
blocks. The analog-to-digital converter (ADC) produces an output value
that is proportional to the silicon temperature.

Currently reading temperatures only is supported.  There are no
active/passive cooling agent supported.

J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455

The VTM Temperature Monitors (TEMPSENSORs) are trimmed during production,
with the resulting values stored in software-readable registers. Software
should use these  register values when translating the Temperature
Monitor output codes to temperature values.

It has an involved workaround. Software needs to read the error codes for
-40C, 30C, 125C from the efuse for each device & derive a new look up table
for adc to temperature conversion. Involved calculating slopes & constants
using 3 different straight line equations with adc refernce codes as the
y-axis & error codes in the x-axis.

-40C to 30C
30C to 125C
125C to 150C

With the above 2 line equations we derive the full look-up table to
workaround the errata i2128 for j721e SoC.

Tested temperature reading on J721e SoC & J7200 SoC.

[daniel.lezcano@linaro.org: Generate look-up tables run-time]
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes from v4:

  * Fixed all the comments on v4.
  * Simplified the computation of the table.
  * Removed unnecessary members in the structures.
  * int_pow in the math.h is for unsigned. Keeping the definition for signed

 drivers/thermal/Makefile           |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c | 623 +++++++++++++++++++++++++++++
 2 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index f0c36a1530d5..def8e1a0399c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -28,7 +28,7 @@ thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
-obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o
+obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
new file mode 100644
index 000000000000..28f3a8e5d6cd
--- /dev/null
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI Bandgap temperature sensor driver for J72XX SoC Family
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/types.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/thermal.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/math.h>
+#include <linux/slab.h>
+
+#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
+#define K3_VTM_DEVINFO_PWR0_CVD_CT_MASK		0xf
+#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
+#define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
+#define K3_VTM_MISC_CTRL_OFFSET			0xc
+#define K3_VTM_TMPSENS_STAT_OFFSET		0x8
+#define K3_VTM_ANYMAXT_OUTRG_ALERT_EN		0x1
+#define K3_VTM_MISC_CTRL2_OFFSET		0x10
+#define K3_VTM_REGS_PER_TS			0x10
+#define K3_VTM_TS_STAT_DTEMP_MASK		0x3ff
+#define K3_VTM_MAX_NUM_TS			8
+#define K3_VTM_TMPSENS_CTRL_CBIASSEL		BIT(0)
+#define K3_VTM_TMPSENS_CTRL_SOC			BIT(5)
+#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
+#define K3_VTM_TMPSENS_CTRL_CLKON_REQ		BIT(7)
+#define K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN	BIT(11)
+
+#define K3_VTM_CORRECTION_TEMP_CNT		3
+
+#define K3_VTM_ADC_BEGIN_VAL			6
+#define K3_VTM_ADC_END_VAL			944
+
+#define MINUS40CREF				5
+#define PLUS30CREF				253
+#define PLUS125CREF				730
+#define PLUS150CREF				940
+
+#define MAX_TEMP				123000
+#define COOL_DOWN_TEMP				105000
+
+#define FACTORS_REDUCTION			13
+static int *derived_table;
+
+static s64 int_power(unsigned long long base, unsigned int exp)
+{
+	s64 result = 1;
+
+	while (exp) {
+		if (exp & 1)
+			result *= base;
+		exp >>= 1;
+		base *= base;
+	}
+
+	return result;
+}
+
+static int compute_value(int index, s64 *factors, int nr_factors, int reduction)
+{
+	s64 value = 0;
+	int i;
+
+	for (i = 0; i < nr_factors; i++)
+		value += factors[i] * int_power(index, i);
+
+	return (int)(value / int_power(10, reduction));
+}
+
+static void init_table(int factors_size, int *table, s64 *factors)
+{
+	const int size = 1024;
+	int i;
+
+	for (i = 0; i < size; i++)
+		table[i] = compute_value(i, factors, factors_size,
+					 FACTORS_REDUCTION);
+}
+
+/**
+ * struct err_values - structure containing error/reference values
+ * @refs: reference error values for -40C, 30C, 125C & 150C
+ * @errs: Actual error values for -40C, 30C, 125C & 150C read from the efuse
+ */
+struct err_values {
+	int refs[4];
+	int errs[4];
+};
+
+static void create_table_segments(struct err_values *err_vals, int seg,
+				  int *ref_table)
+{
+	int m = 0, c, num, den, i, err, idx1, idx2, err1, err2, ref1, ref2;
+
+	if (seg == 0)
+		idx1 = 0;
+	else
+		idx1 = err_vals->refs[seg];
+
+	idx2 = err_vals->refs[seg + 1];
+	err1 = err_vals->errs[seg];
+	err2 = err_vals->errs[seg + 1];
+	ref1 = err_vals->refs[seg];
+	ref2 = err_vals->refs[seg + 1];
+
+	/*
+	 * Calculate the slope with adc values read from the register
+	 * as the y-axis param and err in adc value as x-axis param
+	 */
+	num = ref2 - ref1;
+	den = err2 - err1;
+	if (den)
+		m = num / den;
+	c = ref2 - m * err2;
+
+	/*
+	 * Take care of divide by zero error if error values are same
+	 * Or when the slope is 0
+	 */
+	if (den != 0 && m != 0) {
+		for (i = idx1; i <= idx2; i++) {
+			err = (i - c) / m;
+			if (((i + err1) < 0) || ((i + err1) > 1023))
+				continue;
+			derived_table[i] = ref_table[i + err];
+		}
+	} else { /* Constant error take care of divide by zero */
+		for (i = idx1; i <= idx2; i++) {
+			if (((i + err1) < 0) || ((i + err1) > 1023))
+				continue;
+			derived_table[i] = ref_table[i + err1];
+		}
+	}
+}
+
+static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
+{
+	int inc, i, seg;
+
+	/*
+	 * Fill up the lookup table under 3 segments
+	 * region -40C to +30C
+	 * region +30C to +125C
+	 * region +125C to +150C
+	 */
+	for (seg = 0; seg < 3; seg++)
+		create_table_segments(err_vals, seg, ref_table);
+
+	/* Get to the first valid temperature */
+	i = 0;
+	while (!derived_table[i])
+		i++;
+
+	/*
+	 * Get to the last zero index and back fill the temperature for
+	 * sake of continuity
+	 */
+	if (i) {
+		/* 300 milli celsius steps */
+		while (i--)
+			derived_table[i] = derived_table[i + 1] - 300;
+		/* case 0 */
+		derived_table[i] = derived_table[i + 1] - 300;
+	}
+
+	/*
+	 * Fill the last trailing 0s which are unfilled with increments of
+	 * 100 milli celsius till 1023 code
+	 */
+	i = 1023;
+	while (!derived_table[i])
+		i--;
+
+	i++;
+	inc = 1;
+	while (i < 1024) {
+		derived_table[i] = derived_table[i - 1] + inc * 100;
+		i++;
+	}
+
+	return 0;
+}
+
+struct k3_thermal_data;
+
+struct k3_j72xx_bandgap {
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *cfg2_base;
+	void __iomem *fuse_base;
+	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
+};
+
+/* common data structures */
+struct k3_thermal_data {
+	struct k3_j72xx_bandgap *bgp;
+	u32 ctrl_offset;
+	u32 stat_offset;
+};
+
+static int two_cmp(int tmp, int mask)
+{
+	tmp = ~(tmp);
+	tmp &= mask;
+	tmp += 1;
+
+	/* Return negative value */
+	return (0 - tmp);
+}
+
+static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
+				       unsigned int s2)
+{
+	int d01 = abs(s0 - s1);
+	int d02 = abs(s0 - s2);
+	int d12 = abs(s1 - s2);
+
+	if (d01 <= d02 && d01 <= d12)
+		return (s0 + s1) / 2;
+
+	if (d02 <= d01 && d02 <= d12)
+		return (s0 + s2) / 2;
+
+	return (s1 + s2) / 2;
+}
+
+static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
+				   int *temp)
+{
+	struct k3_j72xx_bandgap *bgp;
+	unsigned int dtemp, s0, s1, s2;
+
+	bgp = devdata->bgp;
+	/*
+	 * Errata is applicable for am654 pg 1.0 silicon/J7ES. There
+	 * is a variation of the order for certain degree centigrade on AM654.
+	 * Work around that by getting the average of two closest
+	 * readings out of three readings everytime we want to
+	 * report temperatures.
+	 *
+	 * Errata workaround.
+	 */
+	s0 = readl(bgp->base + devdata->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	s1 = readl(bgp->base + devdata->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	s2 = readl(bgp->base + devdata->stat_offset) &
+		K3_VTM_TS_STAT_DTEMP_MASK;
+	dtemp = vtm_get_best_value(s0, s1, s2);
+
+	if (dtemp < 0 || dtemp > 1023)
+		return -EINVAL;
+
+	*temp = derived_table[dtemp];
+
+	return 0;
+}
+
+/* Get temperature callback function for thermal zone */
+static int k3_thermal_get_temp(void *devdata, int *temp)
+{
+	struct k3_thermal_data *data = devdata;
+	int ret = 0;
+
+	ret = k3_bgp_read_temp(data, temp);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+	.get_temp = k3_thermal_get_temp,
+};
+
+static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
+{
+	int low = 0, high = 1023, mid;
+
+	if (temp > 160000 || temp < -50000)
+		return -EINVAL;
+
+	/* Binary search to find the adc code */
+	while (low < (high - 1)) {
+		mid = (low + high) / 2;
+		if (temp <= derived_table[mid])
+			high = mid;
+		else
+			low = mid;
+	}
+
+	return mid;
+}
+
+static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
+			     struct k3_j72xx_bandgap *bgp)
+{
+	int i, tmp, pow;
+	int ct_offsets[K3_VTM_CORRECTION_TEMP_CNT];
+	int ct_bm[K3_VTM_CORRECTION_TEMP_CNT];
+
+	/* Populate efuse reg offsets & Bit masks for -40C, 30C, 125C */
+	switch (id) {
+	case 0:
+		ct_offsets[0] = 0x0;
+		ct_offsets[1] = 0x8;
+		ct_offsets[2] = 0x4;
+		ct_bm[0] = 0x3f;
+		ct_bm[1] = 0x1fe000;
+		ct_bm[2] = 0x1ff;
+		break;
+
+	case 1:
+		ct_offsets[0] = 0x0;
+		ct_offsets[1] = 0x8;
+		ct_offsets[2] = 0x4;
+		ct_bm[0] = 0xfc0;
+		ct_bm[1] = 0x1fe00000;
+		ct_bm[2] = 0x3fe00;
+		break;
+
+	case 2:
+		ct_offsets[0] = 0x0;
+		ct_offsets[1] = -1;
+		ct_offsets[2] = 0x4;
+		ct_bm[0] = 0x3f000;
+		ct_bm[1] = 0x7f800000;
+		ct_bm[2] = 0x7fc0000;
+		break;
+
+	case 3:
+		ct_offsets[0] = 0x0;
+		ct_offsets[1] = 0xC;
+		ct_offsets[2] = -1; /* Spread across 2 registers */
+		ct_bm[0] = 0xfc0000;
+		ct_bm[1] = 0x1fe0;
+		ct_bm[2] = 0x1f800000;
+		break;
+
+	case 4:
+		ct_offsets[0] = 0x0;
+		ct_offsets[1] = 0xc;
+		ct_offsets[2] = 0x8;
+		ct_bm[0] = 0x3f000000;
+		ct_bm[1] = 0x1fe000;
+		ct_bm[2] = 0x1ff0;
+		break;
+	}
+
+	for (i = 0; i < 3; i++) {
+		/* Extract the offset value using bit-mask */
+		if (ct_offsets[i] == -1 && i == 1) {
+			/* 25C offset Case of Sensor 2 split between 2 regs */
+			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
+			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
+			pow = tmp & 0x80;
+		} else if (ct_offsets[i] == -1 && i == 2) {
+			/* 125C Case of Sensor 3 split between 2 regs */
+			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
+			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
+			pow = tmp & 0x100;
+		} else {
+			tmp = readl(bgp->fuse_base + ct_offsets[i]);
+			tmp &= ct_bm[i];
+			tmp = tmp >> __ffs(ct_bm[i]);
+
+			/* Obtain the sign bit pow*/
+			pow = ct_bm[i] >> __ffs(ct_bm[i]);
+			pow += 1;
+			pow /= 2;
+		}
+
+		/* Check for negative value */
+		if (tmp & pow) {
+			/* 2's complement value */
+			tmp = two_cmp(tmp, ct_bm[i] >> __ffs(ct_bm[i]));
+		}
+		err[i] = tmp;
+	}
+
+	/* Err value for 150C is set to 0 */
+	err[i] = 0;
+}
+
+static void print_look_up_table(struct device *dev, int *ref_table)
+{
+	int i;
+
+	dev_dbg(dev, "The contents of derived array\n");
+	dev_dbg(dev, "Code   Temperaturei\n");
+	for (i = 0; i <= 1023; i++)
+		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
+}
+
+static const struct of_device_id of_k3_j72xx_bandgap_match[];
+
+struct k3_j72xx_bandgap_data {
+	unsigned int has_errata_i2128;
+};
+
+static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
+{
+	int ret = 0, cnt, val, id, table_size = 1024;
+	int high_max, low_temp;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct k3_j72xx_bandgap *bgp;
+	struct k3_thermal_data *data;
+	int workaround_needed = 0;
+	const struct k3_j72xx_bandgap_data *driver_data;
+	struct thermal_zone_device *ti_thermal;
+	int *ref_table;
+	struct err_values err_vals;
+
+	s64 golden_factors[] = {
+		-490019999999999936,
+		3251200000000000,
+		-1705800000000,
+		603730000,
+		-92627,
+	};
+
+	s64 pvt_wa_factors[] = {
+		-415230000000000000,
+		3126600000000000,
+		-1157800000000,
+	};
+
+	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
+	if (!bgp)
+		return -ENOMEM;
+
+	bgp->dev = dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	bgp->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(bgp->base))
+		return PTR_ERR(bgp->base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	bgp->cfg2_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(bgp->cfg2_base))
+		return PTR_ERR(bgp->cfg2_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bgp->fuse_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(bgp->fuse_base))
+		return PTR_ERR(bgp->fuse_base);
+
+	driver_data = of_device_get_match_data(dev);
+	if (driver_data)
+		workaround_needed = driver_data->has_errata_i2128;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
+	/* Get the sensor count in the VTM */
+	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
+	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
+	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
+
+	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	ref_table = devm_kzalloc(bgp->dev, sizeof(*ref_table) * table_size,
+				 GFP_KERNEL);
+	if (!ref_table) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	derived_table = devm_kzalloc(bgp->dev, sizeof(*derived_table) * table_size,
+				     GFP_KERNEL);
+	if (!derived_table) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	/* Workaround not needed if bit30/bit31 is set even for J721e */
+	if (workaround_needed && (readl(bgp->fuse_base + 0x0) & 0xc0000000) == 0xc0000000)
+		workaround_needed = false;
+
+	dev_dbg(bgp->dev, "Work around %sneeded\n",
+		workaround_needed ? "not " : "");
+
+	if (!workaround_needed)
+		init_table(5, ref_table, golden_factors);
+	else
+		init_table(3, ref_table, pvt_wa_factors);
+
+	/* Register the thermal sensors */
+	for (id = 0; id < cnt; id++) {
+		data[id].bgp = bgp;
+		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
+		data[id].stat_offset = data[id].ctrl_offset +
+					K3_VTM_TMPSENS_STAT_OFFSET;
+
+		if (workaround_needed) {
+			/* ref adc values for -40C, 30C & 125C respectively */
+			err_vals.refs[0] = MINUS40CREF;
+			err_vals.refs[1] = PLUS30CREF;
+			err_vals.refs[2] = PLUS125CREF;
+			err_vals.refs[3] = PLUS150CREF;
+			get_efuse_values(id, &data[id], err_vals.errs, bgp);
+		}
+
+		if (id == 0 && workaround_needed)
+			prep_lookup_table(&err_vals, ref_table);
+		else if (id == 0 && !workaround_needed)
+			memcpy(derived_table, ref_table, table_size * 4);
+
+		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
+		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
+			K3_VTM_TMPSENS_CTRL_SOC |
+			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
+		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
+
+		bgp->ts_data[id] = &data[id];
+		ti_thermal =
+		devm_thermal_zone_of_sensor_register(bgp->dev, id,
+						     &data[id],
+						     &k3_of_thermal_ops);
+		if (IS_ERR(ti_thermal)) {
+			dev_err(bgp->dev, "thermal zone device is NULL\n");
+			ret = PTR_ERR(ti_thermal);
+			goto err_alloc;
+		}
+	}
+
+	/*
+	 * Program TSHUT thresholds
+	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
+	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
+	 *         This is already taken care as per of init
+	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
+	 */
+	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
+	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
+
+	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
+	       K3_VTM_MISC_CTRL2_OFFSET);
+	mdelay(100);
+	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
+	       K3_VTM_MISC_CTRL_OFFSET);
+
+	platform_set_drvdata(pdev, bgp);
+
+	print_look_up_table(dev, ref_table);
+	/*
+	 * Now that the derived_table has the appropriate look up values
+	 * Free up the ref_table
+	 */
+	kfree(ref_table);
+
+	return 0;
+
+err_alloc:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
+{
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
+	.has_errata_i2128 = 1,
+};
+
+const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
+	.has_errata_i2128 = 0,
+};
+
+static const struct of_device_id of_k3_j72xx_bandgap_match[] = {
+	{
+		.compatible = "ti,j721e-vtm",
+		.data = (void *)&k3_j72xx_bandgap_j721e_data,
+	},
+	{
+		.compatible = "ti,j7200-vtm",
+		.data = (void *)&k3_j72xx_bandgap_j7200_data,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, of_k3_j72xx_bandgap_match);
+
+static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
+	.probe = k3_j72xx_bandgap_probe,
+	.remove = k3_j72xx_bandgap_remove,
+	.driver = {
+		.name = "k3-j72xx-soc-thermal",
+		.of_match_table	= of_k3_j72xx_bandgap_match,
+	},
+};
+
+module_platform_driver(k3_j72xx_bandgap_sensor_driver);
+
+MODULE_DESCRIPTION("K3 bandgap temperature sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
-- 
2.17.1

