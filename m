Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7312E56AE74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiGGWa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiGGWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:30:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94F65D67
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:30:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id he28so24906620qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cp4kFfIV9vxNzkxwPVJY1RIkCxRVw29SgQ0nN5WqYjM=;
        b=jJNz4QmfJij1m5k1Z3WHbkakIK/EEmazjOfG3VCc25VR3Ml74OCYQ4y1ulHaZfPNao
         7WKFNeHCSYyiKJIZ5DxPBPf6QA/DMC7UBXohxvoKjcQaLewy2umh5vP4CQ07irJqcEVX
         LOjAzOH87+b+lQZPAs75S8ZoFvszBFrPvoaCqNUhGZ8FCCcQ0J1DzJyqiKDM87rLRYBb
         Aqy1O0jXjy+Qwzzw0f8S0/3nxvf6ZbgSOls+K2iBPKLYUnwkIQA4PJSlt+hw/viG+P2O
         x1I3kbfiy3YHiidJqDHDilEvV/livKcnNTx5AfoJEYjWXUUzirTyrkmEF6E7cp7Qp0Wu
         EKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cp4kFfIV9vxNzkxwPVJY1RIkCxRVw29SgQ0nN5WqYjM=;
        b=Cj2ixqx1bYrKBVbCGKFHNuFTgelocnotxlyQZdH9ajpUwoysoU9GA2i0hm0KrxB6A+
         Zej40wv1FHbFGM1ct8k+E/csZSWjXma00xzF9TrH7tfbiiBNHKlo2IdPZqY5M0y6c1wf
         KFVrezcZKfOFgPvy7rumAFL+FIy1twfG/D8ivzyFfYR2b4f056pRFuwYr20BfAR/qw2k
         oUPf5yHEmUFmBundTgCSchGFxoTSPsjn3aPXN/UM0wCgJoPc3RMajRa4/1JYFFwtqHwp
         H57G4LE9qnN79kXCD74SNdV78v31I0+C7sOVeANQwdHrEJbwrM6DoQkZKDYRVnit0+OM
         gCVA==
X-Gm-Message-State: AJIora/Gc/zL5KkhNdJF3txKZOm+DjksqXHKv/STOVeU37HhM0HjfEY8
        pgiQirEZz4hzfIqFIotL5gJc7Q==
X-Google-Smtp-Source: AGRyM1tD+9XRXBAxNRSxuANjBn7f6MK39Wmp4MU3un44jgsVmGtk/ufdzQsOFPhp8SlWwyk9bYXc0A==
X-Received: by 2002:a05:6214:21ec:b0:470:3f54:e846 with SMTP id p12-20020a05621421ec00b004703f54e846mr328601qvj.58.1657233020932;
        Thu, 07 Jul 2022 15:30:20 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b0031e9bd3586esm1527747qts.79.2022.07.07.15.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:30:20 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>
Subject: [PATCH v2 1/2] iio: adc: stx104: Implement and utilize register structures
Date:   Thu,  7 Jul 2022 13:21:24 -0400
Message-Id: <8cb91d5b53e57b066120e42ea07000d6c7ef5543.1657213745.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657213745.git.william.gray@linaro.org>
References: <cover.1657213745.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce magic numbers and improve code readability by implementing and
utilizing named register data structures.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/adc/stx104.c | 74 +++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7552351bfed9..48a91a95e597 100644
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
+ * @ssr_ad:	Software Strobe Register and ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ssr_ad;
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
@@ -91,24 +115,26 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		}
 
 		/* select ADC channel */
-		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
-		/* trigger ADC sample capture and wait for completion */
-		iowrite8(0, priv->base);
-		while (ioread8(priv->base + 8) & BIT(7));
+		/* trigger ADC sample capture by writing to the 8-bit
+		 * Software Strobe Register and wait for completion
+		 */
+		iowrite8(0, &reg->ssr_ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
 
-		*val = ioread16(priv->base);
+		*val = ioread16(&reg->ssr_ad);
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
 
@@ -130,16 +156,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
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
@@ -153,7 +179,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, &priv->reg->dac[chan->channel]);
 
 			return 0;
 		}
@@ -307,15 +333,15 @@ static int stx104_probe(struct device *dev, unsigned int id)
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
@@ -326,14 +352,14 @@ static int stx104_probe(struct device *dev, unsigned int id)
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
@@ -348,7 +374,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = priv->base + 3;
+	stx104gpio->base = &priv->reg->dio;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
-- 
2.36.1

