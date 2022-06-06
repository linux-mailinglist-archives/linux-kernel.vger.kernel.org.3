Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A953EBFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiFFOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiFFOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:15:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF382CDCE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:15:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bi27so4363426qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHombqk3VYPwKde0y6W4IYyIm10RdpNnxO/ZPqQ0Sxs=;
        b=jtwcDJB56TkN8p8A7JM8buPO6gQUo/XgKrVsHo4iM2y+ufJaPxfc4ArTRJI9jbhIXz
         qI3phv7gG9K76q4/HkPcDEwerfmS5T/+Bk9KMjRH5XDJZ9mNYQxH2WUHEsgX/cFliVu6
         y3gn9FazsXJ7dUGvt27M0LtpJMQUGQx3Bs/fCuJRhzyTOSsxP5rV4RNIeOvy+LprHxJS
         wSWcp5s3hKVUajPANqKtkC4HLSU5ILaKLFHe+W4IdVmN5O3rKkBNLI/mi3VCRBvmU+MW
         SRjGi9yT5AQBQA+w1TMIHmpMw0t4SNjDqMwWXftLVZb/7bNAB/l3QM13+rGArmrTUs1O
         M89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHombqk3VYPwKde0y6W4IYyIm10RdpNnxO/ZPqQ0Sxs=;
        b=EWW2AdVyIv2pdQY3QC0PQTlqIBGYLRgNlQd2NJxK54Urh4cdur3FA3kFWMK0FiYJjh
         4bdNv+GCrQ2jqmkzT3VO/loZ2vgyvUs9b1cXvsPwMMPUQLR8bQlRXLeoHvje2jaKlW4g
         oBWGw+Li61aE40h7JXGbUFd0j1psTvakN7jj/8D2aF9jgbriAH3s6mw/ZKaM+e1he2MI
         H1XP94/su8GW6xGVqNqiQxX/MltM6JDGwxsQ/XTqFxU7QLNU/SlRoEE4AlhAViK5g3xw
         Q3YzEF9ebN8ld6eu7AanguoqVV53aapWpw5uOkVEAa/bYVe5pjkOoocLdIWBDlRlwK0M
         Lx6Q==
X-Gm-Message-State: AOAM5338b6NZ3Erj+ds8/4WCzg8of3W1jm2Ed/+397grBGl5nOZvDICM
        fDZlg5PDu+fVDenLgpsM5RQXiQ==
X-Google-Smtp-Source: ABdhPJzxFp5PvNMb/dA5xI22yRoY4ap7OODLm7toYUJxtZU5yxPmVLHG7YjDJzfEE4uI1G1hHLM1sQ==
X-Received: by 2002:a05:620a:1532:b0:6a6:9647:8d6d with SMTP id n18-20020a05620a153200b006a696478d6dmr11729144qkk.413.1654524927744;
        Mon, 06 Jun 2022 07:15:27 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a268f00b006a3af1bd183sm10335086qkp.127.2022.06.06.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:15:27 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/2] iio: adc: stx104: Implement and utilize register structures
Date:   Mon,  6 Jun 2022 10:15:17 -0400
Message-Id: <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654118389.git.william.gray@linaro.org>
References: <cover.1654118389.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/adc/stx104.c | 70 +++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7552351bfed9..7656b363e281 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
 	.type = IIO_VOLTAGE,				\
@@ -44,14 +45,36 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
+/**
+ * struct stx104_reg - device register structure
+ * @ad:		ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ad;
+	u8 achan;
+	u8 dio;
+	u16 dac[2];
+	u8 cir_asr;
+	u8 acr;
+	u8 pccr_fsh;
+	u8 acfg;
+};
+
 /**
  * struct stx104_iio - IIO device private data structure
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	void __iomem *base;
+	struct stx104_reg __iomem *reg;
 };
 
 /**
@@ -64,7 +87,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	void __iomem *base;
+	u8 __iomem *base;
 	unsigned int out_state;
 };
 
@@ -72,6 +95,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	struct stx104_reg __iomem *const reg = priv->reg;
 	unsigned int adc_config;
 	int adbu;
 	int gain;
@@ -79,7 +103,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -91,24 +115,24 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		}
 
 		/* select ADC channel */
-		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
 		/* trigger ADC sample capture and wait for completion */
-		iowrite8(0, priv->base);
-		while (ioread8(priv->base + 8) & BIT(7));
+		iowrite8(0, &reg->ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
 
-		*val = ioread16(priv->base);
+		*val = ioread16(&reg->ad);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = ioread8(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -130,16 +154,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			iowrite8(0, priv->base + 11);
+			iowrite8(0, &priv->reg->acfg);
 			break;
 		case 2:
-			iowrite8(1, priv->base + 11);
+			iowrite8(1, &priv->reg->acfg);
 			break;
 		case 4:
-			iowrite8(2, priv->base + 11);
+			iowrite8(2, &priv->reg->acfg);
 			break;
 		case 8:
-			iowrite8(3, priv->base + 11);
+			iowrite8(3, &priv->reg->acfg);
 			break;
 		default:
 			return -EINVAL;
@@ -153,7 +177,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, priv->reg->dac + chan->channel);
 
 			return 0;
 		}
@@ -307,15 +331,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	}
 
 	priv = iio_priv(indio_dev);
-	priv->base = devm_ioport_map(dev, base[id], STX104_EXTENT);
-	if (!priv->base)
+	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->reg)
 		return -ENOMEM;
 
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (ioread8(priv->base + 8) & BIT(5)) {
+	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -326,14 +350,14 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 
 	/* configure device for software trigger operation */
-	iowrite8(0, priv->base + 9);
+	iowrite8(0, &priv->reg->acr);
 
 	/* initialize gain setting to x1 */
-	iowrite8(0, priv->base + 11);
+	iowrite8(0, &priv->reg->acfg);
 
 	/* initialize DAC output to 0V */
-	iowrite16(0, priv->base + 4);
-	iowrite16(0, priv->base + 6);
+	iowrite16(0, &priv->reg->dac[0]);
+	iowrite16(0, &priv->reg->dac[1]);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -348,7 +372,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = priv->base + 3;
+	stx104gpio->base = &priv->reg->dio;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
-- 
2.36.1

