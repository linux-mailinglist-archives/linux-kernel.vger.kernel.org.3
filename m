Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF92498670
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbiAXRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:20:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:20837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244347AbiAXRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044828; x=1674580828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ol3QlmypIgkLYpGLJiPGUhUsKaWSsFp4xvZU8I5jV8I=;
  b=QlYHipZ4y6kTABQkAqS6piSaaneIalEFizNlktqsn6jt+7VRyZtRuOQx
   AQwfo+K+6CBHYEgRyZVNi5xUA9V9rJ1j5mmnqqwx5KsJMLf/KzoD4J0Vo
   V8KwRxzoRoPgEG+hscPBc+QOx2SwhXO2AIY8OsbjhEcel7NUfp2DNulS0
   GgzlGM6MGCczr3OdMKK2uxR4qNXpgYrwiVHaMwLwJ4zISxYd2mRl3zDnq
   KhFC98C+Jw82juS6q7sdSno3InnDz6V40L9gPahgtXrgYuMzPq0510tkM
   /S65hdiHQ53RunE5oT9pVB+HJcQkAZpvij0UWPDV/iUp8Nisb6Yl4Btwq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226079531"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226079531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534324057"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 09:20:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B44E29E7; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 4/6] iio: adc: qcom-vadc-common: Re-use generic struct u32_fract
