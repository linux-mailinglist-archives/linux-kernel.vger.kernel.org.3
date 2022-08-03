Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651AF588A81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiHCK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHCK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:28:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DB5A3D8;
        Wed,  3 Aug 2022 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522451; x=1691058451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMXefC0igDeFJ27vYADoWV+7/A1ovx1XLwyBSs3RDMY=;
  b=gdO1r3LgwHXdIEz/KjCDYYzzP6PAV37x6F6iBvAIxpjA4UNwIk5iP/rj
   re+8EHKkm8u/uG0O2cJJarbqDE2uvXVEeRYiy3YN767wVjafA2enyvtlA
   Pufonp800b3BJlpOvI9Jy6DD0T1nHxZmSrHcgAJRTIRQ+tr83wIGfTSmT
   P6zyPatL4IHa4qmjz1q4+ie1oGQWMvZ/U/AQkDZSSFqgSAPHGTy6fhRgp
   pVw5BsPMtZ55Lys9gpWMFWCWP54kJZ5UB9OzxOJXYFacYl9HXk6TNZ+Ad
   rAhB1Ip3aOwenQiIjcnJ7tTgi76hBJhIOb1HFlIiZBmsXcFD4AoJ2uS47
   w==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="174882796"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:25 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 15/19] iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
Date:   Wed, 3 Aug 2022 13:28:51 +0300
Message-ID: <20220803102855.2191070-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
References: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fd02da9b26b2..1a72e304fc3a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1582,6 +1582,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/* This needs to be called with direct mode claimed and st->lock locked. */
 static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
@@ -1594,45 +1595,26 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
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
@@ -1661,9 +1643,25 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
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
 
@@ -1675,7 +1673,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
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

