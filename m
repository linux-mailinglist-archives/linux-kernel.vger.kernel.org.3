Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126A5A7AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiHaKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiHaKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:05:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29D7D79E;
        Wed, 31 Aug 2022 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661940318;
  x=1693476318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+k41+n3odUDXGPNoejWF6hYf5Nr1U+AWwm9/HsCGUk=;
  b=fi1zAo2Xz66IzFtu4jEbjEDMjkAoclzdeQ/n+aj8/cH6Yl5KV7kWnhcz
   iV2VLoFtBzQeO8OdSpGPEbDo8kVYuoqBYyJ+mOmc2CuP9gzn+P8En99qq
   IBVsuSM32bd0dwD5Wy8Q6kKZDBYh/LOFwjf4muWICKKOlHluUCIqxAbT0
   a4eI5OykGWvy1iOupdO52O9zpZ17dbs+M6/yVVQr8WQLBNvliCk95ZZd0
   aOEIBlYziL6emC5naq5THu5/BcAVK6k2ii3pQWAUHkeTsNfc9xeWv32/G
   02i+dboVH6rTfcb3cVRKUQiFOduiQQD1UTjj82/TIJGOPYPcy5GU/KjdT
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
Date:   Wed, 31 Aug 2022 12:05:02 +0200
Message-ID: <20220831100506.3368103-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the device_index switch with callbacks from the chip_info
structure, so that the latter has all the information needed to handle
the variants.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/adc/mcp320x.c | 115 ++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index b4c69acb33e3..c71d90babb39 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -61,11 +61,14 @@ enum {
 	mcp3553,
 };
 
+struct mcp320x;
+
 struct mcp320x_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int resolution;
 	unsigned int conv_time; /* usec */
