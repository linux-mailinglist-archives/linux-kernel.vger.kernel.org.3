Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF555E802
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbiF1PQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348168AbiF1PPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507783207E;
        Tue, 28 Jun 2022 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429325; x=1687965325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owjqT53cCW8sPUIEHydqILHK6GaPDlfzqdQrDpWN6a4=;
  b=vtjJBR7TCGT8Q22mewaEoFlaZ8tgKegO1g5IE143NYy7LWVDRMk7wMjI
   ZoPAHA4CRKy7uNpjl4ZW7LDn+F6KrhWTq2xElAd3c4DV25d95jl3DZJn2
   aOhBduyZQ/MobYuE9twXt0VsBIhPGiwZ28TVM+Oag8ZIjUj2OQy+SfOau
   +YSzSKoxj3S76TznqX1bN84t35BGIqXGoB+femlB8kqgJOOckc9hPBIY8
   V0M76CdR/2VNnzJuR0D7eiwU5UdxWjPi54fMVakx0CcBY/RDs4TqHmiSc
   3TMuwHZkQsg2T96/uFb+sXqXhYTI/VvPQKTXdBPpIZ7RMB+TRdsnNG3cs
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162421252"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:15:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:15:20 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:15:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 19/19] iio: adc: at91-sama5d2_adc: add runtime pm support
Date:   Tue, 28 Jun 2022 18:16:31 +0300
Message-ID: <20220628151631.3116454-20-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support by disabling/enabling ADC's peripheral clock.
On simple conversion the ADC's clock is kept enabled just while the
conversion is in progress. This includes also temperature conversion.
For triggered buffers and touch conversions the ADC clock is kept enabled
while the triggered buffers or touch are enabled. Along with it removed
the __maybe_unused on suspend() and resume() ops as the dev_pm_ops
object members are now filled with SYSTEM_SLEEP_PM_OPS().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 211 +++++++++++++++++++++++------
 1 file changed, 168 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 3f47ca643496..5be38d6b067b 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -28,6 +28,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
@@ -599,6 +600,7 @@ struct at91_adc_state {
 	struct at91_adc_touch		touch_st;
 	struct at91_adc_temp		temp_st;
 	struct iio_dev			*indio_dev;
+	struct device			*dev;
 	/* Ensure naturally aligned timestamp */
 	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
 	/*
@@ -839,9 +841,9 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 			       u32 oversampling_ratio, u32 trackx)
 {
 	/* configure the extended mode register */
-	unsigned int emr = at91_adc_readl(st, EMR);
+	unsigned int emr, osr;
 	unsigned int osr_mask = st->soc_info.platform->osr_mask;
-	int i;
+	int i, ret;
 
 	/* Check against supported oversampling values. */
 	for (i = 0; i < st->soc_info.platform->oversampling_avail_no; i++) {
@@ -851,40 +853,46 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	if (i == st->soc_info.platform->oversampling_avail_no)
 		return -EINVAL;
 
-	/* select oversampling per single trigger event */
-	emr |= AT91_SAMA5D2_EMR_ASTE(1);
-
-	/* delete leftover content if it's the case */
-	emr &= ~(osr_mask | AT91_SAMA5D2_TRACKX_MASK);
-
 	/* select oversampling ratio from configuration */
 	switch (oversampling_ratio) {
 	case 1:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
-					    osr_mask);
+		osr = AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
+					   osr_mask);
 		break;
 	case 4:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
-					    osr_mask);
+		osr = AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
+					   osr_mask);
 		break;
 	case 16:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
-					    osr_mask);
+		osr = AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
+					   osr_mask);
 		break;
 	case 64:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
-					    osr_mask);
+		osr = AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
+					   osr_mask);
 		break;
 	case 256:
-		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
-					    osr_mask);
+		osr = AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
+					   osr_mask);
 		break;
 	}
 
-	/* Update trackx. */
-	emr |= AT91_SAMA5D2_TRACKX(trackx);
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
+	emr = at91_adc_readl(st, EMR);
+	/* select oversampling per single trigger event */
+	emr |= AT91_SAMA5D2_EMR_ASTE(1);
+	/* delete leftover content if it's the case */
+	emr &= ~(osr_mask | AT91_SAMA5D2_TRACKX_MASK);
+	/* Update osr and trackx. */
+	emr |= osr | AT91_SAMA5D2_TRACKX(trackx);
 	at91_adc_writel(st, EMR, emr);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	st->oversampling_ratio = oversampling_ratio;
 
 	return 0;
