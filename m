Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02153C80D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiFCKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbiFCKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDB3AA52;
        Fri,  3 Jun 2022 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250411; x=1685786411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0fsSIU29EuhBbM0LUaUeCq/SxCSD2R+0n5JMdHNevI=;
  b=iAmzbBd2jcC0zu3LPuI1pUAzyZaHn91E6Zs7ZTDlySOJ5HNywUehlsYl
   IOGqvoyau0KEXw4bUA3XZqLUIFimqX4/0hDHe+VvlXYERmCBfbOIp6vAP
   YzN7XizFiTbwYOby5DiB4uHliHrzlm04Kq7njaeIH8M7aCzLOHVYam+FY
   P9cH8tGsEBGb7lCHDa2c0ftwTcfuV2a6pgUMr27I4zYiiWu0WGz2khSJK
   dKuSKe0TaBsvUUCnzy6oacM3NP3sOrnCJE9aypwZf8Uwfb5qiE3aUWUIf
   S4573KqEj4C1BuinltFwHxl8rUD8yqi/vbPDPflNqaQ61MEe7rm4VonfX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336872180"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="336872180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="613215278"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2022 03:00:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4ACC5D99; Fri,  3 Jun 2022 13:00:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v3 6/6] iio: adc: meson_saradc: Use regmap_read_poll_timeout() for busy wait
Date:   Fri,  3 Jun 2022 13:00:04 +0300
Message-Id: <20220603100004.70336-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify busy wait stages by using regmap_read_poll_timeout().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch, but RFC, not always the read_poll_timeout() can be used, would
    be nice to have it tested.

 drivers/iio/adc/meson_saradc.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index c100f933c12e..c18be3c519af 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -322,22 +322,17 @@ static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
 static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int regval, timeout = 10000;
+	int val;
 
 	/*
 	 * NOTE: we need a small delay before reading the status, otherwise
 	 * the sample engine may not have started internally (which would
 	 * seem to us that sampling is already finished).
 	 */
-	do {
-		udelay(1);
-		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
-	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
-
-	if (timeout < 0)
-		return -ETIMEDOUT;
-
-	return 0;
+	udelay(1);
+	return regmap_read_poll_timeout_atomic(priv->regmap, MESON_SAR_ADC_REG0, val,
+					       !FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, val),
+					       1, 10000);
 }
 
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
@@ -489,7 +484,7 @@ static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
 static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int val, timeout = 10000;
+	int val, ret;
 
 	mutex_lock(&indio_dev->mlock);
 
@@ -499,18 +494,18 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 				   MESON_SAR_ADC_DELAY_KERNEL_BUSY,
 				   MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
+		udelay(1);
+
 		/*
 		 * wait until BL30 releases it's lock (so we can use the SAR
 		 * ADC)
 		 */
-		do {
-			udelay(1);
-			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
-		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
-
-		if (timeout < 0) {
+		ret = regmap_read_poll_timeout_atomic(priv->regmap, MESON_SAR_ADC_DELAY, val,
+						      !(val & MESON_SAR_ADC_DELAY_BL30_BUSY),
+						      1, 10000);
+		if (ret) {
 			mutex_unlock(&indio_dev->mlock);
-			return -ETIMEDOUT;
+			return ret;
 		}
 	}
 
-- 
2.35.1

