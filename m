Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F45A7AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiHaKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHaKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:05:15 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957818B1C;
        Wed, 31 Aug 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661940313;
  x=1693476313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBlIcerlLMxcXOCk6lLphH5SI/cE6LX4zmms8VOffM4=;
  b=Uf64svgJVZ6xeMde5BtURIEd2goDWo0l3Nn7MYTgidr+I64in9LfxHmI
   FJp0UeRa1ePymE20mKiWeib45b1ZvE2exwDOvBFH0m9u2rzFP1q8avG6r
   ytWxiaMUXdSIHUOMa66rx15UEhKQV/z6ag81lNA7nnXwVHt7js2bRKObo
   E5vnmuQ2wMD+0Zc/j70AjaX7RFPkhiOZGHolSMScCVw1AHbOSJcNlBZZj
   oPG+CHjsAATSg4l5/E/DHGg2IaDFJt1SfYujpGdAAXKqLc86CbMx9xlw0
   Wl0G3g8xZmGt7sILJ2dS31uwDYFq2X5C5i9fBdYqpXwn2YGtpiAHTLdto
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] iio: adc: mcp320x: remove device_index check for TX
Date:   Wed, 31 Aug 2022 12:05:03 +0200
Message-ID: <20220831100506.3368103-3-vincent.whitchurch@axis.com>
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

Replace the device_index switch with a TX value computation based on the
number of channels in the chip_info structure, so that the latter has
all the information needed to handle the variants.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/adc/mcp320x.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index c71d90babb39..77fb4522a378 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -147,29 +147,34 @@ static int mcp3550_convert_rx(struct mcp320x *adc)
 	return (s32)raw;
 }
 
-static int mcp320x_channel_to_tx_data(int device_index,
-			const unsigned int channel, bool differential)
+static int mcp320x_channel_to_tx_data(const struct mcp320x_chip_info *info,
+				      const struct iio_chan_spec *channel)
 {
 	int start_bit = 1;
+	bool differential = channel->differential;
+	u8 address = channel->address;
+	/*
+	 * This happens to be the same as the last number of the model name for
+	 * multi-channel MCP300X and MCP320X.
+	 */
+	unsigned int num_nondiff_channels = info->num_channels / 2;
 
-	switch (device_index) {
-	case mcp3002:
-	case mcp3202:
+	switch (num_nondiff_channels) {
+	case 2:
 		return ((start_bit << 4) | (!differential << 3) |
-							(channel << 2));
-	case mcp3004:
-	case mcp3204:
-	case mcp3008:
-	case mcp3208:
+			(address << 2));
+	case 4:
+	case 8:
 		return ((start_bit << 6) | (!differential << 5) |
-							(channel << 2));
+			(address << 2));
 	default:
-		return -EINVAL;
+		return 0;
 	}
 }
 
-static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
-				  bool differential, int device_index, int *val)
+static int mcp320x_adc_conversion(struct mcp320x *adc,
+				  const struct iio_chan_spec *channel,
+				  int *val)
 {
 	const struct mcp320x_chip_info *info = adc->chip_info;
 	int ret;
@@ -185,8 +190,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 
 	memset(&adc->rx_buf, 0, sizeof(adc->rx_buf));
 	if (adc->chip_info->num_channels > 1)
-		adc->tx_buf = mcp320x_channel_to_tx_data(device_index, channel,
-							 differential);
+		adc->tx_buf = mcp320x_channel_to_tx_data(info, channel);
 
 	ret = spi_sync(adc->spi, &adc->msg);
 	if (ret < 0)
@@ -203,16 +207,12 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 {
 	struct mcp320x *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
-	int device_index = 0;
 
 	mutex_lock(&adc->lock);
 
-	device_index = spi_get_device_id(adc->spi)->driver_data;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = mcp320x_adc_conversion(adc, channel->address,
-			channel->differential, device_index, val);
+		ret = mcp320x_adc_conversion(adc, channel, val);
 		if (ret < 0)
 			goto out;
 
@@ -452,8 +452,8 @@ static int mcp320x_probe(struct spi_device *spi)
 		 * conversions without delay between them resets the chip
 		 * and ensures all subsequent conversions succeed.
 		 */
-		mcp320x_adc_conversion(adc, 0, 1, device_index, &ret);
-		mcp320x_adc_conversion(adc, 0, 1, device_index, &ret);
+		mcp320x_adc_conversion(adc, &chip_info->channels[0], &ret);
+		mcp320x_adc_conversion(adc, &chip_info->channels[0], &ret);
 	}
 
 	adc->reg = devm_regulator_get(&spi->dev, "vref");
-- 
2.34.1

