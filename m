Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E35445CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiFIIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiFIIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9DE171250;
        Thu,  9 Jun 2022 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763426; x=1686299426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+8+SbaEPw+eg5jqq8cLYeHfwxGmoyYQ4Xtgw1pClLk=;
  b=kWokRKtFXG+BlxNNHnt0f641pKCP6SA+QA4+oar1hM3fbyzcNPxpoHmm
   ApKL+dsDdOdgc9hW9v2Tqt9vlHYN4hu2k2z7fkvs7EEWtIwwc4faGT5JC
   x3nCOeVgVn/SYqyKjQ3tkBYkGVHZd87Ei2VWjopinFjjmBY4xEQjFbd5k
   qw+GTbQ3ZlkkCXlwXpZYDshv9xFGcInJxOauWaTrKVSwxwUqsj3aIN530
   LYfgl5bqgF0zhn3SxR/V78M2jWEVTGvaj1/uURvejpeNlqIx/OkfU//a0
   gRANdBNRH5Z719MjoEUCKN2BiyEfSBMMGnfaliAmRbQnQuAzD5+kh4MwW
   w==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="177213503"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:25 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 09/16] iio: adc: at91-sama5d2_adc: update trackx on emr
Date:   Thu, 9 Jun 2022 11:32:06 +0300
Message-ID: <20220609083213.1795019-10-claudiu.beznea@microchip.com>
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

Add support for updating trackx bits of EMR register. Having different
values of EMR.TRACKX when measuring temperature give a better accuracy.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 76367cc948e8..22cd8d33c9bf 100644
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
 
@@ -747,7 +751,7 @@ static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
 }
 
 static int at91_adc_config_emr(struct at91_adc_state *st,
-			       u32 oversampling_ratio)
+			       u32 oversampling_ratio, u32 trackx)
 {
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
@@ -758,7 +762,7 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
 
 	/* delete leftover content if it's the case */
-	emr &= ~osr_mask;
+	emr &= ~(osr_mask | AT91_SAMA5D2_TRACKX_MASK);
 
 	/* select oversampling ratio from configuration */
 	switch (oversampling_ratio) {
@@ -794,6 +798,8 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 		break;
 	}
 
+	/* Update trackx. */
+	emr |= AT91_SAMA5D2_TRACKX(trackx);
 	at91_adc_writel(st, EMR, emr);
 
 	st->oversampling_ratio = oversampling_ratio;
@@ -1696,7 +1702,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		if (val == st->oversampling_ratio)
 			goto unlock;
 		/* update ratio */
-		ret = at91_adc_config_emr(st, val);
+		ret = at91_adc_config_emr(st, val, 0);
 unlock:
 		mutex_unlock(&st->lock);
 		return ret;
@@ -1872,7 +1878,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
 
 	/* configure extended mode register */
-	at91_adc_config_emr(st, st->oversampling_ratio);
+	at91_adc_config_emr(st, st->oversampling_ratio, 0);
 }
 
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
-- 
2.34.1

