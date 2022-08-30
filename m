Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269735A6150
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiH3LHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3LHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:07:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FFB1BB6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:07:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5M-000760-Lq; Tue, 30 Aug 2022 13:07:12 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5L-002rJB-Up; Tue, 30 Aug 2022 13:07:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSz5K-008Y0m-Sl; Tue, 30 Aug 2022 13:07:10 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/3] iio: adc: tsc2046: add vref support
Date:   Tue, 30 Aug 2022 13:07:08 +0200
Message-Id: <20220830110709.2037302-2-o.rempel@pengutronix.de>
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

If VREF pin is attached, we should use external VREF source instead of
the internal. Otherwise we will get wrong measurements on some of channel
types.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 64 +++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 0d9436a69cbfb..bbc8b4137b0b1 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
 #include <asm/unaligned.h>
@@ -175,6 +176,9 @@ struct tsc2046_adc_priv {
 	u32 time_per_bit_ns;
 
 	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
+	bool use_internal_vref;
+	unsigned int vref_mv;
+	struct regulator *vref_reg;
 };
 
 #define TI_TSC2046_V_CHAN(index, bits, name)			\
@@ -252,7 +256,9 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
 	case TI_TSC2046_ADDR_AUX:
 	case TI_TSC2046_ADDR_VBAT:
 	case TI_TSC2046_ADDR_TEMP0:
-		pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
+		pd |= TI_TSC2046_SER;
+		if (priv->use_internal_vref)
+			pd |= TI_TSC2046_PD1_VREF_ON;
 	}
 
 	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
@@ -468,7 +474,7 @@ static int tsc2046_adc_read_raw(struct iio_dev *indio_dev,
 		 * So, it is better to use external voltage-divider driver
 		 * instead, which is calculating complete chain.
 		 */
-		*val = TI_TSC2046_INT_VREF;
+		*val = priv->vref_mv;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -781,22 +787,42 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	indio_dev->num_channels = dcfg->num_channels;
 	indio_dev->info = &tsc2046_adc_info;
 
+	priv->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(priv->vref_reg)) {
+		ret = regulator_enable(priv->vref_reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(priv->vref_reg);
+		if (ret < 0)
+			goto err_regulator_disable;
+
+		priv->vref_mv = ret / 1000;
+		priv->use_internal_vref = false;
+	} else {
+		/* Use internal reference */
+		priv->vref_mv = TI_TSC2046_INT_VREF;
+		priv->use_internal_vref = true;
+	}
+
 	tsc2046_adc_parse_fwnode(priv);
 
 	ret = tsc2046_adc_setup_spi_msg(priv);
 	if (ret)
-		return ret;
+		goto err_regulator_disable;
 
 	mutex_init(&priv->slock);
 
 	ret = devm_request_irq(dev, spi->irq, &tsc2046_adc_irq,
 			       IRQF_NO_AUTOEN, indio_dev->name, indio_dev);
 	if (ret)
-		return ret;
+		goto err_regulator_disable;
 
 	trig = devm_iio_trigger_alloc(dev, "touchscreen-%s", indio_dev->name);
-	if (!trig)
-		return -ENOMEM;
+	if (!trig) {
+		ret = -ENOMEM;
+		goto err_regulator_disable;
+	}
 
 	priv->trig = trig;
 	iio_trigger_set_drvdata(trig, indio_dev);
@@ -811,20 +837,39 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	ret = devm_iio_trigger_register(dev, trig);
 	if (ret) {
 		dev_err(dev, "failed to register trigger\n");
-		return ret;
+		goto err_regulator_disable;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      &tsc2046_adc_trigger_handler, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to setup triggered buffer\n");
-		return ret;
+		goto err_regulator_disable;
 	}
 
 	/* set default trigger */
 	indio_dev->trig = iio_trigger_get(priv->trig);
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		goto err_regulator_disable;
+
+	return 0;
+
+err_regulator_disable:
+	if (!IS_ERR(priv->vref_reg))
+		regulator_disable(priv->vref_reg);
+
+	return ret;
+}
+
+static void tsc2046_adc_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
+
+	if (!IS_ERR(priv->vref_reg))
+		regulator_disable(priv->vref_reg);
 }
 
 static const struct of_device_id ads7950_of_table[] = {
@@ -839,6 +884,7 @@ static struct spi_driver tsc2046_adc_driver = {
 		.of_match_table = ads7950_of_table,
 	},
 	.probe = tsc2046_adc_probe,
+	.remove = tsc2046_adc_remove,
 };
 module_spi_driver(tsc2046_adc_driver);
 
-- 
2.30.2

