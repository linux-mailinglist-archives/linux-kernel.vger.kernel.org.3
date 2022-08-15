Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DA59295E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiHOGMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiHOGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:12:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3318E34;
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so9446996lfs.0;
        Sun, 14 Aug 2022 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nySt5r8RBUWJyAwoMP25rpQPbX0MGFg7D6eUR2CrCKw=;
        b=C2VOQjEU0J5JtK2+jRfvLhmQLD/14wnfrCe4oP9sCX8jHeNv4YbVZ9rVJF05PvM2/b
         CBvMU09RafkqgOo7XSBT+QtD8FcGiHGkwWMXowfaDTDx7ZWSSyXI3zYFJQxZM5UqV4ZO
         xApiJj0gAHH8YZqz7y7DhgSmx1ecSsdAAj0V89w/U7tEMFFbdBnCzQIjdiwKejy0Nd3G
         oBCD5H9KTTwLsaqgCO4gzVcdNW4K+fCrhMRf7okA/5YAw/c7lCgSDx8GAme6t+u2SSY6
         T/6ewO1cggdlFBVP/SqXSTduUkXx0b+SUHPOuGTpAZLDLpd2Xp5hLJw79twsU8dpXBLS
         KOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nySt5r8RBUWJyAwoMP25rpQPbX0MGFg7D6eUR2CrCKw=;
        b=mtcHv017K/KaS9S+KIBKfROHq/oxaerDlXU5fnRr/Tii0T0JmMYWCLfBciNWunLlxs
         4gQLov+kSotydugC6Yz4lVoQlpKYO28e33ZCAtVjq1Jft4wkIb4BBIdbJhygUeazP9xH
         MmTlUs49ScMvB5/rqvLuMHlG4S3fJz44H1Ey2vjZyt5rU2JvIrib3/lpZm5Am/h634hi
         hHn2ZXF9FMOKCIVQrF95cXQ9JWw7xGdfh5EdoW2FtkU61Z7QE6mmfgf29IWloxEvJzoX
         U1rlwhJg03pi/3Y7EfeeBUbJhg79yxOEQikoE84QAjpbsokqy7sESAmwf1XrIlQTOQGh
         0AlA==
X-Gm-Message-State: ACgBeo2q4/XZmhWUGrNevjKhjPw+VEV8tj4nbHsZef9JPQMQaLTu2Inx
        hM8sLf6gLjBoiYpSJlxGFFI=
X-Google-Smtp-Source: AA6agR5TlGwUkFeWcmfXW+Z0bpGE/SZFTFMRDHtL5B8jkPsv8+3870hOMLqtc/XRmYHp3OtdHr62iA==
X-Received: by 2002:a19:4918:0:b0:48c:e6a0:c8d8 with SMTP id w24-20020a194918000000b0048ce6a0c8d8mr5077135lfa.679.1660543914126;
        Sun, 14 Aug 2022 23:11:54 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:53 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] iio: adc: mcp3911: add support for buffers
Date:   Mon, 15 Aug 2022 08:16:21 +0200
Message-Id: <20220815061625.35568-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for buffers to make the driver fit for more use cases.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/Kconfig   |   2 +
 drivers/iio/adc/mcp3911.c | 103 +++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7fe5930891e0..3b5db59f3931 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -718,6 +718,8 @@ config MCP3422
 config MCP3911
 	tristate "Microchip Technology MCP3911 driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Microchip Technology's MCP3911
 	  analog to digital converter.
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 7e2efe702e57..4452b01c76f3 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -5,16 +5,25 @@
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
+
+#include <asm/unaligned.h>
+
 #define MCP3911_REG_CHANNEL0		0x00
 #define MCP3911_REG_CHANNEL1		0x03
 #define MCP3911_REG_MOD			0x06
@@ -22,6 +31,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
 #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
@@ -54,6 +64,13 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct {
+		u32 channels[MCP3911_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} scan;
+
+	u8 tx_buf __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -196,16 +213,66 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = idx,					\
+		.scan_index = idx,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 24,				\
+			.storagebits = 32,			\
+			.endianness = IIO_BE,			\
+		},						\
 }
 
 static const struct iio_chan_spec mcp3911_channels[] = {
 	MCP3911_CHAN(0),
 	MCP3911_CHAN(1),
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mcp3911 *adc = iio_priv(indio_dev);
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &adc->tx_buf,
+			.len = 1,
+		}, {
+			.rx_buf = adc->rx_buf,
+			.len = sizeof(adc->rx_buf),
+		},
+	};
+	int scan_index;
+	int i = 0;
+	int ret;
+
+	mutex_lock(&adc->lock);
+	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
+	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret < 0) {
+		dev_warn(&adc->spi->dev,
+				"failed to get conversion data\n");
+		goto out;
+	}
+
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask, indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
+
+		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);
+		i++;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
+					   iio_get_time_ns(indio_dev));
+out:
+	mutex_unlock(&adc->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
@@ -214,7 +281,7 @@ static const struct iio_info mcp3911_info = {
 static int mcp3911_config(struct mcp3911 *adc)
 {
 	struct device *dev = &adc->spi->dev;
-	u32 configreg;
+	u32 regval;
 	int ret;
 
 	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
@@ -233,29 +300,43 @@ static int mcp3911_config(struct mcp3911 *adc)
 	}
 	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
 
-	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
+	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
 		return ret;
 
+	regval &= ~MCP3911_CONFIG_VREFEXT;
 	if (adc->vref) {
 		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
-		configreg |= MCP3911_CONFIG_VREFEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
 	} else {
 		dev_dbg(&adc->spi->dev,
 			"use internal voltage reference (1.2V)\n");
-		configreg &= ~MCP3911_CONFIG_VREFEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 0);
 	}
 
+	regval &= ~MCP3911_CONFIG_CLKEXT;
 	if (adc->clki) {
 		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
-		configreg |= MCP3911_CONFIG_CLKEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 1);
 	} else {
 		dev_dbg(&adc->spi->dev,
 			"use crystal oscillator as clocksource\n");
-		configreg &= ~MCP3911_CONFIG_CLKEXT;
+		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 0);
 	}
 
-	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
+	ret = mcp3911_write(adc, MCP3911_REG_CONFIG, regval, 2);
+	if (ret)
+		return ret;
+
+	ret = mcp3911_read(adc, MCP3911_REG_STATUSCOM, &regval, 2);
+	if (ret)
+		return ret;
+
+	/* Address counter incremented, cycle through register types */
+	regval &= ~MCP3911_STATUSCOM_READ;
+	regval |= FIELD_PREP(MCP3911_STATUSCOM_READ, 0x02);
+
+	return  mcp3911_write(adc, MCP3911_REG_STATUSCOM, regval, 2);
 }
 
 static void mcp3911_cleanup_regulator(void *_adc)
@@ -326,6 +407,12 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+			NULL,
+			mcp3911_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&adc->spi->dev, indio_dev);
 }
 
-- 
2.37.1

