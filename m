Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1AA4874D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbiAGJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiAGJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:35:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418EC06118C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:35:34 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n5lej-0002WK-4G; Fri, 07 Jan 2022 10:35:29 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1n5lei-00CmVE-Fd; Fri, 07 Jan 2022 10:35:28 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: adc: tsc2046: add .read_raw support
Date:   Fri,  7 Jan 2022 10:35:27 +0100
Message-Id: <20220107093527.3046331-1-o.rempel@pengutronix.de>
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
 drivers/iio/adc/ti-tsc2046.c | 114 ++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 8126084616e6..55787d18e2cd 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -82,6 +82,7 @@
 #define TI_TSC2046_DATA_12BIT			GENMASK(14, 3)
 
 #define TI_TSC2046_MAX_CHAN			8
+#define TI_TSC2046_INT_VREF			2500
 
 /* Represents a HW sample */
 struct tsc2046_adc_atom {
@@ -178,6 +179,11 @@ struct tsc2046_adc_priv {
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.channel = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |	\
+			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |	\
+			BIT(IIO_CHAN_INFO_DEBOUNCE_TIME),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.datasheet_name = "#name",				\
 	.scan_index = index,					\
 	.scan_type = {						\
@@ -241,6 +247,14 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
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
 
@@ -252,16 +266,47 @@ static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
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
@@ -272,13 +317,25 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
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
@@ -385,6 +442,46 @@ static irqreturn_t tsc2046_adc_trigger_handler(int irq, void *p)
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
+		 * So, it is better to use external voltage-divider.
+		 */
+		*val = TI_TSC2046_INT_VREF;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = priv->ch_cfg[chan->channel].oversampling_ratio;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
+		*val = tsc2046_adc_time_to_count(priv,
+				priv->ch_cfg[chan->channel].settling_time_us);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_DEBOUNCE_TIME:
+		*val = priv->ch_cfg[chan->channel].settling_time_us;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
 static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 					const unsigned long *active_scan_mask)
 {
@@ -415,6 +512,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info tsc2046_adc_info = {
+	.read_raw	  = tsc2046_adc_read_raw,
 	.update_scan_mode = tsc2046_adc_update_scan_mode,
 };
 
-- 
2.30.2

