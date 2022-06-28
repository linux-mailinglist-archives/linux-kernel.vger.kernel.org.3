Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B755E6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiF1PPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347987AbiF1POk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E32E09A;
        Tue, 28 Jun 2022 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429278; x=1687965278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kpUWPrjN6tT2xVPogeKtIYvEa5wE+vr2zel4CAvwWsE=;
  b=qs1Jd4lzYLiG3cLYNlm9RWWVUpvBX3g7nkM6AUQzNIuZjLB8TkzyZmY9
   bNiMRAiTul8HrwereElKW/FbR/osPUJgfiWVBpFrXoh6yola8BhdYH3w6
   7yAgrTpwrxnpTPe/Iawnx+RN3EN+ke2eW5N3PDP09BkUvA5CTrGlDiQAl
   GdeLyajhmY5SJtDzJM7OPZHOW5cltgJCe1DkkVSIxn6zkbwcDU1fHNNbe
   s5duSjzwC748wO8dGnrvdihADQzP+ut7aO2Wfz0u/VtdhmUfSS57T+D+h
   cgiHfbrarXwSh3rwmj3oMUA7oDs/sGPpvZYmLAypfynzPbY+pAaSpCmCJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="102111302"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:37 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 07/19] iio: adc: at91-sama5d2_adc: move the check of oversampling in its function
Date:   Tue, 28 Jun 2022 18:16:19 +0300
Message-ID: <20220628151631.3116454-8-claudiu.beznea@microchip.com>
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

Oversampling values are checked anyway in at91_adc_emr_config(). Remove
the checking of these from at91_adc_write_raw() and return -EINVAL
instead in at91_adc_emr_config().

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 692707b6e3e3..a0661f097ccb 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -728,8 +728,8 @@ static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
 		at91_adc_writel(st, EOC_IER, BIT(channel));
 }
 
-static void at91_adc_config_emr(struct at91_adc_state *st,
-				u32 oversampling_ratio)
+static int at91_adc_config_emr(struct at91_adc_state *st,
+			       u32 oversampling_ratio)
 {
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
@@ -755,9 +755,13 @@ static void at91_adc_config_emr(struct at91_adc_state *st,
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	at91_adc_writel(st, EMR, emr);
+
+	return 0;
 }
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
@@ -1650,9 +1654,6 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
-		    (val != AT91_OSR_16SAMPLES))
-			return -EINVAL;
 		/* if no change, optimize out */
 		if (val == st->oversampling_ratio)
 			return 0;
@@ -1661,12 +1662,13 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		mutex_lock(&st->lock);
-		st->oversampling_ratio = val;
 		/* update ratio */
-		at91_adc_config_emr(st, val);
+		ret = at91_adc_config_emr(st, val);
+		if (!ret)
+			st->oversampling_ratio = val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
-		return 0;
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val < st->soc_info.min_sample_rate ||
 		    val > st->soc_info.max_sample_rate)
-- 
2.34.1

