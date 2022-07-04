Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42840565CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiGDRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiGDRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1916E26E3;
        Mon,  4 Jul 2022 10:19:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z13so16713792lfj.13;
        Mon, 04 Jul 2022 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNIj3LpkA8AS8doXHlRfvjaWK2oNi27ElwWZcfgxMbE=;
        b=H+QWJDolEciQaI2ggUP+L8jsOsuXR8sBjQLxjeaVJw5OF8LoiQqILWmMgZQCICNmJV
         eHomv/K8MUDI8HG+dSuCgGpOO2UB8lsY/WmALHg5FxOWoecC+WxNTTKE8h5D1PsFJCF6
         E67xeqN0JKs3WK+5pZYqbkCSmr/po1Kyh4kp2zwfv0QCd50xnJkPaGoDSMiPuak3YJ0R
         NRniJXG8hPsPrYW/7vS+FGAOEFsZHomFLWvBRpYzCn/uNS8sR+K8+ogM/aS3Kgo3xaOt
         HFNKDQsg2RvUQo5A81hjszqCo6V9/0OZxEhfJn7aZAuqPkPI6260/2/LX7fiWHoj8G/I
         qRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNIj3LpkA8AS8doXHlRfvjaWK2oNi27ElwWZcfgxMbE=;
        b=1RJLciqUP6ma5kk7gF0JWqJ/5ZKhUAMQZh02JCeDZZU1zgQjTgvgRryaTwrqYyyUFe
         civJl/AFi4d4GlgiKOsepeOcCPQpssmeerkAFBaPUM7OxpFd9kqtK2VVJus+qwXt1xMY
         FJigNSwUyUdnTiGGTKonWNybjZGjZpQaDGz4jnh72QaJpSgVsjxCOEoeuRDy6OPw2HDQ
         suDwXknNGspGBWQ52Qv9yFqSn1vZ8ARfsVD/8UKD5svN/Bsh2qX2uFPvGXdjJcoW72rt
         3b6ayBvvw66ckhtNAYCNlb4afsFVHGt8EuxAeQDlwLfvqdUPMtaPO6Fih3sG2pJbdy3F
         SQ3w==
X-Gm-Message-State: AJIora8hE3b5keHnSFw2d0jRXM+h7HPGZSnWcbISbjkrPOLdBydAaDPp
        yXGyriyhOIXaBM3VTC3ucc4=
X-Google-Smtp-Source: AGRyM1spgvgl60EAao6HETeL4DgG3bNDQcbxap9wbMLzZomffILM1CJB32L3LQ8wyZm3W2/tgoZxsQ==
X-Received: by 2002:a05:6512:3b08:b0:481:1b90:bf55 with SMTP id f8-20020a0565123b0800b004811b90bf55mr20108627lfv.153.1656955154249;
        Mon, 04 Jul 2022 10:19:14 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:13 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] iio: adc: mcp3911: add support for buffers
Date:   Mon,  4 Jul 2022 19:21:12 +0200
Message-Id: <20220704172116.195841-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
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

Add support for buffers to make the driver fit for more usecases.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 99 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f5fd9da6ab55..cf4dacc7de06 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -5,10 +5,16 @@
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -22,6 +28,7 @@
 #define MCP3911_REG_GAIN		0x09
 
 #define MCP3911_REG_STATUSCOM		0x0a
+#define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
 #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
@@ -54,6 +61,13 @@ struct mcp3911 {
 	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
+	struct {
+		u32 channels[MCP3911_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} scan;
+
+	u8 tx_buf[MCP3911_NUM_CHANNELS * 3] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
 };
 
 static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
@@ -196,16 +210,66 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
+	struct spi_transfer xfer = {
+		.tx_buf = adc->tx_buf,
+		.rx_buf = adc->rx_buf,
+		.len = sizeof(adc->rx_buf),
+	};
+	int scan_index;
+	int i = 0;
+	int ret;
+
+	mutex_lock(&adc->lock);
+	adc->tx_buf[0] = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
+	ret = spi_sync_transfer(adc->spi, &xfer, 1);
+	if (ret < 0) {
+		dev_warn(&adc->spi->dev,
+				"failed to get conversion data\n");
+		goto out;
+	}
+
+	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+		const struct iio_chan_spec *scan_chan =
+			&indio_dev->channels[scan_index];
+
+		adc->scan.channels[i] = adc->rx_buf[scan_chan->channel * 3 + 0] << 16 |
+					adc->rx_buf[scan_chan->channel * 3 + 1] << 8 |
+					adc->rx_buf[scan_chan->channel * 3 + 2] << 0;
+
+		i++;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
+			iio_get_time_ns(indio_dev));
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
@@ -214,7 +278,7 @@ static const struct iio_info mcp3911_info = {
 static int mcp3911_config(struct mcp3911 *adc)
 {
 	struct device *dev = &adc->spi->dev;
-	u32 configreg;
+	u32 regval;
 	int ret;
 
 	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
@@ -233,29 +297,43 @@ static int mcp3911_config(struct mcp3911 *adc)
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
 
 static void mcp3911_cleanup(void *_adc)
@@ -325,6 +403,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3911_info;
@@ -335,6 +414,12 @@ static int mcp3911_probe(struct spi_device *spi)
 
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
2.36.1

