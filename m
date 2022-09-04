Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE45AC3C7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiIDKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIDKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:02:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102A40E07
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:02:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS7-0005cq-FT; Sun, 04 Sep 2022 12:02:07 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS4-003qVn-89; Sun, 04 Sep 2022 12:02:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS5-00FAJi-1j; Sun, 04 Sep 2022 12:02:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 3/3] iio: adc: tsc2046: silent spi_device_id warning
Date:   Sun,  4 Sep 2022 12:02:03 +0200
Message-Id: <20220904100203.3614502-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220904100203.3614502-1-o.rempel@pengutronix.de>
References: <20220904100203.3614502-1-o.rempel@pengutronix.de>
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

Add spi_device_id to silent following kernel runtime warning:
"SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc".

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
changes v4:
- add Reviewed-by: Andy Shevchenko
changes v3:
- add missing point
- remove unneeded blank line
- assignment id at the definition line
changes v2:
- attach actual driver_data
- use spi_get_device_id fallback
---
 drivers/iio/adc/ti-tsc2046.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 8d6559303172f..1bbb51a6683c9 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -805,6 +805,11 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	}
 
 	dcfg = device_get_match_data(dev);
+	if (!dcfg) {
+		const struct spi_device_id *id = spi_get_device_id(spi);
+
+		dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
+	}
 	if (!dcfg)
 		return -EINVAL;
 
@@ -886,11 +891,18 @@ static const struct of_device_id ads7950_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);
 
+static const struct spi_device_id tsc2046_adc_spi_ids[] = {
+	{ "tsc2046e-adc", (unsigned long)&tsc2046_adc_dcfg_tsc2046e },
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
 };
 module_spi_driver(tsc2046_adc_driver);
-- 
2.30.2

