Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77639588A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiHCK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiHCK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:28:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43B5A2DA;
        Wed,  3 Aug 2022 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522446; x=1691058446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZujKNTVNDTmlF397h+mi6m/5oiyDsVScz732mATl8Q=;
  b=s0/V4NMxjkkWKzvZrvi4a79q67fim24DUTKJP4xYuOastWzSE7w0s5FG
   qoUswFu6gqhG6dfVaUDqf11xJMijBCz07YhFS616UniRgUhg4clVFbhnJ
   6J+BDMGJOer8PsyIGBTLo9rFOmS5urIDvIKpTtjjIt/dgs3dBIQJUEwGt
   eO4aXg0/xxg/pPuXoUXWluAXBy1+7hYVcwQSv37mNDKaKLzBIUy0WQ3Qf
   D+Iwoy6k6VVptHLdPhuIn6flu6zSUyXm2Yrgvq9gfCgNIEeVjuN5Nkw+1
   Q9nvVYSobeqNSEQrYxa9VuVUWYKQO+HUaZPa+/GKXcWIOu/Fi37q32Gtb
   A==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="170757322"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 13/19] iio: adc: at91-sama5d2_adc: update trackx on emr
Date:   Wed, 3 Aug 2022 13:28:49 +0300
Message-ID: <20220803102855.2191070-14-claudiu.beznea@microchip.com>
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

Add support for updating trackx bits of EMR register. Having different
values of EMR.TRACKX when measuring temperature give a better accuracy.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a1df475a6f29..0209353cbfd7 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -145,6 +145,10 @@ struct at91_adc_reg_layout {
 #define AT91_SAMA5D2_EMR_OSR_64SAMPLES		3
 #define AT91_SAMA5D2_EMR_OSR_256SAMPLES		4
 
+/* Extended Mode Register - TRACKX */
+#define AT91_SAMA5D2_TRACKX_MASK		GENMASK(23, 22)
+#define AT91_SAMA5D2_TRACKX(x)			(((x) << 22) & \
+						 AT91_SAMA5D2_TRACKX_MASK)
 /* Extended Mode Register - Averaging on single trigger event */
 #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
 
@@ -746,7 +750,7 @@ static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
 }
 
 static int at91_adc_config_emr(struct at91_adc_state *st,
-			       u32 oversampling_ratio)
+			       u32 oversampling_ratio, u32 trackx)
 {
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
@@ -765,7 +769,7 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
 
 	/* delete leftover content if it's the case */
-	emr &= ~osr_mask;
+	emr &= ~(osr_mask | AT91_SAMA5D2_TRACKX_MASK);
 
 	/* select oversampling ratio from configuration */
 	switch (oversampling_ratio) {
@@ -791,6 +795,8 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 		break;
 	}
 
+	/* Update trackx. */
+	emr |= AT91_SAMA5D2_TRACKX(trackx);
 	at91_adc_writel(st, EMR, emr);
 
 	st->oversampling_ratio = oversampling_ratio;
@@ -1706,7 +1712,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 			return ret;
 		mutex_lock(&st->lock);
 		/* update ratio */
-		ret = at91_adc_config_emr(st, val);
+		ret = at91_adc_config_emr(st, val, 0);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
@@ -1904,7 +1910,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
 
 	/* configure extended mode register */
-	at91_adc_config_emr(st, st->oversampling_ratio);
+	at91_adc_config_emr(st, st->oversampling_ratio, 0);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
-- 
2.34.1

