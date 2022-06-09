Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93575445DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiFIIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbiFIIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A24715350A;
        Thu,  9 Jun 2022 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763413; x=1686299413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTxaHzNnrApqr430EBGS74YS00WcP8WmBnl1fkR5Td4=;
  b=JpcXNul4nmbGxJJjrESzXm0PhMubcktC1KikyEjhHuKlGptQ02LmV+eV
   HMpKBsPuBUxnJOzselMIOiZ+9z/+ICm//fyeiaVC9YD7zdsBv9ycnGA7H
   Opkbk60zjNCQqDge2hIF728ekawqQ7NQ+i5FVeHcSdmfUPqij+p17sNNT
   PiPMCwmWyTQ1Usw3W505tZS2lGvkZmC54ckIIJPb0+zN7qApNlaKyOtRe
   /ACMeB14CDir9z5Gayvk8FYbRXZKjOar8mAa/M87WOAKlO1K8P+NCDzwQ
   UokoAiJCThXQZQLZ0bwxWipJAu110MUJbpiMvVHtHoNK+lZIJ+u9HU01d
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167403617"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 05/16] iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
Date:   Thu, 9 Jun 2022 11:32:02 +0300
Message-ID: <20220609083213.1795019-6-claudiu.beznea@microchip.com>
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

ADC captures data on 12 bits (if oversampling is not enabled). When using
oversampling captured data could go up to 14 bits for SAMA5D2 or up to
16 bits for SAMA7G5 (depending on oversampling settings). All the channels
that are subject of oversampling are registered as 14 or 16 real bits.
Depending on the oversampling settings the ADC converted value need to be
shifted up to 14 or 16 to cope with realbits value registered to IIO
subsystem. Commit adds platform specific information to know if we
run on a system with up to 14 or 16 bits ADC converted data.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 32 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1ceab097335c..7321a4b519af 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -404,6 +404,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @hw_trig_cnt:	number of possible hardware triggers
  * @osr_mask:		oversampling ratio bitmask on EMR register
  * @osr_vals:		available oversampling rates
+ * @chan_realbits:	realbits for registered channels
  */
 struct at91_adc_platform {
 	const struct at91_adc_reg_layout	*layout;
@@ -417,6 +418,7 @@ struct at91_adc_platform {
 	unsigned int				hw_trig_cnt;
 	unsigned int				osr_mask;
 	unsigned int				osr_vals;
+	unsigned int				chan_realbits;
 };
 
 /**
@@ -619,6 +621,7 @@ static const struct at91_adc_platform sama5d2_platform = {
 	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
 		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
 		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
+	.chan_realbits = 14,
 };
 
 static const struct at91_adc_platform sama7g5_platform = {
@@ -638,6 +641,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.osr_vals = BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES) |
 		    BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES) |
 		    BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES),
+	.chan_realbits = 16,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -779,19 +783,21 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 {
-	if (st->oversampling_ratio == AT91_OSR_1SAMPLES) {
-		/*
-		 * in this case we only have 12 bits of real data, but channel
-		 * is registered as 14 bits, so shift left two bits
-		 */
-		*val <<= 2;
-	} else if (st->oversampling_ratio == AT91_OSR_4SAMPLES) {
-		/*
-		 * in this case we have 13 bits of real data, but channel
-		 * is registered as 14 bits, so left shift one bit
-		 */
-		*val <<= 1;
-	}
+	int nbits, diff;
+
+	if (st->oversampling_ratio == AT91_OSR_1SAMPLES)
+		nbits = 12;
+	else if (st->oversampling_ratio == AT91_OSR_4SAMPLES)
+		nbits = 13;
+	else if (st->oversampling_ratio == AT91_OSR_16SAMPLES)
+		nbits = 14;
+
+	/*
+	 * We have nbits of real data and channel is registered as
+	 * st->soc_info.platform->chan_realbits, so shift left diff bits.
+	 */
+	diff = st->soc_info.platform->chan_realbits - nbits;
+	*val <<= diff;
 
 	return IIO_VAL_INT;
 }
-- 
2.34.1

