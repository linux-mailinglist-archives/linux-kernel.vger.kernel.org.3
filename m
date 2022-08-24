Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21759F7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiHXKkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbiHXKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:40:10 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078D80F49;
        Wed, 24 Aug 2022 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661337609;
  x=1692873609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bgCTnGLO80zLn5pKZiWdX/V5zTz497jUqF+cyjA6Qw=;
  b=kAi7jzPA6+g0qOBTy7lJwGcSx+QbJ5fx49Z+OyShIwNm9N485LD6z0Tc
   HxYyc0S7zaSzHnHf6z1IvTvkbxoyV+ApMPLTVQ+jZ9/qmHKKGOLKNNcJa
   LI6UFfh3+XHE8Hhznbebz+j7pVfkfvxv0js4Qi+kzbEulVjqj3FeGfZHS
   2OVbdhsr7gFTawJ0fn5Olrl85cPLmWPTnpbP2L+zVomhwB/68g58A3K2d
   Erc6Jr1oOiHmfkDlNw1+wCqn0iOBY+2k17Ulg9ezk/3UONqEKyot0KH2P
   KckPVPLb5S5HOFXcRl2bLVbB0dDZkAOX63aY8tdjxKogh3pziNMHkqEK6
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <axel.jonsson@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
Date:   Wed, 24 Aug 2022 12:40:02 +0200
Message-ID: <20220824104002.2749075-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Jonsson <axel.jonsson@axis.com>

Add support for triggered buffers.  Just read the channels in a loop to
keep things simple.

Signed-off-by: Axel Jonsson <axel.jonsson@axis.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/adc/Kconfig   |   2 +
 drivers/iio/adc/mcp320x.c | 130 ++++++++++++++++++++++++++++----------
 2 files changed, 99 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 48ace7412874..9f2628120885 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -696,6 +696,8 @@ config MAX9611
 config MCP320X
 	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Microchip Technology's
 	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 28398f34628a..9782cbd37728 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -43,6 +43,10 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/regulator/consumer.h>
 
 enum {
@@ -231,37 +235,51 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-#define MCP320X_VOLTAGE_CHANNEL(num)				\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = (num),				\
-		.address = (num),				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+#define MCP320X_VOLTAGE_CHANNEL(num)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num),					\
+		.address = (num),					\
+		.scan_index = (num),					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
 	}
 
-#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2)		\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = (chan1),				\
-		.channel2 = (chan2),				\
-		.address = (chan1),				\
-		.differential = 1,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2, diffoff)		\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (chan1),					\
+		.channel2 = (chan2),					\
+		.address = (chan1),					\
+		.scan_index = (chan1 + diffoff),			\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+		.differential = 1,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
 	}
 
 static const struct iio_chan_spec mcp3201_channels[] = {
-	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 1),
 };
 
 static const struct iio_chan_spec mcp3202_channels[] = {
 	MCP320X_VOLTAGE_CHANNEL(0),
 	MCP320X_VOLTAGE_CHANNEL(1),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 2),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0, 2),
 };
 
 static const struct iio_chan_spec mcp3204_channels[] = {
@@ -269,10 +287,10 @@ static const struct iio_chan_spec mcp3204_channels[] = {
 	MCP320X_VOLTAGE_CHANNEL(1),
 	MCP320X_VOLTAGE_CHANNEL(2),
 	MCP320X_VOLTAGE_CHANNEL(3),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 4),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0, 4),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3, 4),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2, 4),
 };
 
 static const struct iio_chan_spec mcp3208_channels[] = {
@@ -284,14 +302,14 @@ static const struct iio_chan_spec mcp3208_channels[] = {
 	MCP320X_VOLTAGE_CHANNEL(5),
 	MCP320X_VOLTAGE_CHANNEL(6),
 	MCP320X_VOLTAGE_CHANNEL(7),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(4, 5),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(5, 4),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(6, 7),
-	MCP320X_VOLTAGE_CHANNEL_DIFF(7, 6),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(4, 5, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(5, 4, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(6, 7, 8),
+	MCP320X_VOLTAGE_CHANNEL_DIFF(7, 6, 8),
 };
 
 static const struct iio_info mcp320x_info = {
@@ -371,6 +389,46 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 	},
 };
 
+static irqreturn_t mcp320x_buffer_trigger_handler(int irq, void *pollfunc)
+{
+	struct iio_poll_func *pf = pollfunc;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mcp320x *adc = iio_priv(indio_dev);
+	s32 data[ARRAY_SIZE(mcp3208_channels)];
+	int device_index;
+	int i = 0;
+	int chan;
+
+	device_index = spi_get_device_id(adc->spi)->driver_data;
+
+	mutex_lock(&adc->lock);
+
+	for_each_set_bit(chan, indio_dev->active_scan_mask, indio_dev->masklength) {
+		const struct iio_chan_spec *spec = &indio_dev->channels[chan];
+		int ret, val;
+
+		ret = mcp320x_adc_conversion(adc, spec->address,
+					     spec->differential, device_index,
+					     &val);
+		if (ret < 0) {
+			dev_err_ratelimited(&adc->spi->dev, "Failed to read data: %d\n",
+					    ret);
+			goto out;
+		}
+
+		data[i++] = val;
+	}
+
+	iio_push_to_buffers(indio_dev, data);
+
+out:
+	mutex_unlock(&adc->lock);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static void mcp320x_reg_disable(void *reg)
 {
 	regulator_disable(reg);
@@ -456,6 +514,12 @@ static int mcp320x_probe(struct spi_device *spi)
 
 	mutex_init(&adc->lock);
 
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      mcp320x_buffer_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.34.1

