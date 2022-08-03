Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED32A588A73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiHCK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiHCK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:27:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511131DF9;
        Wed,  3 Aug 2022 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522434; x=1691058434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXDN5FGyWbjPTPcw5Hqk3JhfHtmBmGchIV6JtD8l/8U=;
  b=UXHwiU+qMEYp+O5ZtJ7z2/IePH15QTIxus6CskMp7i71A+o5N6unAR7R
   D5DlCa0T67UXDQfc6+5EPq/D1TjFlm/s2mEzAnU0NVjOjFAcq+EAwlbUl
   J5Ag6xJTnOFHhYA74BIHkpO2H6Nv8Z7addWNEWv5/znFxT+PFEEyVM4hz
   x/lakzmC5H7MrxWz/I3nJM9UeUo1kIM/ybrkRFkd40xCgBeGns8R92Nzq
   xlr9p7xeH2seew5FFsHs8xHL/C2GkhjmsDmzMT4WLSLToVfZXY/h8QjRa
   vOv3m57YNDWXwrv2Y9+dIPYwgtljE0pbck9A4f0ByBrsnBlK8XAkP/r8+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364762"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:13 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 11/19] iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
Date:   Wed, 3 Aug 2022 13:28:47 +0300
Message-ID: <20220803102855.2191070-12-claudiu.beznea@microchip.com>
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

Add 64 and 256 oversampling ratio support. It is necessary for temperature
sensor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v3:
- adapt to changes on patch 10/19

 drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index db9d77385149..d6a93aa7fbaf 100644
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
@@ -421,7 +423,7 @@ struct at91_adc_platform {
 	unsigned int				max_index;
 	unsigned int				hw_trig_cnt;
 	unsigned int				osr_mask;
-	unsigned int				oversampling_avail[3];
+	unsigned int				oversampling_avail[5];
 	unsigned int				oversampling_avail_no;
 	unsigned int				chan_realbits;
 };
@@ -642,8 +644,8 @@ static const struct at91_adc_platform sama7g5_platform = {
 #define AT91_SAMA7G5_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
 	.osr_mask = GENMASK(18, 16),
-	.oversampling_avail = { 1, 4, 16, },
-	.oversampling_avail_no = 3,
+	.oversampling_avail = { 1, 4, 16, 64, 256, },
+	.oversampling_avail_no = 5,
 	.chan_realbits = 16,
 };
 
@@ -749,6 +751,15 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
 	unsigned int osr_mask = st->soc_info.platform->osr_mask;
+	int i;
+
+	/* Check against supported oversampling values. */
+	for (i = 0; i < st->soc_info.platform->oversampling_avail_no; i++) {
+		if (oversampling_ratio == st->soc_info.platform->oversampling_avail[i])
+			break;
+	}
+	if (i == st->soc_info.platform->oversampling_avail_no)
+		return -EINVAL;
 
 	/* select oversampling per single trigger event */
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
@@ -770,8 +781,14 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
-	default:
-		return -EINVAL;
+	case 64:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
+					    osr_mask);
+		break;
+	case 256:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
+					    osr_mask);
+		break;
 	}
 
 	at91_adc_writel(st, EMR, emr);
@@ -789,6 +806,10 @@ static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 		nbits = 13;
 	else if (st->oversampling_ratio == 16)
 		nbits = 14;
+	else if (st->oversampling_ratio == 64)
+		nbits = 15;
+	else if (st->oversampling_ratio == 256)
+		nbits = 16;
 	else
 		/* Should not happen. */
 		return -EINVAL;
-- 
2.34.1

