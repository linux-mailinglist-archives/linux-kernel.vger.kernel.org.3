Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60E55E7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbiF1PPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbiF1PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE163313A4;
        Tue, 28 Jun 2022 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429302; x=1687965302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wAqMM+KZBfprtJESuWG3hz8002LSWCuMMQEWX6yP8PQ=;
  b=0fWP/WhbKVUcZ+NZe77FPkuA54mwTB+SFyqJH3HfqQZPz5kqkfZoGuvO
   tjLk9aWvjzgDvx2HByGcpqqd7cntelekX7deXxjXwXgTL+H4rHl+8DlKC
   LSDEx8AyuDMb7K5rG6TNdh7qODTiZmRXyIZFuFbAr1mkHHaCqBc4rW3ZU
   I4OStvyXnuQCAGZ5b7+NrSSn7F4s477EoWgliLZ/ELxGWIpsMt/9Btf9S
   hF+Hg7HpoCFyEbo+lCuaX7wMUrkP2MfoEA3onouz1b0UC+f4BvoGQu4Yp
   HM0UikK71r3/JfI3tl5vVoqLJlahd4lxd8jKCPPQsf7EE1asmijB4XNIG
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162421037"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:15:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:57 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 13/19] iio: adc: at91-sama5d2_adc: update trackx on emr
Date:   Tue, 28 Jun 2022 18:16:25 +0300
Message-ID: <20220628151631.3116454-14-claudiu.beznea@microchip.com>
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

Add support for updating trackx bits of EMR register. Having different
values of EMR.TRACKX when measuring temperature give a better accuracy.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 57c78cd23634..ee67f944b58c 100644
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
@@ -1703,7 +1709,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 			return ret;
 		mutex_lock(&st->lock);
 		/* update ratio */
-		ret = at91_adc_config_emr(st, val);
+		ret = at91_adc_config_emr(st, val, 0);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
@@ -1901,7 +1907,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
 
 	/* configure extended mode register */
-	at91_adc_config_emr(st, st->oversampling_ratio);
+	at91_adc_config_emr(st, st->oversampling_ratio, 0);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
-- 
2.34.1

