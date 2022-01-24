Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79721498673
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiAXRVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:21:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:17853 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244389AbiAXRUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044831; x=1674580831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUNTtC4SehQi3UDg50mC4uWw+k23kUBXzji3SHfmIfM=;
  b=Muo/q4/zYjhtLXL1on/BBLXoiIBHLeE82KPqN5ZDi/QiEdGWxes9VC2d
   KzyxFPx/HWBj6S3frRp6JS8y+Pzuloct1vw4tvdQ5SEDB4r5HR1MT5Qsw
   ZhTNyMqjPMdTYIM0uh84Rlj+CxAskAInCLikC5akQIObwDsnHx/T0skhm
   ulWhDzPNpUw4RDMlzop29DleU7ZEp3VeCCI3bbXq8JbLD7/vK72oFnbTk
   wbOt7l/D4v6OlmE4jNkRB4BaCT7lIby6TBHY/v4xS4+kod7UdTA5Rq+zt
   ehqiO+cW0sgGPiHKGw9DHRNANE6snTEacJWF7AjKX2/rt4s5pHo5JUlb5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246044028"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246044028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766469370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2022 09:20:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5FE4A5F; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
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
Subject: [PATCH v3 6/6] iio: afe: iio-rescale: Re-use generic struct s32_fract
Date:   Mon, 24 Jan 2022 19:20:32 +0200
Message-Id: <20220124172032.87893-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
References: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s32_fract.
No changes intended.

The new member is put to be the first one to avoid additional
pointer arithmetic. Besides that one may switch to use fract
member to perform container_of(), which will be no-op in this
case, to get struct rescale.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: split out assignment reshuffling (Jonathan)
 drivers/iio/afe/iio-rescale.c | 70 ++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 8b9d2aa1502e..0368bca8a485 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -11,6 +11,7 @@
 #include <linux/gcd.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -21,17 +22,16 @@ struct rescale;
 
 struct rescale_cfg {
 	enum iio_chan_type type;
-	int (*props)(struct device *dev, struct rescale *rescale);
+	int (*props)(struct device *dev, struct s32_fract *fract);
 };
 
 struct rescale {
+	struct s32_fract fract;
 	const struct rescale_cfg *cfg;
 	struct iio_channel *source;
 	struct iio_chan_spec chan;
 	struct iio_chan_spec_ext_info *ext_info;
 	bool chan_processed;
-	s32 numerator;
-	s32 denominator;
 };
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
@@ -39,6 +39,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
+	struct s32_fract *fract = &rescale->fract;
 	unsigned long long tmp;
 	int ret;
 
@@ -67,19 +68,19 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
+			*val *= fract->numerator;
+			*val2 *= fract->denominator;
 			return ret;
 		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
+			*val *= fract->numerator;
+			if (fract->denominator == 1)
 				return ret;
-			*val2 = rescale->denominator;
+			*val2 = fract->denominator;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_VAL_FRACTIONAL_LOG2:
 			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
+			do_div(tmp, fract->denominator);
+			tmp *= fract->numerator;
 			do_div(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
@@ -175,7 +176,7 @@ static int rescale_configure_channel(struct device *dev,
 }
 
 static int rescale_current_sense_amplifier_props(struct device *dev,
-						 struct rescale *rescale)
+						 struct s32_fract *fract)
 {
 	u32 sense;
 	u32 gain_mult = 1;
@@ -199,22 +200,22 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
 	 * numerator/denominator from overflowing.
 	 */
 	factor = gcd(sense, 1000000);
-	rescale->numerator = 1000000 / factor;
-	rescale->denominator = sense / factor;
+	fract->numerator = 1000000 / factor;
+	fract->denominator = sense / factor;
 
-	factor = gcd(rescale->numerator, gain_mult);
-	rescale->numerator /= factor;
-	rescale->denominator *= gain_mult / factor;
+	factor = gcd(fract->numerator, gain_mult);
+	fract->numerator /= factor;
+	fract->denominator *= gain_mult / factor;
 
-	factor = gcd(rescale->denominator, gain_div);
-	rescale->numerator *= gain_div / factor;
-	rescale->denominator /= factor;
+	factor = gcd(fract->denominator, gain_div);
+	fract->numerator *= gain_div / factor;
+	fract->denominator /= factor;
 
 	return 0;
 }
 
 static int rescale_current_sense_shunt_props(struct device *dev,
-					     struct rescale *rescale)
+					     struct s32_fract *fract)
 {
 	u32 shunt;
 	u32 factor;
@@ -228,35 +229,33 @@ static int rescale_current_sense_shunt_props(struct device *dev,
 	}
 
 	factor = gcd(shunt, 1000000);
-	rescale->numerator = 1000000 / factor;
-	rescale->denominator = shunt / factor;
+	fract->numerator = 1000000 / factor;
+	fract->denominator = shunt / factor;
 
 	return 0;
 }
 
 static int rescale_voltage_divider_props(struct device *dev,
-					 struct rescale *rescale)
+					 struct s32_fract *fract)
 {
 	int ret;
 	u32 factor;
 
-	ret = device_property_read_u32(dev, "output-ohms",
-				       &rescale->denominator);
+	ret = device_property_read_u32(dev, "output-ohms", &fract->denominator);
 	if (ret) {
 		dev_err(dev, "failed to read output-ohms: %d\n", ret);
 		return ret;
 	}
 
-	ret = device_property_read_u32(dev, "full-ohms",
-				       &rescale->numerator);
+	ret = device_property_read_u32(dev, "full-ohms", &fract->numerator);
 	if (ret) {
 		dev_err(dev, "failed to read full-ohms: %d\n", ret);
 		return ret;
 	}
 
-	factor = gcd(rescale->numerator, rescale->denominator);
-	rescale->numerator /= factor;
-	rescale->denominator /= factor;
+	factor = gcd(fract->numerator, fract->denominator);
+	fract->numerator /= factor;
+	fract->denominator /= factor;
 
 	return 0;
 }
@@ -299,6 +298,7 @@ static int rescale_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct iio_channel *source;
 	struct rescale *rescale;
+	struct s32_fract *fract;
 	int sizeof_ext_info;
 	int sizeof_priv;
 	int i;
@@ -324,14 +324,16 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale = iio_priv(indio_dev);
 	rescale->source = source;
 	rescale->cfg = of_device_get_match_data(dev);
-	rescale->numerator = 1;
-	rescale->denominator = 1;
 
-	ret = rescale->cfg->props(dev, rescale);
+	fract = &rescale->fract;
+	fract->numerator = 1;
+	fract->denominator = 1;
+
+	ret = rescale->cfg->props(dev, fract);
 	if (ret)
 		return ret;
 
-	if (!rescale->numerator || !rescale->denominator) {
+	if (!fract->numerator || !fract->denominator) {
 		dev_err(dev, "invalid scaling factor.\n");
 		return -EINVAL;
 	}
-- 
2.34.1

