Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926CA5445D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiFIIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiFIIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700AE18144A;
        Thu,  9 Jun 2022 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763421; x=1686299421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=77ZWqA+4UaqVdZ24io5cE1ntvgewfYNdW+CZyfcvoQY=;
  b=oQeSvKyoo45dM060zs3PwAxh++YPMpu7YhuPsnU3knio/Lw12DvPSgux
   kmBWCyY+IGFxlWVYlYSGEzoWych2FkfdrIXW+nKIwwQuht8O9RaJtEaYF
   4sQD4KykVkEPlpOwu5mQ2sG8btjMVH81agkRo9FbX0+JAIfMnqE43PChE
   y1Pxzja4vfSp0eTDVUmNuopvu7PRl/r8AI04GOX/uAnUXsFCaEud9mPXs
   HwHjiDN2/7HGfAodUAiYMNy4E0E9zZzG+nKo+WFEJgb9icuE3VvWTB2iH
   dxzxy6Arye56yPrzmUXW8RgEvNuZtDC6sXajHvOUvRBMR84xDFhlb/eWQ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="99259938"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 06/16] iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
Date:   Thu, 9 Jun 2022 11:32:03 +0300
Message-ID: <20220609083213.1795019-7-claudiu.beznea@microchip.com>
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

Add 64 and 256 oversampling ratio support. It is necessary for temperature
sensor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7321a4b519af..b52f1020feaf 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -142,6 +142,8 @@ struct at91_adc_reg_layout {
 #define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
 #define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
 #define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
+#define AT91_SAMA5D2_EMR_OSR_64SAMPLES		3
+#define AT91_SAMA5D2_EMR_OSR_256SAMPLES		4
 
 /* Extended Mode Register - Averaging on single trigger event */
 #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
@@ -308,6 +310,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_OSR_1SAMPLES		1
 #define AT91_OSR_4SAMPLES		4
 #define AT91_OSR_16SAMPLES		16
+#define AT91_OSR_64SAMPLES		64
+#define AT91_OSR_256SAMPLES		256
 
 #define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
 	{								\
@@ -640,7 +644,9 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.osr_mask = GENMASK(18, 16),
 	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
 		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
-		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
+		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES) |
+		    BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES) |
+		    BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES),
 	.chan_realbits = 16,
 };
 
@@ -774,6 +780,18 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
+	case AT91_OSR_64SAMPLES:
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES)))
+			return -EINVAL;
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
+					    osr_mask);
+		break;
+	case AT91_OSR_256SAMPLES:
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES)))
+			return -EINVAL;
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
+					    osr_mask);
+		break;
 	}
 
 	at91_adc_writel(st, EMR, emr);
@@ -791,6 +809,10 @@ static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 		nbits = 13;
 	else if (st->oversampling_ratio == AT91_OSR_16SAMPLES)
 		nbits = 14;
+	else if (st->oversampling_ratio == AT91_OSR_64SAMPLES)
+		nbits = 15;
+	else if (st->oversampling_ratio == AT91_OSR_256SAMPLES)
+		nbits = 16;
 
 	/*
 	 * We have nbits of real data and channel is registered as
@@ -1679,7 +1701,8 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
-		    (val != AT91_OSR_16SAMPLES))
+		    (val != AT91_OSR_16SAMPLES) && (val != AT91_OSR_64SAMPLES) &&
+		    (val != AT91_OSR_256SAMPLES))
 			return -EINVAL;
 		/* if no change, optimize out */
 		mutex_lock(&st->lock);
@@ -1897,7 +1920,9 @@ static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
 static IIO_CONST_ATTR(oversampling_ratio_available,
 		      __stringify(AT91_OSR_1SAMPLES) " "
 		      __stringify(AT91_OSR_4SAMPLES) " "
-		      __stringify(AT91_OSR_16SAMPLES));
+		      __stringify(AT91_OSR_16SAMPLES) " "
+		      __stringify(AT91_OSR_64SAMPLES) " "
+		      __stringify(AT91_OSR_256SAMPLES));
 
 static struct attribute *at91_adc_attributes[] = {
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-- 
2.34.1

