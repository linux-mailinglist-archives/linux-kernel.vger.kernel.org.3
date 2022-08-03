Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616E588A63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiHCK1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbiHCK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9820BC6;
        Wed,  3 Aug 2022 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522418; x=1691058418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDl9ArM+tNwYpgARK8PCiohAPw8HwxlStSM0vpuBwJ0=;
  b=drT9pDFk5mzcIFr1Nvtyjqb5xvx2cvH7c0KXHtMyo0bJG0gNjQmn0iwq
   yEIQzuLUtOePjihvNRN4VZQXVzwIIJABtLtSGjXdW6c0cRJ3NrC9IhEn+
   X23+Ry7ba54M4cYaHfTZbPs2na0AhFe2FMKYqK29NWZ4m1jQ4yL4kcVer
   VzuWxCDn3Xwfmmy21wqEsjTrvgwM+G1UiNnU8ygZxYaaMgt7lfBzRfU6h
   ZvE76lDZjH7/djV3NtA6ai+ttuxsml+sBI1DcDxvvL58VNimoEWCFuglQ
   AcMlmWG5LAkPFPOJ5MZUetOWrcAVgbaM1dMJrgw0TJ1ON6F2dBFid6quF
   w==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364714"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:26:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 06/19] iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw versions
Date:   Wed, 3 Aug 2022 13:28:42 +0300
Message-ID: <20220803102855.2191070-7-claudiu.beznea@microchip.com>
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

SAMA7G5 introduces 64 and 256 oversampling rates. Due to this EMR.OSR is 3
bits long. Change the code to reflect this. Commit prepares the code
for the addition of 64 and 256 oversampling rates.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 64943d8ea869..0283c8cc3168 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -138,8 +138,7 @@ struct at91_adc_reg_layout {
 /* Extended Mode Register */
 	u16				EMR;
 /* Extended Mode Register - Oversampling rate */
-#define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
-#define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
+#define AT91_SAMA5D2_EMR_OSR(V, M)		(((V) << 16) & (M))
 #define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
 #define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
 #define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
@@ -403,6 +402,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @max_index:		highest channel index (highest index may be higher
  *			than the total channel number)
  * @hw_trig_cnt:	number of possible hardware triggers
+ * @osr_mask:		oversampling ratio bitmask on EMR register
  */
 struct at91_adc_platform {
 	const struct at91_adc_reg_layout	*layout;
@@ -414,6 +414,7 @@ struct at91_adc_platform {
 	unsigned int				max_channels;
 	unsigned int				max_index;
 	unsigned int				hw_trig_cnt;
+	unsigned int				osr_mask;
 };
 
 /**
@@ -612,6 +613,7 @@ static const struct at91_adc_platform sama5d2_platform = {
 	.max_index = AT91_SAMA5D2_MAX_CHAN_IDX,
 #define AT91_SAMA5D2_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA5D2_HW_TRIG_CNT,
+	.osr_mask = GENMASK(17, 16),
 };
 
 static const struct at91_adc_platform sama7g5_platform = {
@@ -627,6 +629,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
 #define AT91_SAMA7G5_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
+	.osr_mask = GENMASK(18, 16),
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -725,30 +728,32 @@ static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
 		at91_adc_writel(st, EOC_IER, BIT(channel));
 }
 
-static void at91_adc_config_emr(struct at91_adc_state *st)
+static void at91_adc_config_emr(struct at91_adc_state *st,
+				u32 oversampling_ratio)
 {
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
+	unsigned int osr_mask = st->soc_info.platform->osr_mask;
 
 	/* select oversampling per single trigger event */
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
 
 	/* delete leftover content if it's the case */
-	emr &= ~AT91_SAMA5D2_EMR_OSR_MASK;
+	emr &= ~osr_mask;
 
 	/* select oversampling ratio from configuration */
-	switch (st->oversampling_ratio) {
+	switch (oversampling_ratio) {
 	case AT91_OSR_1SAMPLES:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES) &
-		       AT91_SAMA5D2_EMR_OSR_MASK;
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
+					    osr_mask);
 		break;
 	case AT91_OSR_4SAMPLES:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES) &
-		       AT91_SAMA5D2_EMR_OSR_MASK;
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
+					    osr_mask);
 		break;
 	case AT91_OSR_16SAMPLES:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES) &
-		       AT91_SAMA5D2_EMR_OSR_MASK;
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
+					    osr_mask);
 		break;
 	}
 
@@ -1658,7 +1663,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		st->oversampling_ratio = val;
 		/* update ratio */
-		at91_adc_config_emr(st);
+		at91_adc_config_emr(st, val);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 		return 0;
@@ -1838,7 +1843,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
 
 	/* configure extended mode register */
-	at91_adc_config_emr(st);
+	at91_adc_config_emr(st, st->oversampling_ratio);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
-- 
2.34.1

