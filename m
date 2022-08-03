Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27C588A70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiHCK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiHCK1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:27:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17C49B74;
        Wed,  3 Aug 2022 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522432; x=1691058432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zgJ/sTKnZeGVtlIswUamGjRCKFb1gi/3YQgy2jJ1lbo=;
  b=PislFyQpVFaBp01ZGojtrkRidIu6ZWRW9K9wTSyhk0CsAgqCZsF0PJj6
   IbrdZ4Vw01XBYZnKr/2XzhMrJk1gLkQ1Lhj+OyC9Eld9sISRRdl9KV/Q1
   YkBQOWhbuBpwIYOCB6SlJ2GRJhEw/NgYzMBg8dHAEep0swIIv+V6HHfeg
   P73YkFScwzzIxQ/PlW+aLAbD/LeEoffYKLM3PysT2VfhHE6P5z+lSDKPw
   bYUdvm8gKhxCZChaca7LDYYXtBfdPQJWYdWQtfIJmNCJ17EyOhWC9gSJq
   Z2KDqfvrjMFdQkqExgRoCo9mK2Pc9O/RVi9Z/QZmO1uhxI5B01S0K1gwb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="167621997"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 10/19] iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
Date:   Wed, 3 Aug 2022 13:28:46 +0300
Message-ID: <20220803102855.2191070-11-claudiu.beznea@microchip.com>
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

Changes in v3:
- return -EINVAL in case at91_adc_adjust_val_osr() if
  oversampling ratio is not supported

 drivers/iio/adc/at91-sama5d2_adc.c | 35 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 47caaf271fae..db9d77385149 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -408,6 +408,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
  * @osr_mask:		oversampling ratio bitmask on EMR register
  * @oversampling_avail:	available oversampling values
  * @oversampling_avail_no: number of available oversampling values
+ * @chan_realbits:	realbits for registered channels
  */
 struct at91_adc_platform {
 	const struct at91_adc_reg_layout	*layout;
@@ -422,6 +423,7 @@ struct at91_adc_platform {
 	unsigned int				osr_mask;
 	unsigned int				oversampling_avail[3];
 	unsigned int				oversampling_avail_no;
+	unsigned int				chan_realbits;
 };
 
 /**
@@ -623,6 +625,7 @@ static const struct at91_adc_platform sama5d2_platform = {
 	.osr_mask = GENMASK(17, 16),
 	.oversampling_avail = { 1, 4, 16, },
 	.oversampling_avail_no = 3,
+	.chan_realbits = 14,
 };
 
 static const struct at91_adc_platform sama7g5_platform = {
@@ -641,6 +644,7 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.osr_mask = GENMASK(18, 16),
 	.oversampling_avail = { 1, 4, 16, },
 	.oversampling_avail_no = 3,
+	.chan_realbits = 16,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -777,19 +781,24 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 {
-	if (st->oversampling_ratio == 1) {
-		/*
-		 * in this case we only have 12 bits of real data, but channel
-		 * is registered as 14 bits, so shift left two bits
-		 */
-		*val <<= 2;
-	} else if (st->oversampling_ratio == 4) {
-		/*
-		 * in this case we have 13 bits of real data, but channel
-		 * is registered as 14 bits, so left shift one bit
-		 */
-		*val <<= 1;
-	}
+	int nbits, diff;
+
+	if (st->oversampling_ratio == 1)
+		nbits = 12;
+	else if (st->oversampling_ratio == 4)
+		nbits = 13;
+	else if (st->oversampling_ratio == 16)
+		nbits = 14;
+	else
+		/* Should not happen. */
+		return -EINVAL;
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

