Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2695A6152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH3LH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiH3LHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:07:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984EB1BB6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:07:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5M-00075z-Lt; Tue, 30 Aug 2022 13:07:12 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5L-002rJ8-Nx; Tue, 30 Aug 2022 13:07:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5K-008Y0v-TW; Tue, 30 Aug 2022 13:07:10 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 3/3] iio: adc: tsc2046: silent spi_device_id warning
Date:   Tue, 30 Aug 2022 13:07:09 +0200
Message-Id: <20220830110709.2037302-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830110709.2037302-1-o.rempel@pengutronix.de>
References: <20220830110709.2037302-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi_device_id to silent following warning:
 SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index bbc8b4137b0b1..b9a1fac659d46 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -761,7 +761,15 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	dcfg = device_get_match_data(dev);
+	if (!dev_fwnode(dev)) {
+		const struct spi_device_id *id;
+
+		id = spi_get_device_id(spi);
+		dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
+	} else {
+		dcfg = device_get_match_data(dev);
+	}
+
 	if (!dcfg)
 		return -EINVAL;
 
@@ -878,11 +886,18 @@ static const struct of_device_id ads7950_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);
 
+static const struct spi_device_id tsc2046_adc_spi_ids[] = {
+	{ "tsc2046e-adc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);
+
 static struct spi_driver tsc2046_adc_driver = {
 	.driver = {
 		.name = "tsc2046",
 		.of_match_table = ads7950_of_table,
 	},
+	.id_table = tsc2046_adc_spi_ids,
 	.probe = tsc2046_adc_probe,
 	.remove = tsc2046_adc_remove,
 };
-- 
2.30.2

