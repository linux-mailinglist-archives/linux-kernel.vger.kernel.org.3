Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619664903D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiAQI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiAQI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:29:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1FC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:29:01 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n9NNm-0007eR-Fs; Mon, 17 Jan 2022 09:28:54 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1n9NNl-00E8vk-5R; Mon, 17 Jan 2022 09:28:53 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/2] iio: adc: tsc2046: add .read_raw support
Date:   Mon, 17 Jan 2022 09:28:51 +0100
Message-Id: <20220117082852.3370869-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add read_raw() support to make use of iio_hwmon and other iio clients.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 118 ++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 7ac1fc4b04c2..95771ceba206 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -86,6 +86,7 @@
 #define TI_TSC2046_EXT_POLL_CNT			3
 #define TI_TSC2046_POLL_CNT \
 	(TI_TSC2046_MIN_POLL_CNT + TI_TSC2046_EXT_POLL_CNT)
+#define TI_TSC2046_INT_VREF			2500
 
 /* Represents a HW sample */
 struct tsc2046_adc_atom {
@@ -166,9 +167,6 @@ struct tsc2046_adc_priv {
 	struct tsc2046_adc_atom *rx;
 	struct tsc2046_adc_atom *tx;
 
-	struct tsc2046_adc_atom *rx_one;
-	struct tsc2046_adc_atom *tx_one;
-
 	unsigned int count;
 	unsigned int groups;
 	u32 effective_speed_hz;
@@ -184,6 +182,8 @@ struct tsc2046_adc_priv {
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.channel = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.datasheet_name = "#name",				\
 	.scan_index = index,					\
 	.scan_type = {						\
@@ -247,6 +247,14 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
 	else
 		pd = 0;
 
+	switch (ch_idx) {
+	case TI_TSC2046_ADDR_TEMP1:
+	case TI_TSC2046_ADDR_AUX:
+	case TI_TSC2046_ADDR_VBAT:
+	case TI_TSC2046_ADDR_TEMP0:
+		pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
+	}
+
 	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
 }
 
@@ -258,16 +266,50 @@ static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
 static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 				u32 *effective_speed_hz)
 {
+	struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
+	struct tsc2046_adc_atom *rx_buf, *tx_buf;
+	unsigned int val, val_normalized = 0;
+	int ret, i, count_skip = 0, max_count;
 	struct spi_transfer xfer;
 	struct spi_message msg;
-	int ret;
+	u8 cmd;
+
+	if (!effective_speed_hz) {
+		count_skip = tsc2046_adc_time_to_count(priv, ch->settling_time_us);
+		max_count = count_skip + ch->oversampling_ratio;
+	} else {
+		max_count = 1;
+	}
+
+	if (sizeof(*tx_buf) * max_count > PAGE_SIZE)
+		return -ENOSPC;
+
+	tx_buf = kcalloc(max_count, sizeof(*tx_buf), GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+
+	rx_buf = kcalloc(max_count, sizeof(*rx_buf), GFP_KERNEL);
+	if (!rx_buf) {
+		ret = -ENOMEM;
+		goto free_tx;
+	}
+
+	/*
+	 * Do not enable automatic power down on working samples. Otherwise the
+	 * plates will never be completely charged.
+	 */
+	cmd = tsc2046_adc_get_cmd(priv, ch_idx, true);
+
+	for (i = 0; i < max_count - 1; i++)
+		tx_buf[i].cmd = cmd;
+
+	/* automatically power down on last sample */
+	tx_buf[i].cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
 
 	memset(&xfer, 0, sizeof(xfer));
-	priv->tx_one->cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
-	priv->tx_one->data = 0;
-	xfer.tx_buf = priv->tx_one;
-	xfer.rx_buf = priv->rx_one;
-	xfer.len = sizeof(*priv->tx_one);
+	xfer.tx_buf = tx_buf;
+	xfer.rx_buf = rx_buf;
+	xfer.len = sizeof(*tx_buf) * max_count;
 	spi_message_init_with_transfers(&msg, &xfer, 1);
 
 	/*
@@ -278,13 +320,25 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
 	if (ret) {
 		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
 				    ERR_PTR(ret));
-		return ret;
+		goto free_bufs;
 	}
 
 	if (effective_speed_hz)
 		*effective_speed_hz = xfer.effective_speed_hz;
 
-	return tsc2046_adc_get_value(priv->rx_one);
+	for (i = 0; i < max_count - count_skip; i++) {
+		val = tsc2046_adc_get_value(&rx_buf[count_skip + i]);
+		val_normalized += val;
+	}
+
+	ret = DIV_ROUND_UP(val_normalized, max_count - count_skip);
+
+free_bufs:
+	kfree(rx_buf);
+free_tx:
+	kfree(tx_buf);
+
+	return ret;
 }
 
 static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
@@ -391,6 +445,37 @@ static irqreturn_t tsc2046_adc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int tsc2046_adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long m)
+{
+	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = tsc2046_adc_read_one(priv, chan->channel, NULL);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Note: the TSC2046 has internal voltage divider on the VBAT
+		 * line. This divider can be influenced by external divider.
+		 * So, it is better to use external voltage-divider driver
+		 * instead, which is calculating complete chain.
+		 */
+		*val = TI_TSC2046_INT_VREF;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
 static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 					const unsigned long *active_scan_mask)
 {
@@ -421,6 +506,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info tsc2046_adc_info = {
+	.read_raw	  = tsc2046_adc_read_raw,
 	.update_scan_mode = tsc2046_adc_update_scan_mode,
 };
 
@@ -563,16 +649,6 @@ static int tsc2046_adc_setup_spi_msg(struct tsc2046_adc_priv *priv)
 	size_t size;
 	int ret;
 
-	priv->tx_one = devm_kzalloc(&priv->spi->dev, sizeof(*priv->tx_one),
-				    GFP_KERNEL);
-	if (!priv->tx_one)
-		return -ENOMEM;
-
-	priv->rx_one = devm_kzalloc(&priv->spi->dev, sizeof(*priv->rx_one),
-				    GFP_KERNEL);
-	if (!priv->rx_one)
-		return -ENOMEM;
-
 	/*
 	 * Make dummy read to set initial power state and get real SPI clock
 	 * freq. It seems to be not important which channel is used for this
-- 
2.30.2