Date:   Mon, 24 Jan 2022 19:20:30 +0200
Message-Id: <20220124172032.87893-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
References: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u32_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: no changes
v2: comile-tested, i.o.w. fixed compilation errors

 drivers/iio/adc/qcom-pm8xxx-xoadc.c      | 15 ++--
 drivers/iio/adc/qcom-spmi-vadc.c         | 24 +++----
 drivers/iio/adc/qcom-vadc-common.c       | 92 ++++++++++++------------
 include/linux/iio/adc/qcom-vadc-common.h | 15 +---
 4 files changed, 69 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 21d7eff645c3..5e9e56821075 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -175,7 +175,7 @@ struct xoadc_channel {
 	const char *datasheet_name;
 	u8 pre_scale_mux:2;
 	u8 amux_channel:4;
-	const struct vadc_prescale_ratio prescale;
+	const struct u32_fract prescale;
 	enum iio_chan_type type;
 	enum vadc_scale_fn_type scale_fn_type;
 	u8 amux_ip_rsv:3;
@@ -218,7 +218,9 @@ struct xoadc_variant {
 		.datasheet_name = __stringify(_dname),			\
 		.pre_scale_mux = _presmux,				\
 		.amux_channel = _amux,					\
-		.prescale = { .num = _prenum, .den = _preden },		\
+		.prescale = {						\
+			.numerator = _prenum, .denominator = _preden,	\
+		},							\
 		.type = _type,						\
 		.scale_fn_type = _scale,				\
 		.amux_ip_rsv = _amip,					\
@@ -809,12 +811,11 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
 		BIT(IIO_CHAN_INFO_PROCESSED);
 	iio_chan->indexed = 1;
 
-	dev_dbg(dev, "channel [PRESCALE/MUX: %02x AMUX: %02x] \"%s\" "
-		"ref voltage: %d, decimation %d "
-		"prescale %d/%d, scale function %d\n",
+	dev_dbg(dev,
+		"channel [PRESCALE/MUX: %02x AMUX: %02x] \"%s\" ref voltage: %d, decimation %d prescale %d/%d, scale function %d\n",
 		hwchan->pre_scale_mux, hwchan->amux_channel, ch->name,
-		ch->amux_ip_rsv, ch->decimation, hwchan->prescale.num,
-		hwchan->prescale.den, hwchan->scale_fn_type);
+		ch->amux_ip_rsv, ch->decimation, hwchan->prescale.numerator,
+		hwchan->prescale.denominator, hwchan->scale_fn_type);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 07b1a99381d9..34202ba52469 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -122,15 +122,15 @@ struct vadc_priv {
 	struct mutex		 lock;
 };
 
-static const struct vadc_prescale_ratio vadc_prescale_ratios[] = {
-	{.num =  1, .den =  1},
-	{.num =  1, .den =  3},
-	{.num =  1, .den =  4},
-	{.num =  1, .den =  6},
-	{.num =  1, .den = 20},
-	{.num =  1, .den =  8},
-	{.num = 10, .den = 81},
-	{.num =  1, .den = 10}
+static const struct u32_fract vadc_prescale_ratios[] = {
+	{ .numerator =  1, .denominator =  1 },
+	{ .numerator =  1, .denominator =  3 },
+	{ .numerator =  1, .denominator =  4 },
+	{ .numerator =  1, .denominator =  6 },
+	{ .numerator =  1, .denominator = 20 },
+	{ .numerator =  1, .denominator =  8 },
+	{ .numerator = 10, .denominator = 81 },
+	{ .numerator =  1, .denominator = 10 },
 };
 
 static int vadc_read(struct vadc_priv *vadc, u16 offset, u8 *data)
@@ -404,13 +404,13 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	return ret;
 }
 
-static int vadc_prescaling_from_dt(u32 num, u32 den)
+static int vadc_prescaling_from_dt(u32 numerator, u32 denominator)
 {
 	unsigned int pre;
 
 	for (pre = 0; pre < ARRAY_SIZE(vadc_prescale_ratios); pre++)
-		if (vadc_prescale_ratios[pre].num == num &&
-		    vadc_prescale_ratios[pre].den == den)
+		if (vadc_prescale_ratios[pre].numerator == numerator &&
+		    vadc_prescale_ratios[pre].denominator == denominator)
 			break;
 
 	if (pre == ARRAY_SIZE(vadc_prescale_ratios))
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 14723896aab2..6c6aec848f98 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -289,44 +289,44 @@ static const struct vadc_map_pt adcmap7_100k[] = {
 	{ 2420, 130048 }
 };
 
-static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
-	{.num =  1, .den =  1},
-	{.num =  1, .den =  3},
-	{.num =  1, .den =  4},
-	{.num =  1, .den =  6},
-	{.num =  1, .den = 20},
-	{.num =  1, .den =  8},
-	{.num = 10, .den = 81},
-	{.num =  1, .den = 10},
-	{.num =  1, .den = 16}
+static const struct u32_fract adc5_prescale_ratios[] = {
+	{ .numerator =  1, .denominator =  1 },
+	{ .numerator =  1, .denominator =  3 },
+	{ .numerator =  1, .denominator =  4 },
+	{ .numerator =  1, .denominator =  6 },
+	{ .numerator =  1, .denominator = 20 },
+	{ .numerator =  1, .denominator =  8 },
+	{ .numerator = 10, .denominator = 81 },
+	{ .numerator =  1, .denominator = 10 },
+	{ .numerator =  1, .denominator = 16 },
 };
 
 static int qcom_vadc_scale_hw_calib_volt(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_uv);
 static int qcom_vadc_scale_hw_calib_therm(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 static int qcom_vadc7_scale_hw_calib_therm(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_smb_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_chg5_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_calib_die_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 static int qcom_vadc7_scale_hw_calib_die_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
 
@@ -406,7 +406,7 @@ static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
 }
 
 static int qcom_vadc_scale_volt(const struct vadc_linear_graph *calib_graph,
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				bool absolute, u16 adc_code,
 				int *result_uv)
 {
@@ -414,15 +414,15 @@ static int qcom_vadc_scale_volt(const struct vadc_linear_graph *calib_graph,
 
 	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
 
-	voltage = voltage * prescale->den;
-	result = div64_s64(voltage, prescale->num);
+	voltage *= prescale->denominator;
+	result = div64_s64(voltage, prescale->numerator);
 	*result_uv = result;
 
 	return 0;
 }
 
 static int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
-				 const struct vadc_prescale_ratio *prescale,
+				 const struct u32_fract *prescale,
 				 bool absolute, u16 adc_code,
 				 int *result_mdec)
 {
@@ -444,7 +444,7 @@ static int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
 }
 
 static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
-				    const struct vadc_prescale_ratio *prescale,
+				    const struct u32_fract *prescale,
 				    bool absolute,
 				    u16 adc_code, int *result_mdec)
 {
@@ -454,8 +454,8 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
 
 	if (voltage > 0) {
-		temp = voltage * prescale->den;
-		do_div(temp, prescale->num * 2);
+		temp = voltage * prescale->denominator;
+		do_div(temp, prescale->numerator * 2);
 		voltage = temp;
 	} else {
 		voltage = 0;
@@ -467,7 +467,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 }
 
 static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
-				    const struct vadc_prescale_ratio *prescale,
+				    const struct u32_fract *prescale,
 				    bool absolute,
 				    u16 adc_code, int *result_mdec)
 {
@@ -475,8 +475,8 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
 
 	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
 
-	voltage = voltage * prescale->den;
-	voltage = div64_s64(voltage, prescale->num);
+	voltage *= prescale->denominator;
+	voltage = div64_s64(voltage, prescale->numerator);
 	voltage = ((PMI_CHG_SCALE_1) * (voltage * 2));
 	voltage = (voltage + PMI_CHG_SCALE_2);
 	result =  div64_s64(voltage, 1000000);
@@ -487,21 +487,21 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
 
 /* convert voltage to ADC code, using 1.875V reference */
 static u16 qcom_vadc_scale_voltage_code(s32 voltage,
-					const struct vadc_prescale_ratio *prescale,
+					const struct u32_fract *prescale,
 					const u32 full_scale_code_volt,
 					unsigned int factor)
 {
 	s64 volt = voltage;
 	s64 adc_vdd_ref_mv = 1875; /* reference voltage */
 
-	volt *= prescale->num * factor * full_scale_code_volt;
-	volt = div64_s64(volt, (s64)prescale->den * adc_vdd_ref_mv * 1000);
+	volt *= prescale->numerator * factor * full_scale_code_volt;
+	volt = div64_s64(volt, (s64)prescale->denominator * adc_vdd_ref_mv * 1000);
 
 	return volt;
 }
 
 static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				unsigned int factor)
 {
@@ -520,8 +520,8 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
 	voltage = div64_s64(voltage, data->full_scale_code_volt);
 	if (voltage > 0) {
-		voltage *= prescale->den;
-		temp = prescale->num * factor;
+		voltage *= prescale->denominator;
+		temp = prescale->numerator * factor;
 		voltage = div64_s64(voltage, temp);
 	} else {
 		voltage = 0;
@@ -531,7 +531,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 }
 
 static int qcom_vadc7_scale_hw_calib_therm(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -557,7 +557,7 @@ static int qcom_vadc7_scale_hw_calib_therm(
 }
 
 static int qcom_vadc_scale_hw_calib_volt(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_uv)
 {
@@ -568,7 +568,7 @@ static int qcom_vadc_scale_hw_calib_volt(
 }
 
 static int qcom_vadc_scale_hw_calib_therm(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -584,7 +584,7 @@ static int qcom_vadc_scale_hw_calib_therm(
 }
 
 static int qcom_vadc_scale_hw_calib_die_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -596,7 +596,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 }
 
 static int qcom_vadc7_scale_hw_calib_die_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -611,7 +611,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 }
 
 static int qcom_vadc_scale_hw_smb_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -623,7 +623,7 @@ static int qcom_vadc_scale_hw_smb_temp(
 }
 
 static int qcom_vadc_scale_hw_chg5_temp(
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
 {
@@ -636,7 +636,7 @@ static int qcom_vadc_scale_hw_chg5_temp(
 
 int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 		    const struct vadc_linear_graph *calib_graph,
-		    const struct vadc_prescale_ratio *prescale,
+		    const struct u32_fract *prescale,
 		    bool absolute,
 		    u16 adc_code, int *result)
 {
@@ -667,7 +667,7 @@ EXPORT_SYMBOL(qcom_vadc_scale);
 u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 				 u32 full_scale_code_volt, int temp)
 {
-	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+	const struct u32_fract *prescale = &adc5_prescale_ratios[prescale_ratio];
 	s32 voltage;
 
 	voltage = qcom_vadc_map_temp_voltage(adcmap_100k_104ef_104fb_1875_vref,
@@ -682,7 +682,7 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result)
 {
-	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+	const struct u32_fract *prescale = &adc5_prescale_ratios[prescale_ratio];
 
 	if (!(scaletype >= SCALE_HW_CALIB_DEFAULT &&
 		scaletype < SCALE_HW_CALIB_INVALID)) {
@@ -695,13 +695,13 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 }
 EXPORT_SYMBOL(qcom_adc5_hw_scale);
 
-int qcom_adc5_prescaling_from_dt(u32 num, u32 den)
+int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
 {
 	unsigned int pre;
 
 	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
-		if (adc5_prescale_ratios[pre].num == num &&
-		    adc5_prescale_ratios[pre].den == den)
+		if (adc5_prescale_ratios[pre].numerator == numerator &&
+		    adc5_prescale_ratios[pre].denominator == denominator)
 			break;
 
 	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 33f60f43e1aa..ce78d4804994 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -6,6 +6,7 @@
 #ifndef QCOM_VADC_COMMON_H
 #define QCOM_VADC_COMMON_H
 
+#include <linux/math.h>
 #include <linux/types.h>
 
 #define VADC_CONV_TIME_MIN_US			2000
@@ -79,16 +80,6 @@ struct vadc_linear_graph {
 	s32 gnd;
 };
 
-/**
- * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
- * @num: the inverse numerator of the gain applied to the input channel.
- * @den: the inverse denominator of the gain applied to the input channel.
- */
-struct vadc_prescale_ratio {
-	u32 num;
-	u32 den;
-};
-
 /**
  * enum vadc_scale_fn_type - Scaling function to convert ADC code to
  *				physical scaled units for the channel.
@@ -144,12 +135,12 @@ struct adc5_data {
 
 int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 		    const struct vadc_linear_graph *calib_graph,
-		    const struct vadc_prescale_ratio *prescale,
+		    const struct u32_fract *prescale,
 		    bool absolute,
 		    u16 adc_code, int *result_mdec);
 
 struct qcom_adc5_scale_type {
-	int (*scale_fn)(const struct vadc_prescale_ratio *prescale,
+	int (*scale_fn)(const struct u32_fract *prescale,
 		const struct adc5_data *data, u16 adc_code, int *result);
 };
 
-- 
2.34.1

