Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42FB49865F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiAXRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:20:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:33543 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244274AbiAXRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044825; x=1674580825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5wu6jTRsftWHS1sGrTpaPtl4CwQ65yAvK9AFROQxzE=;
  b=n8UDwj4RmTK3Q8aIGvT5jbhcdDuToQmNjo3VPwO8CpVB75AFrgvkcB7d
   wBZbtVbzw+vMvaPwtaLQsCWGY0ROpwR3EYnJBEOOPMGN4q6u8ZC4oitD2
   yM98427sILE93tJSQ1/LUG9E56H8o+QYzJ8rzWbQ8W7wNbJpndZg5z3C9
   LFlgKiYUgKfHqSTm2ThVp7dGgn6ZkoKJ2woyZXW8+zn3mLonxwGLzNn9q
   YchrhhcudUT2bDdUyiYTFDH56JkeWDcA25yq0ZLqW+5cstQ4e1Z5HIeK2
   UseNg2JKA2iuY6WLf9kt0viUGoSJ7rc4b82ydqLVlaw/SyfCV5hJDsMcc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332452742"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332452742"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="768748116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2022 09:20:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB4CC616; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
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
Subject: [PATCH v3 3/6] iio: adc: twl4030-madc: Re-use generic struct s16_fract
Date:   Mon, 24 Jan 2022 19:20:29 +0200
Message-Id: <20220124172032.87893-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
References: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
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

