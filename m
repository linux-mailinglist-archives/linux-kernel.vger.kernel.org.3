Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD184BF448
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiBVJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiBVJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814C13D57E;
        Tue, 22 Feb 2022 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520400; x=1677056400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeYYCpfWzDLsBB2Xg8Rn8iCJ+VSaLy0WDtFNFueGsFE=;
  b=igiVNytXKf1yWDbmVxXZyutktmis/H+x3KH32V2/S7L5NO9qbUeckNwE
   kIpgkpR2RPBODHzhAy8L0fIoIIdw+71J/BLKtLOVkdDTarwCYqnZhCUyz
   NvuO5mNfqX9tYsIA4YkE/YRCHY6lxioFQbkfQprDY8LEoyCmnnoA/m1mB
   n6iG/2qPPPgK7ywIgQ6N7/GnZhXYiJ2P6X51PpBWp6AcACalqrJTZWLjR
   XHHJWEQJE4ipPGX7US+9KGnMxFzPRP3cfrr6na2mXR9GSBMsDb5+1zR75
   GEpFC8RkU9uQ1eiDY1GheIOx1Zo6bj7ujFnYESpYT2nYPHLkksPIba+UR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232263798"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232263798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="505462003"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2022 00:59:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4629763; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 6/8] iio: accel: adxl345: Extract adxl345_powerup() helper
Date:   Tue, 22 Feb 2022 11:00:07 +0200
Message-Id: <20220222090009.2060-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
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

