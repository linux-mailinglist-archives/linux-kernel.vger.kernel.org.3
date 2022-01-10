Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC9489F03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiAJSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:17:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:39573 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238898AbiAJSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641838626; x=1673374626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9s5Du4f2yZLctsj3Xd+IrsaX7TqFktojLsiV/xqgnM=;
  b=aM2W94P2miigeQM/kda+DIg3lovQXilzLf1YCp25firx4Y/nSs+DIwfM
   8ArXcma3gQeUTXj3T2urEFm//pm5YHwSmHn+EZCMyMoLNn4+OLJoAqNbb
   W7X91gP6w1g90fzRhsfQvRU7WRl6zpC46D0Oro2ULbl0peJH4+SnWgjSq
   FK3y3uZ5BR1cPDbYV7NCFUq3rsVQLmaeSCCVVBomgjrQrZym7h41Ofr+J
   M1HnPLIDbuThCB9L80zEzT5czt4WT+4HiQWC0h5sgfblXS2gfokrlIj5b
   i4LKrjcH5vdNJNVK9qu45pG7tpkfRJMYW5wHFW8Wdy9bZI1M3En0TtkP+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="240839567"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="240839567"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="514765365"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2022 10:17:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EED36232; Mon, 10 Jan 2022 20:17:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 4/5] iio: adc: qcom-vadc-common: Re-use generic struct u32_fract
Date:   Mon, 10 Jan 2022 20:17:10 +0200
Message-Id: <20220110181711.65054-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
References: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u32_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c      |  2 +-
 drivers/iio/adc/qcom-spmi-vadc.c         |  2 +-
 drivers/iio/adc/qcom-vadc-common.c       | 48 ++++++++++++------------
 include/linux/iio/adc/qcom-vadc-common.h | 15 ++------
 4 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 21d7eff645c3..ef249d745d85 100644
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
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 07b1a99381d9..69733564fa42 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -122,7 +122,7 @@ struct vadc_priv {
 	struct mutex		 lock;
 };
 
-static const struct vadc_prescale_ratio vadc_prescale_ratios[] = {
+static const struct u32_fract vadc_prescale_ratios[] = {
 	{.num =  1, .den =  1},
 	{.num =  1, .den =  3},
 	{.num =  1, .den =  4},
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 14723896aab2..ec177360a354 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -289,7 +289,7 @@ static const struct vadc_map_pt adcmap7_100k[] = {
 	{ 2420, 130048 }
 };
 
-static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
+static const struct u32_fract adc5_prescale_ratios[] = {
 	{.num =  1, .den =  1},
 	{.num =  1, .den =  3},
 	{.num =  1, .den =  4},
@@ -302,31 +302,31 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
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
@@ -422,7 +422,7 @@ static int qcom_vadc_scale_volt(const struct vadc_linear_graph *calib_graph,
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
@@ -467,7 +467,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 }
 
 static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
-				    const struct vadc_prescale_ratio *prescale,
+				    const struct u32_fract *prescale,
 				    bool absolute,
 				    u16 adc_code, int *result_mdec)
 {
@@ -487,7 +487,7 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
 
 /* convert voltage to ADC code, using 1.875V reference */
 static u16 qcom_vadc_scale_voltage_code(s32 voltage,
-					const struct vadc_prescale_ratio *prescale,
+					const struct u32_fract *prescale,
 					const u32 full_scale_code_volt,
 					unsigned int factor)
 {
@@ -501,7 +501,7 @@ static u16 qcom_vadc_scale_voltage_code(s32 voltage,
 }
 
 static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
-				const struct vadc_prescale_ratio *prescale,
+				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				unsigned int factor)
 {
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

