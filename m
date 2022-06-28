Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76D55E962
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbiF1POl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347785AbiF1PO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A22D1D2;
        Tue, 28 Jun 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429266; x=1687965266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXG7YlbsOZ3z/WgmYcYRa9YBKV8mMjd6Oe/SsZqOqYE=;
  b=jWJnBVryta3aRa1IW3REBpozbQDOXoKuDHvtkrDgl0xiuoZkiBDLnHb/
   NUocSLrotxc5NekcPwDsHVapjWsyrNj5f52IaXbqzUFfU18A9lcaQ0lWO
   qOMQsJFKLbJjGOCERorNXtKARe9ySuWVn/oHKHRV/ER1W8XVStCxFwieg
   MOeMZ7c1FEBerHudI0cbjYX7aWukZFVw4BY9DrPlECVZ/dCKQ3b2XJNjR
   YGkRRDpBldXnN0NO4/aYSXY9ohuHi2GSWMIq0HaDVtFZujECeN6+/TGKt
   oJXQshgJsEYeKRwE/hR9fuykSAxlFik/b/5R8ko/4st+rCtfUlt+3UYF+
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="170219131"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 04/19] iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
Date:   Tue, 28 Jun 2022 18:16:16 +0300
Message-ID: <20220628151631.3116454-5-claudiu.beznea@microchip.com>
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

In case triggered buffers are enabled while system is suspended they will
not work anymore after resume. For this call at91_adc_buffer_postdisable()
on suspend and at91_adc_buffer_prepare() on resume. On tests it has been
seen that at91_adc_buffer_postdisable() call is not necessary but it has
been kept because it also does the book keeping for DMA. On resume path
there is no need to call at91_adc_configure_touch() as it is embedded in
at91_adc_buffer_prepare().

Fixes: 073c662017f2f ("iio: adc: at91-sama5d2_adc: add support for DMA")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 40a95d2fd5c8..2c087d52f164 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2116,6 +2116,9 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	if (iio_buffer_enabled(indio_dev))
+		at91_adc_buffer_postdisable(indio_dev);
+
 	/*
 	 * Do a sofware reset of the ADC before we go to suspend.
 	 * this will ensure that all pins are free from being muxed by the ADC
@@ -2159,14 +2162,11 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	if (!iio_buffer_enabled(indio_dev))
 		return 0;
 
-	/* check if we are enabling triggered buffer or the touchscreen */
-	if (at91_adc_current_chan_is_touch(indio_dev))
-		return at91_adc_configure_touch(st, true);
-	else
-		return at91_adc_configure_trigger(st->trig, true);
+	ret = at91_adc_buffer_prepare(indio_dev);
+	if (ret)
+		goto vref_disable_resume;
 
-	/* not needed but more explicit */
-	return 0;
+	return at91_adc_configure_trigger(st->trig, true);
 
 vref_disable_resume:
 	regulator_disable(st->vref);
-- 
2.34.1

