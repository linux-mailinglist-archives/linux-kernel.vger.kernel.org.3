Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58975AC3C8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiIDKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiIDKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:02:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108440E08
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 03:02:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS7-0005cm-FT; Sun, 04 Sep 2022 12:02:07 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS4-003qVk-0U; Sun, 04 Sep 2022 12:02:05 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oUmS5-00FAJZ-14; Sun, 04 Sep 2022 12:02:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 2/3] iio: adc: tsc2046: add vref support
Date:   Sun,  4 Sep 2022 12:02:02 +0200
Message-Id: <20220904100203.3614502-2-o.rempel@pengutronix.de>
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

If VREF pin is attached, we should use external VREF source instead of
the internal. Otherwise we will get wrong measurements on some of the channel
types.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
changes v6:
- optimize struct padding and reduce size from 480 to 472 bytes.
changes v5:
- add "the" before channel
- refactor error handling on regulator registration
- use MILLI instead of 1000
changes v4:
- use vref_reg pointer instead of bool use_internal_vref
- move regulator registration to a separate function
- rework error handling
- add devm_add_action_or_reset
---
 drivers/iio/adc/ti-tsc2046.c | 57 ++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 0d9436a69cbfb..8d6559303172f 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -8,7 +8,9 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <asm/unaligned.h>
 
@@ -139,6 +141,7 @@ enum tsc2046_state {
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
 	const struct tsc2046_adc_dcfg *dcfg;
+	struct regulator *vref_reg;
 
 	struct iio_trigger *trig;
 	struct hrtimer trig_timer;
@@ -173,6 +176,7 @@ struct tsc2046_adc_priv {
 	u32 scan_interval_us;
 	u32 time_per_scan_us;
 	u32 time_per_bit_ns;
+	unsigned int vref_mv;
 
 	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
 };
@@ -252,7 +256,9 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
 	case TI_TSC2046_ADDR_AUX:
 	case TI_TSC2046_ADDR_VBAT:
 	case TI_TSC2046_ADDR_TEMP0:
-		pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
+		pd |= TI_TSC2046_SER;
+		if (!priv->vref_reg)
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
@@ -740,6 +746,49 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
 	}
 }
 
+static void tsc2046_adc_regulator_disable(void *data)
+{
+	struct tsc2046_adc_priv *priv = data;
+
+	regulator_disable(priv->vref_reg);
+}
+
+static int tsc2046_adc_configure_regulator(struct tsc2046_adc_priv *priv)
+{
+	struct device *dev = &priv->spi->dev;
+	int ret;
+
+	priv->vref_reg = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(priv->vref_reg)) {
+		/* If regulator exists but can't be get, return an error */
+		if (PTR_ERR(priv->vref_reg) != -ENODEV)
+			return PTR_ERR(priv->vref_reg);
+		priv->vref_reg = NULL;
+	}
+	if (!priv->vref_reg) {
+		/* Use internal reference */
+		priv->vref_mv = TI_TSC2046_INT_VREF;
+		return 0;
+	}
+
+	ret = regulator_enable(priv->vref_reg);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, tsc2046_adc_regulator_disable,
+				       priv);
+	if (ret)
+		return ret;
+
+	ret = regulator_get_voltage(priv->vref_reg);
+	if (ret < 0)
+		return ret;
+
+	priv->vref_mv = ret / MILLI;
+
+	return 0;
+}
+
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
 	const struct tsc2046_adc_dcfg *dcfg;
@@ -781,6 +830,10 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	indio_dev->num_channels = dcfg->num_channels;
 	indio_dev->info = &tsc2046_adc_info;
 
+	ret = tsc2046_adc_configure_regulator(priv);
+	if (ret)
+		return ret;
+
 	tsc2046_adc_parse_fwnode(priv);
 
 	ret = tsc2046_adc_setup_spi_msg(priv);
-- 
2.30.2

