Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4753C80A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiFCKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiFCKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:00:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F773AA52;
        Fri,  3 Jun 2022 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654250409; x=1685786409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJ+n2tYqhmEhzpVzUUn7F7bPvKrA5/Ib2p+26wHyTAo=;
  b=lYGngQlGoqrz6IOf7XrNmHDxvppSFJKP3e6f2H+LKOlq97QPhomPP4Hc
   AYHvkdcmWPB4YxgRlwYEohZsIsIG6Uu//fZb/HYkAFPDaiYiGXWbc62aT
   eWHwsLp2DrFdXUrYpaNe5IhHdLeAlicEpwwYZ98GpD1pcKsy5U6j+dXak
   f4z83aeEOamO3dU5Fu8nKj1PMC9I1DT9zpEokpgmNcs7X/tufz9gP60yg
   p7/ZB2U9/dY9TOC3W3qsY4nvmoQhYRxmBPm0yA9TBiYjX7I7E9xGDLvKx
   XKS8RqOQstgJzZ7QrOwZGe9q4qoX2mFGcDK4ZsCK4c5oGVE0OAGnduWYr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263863070"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="263863070"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="824667302"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2022 03:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2179DF1; Fri,  3 Jun 2022 13:00:07 +0300 (EEST)
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
Subject: [PATCH v3 2/6] iio: adc: meson_saradc: Align messages to be with physical device prefix
Date:   Fri,  3 Jun 2022 13:00:00 +0300
Message-Id: <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align messages to be printed with the physical device prefix as it's done
everywhere else in this driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch (inspired by previous change)
 drivers/iio/adc/meson_saradc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 4fe6b997cd03..658047370db0 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -345,6 +345,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int regval, fifo_chan, fifo_val, count;
 
 	if (!wait_for_completion_timeout(&priv->done,
@@ -353,16 +354,14 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 
 	count = meson_sar_adc_get_fifo_count(indio_dev);
 	if (count != 1) {
-		dev_err(&indio_dev->dev,
-			"ADC FIFO has %d element(s) instead of one\n", count);
+		dev_err(dev, "ADC FIFO has %d element(s) instead of one\n", count);
 		return -EINVAL;
 	}
 
 	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
 	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
 	if (fifo_chan != chan->address) {
-		dev_err(&indio_dev->dev,
-			"ADC FIFO entry belongs to channel %d instead of %lu\n",
+		dev_err(dev, "ADC FIFO entry belongs to channel %d instead of %lu\n",
 			fifo_chan, chan->address);
 		return -EINVAL;
 	}
-- 
2.35.1