+	int (*convert_rx)(struct mcp320x *adc);
 };
 
 /**
@@ -96,6 +99,54 @@ struct mcp320x {
 	u8 rx_buf[4];
 };
 
+static int mcp3001_convert_rx(struct mcp320x *adc)
+{
+	return adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3;
+}
+
+static int mcp3002_convert_rx(struct mcp320x *adc)
+{
+	return adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6;
+}
+
+static int mcp3201_convert_rx(struct mcp320x *adc)
+{
+	return adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1;
+}
+
+static int mcp3202_convert_rx(struct mcp320x *adc)
+{
+	return adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4;
+}
+
+static int mcp3301_convert_rx(struct mcp320x *adc)
+{
+	return sign_extend32((adc->rx_buf[0] & 0x1f) << 8 | adc->rx_buf[1], 12);
+}
+
+static int mcp3550_convert_rx(struct mcp320x *adc)
+{
+	u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
+
+	if (!(adc->spi->mode & SPI_CPOL))
+		raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
+
+	/*
+	 * If the input is within -vref and vref, bit 21 is the sign.
+	 * Up to 12% overrange or underrange are allowed, in which case
+	 * bit 23 is the sign and bit 0 to 21 is the value.
+	 */
+	raw >>= 8;
+	if (raw & BIT(22) && raw & BIT(23))
+		return -EIO; /* cannot have overrange AND underrange */
+	else if (raw & BIT(22))
+		raw &= ~BIT(22); /* overrange */
+	else if (raw & BIT(23) || raw & BIT(21))
+		raw |= GENMASK(31, 22); /* underrange or negative */
+
+	return (s32)raw;
+}
+
 static int mcp320x_channel_to_tx_data(int device_index,
 			const unsigned int channel, bool differential)
 {
@@ -120,6 +171,7 @@ static int mcp320x_channel_to_tx_data(int device_index,
 static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 				  bool differential, int device_index, int *val)
 {
+	const struct mcp320x_chip_info *info = adc->chip_info;
 	int ret;
 
 	if (adc->chip_info->conv_time) {
@@ -140,55 +192,9 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 	if (ret < 0)
 		return ret;
 
-	switch (device_index) {
-	case mcp3001:
-		*val = (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
-		return 0;
-	case mcp3002:
-	case mcp3004:
-	case mcp3008:
-		*val = (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
-		return 0;
-	case mcp3201:
-		*val = (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
-		return 0;
-	case mcp3202:
-	case mcp3204:
-	case mcp3208:
-		*val = (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
-		return 0;
-	case mcp3301:
-		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
-				    | adc->rx_buf[1], 12);
-		return 0;
-	case mcp3550_50:
-	case mcp3550_60:
-	case mcp3551:
-	case mcp3553: {
-		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
-
-		if (!(adc->spi->mode & SPI_CPOL))
-			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
+	*val = info->convert_rx(adc);
 
-		/*
-		 * If the input is within -vref and vref, bit 21 is the sign.
-		 * Up to 12% overrange or underrange are allowed, in which case
-		 * bit 23 is the sign and bit 0 to 21 is the value.
-		 */
-		raw >>= 8;
-		if (raw & BIT(22) && raw & BIT(23))
-			return -EIO; /* cannot have overrange AND underrange */
-		else if (raw & BIT(22))
-			raw &= ~BIT(22); /* overrange */
-		else if (raw & BIT(23) || raw & BIT(21))
-			raw |= GENMASK(31, 22); /* underrange or negative */
-
-		*val = (s32)raw;
-		return 0;
-		}
-	default:
-		return -EINVAL;
-	}
+	return 0;
 }
 
 static int mcp320x_read_raw(struct iio_dev *indio_dev,
@@ -302,51 +308,61 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 	[mcp3001] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3001_convert_rx,
 		.resolution = 10
 	},
 	[mcp3002] = {
 		.channels = mcp3202_channels,
 		.num_channels = ARRAY_SIZE(mcp3202_channels),
+		.convert_rx = mcp3002_convert_rx,
 		.resolution = 10
 	},
 	[mcp3004] = {
 		.channels = mcp3204_channels,
 		.num_channels = ARRAY_SIZE(mcp3204_channels),
+		.convert_rx = mcp3002_convert_rx,
 		.resolution = 10
 	},
 	[mcp3008] = {
 		.channels = mcp3208_channels,
 		.num_channels = ARRAY_SIZE(mcp3208_channels),
+		.convert_rx = mcp3002_convert_rx,
 		.resolution = 10
 	},
 	[mcp3201] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3201_convert_rx,
 		.resolution = 12
 	},
 	[mcp3202] = {
 		.channels = mcp3202_channels,
 		.num_channels = ARRAY_SIZE(mcp3202_channels),
+		.convert_rx = mcp3202_convert_rx,
 		.resolution = 12
 	},
 	[mcp3204] = {
 		.channels = mcp3204_channels,
 		.num_channels = ARRAY_SIZE(mcp3204_channels),
+		.convert_rx = mcp3202_convert_rx,
 		.resolution = 12
 	},
 	[mcp3208] = {
 		.channels = mcp3208_channels,
 		.num_channels = ARRAY_SIZE(mcp3208_channels),
+		.convert_rx = mcp3202_convert_rx,
 		.resolution = 12
 	},
 	[mcp3301] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3301_convert_rx,
 		.resolution = 13
 	},
 	[mcp3550_50] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3550_convert_rx,
 		.resolution = 21,
 		/* 2% max deviation + 144 clock periods to exit shutdown */
 		.conv_time = 80000 * 1.02 + 144000 / 102.4,
@@ -354,18 +370,21 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 	[mcp3550_60] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3550_convert_rx,
 		.resolution = 21,
 		.conv_time = 66670 * 1.02 + 144000 / 122.88,
 	},
 	[mcp3551] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3550_convert_rx,
 		.resolution = 21,
 		.conv_time = 73100 * 1.02 + 144000 / 112.64,
 	},
 	[mcp3553] = {
 		.channels = mcp3201_channels,
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.convert_rx = mcp3550_convert_rx,
 		.resolution = 21,
 		.conv_time = 16670 * 1.02 + 144000 / 122.88,
 	},
-- 
2.34.1

