Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03D4BEE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiBUXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiBUXc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:32:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FC24F33;
        Mon, 21 Feb 2022 15:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486352; x=1677022352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TIQE1Bt4Qr3VtZWf4mfaGcnKSVVxa39RSPZi/zpSBz0=;
  b=aqZLyMrT+c5MzJpJmdE38VixLzDpmfraKphrSjxLsJ/taaCsOkQT5w52
   ifRCHO0R42zEln4j4SUE3obAm1dGL+3TAyUus4Qw82Y9RV0mI3NfnCQrN
   zMjyJ/+MuZ54UHGbzbyMxECrje2IXhed627pDEEpCC6pjFy0mm37CmSbf
   kGcKS8UVM9nXvdz6MPQE139y80l2J39kCIO1arSsVCKt0wd8sqoEyIULw
   sTYHjL0oxNex6iD36gcG2BT/AR894fChAdVw5huG5fCarW3/SQUzBEbTi
   hn2NoF9JQSUexMRAZR/w4QeOQWGYoeghHEz2hEvb9cswJqHt/AmSWfsHB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314841873"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314841873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="505303712"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 15:32:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DDE7640D; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 6/8] iio: accel: adxl345: Extract adxl345_powerup() helper
Date:   Tue, 22 Feb 2022 01:32:33 +0200
Message-Id: <20220221233235.86893-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of symmetry and possible reuse in the future
extract adxl435_powerup() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl345_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 315a408115b3..4e4562fc35c9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -209,6 +209,11 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
+static int adxl345_powerup(void *regmap)
+{
+	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+}
+
 static void adxl345_powerdown(void *regmap)
 {
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
@@ -265,8 +270,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
 	/* Enable measurement mode */
-	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			   ADXL345_POWER_CTL_MEASURE);
+	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-- 
2.34.1

