Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC45445DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiFIIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiFIIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD0182B88;
        Thu,  9 Jun 2022 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763422; x=1686299422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wCSIkkvazbTh0QE+i1AwpXua1EMs/hRmfnwnVg4TM+w=;
  b=zyg/n40qydiMZRdD7GEOAV61XAH5VDy0mgnrgLxNg48F28WZRnG5SrA4
   1OCqok8d/FvISXihilXF+t/jC6mmKMj415ljf4cR7XPWjq9ZZ9Yqh51qa
   hH1tzDT6ammx5ENd3I4HFC2qTCStFEtuHue1SGswGFWRfaVqMFYLPd+sk
   IyYz50vqs7eVrzDitHHQ6X8L/wcY/FoMrOf5qYR1p3copPv+HPwfKn75i
   CiyaUB2Gn/atpxficV4rc2UTQOb1xRX8UKSZAo48BJVb9lHcJpC96BPHy
   kNQXadM/rpE7Ik9IIfWewL7YmbXn1XLqiT2Q3Ibe0v7gUx3r1WzooXoZw
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="99259942"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 07/16] iio: adc: at91-sama5d2_adc: simplify the code in at91_adc_read_info_raw()
Date:   Thu, 9 Jun 2022 11:32:04 +0300
Message-ID: <20220609083213.1795019-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify a bit the code in at91_adc_read_info_raw() by reducing the
number of lines of code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 35 +++++++++---------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b52f1020feaf..fbb98e216e70 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1576,6 +1576,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int (*fn)(struct at91_adc_state *, int, u16 *) = NULL;
 	u16 tmp_val;
 	int ret;
 
@@ -1583,29 +1584,18 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	 * Keep in mind that we cannot use software trigger or touchscreen
 	 * if external trigger is enabled
 	 */
-	if (chan->type == IIO_POSITIONRELATIVE) {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		mutex_lock(&st->lock);
-
-		ret = at91_adc_read_position(st, chan->channel,
-					     &tmp_val);
-		*val = tmp_val;
-		ret = at91_adc_adjust_val_osr(st, val);
-		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+	if (chan->type == IIO_POSITIONRELATIVE)
+		fn = at91_adc_read_position;
+	if (chan->type == IIO_PRESSURE)
+		fn = at91_adc_read_pressure;
 
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
 		return ret;
-	}
-	if (chan->type == IIO_PRESSURE) {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		mutex_lock(&st->lock);
+	mutex_lock(&st->lock);
 
-		ret = at91_adc_read_pressure(st, chan->channel,
-					     &tmp_val);
+	if (fn) {
+		ret = fn(st, chan->channel, &tmp_val);
 		*val = tmp_val;
 		ret = at91_adc_adjust_val_osr(st, val);
 		mutex_unlock(&st->lock);
@@ -1616,11 +1606,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	/* in this case we have a voltage channel */
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
-
 	st->chan = chan;
 
 	at91_adc_cor(st, chan);
-- 
2.34.1

