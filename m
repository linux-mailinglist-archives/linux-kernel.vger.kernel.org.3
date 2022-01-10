Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DD6489F01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiAJSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:17:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:15381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238903AbiAJSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641838626; x=1673374626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhbG96ZN/wAY6OGe8M6N4jiC1NAS2+lq1p40m3Bi1G0=;
  b=N5Gus2AGnYZpI6TsuhaojCslrO+y/985I80jiUH+tv0FccBMGDClioDK
   FjQmtbjsw6pd5HL/qtaTns9Jd0wBTuDdVzP0stVa3684SjOzeCeATEDxO
   xlt2G84LJK+4fVtzMlrfWExp+2VasrQhWQH04hqwuQ2TSmWdvUDbGQ3bw
   0d6Ke2EHb+XcOiucKBcP1ni5qVfOm+W2pkHySgOSqWOm6auk5G446h0KA
   TfLpFFRkKc9+dtxHECv5/UoN2fnIik0Ug8B51VVYQA43LBquHsYQbMj2b
   q2aM2Z2oMmzNl7JX+wEElkjuYGosUnc6AL5SSnYlE1P3O1+rRiEVy70U4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242101549"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242101549"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="592430090"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2022 10:17:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DEC7E125; Mon, 10 Jan 2022 20:17:12 +0200 (EET)
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
Subject: [PATCH v1 3/5] iio: adc: twl4030-madc: Re-use generic struct s16_fract
Date:   Mon, 10 Jan 2022 20:17:09 +0200
Message-Id: <20220110181711.65054-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
References: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/twl4030-madc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 6ce40cc4568a..f8f8aea15612 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -231,13 +231,7 @@ static const struct iio_chan_spec twl4030_madc_iio_channels[] = {
 
 static struct twl4030_madc_data *twl4030_madc;
 
-struct twl4030_prescale_divider_ratios {
-	s16 numerator;
-	s16 denominator;
-};
-
-static const struct twl4030_prescale_divider_ratios
-twl4030_divider_ratios[16] = {
+static const struct s16_fract twl4030_divider_ratios[16] = {
 	{1, 1},		/* CHANNEL 0 No Prescaler */
 	{1, 1},		/* CHANNEL 1 No Prescaler */
 	{6, 10},	/* CHANNEL 2 */
@@ -256,7 +250,6 @@ twl4030_divider_ratios[16] = {
 	{5, 11},	/* CHANNEL 15 */
 };
 
-
 /* Conversion table from -3 to 55 degrees Celcius */
 static int twl4030_therm_tbl[] = {
 	30800,	29500,	28300,	27100,
-- 
2.34.1

