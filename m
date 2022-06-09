Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A585445E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiFIIcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiFIIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE015FE3E;
        Thu,  9 Jun 2022 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763446; x=1686299446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0kekLaOAQqjXFiqG+SZLMmF7SrlN2r0uUk4olOvrzOo=;
  b=bcmJlc53wOTJ6RoISAzLqhTJnRyixzlFqCakV4HOKVjPvLETzRVy/78d
   HigGmSA5WO4kIVCHcUnuauFIwkX3YY1z8asrCoeJ+Tefcimv7+Q0nbHwz
   GxUKfMufdUrhz8jcCH/8NiqKKlfNDqFDirmu5lMuf0HKf2eQFb4ZBA491
   v8t9+weI3774qch1VCtunnepRkzuF//C9dgOV9ry8A6pxI4JWcjGeOkY7
   K/6SOfAvEDpnnH/rSVs3TUdj2Jbgi6cqmfIZ5MbVChMp8PQFV+3qzMVkD
   NomVtK6xrRKPo/4+sCaX6/ENh+ziZiHF7vea0iebcMK7UjqXShz2T/qU7
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="177213539"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 11/16] iio: adc: at91-sama5d2_adc: add locking parameter to at91_adc_read_info_raw()
Date:   Thu, 9 Jun 2022 11:32:08 +0300
Message-ID: <20220609083213.1795019-12-claudiu.beznea@microchip.com>
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

Add a parameter to at91_adc_read_info_raw() to specify if st->lock mutex
need to be acquired. This prepares for the addition of temperature sensor
code which will re-use at91_adc_read_info_raw() function to read 2 voltages
for determining the real temperature.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1283bcf4e682..8f8fef42de84 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1583,7 +1583,8 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 }
 
 static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
-				  struct iio_chan_spec const *chan, int *val)
+				  struct iio_chan_spec const *chan, int *val,
+				  bool lock)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	int (*fn)(struct at91_adc_state *, int, u16 *) = NULL;
@@ -1602,13 +1603,15 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
 		return ret;
-	mutex_lock(&st->lock);
+	if (lock)
+		mutex_lock(&st->lock);
 
 	if (fn) {
 		ret = fn(st, chan->channel, &tmp_val);
 		*val = tmp_val;
 		ret = at91_adc_adjust_val_osr(st, val);
-		mutex_unlock(&st->lock);
+		if (lock)
+			mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
@@ -1644,7 +1647,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	/* Needed to ACK the DRDY interruption */
 	at91_adc_readl(st, LCDR);
 
-	mutex_unlock(&st->lock);
+	if (lock)
+		mutex_unlock(&st->lock);
 
 	iio_device_release_direct_mode(indio_dev);
 	return ret;
@@ -1658,7 +1662,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return at91_adc_read_info_raw(indio_dev, chan, val);
+		return at91_adc_read_info_raw(indio_dev, chan, val, true);
+
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uv / 1000;
 		if (chan->differential)
-- 
2.34.1

