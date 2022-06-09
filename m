Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1165445D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiFIIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiFIIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1D156B65;
        Thu,  9 Jun 2022 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763440; x=1686299440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYC370GlY9Ziv2hoPvbdqWUTbAFrz6Hk5YnNDt35pC4=;
  b=E5lUcq3hCMLbH4He/jEp/G6Vq0BbvdP6NMCJxSMSumgVuqx0Ziu8XZ2e
   6XHmY6DA0q6qQL6GQIQ6qv3C4LjKC8cQ4RJemzbkdBzTu+zYnK3BaGFpq
   /tzj0AN1xYAUNu1Knn5SezMsi81i0dDA+61QAEsgFR2MqygVk/WGJsUvW
   tPNefXcoVEAtPikW+nt46BVBT7FEJouEPEH7SUbTkhV236XPBeougKhRT
   n1zNQzYGZl+Pg020O0S1YWztAHgL7QhjYhe5KewVxMAAapaikkJr/wbeV
   9rrCwJ+Jawzx+RTWSLDfv7iMCj+8W8c3iEvrj1ieiCv5+9Svf3RBU1Vl6
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="99259994"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 10/16] iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for at91_adc_setup_samp_freq()
Date:   Thu, 9 Jun 2022 11:32:07 +0300
Message-ID: <20220609083213.1795019-11-claudiu.beznea@microchip.com>
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

Add startup and tracktim as parameter for at91_adc_setup_samp_freq()
function. In case of temperature sensor being enabled these parameters
will be configured on temperature read request to improve the accuracy
of the read temperature.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 22cd8d33c9bf..1283bcf4e682 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1435,7 +1435,9 @@ static unsigned at91_adc_startup_time(unsigned startup_time_min,
 	return i;
 }
 
-static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq)
+static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
+				     unsigned int startup_time,
+				     unsigned int tracktim)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	unsigned f_per, prescal, startup, mr;
@@ -1443,17 +1445,17 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq)
 	f_per = clk_get_rate(st->per_clk);
 	prescal = (f_per / (2 * freq)) - 1;
 
-	startup = at91_adc_startup_time(st->soc_info.startup_time,
-					freq / 1000);
+	startup = at91_adc_startup_time(startup_time, freq / 1000);
 
 	mr = at91_adc_readl(st, MR);
 	mr &= ~(AT91_SAMA5D2_MR_STARTUP_MASK | AT91_SAMA5D2_MR_PRESCAL_MASK);
 	mr |= AT91_SAMA5D2_MR_STARTUP(startup);
 	mr |= AT91_SAMA5D2_MR_PRESCAL(prescal);
+	mr |= AT91_SAMA5D2_MR_TRACKTIM(tracktim);
 	at91_adc_writel(st, MR, mr);
 
-	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
-		freq, startup, prescal);
+	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u, tracktim=%u\n",
+		freq, startup, prescal, tracktim);
 	st->current_sample_rate = freq;
 }
 
@@ -1712,7 +1714,8 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&st->lock);
-		at91_adc_setup_samp_freq(indio_dev, val);
+		at91_adc_setup_samp_freq(indio_dev, val,
+					 st->soc_info.startup_time, 0);
 		mutex_unlock(&st->lock);
 		return 0;
 	default:
@@ -1875,7 +1878,8 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_writel(st, MR,
 			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
 
-	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
+	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate,
+				 st->soc_info.startup_time, 0);
 
 	/* configure extended mode register */
 	at91_adc_config_emr(st, st->oversampling_ratio, 0);
-- 
2.34.1

