Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9C48A024
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiAJTbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:31:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:48345 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243488AbiAJTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641843061; x=1673379061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVsXAu/V6GXY3m9grnOAWS9q+Cf5i6O+WwUAv3by8tE=;
  b=N3ItHtKpAB2UgZKhMDL0kJh+PtrUcgpGFjjCdsGMKjEFBfWCRx1pRwop
   ksILhtOXHYMy/P+i54TM4fBG1XHbrb+kLm3niarPZAPfnV9HNJuz2mvOR
   rQB6obvBCTcoMqWSgijyots+OUnNuCGR+msylDs/Z034MJ+4CEMqiISgu
   Lp0SHu0SfbFJ4JgrI/wvYnBrXc5pjXmHZatMKngW4etKSbv/Ssf/XhyJ3
   5sOF4kOIA/ECciNz5jD/CXmNXpbMAITeNmrOPxOFFU3NfX7WNdO0JO12E
   iVeJ3F2dpNhHIU5eFHTHOIPTh4cH690Jrt/3CcaBjduBNsZxKhp1MXKj8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="224000751"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="224000751"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 11:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="762259260"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2022 11:30:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3690316B; Mon, 10 Jan 2022 21:31:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 3/5] iio: adc: twl4030-madc: Re-use generic struct s16_fract
Date:   Mon, 10 Jan 2022 21:31:02 +0200
Message-Id: <20220110193104.75225-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: no changes

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