@@ -940,15 +948,22 @@ static void at91_adc_adjust_val_osr_array(struct at91_adc_state *st, void *buf,
 static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 {
 	u32 clk_khz = st->current_sample_rate / 1000;
-	int i = 0;
+	int i = 0, ret;
 	u16 pendbc;
 	u32 tsmr, acr;
 
-	if (!state) {
+	if (state) {
+		ret = pm_runtime_resume_and_get(st->dev);
+		if (ret < 0)
+			return ret;
+	} else {
 		/* disabling touch IRQs and setting mode to no touch enabled */
 		at91_adc_writel(st, IDR,
 				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
 		at91_adc_writel(st, TSMR, 0);
+
+		pm_runtime_mark_last_busy(st->dev);
+		pm_runtime_put_autosuspend(st->dev);
 		return 0;
 	}
 	/*
@@ -1089,10 +1104,9 @@ static int at91_adc_read_pressure(struct at91_adc_state *st, int chan, u16 *val)
 	return IIO_VAL_INT;
 }
 
-static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
+static void at91_adc_configure_trigger_registers(struct at91_adc_state *st,
+						 bool state)
 {
-	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
-	struct at91_adc_state *st = iio_priv(indio);
 	u32 status = at91_adc_readl(st, TRGR);
 
 	/* clear TRGMOD */
@@ -1103,6 +1117,26 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 
 	/* set/unset hw trigger */
 	at91_adc_writel(st, TRGR, status);
+}
+
+static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
+	struct at91_adc_state *st = iio_priv(indio);
+	int ret;
+
+	if (state) {
+		ret = pm_runtime_resume_and_get(st->dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	at91_adc_configure_trigger_registers(st, state);
+
+	if (!state) {
+		pm_runtime_mark_last_busy(st->dev);
+		pm_runtime_put_autosuspend(st->dev);
+	}
 
 	return 0;
 }
@@ -1261,11 +1295,15 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	/* we continue with the triggered buffer */
 	ret = at91_adc_dma_start(indio_dev);
 	if (ret) {
 		dev_err(&indio_dev->dev, "buffer prepare failed\n");
-		return ret;
+		goto pm_runtime_put;
 	}
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
@@ -1288,12 +1326,16 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 	if (at91_adc_buffer_check_use_irq(indio_dev, st))
 		at91_adc_writel(st, IER, AT91_SAMA5D2_IER_DRDY);
 
-	return 0;
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+	return ret;
 }
 
 static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
 	u8 bit;
 
 	/* check if we are disabling triggered buffer or the touchscreen */
@@ -1304,6 +1346,10 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * For each enable channel we must disable it in hardware.
 	 * In the case of DMA, we must read the last converted value
@@ -1339,6 +1385,9 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	if (st->dma_st.dma_chan)
 		dmaengine_terminate_sync(st->dma_st.dma_chan);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	return 0;
 }
 
@@ -1527,12 +1576,17 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	unsigned f_per, prescal, startup, mr;
+	int ret;
 
 	f_per = clk_get_rate(st->per_clk);
 	prescal = (f_per / (2 * freq)) - 1;
 
 	startup = at91_adc_startup_time(startup_time, freq / 1000);
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return;
+
 	mr = at91_adc_readl(st, MR);
 	mr &= ~(AT91_SAMA5D2_MR_STARTUP_MASK | AT91_SAMA5D2_MR_PRESCAL_MASK);
 	mr |= AT91_SAMA5D2_MR_STARTUP(startup);
@@ -1540,6 +1594,9 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
 	mr |= AT91_SAMA5D2_MR_TRACKTIM(tracktim);
 	at91_adc_writel(st, MR, mr);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u, tracktim=%u\n",
 		freq, startup, prescal, tracktim);
 	st->current_sample_rate = freq;
@@ -1676,6 +1733,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	u16 tmp_val;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Keep in mind that we cannot use software trigger or touchscreen
 	 * if external trigger is enabled
@@ -1687,7 +1748,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
 
-		return ret;
+		goto pm_runtime_put;
 	}
 	if (chan->type == IIO_PRESSURE) {
 		ret = at91_adc_read_pressure(st, chan->channel,
@@ -1696,7 +1757,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
 
-		return ret;
+		goto pm_runtime_put;
 	}
 
 	/* in this case we have a voltage or temperature channel */
@@ -1738,6 +1799,9 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	/* Needed to ACK the DRDY interruption */
 	at91_adc_readl(st, LCDR);
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
 	return ret;
 }
 
