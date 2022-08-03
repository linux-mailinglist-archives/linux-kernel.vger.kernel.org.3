Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A2E588A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiHCK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiHCK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042B252B4;
        Wed,  3 Aug 2022 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522413; x=1691058413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWjmlrRxeD0EqJC2I0ODZLzPhcirr16fnSvcBWhPnTc=;
  b=hvr/dRBWid8bA+koSRTi6poj+QueyE5orTRhSTwV8G7ZkuyFtSRCotbs
   vIyG8E2d4qcV/vk8DTNeuh9Y0CAdApvYt/rqdJ3jIgzIj2HNVpRnLeHPq
   0ip0e0BeG3PpmObUeR32yF4f7D4dLe/zoPqRUKp+iTLlWLUTrbs1iTgNI
   AeD0lSk5E/Obux6+aVRoJPNZq2CCt7b+iB9bAboQGIWiK5dDyJBo2NAr7
   O04tRV1Nz6/THYRkyBY1v3qK2HyI/7QHNN2dHL8AefyfdMWzQ0Jit9FEM
   Gvli5iCe7QR9zrEe1JHBC3B04/wAEpfVRqKR+xieu2O0KlIiaM6OMLXrq
   A==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364696"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 03:26:50 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 04/19] iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
Date:   Wed, 3 Aug 2022 13:28:40 +0300
Message-ID: <20220803102855.2191070-5-claudiu.beznea@microchip.com>
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
index 3734ddc82952..e2c82c5a2fac 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2116,6 +2116,9 @@ static int at91_adc_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	if (iio_buffer_enabled(indio_dev))
+		at91_adc_buffer_postdisable(indio_dev);
+
 	/*
 	 * Do a sofware reset of the ADC before we go to suspend.
 	 * this will ensure that all pins are free from being muxed by the ADC
@@ -2159,14 +2162,11 @@ static int at91_adc_resume(struct device *dev)
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

