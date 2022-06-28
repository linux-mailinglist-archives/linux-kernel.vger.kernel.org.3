Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780455E847
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348178AbiF1PPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348148AbiF1PP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD33192C;
        Tue, 28 Jun 2022 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429308; x=1687965308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rByJglM2d06QxwVgzCDCAyCd/i7n0BpKAOj33uROlo=;
  b=cMjlQFp5h4eMof+Or1u5ajb3iKm130z1MEeLSbyMzsmj+lK57rfnc3h4
   CvwSXJofDtNirdy6cZWvYNNyq9FBk1o2Gq1WSwM+L/dsUoddVfwWUH6VR
   krqiqD5ABzdmw54Aqe1gAQ6Bnk9nZEIWtE75DZlv7OUBy+jmD543ZMxGq
   6UckZQaKre+uEGVQ2vA4xhe4ywwayh3HEJXAqql9di16I9Uv7396tcuy8
   2XDzpVGS7sBeKkvhmHLIgTzIMFso94P5f7xgDBMvgZPI9oieFfIyAlJ97
   qG0JyT+mxCiBdE7N1NtE88roVz5BKoOS2v0ys4z5xfSnWijZlZCDTbYYR
   w==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="170219348"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:15:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:15:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:15:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 15/19] iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
Date:   Tue, 28 Jun 2022 18:16:27 +0300
Message-ID: <20220628151631.3116454-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove iio_device_{claim, release}_direct_mode() and lock/unlock to
&st->lock from at91_adc_read_info_raw(). Instead add a wrapper around
at91_adc_read_info_raw() and do there the lock/unlock. This will allow
using the at91_adc_read_info_raw() in patch that add support for
temperature sensor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 3de5d1cb8a12..04c44b2d574c 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1579,6 +1579,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/* This needs to be called with direct mode claimed and st->lock locked. */
 static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
@@ -1591,45 +1592,26 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	 * if external trigger is enabled
 	 */
 	if (chan->type == IIO_POSITIONRELATIVE) {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		mutex_lock(&st->lock);
-
 		ret = at91_adc_read_position(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
-		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
 	}
 	if (chan->type == IIO_PRESSURE) {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		mutex_lock(&st->lock);
-
 		ret = at91_adc_read_pressure(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
-		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
 	}
 
 	/* in this case we have a voltage channel */
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
-
 	st->chan = chan;
 
 	at91_adc_cor(st, chan);
@@ -1658,9 +1640,25 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	/* Needed to ACK the DRDY interruption */
 	at91_adc_readl(st, LCDR);
 
+	return ret;
+}
+
+static int at91_adc_read_info_locked(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, int *val)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	ret = at91_adc_read_info_raw(indio_dev, chan, val);
 	mutex_unlock(&st->lock);
 
 	iio_device_release_direct_mode(indio_dev);
+
 	return ret;
 }
 
@@ -1672,7 +1670,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return at91_adc_read_info_raw(indio_dev, chan, val);
+		return at91_adc_read_info_locked(indio_dev, chan, val);
+
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uv / 1000;
 		if (chan->differential)
-- 
2.34.1