@@ -1807,6 +1871,10 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 		return ret;
 	mutex_lock(&st->lock);
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		goto unlock;
+
 	at91_adc_temp_sensor_configure(st, true);
 
 	/* Read VBG. */
@@ -1825,6 +1893,9 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 restore_config:
 	/* Revert previous settings. */
 	at91_adc_temp_sensor_configure(st, false);
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+unlock:
 	mutex_unlock(&st->lock);
 	iio_device_release_direct_mode(indio_dev);
 	if (ret < 0)
@@ -2369,13 +2440,19 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto vref_disable;
 
-	at91_adc_hw_init(indio_dev);
-
 	platform_set_drvdata(pdev, indio_dev);
+	st->dev = &pdev->dev;
+	pm_runtime_set_autosuspend_delay(st->dev, 500);
+	pm_runtime_use_autosuspend(st->dev);
+	pm_runtime_set_active(st->dev);
+	pm_runtime_enable(st->dev);
+	pm_runtime_get_noresume(st->dev);
+
+	at91_adc_hw_init(indio_dev);
 
 	ret = at91_adc_buffer_and_trigger_init(&pdev->dev, indio_dev);
 	if (ret < 0)
-		goto per_clk_disable_unprepare;
+		goto err_pm_disable;
 
 	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
 		dev_info(&pdev->dev, "cannot set DMA mask to 32-bit\n");
@@ -2391,11 +2468,18 @@ static int at91_adc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "version: %x\n",
 		 readl_relaxed(st->base + st->soc_info.platform->layout->VERSION));
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	return 0;
 
 dma_disable:
 	at91_adc_dma_disable(st);
-per_clk_disable_unprepare:
+err_pm_disable:
+	pm_runtime_put_noidle(st->dev);
+	pm_runtime_disable(st->dev);
+	pm_runtime_set_suspended(st->dev);
+	pm_runtime_dont_use_autosuspend(st->dev);
 	clk_disable_unprepare(st->per_clk);
 vref_disable:
 	regulator_disable(st->vref);
@@ -2413,6 +2497,8 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 	at91_adc_dma_disable(st);
 
+	pm_runtime_disable(st->dev);
+	pm_runtime_set_suspended(st->dev);
 	clk_disable_unprepare(st->per_clk);
 
 	regulator_disable(st->vref);
@@ -2421,10 +2507,15 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static __maybe_unused int at91_adc_suspend(struct device *dev)
+static int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
 	if (iio_buffer_enabled(indio_dev))
 		at91_adc_buffer_postdisable(indio_dev);
@@ -2437,6 +2528,8 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	 */
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_noidle(st->dev);
 	clk_disable_unprepare(st->per_clk);
 	regulator_disable(st->vref);
 	regulator_disable(st->reg);
@@ -2444,7 +2537,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static __maybe_unused int at91_adc_resume(struct device *dev)
+static int at91_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -2466,18 +2559,28 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	if (ret)
 		goto vref_disable_resume;
 
+	pm_runtime_get_noresume(st->dev);
+
 	at91_adc_hw_init(indio_dev);
 
 	/* reconfiguring trigger hardware state */
-	if (!iio_buffer_enabled(indio_dev))
-		return 0;
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = at91_adc_buffer_prepare(indio_dev);
+		if (ret)
+			goto pm_runtime_put;
 
-	ret = at91_adc_buffer_prepare(indio_dev);
-	if (ret)
-		goto vref_disable_resume;
+		at91_adc_configure_trigger_registers(st, true);
+	}
+
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
 
-	return at91_adc_configure_trigger(st->trig, true);
+	return 0;
 
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_noidle(st->dev);
+	clk_disable_unprepare(st->per_clk);
 vref_disable_resume:
 	regulator_disable(st->vref);
 reg_disable_resume:
@@ -2487,7 +2590,29 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+static int at91_adc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	clk_disable(st->per_clk);
+
+	return 0;
+}
+
+static int at91_adc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	return clk_enable(st->per_clk);
+}
+
+static const struct dev_pm_ops at91_adc_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(at91_adc_suspend, at91_adc_resume)
+	RUNTIME_PM_OPS(at91_adc_runtime_suspend, at91_adc_runtime_resume,
+		       NULL)
+};
 
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
@@ -2508,7 +2633,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
-		.pm = &at91_adc_pm_ops,
+		.pm = pm_ptr(&at91_adc_pm_ops),
 	},
 };
 module_platform_driver(at91_adc_driver)
-- 
2.34.1

