Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5449CB70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiAZNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:53:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:22303 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241660AbiAZNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643205224; x=1674741224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gzniQafwJFfBXa90c8OU8Bl36/V50WeEVvo6O2AT0k=;
  b=LZAYFHD02j7ploJq+SHt3LmOKXCGffFKpkrs+cAUrT3ruJqWG5tFHxhO
   Fck5Ewqdu/PgdyMgPx0+t7EsP7czV3L9eqc+9o8a7B3W44AR3sB64EOe7
   wi3AFv6q8dFbPE/M0hi1CGHvyRu+42CrpfHqFmRTvIZT1AA9QgWU8n5Ik
   Kf2Vy0qhRo4x7TQ29wKDUBp0tck1f9PMUYiqmwdUjDjSz560iD4v2fLfs
   amdxrmuK+Shb+3bskmue6Bir9Cw+KSu2fI121S1IO1tN+QtvW59YN/CcK
   wOJCfBpuBEEKB9nyWwAZFSgh8SVyaM8VpPO2BFT5OzVIru52BT1ipTKJM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332905574"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="332905574"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="520801639"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2022 05:53:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BEB085E4; Wed, 26 Jan 2022 15:53:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 3/4] iio: adc: twl4030-madc: Re-use generic struct s16_fract
Date:   Wed, 26 Jan 2022 15:53:52 +0200
Message-Id: <20220126135353.24007-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
References: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v4: no changes
v3: no changes
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

