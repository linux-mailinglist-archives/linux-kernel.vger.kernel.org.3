Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE685445ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiFIIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiFIIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAE17F82A;
        Thu,  9 Jun 2022 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763452; x=1686299452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOoygEpCGBMLPr2N4WpcMy6Q3oFkG1fXmGNGKo0JjEA=;
  b=eTH074rBmYCQ9D6DPNcIr4HSU0DkE2v4J71bIYShVJ+cVg+YSU6k+A8s
   XSDY6Y4ngkHBiy3XOauHG/1QyGxA2neOZ+KUknvxa2dOFriVIz+IeitqY
   e4hvlFcC2pweoAUqtDSwKGpyfQL1N80lkAVNepG9J2iRiZ3v4v2nAeLp3
   6uJ6Bb9SJUQH3rtT5h3ToujnwtuqMTAoMVMqIoUY9tpBtM/FJ1STccgh/
   zTbrA/iBm1i1cTh+qBErr7T6S50z0rh6NMZ94/Dh/DGk2S5IZwHC7wf9p
   ++9g6BXfTL5x2kKtPtcojb6CmMiB6rNPfkyJLJZLtiMtC/y9LpmNp+MQl
   w==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167403812"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:47 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 15/16] iio: adc: at91-sama5d2_adc: add runtime pm support
Date:   Thu, 9 Jun 2022 11:32:12 +0300
Message-ID: <20220609083213.1795019-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support by disabling/enabling ADC's peripheral clock.
On simple conversion the ADC's clock is kept enabled just while the
conversion is in progress. This includes also temperature conversion.
For triggers and touch conversions the ADC clock is kept enabled while
the triggers or touch are enabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 201 +++++++++++++++++++++++++----
 1 file changed, 173 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1a6788566969..5d9ad51d0920 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -28,6 +28,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
@@ -600,6 +601,7 @@ struct at91_adc_state {
 	struct at91_adc_touch		touch_st;
 	struct at91_adc_temp		temp_st;
 	struct iio_dev			*indio_dev;
+	struct device			*dev;
 	/* Ensure naturally aligned timestamp */
 	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
 	/*
@@ -844,10 +846,16 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 			       u32 oversampling_ratio, u32 trackx)
 {
 	/* configure the extended mode register */
-	unsigned int emr = at91_adc_readl(st, EMR);
+	unsigned int emr;
 	unsigned int osr_mask = st->soc_info.platform->osr_mask;
 	unsigned int osr_vals = st->soc_info.platform->osr_vals;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
+	emr = at91_adc_readl(st, EMR);
 	/* select oversampling per single trigger event */
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
 
@@ -857,32 +865,42 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	/* select oversampling ratio from configuration */
 	switch (oversampling_ratio) {
 	case AT91_OSR_1SAMPLES:
-		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES)))
-			return -EINVAL;
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_1SAMPLES))) {
+			ret = -EINVAL;
+			goto pm_runtime_put;
+		}
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
 					    osr_mask);
 		break;
 	case AT91_OSR_4SAMPLES:
-		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES)))
-			return -EINVAL;
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_4SAMPLES))) {
+			ret = -EINVAL;
+			goto pm_runtime_put;
+		}
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
 					    osr_mask);
 		break;
 	case AT91_OSR_16SAMPLES:
-		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES)))
-			return -EINVAL;
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_16SAMPLES))) {
+			ret = -EINVAL;
+			goto pm_runtime_put;
+		}
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
 	case AT91_OSR_64SAMPLES:
-		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES)))
-			return -EINVAL;
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_64SAMPLES))) {
+			ret = -EINVAL;
+			goto pm_runtime_put;
+		}
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
 					    osr_mask);
 		break;
 	case AT91_OSR_256SAMPLES:
-		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES)))
-			return -EINVAL;
+		if (!(osr_vals & BIT(AT91_SAMA5D2_EMR_OSR_256SAMPLES))) {
+			ret = -EINVAL;
+			goto pm_runtime_put;
+		}
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
 					    osr_mask);
 		break;
@@ -894,7 +912,10 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 	st->oversampling_ratio = oversampling_ratio;
 
-	return 0;
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+	return ret;
 }
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
@@ -947,15 +968,22 @@ static void at91_adc_adjust_val_osr_array(struct at91_adc_state *st, void *buf,
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
@@ -1100,8 +1128,16 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(indio);
-	u32 status = at91_adc_readl(st, TRGR);
+	u32 status;
+	int ret;
+
+	if (state) {
+		ret = pm_runtime_resume_and_get(st->dev);
+		if (ret < 0)
+			return ret;
+	}
 
+	status = at91_adc_readl(st, TRGR);
 	/* clear TRGMOD */
 	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
 
@@ -1111,6 +1147,11 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	/* set/unset hw trigger */
 	at91_adc_writel(st, TRGR, status);
 
+	if (!state) {
+		pm_runtime_mark_last_busy(st->dev);
+		pm_runtime_put_autosuspend(st->dev);
+	}
+
 	return 0;
 }
 
@@ -1268,11 +1309,15 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
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
@@ -1295,12 +1340,16 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
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
@@ -1311,6 +1360,10 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * For each enable channel we must disable it in hardware.
 	 * In the case of DMA, we must read the last converted value
@@ -1346,6 +1399,9 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	if (st->dma_st.dma_chan)
 		dmaengine_terminate_sync(st->dma_st.dma_chan);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	return 0;
 }
 
@@ -1534,12 +1590,17 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
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
@@ -1547,6 +1608,9 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
 	mr |= AT91_SAMA5D2_MR_TRACKTIM(tracktim);
 	at91_adc_writel(st, MR, mr);
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u, tracktim=%u\n",
 		freq, startup, prescal, tracktim);
 	st->current_sample_rate = freq;
@@ -1684,6 +1748,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	u16 tmp_val;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Keep in mind that we cannot use software trigger or touchscreen
 	 * if external trigger is enabled
@@ -1695,7 +1763,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
-		return ret;
+		goto pm_runtime_put;
 	if (lock)
 		mutex_lock(&st->lock);
 
@@ -1707,7 +1775,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
-		return ret;
+		goto pm_runtime_put;
 	}
 
 	/* in this case we have a voltage or temperature channel */
@@ -1753,6 +1821,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&st->lock);
 
 	iio_device_release_direct_mode(indio_dev);
+
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	return ret;
 }
 
@@ -1804,6 +1877,10 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
 
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&st->lock);
 
 	at91_adc_temp_sensor_configure(st, true);
@@ -1825,6 +1902,10 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 	/* Revert previous settings. */
 	at91_adc_temp_sensor_configure(st, false);
 	mutex_unlock(&st->lock);
+
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	if (ret < 0)
 		return ret;
 
@@ -2363,13 +2444,19 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	at91_adc_temp_sensor_init(st, &pdev->dev);
 
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
@@ -2385,10 +2472,18 @@ static int at91_adc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "version: %x\n",
 		 readl_relaxed(st->base + st->soc_info.platform->layout->VERSION));
 
+	pm_runtime_mark_last_busy(st->dev);
+	pm_runtime_put_autosuspend(st->dev);
+
 	return 0;
 
 dma_disable:
 	at91_adc_dma_disable(st);
+err_pm_disable:
+	pm_runtime_put_noidle(st->dev);
+	pm_runtime_disable(st->dev);
+	pm_runtime_set_suspended(st->dev);
+	pm_runtime_dont_use_autosuspend(st->dev);
 per_clk_disable_unprepare:
 	clk_disable_unprepare(st->per_clk);
 vref_disable:
@@ -2402,11 +2497,18 @@ static int at91_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
 	iio_device_unregister(indio_dev);
 
 	at91_adc_dma_disable(st);
 
+	pm_runtime_disable(st->dev);
+	pm_runtime_put_noidle(st->dev);
 	clk_disable_unprepare(st->per_clk);
 
 	regulator_disable(st->vref);
@@ -2419,6 +2521,11 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Do a sofware reset of the ADC before we go to suspend.
@@ -2428,7 +2535,8 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	 */
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
 
-	clk_disable_unprepare(st->per_clk);
+	pm_runtime_force_suspend(st->dev);
+	clk_unprepare(st->per_clk);
 	regulator_disable(st->vref);
 	regulator_disable(st->reg);
 
@@ -2453,25 +2561,40 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	if (ret)
 		goto reg_disable_resume;
 
-	ret = clk_prepare_enable(st->per_clk);
+	ret = clk_prepare(st->per_clk);
 	if (ret)
 		goto vref_disable_resume;
 
+	ret = pm_runtime_force_resume(st->dev);
+	if (ret < 0)
+		goto clk_unprepare_resume;
+
 	at91_adc_hw_init(indio_dev);
 
 	/* reconfiguring trigger hardware state */
 	if (!iio_buffer_enabled(indio_dev))
-		return 0;
+		goto pm_runtime_put;
 
 	/* check if we are enabling triggered buffer or the touchscreen */
 	if (at91_adc_current_chan_is_touch(indio_dev))
-		return at91_adc_configure_touch(st, true);
+		ret = at91_adc_configure_touch(st, true);
 	else
-		return at91_adc_configure_trigger(st->trig, true);
+		ret = at91_adc_configure_trigger(st->trig, true);
+
+pm_runtime_put:
+	pm_runtime_mark_last_busy(st->dev);
+	if (ret < 0) {
+		pm_runtime_put_sync_suspend(st->dev);
+		goto clk_unprepare_resume;
+	} else {
+		pm_runtime_put_autosuspend(st->dev);
+	}
 
 	/* not needed but more explicit */
 	return 0;
 
+clk_unprepare_resume:
+	clk_unprepare(st->per_clk);
 vref_disable_resume:
 	regulator_disable(st->vref);
 reg_disable_resume:
@@ -2481,7 +2604,29 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+static int __maybe_unused at91_adc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	clk_disable(st->per_clk);
+
+	return 0;
+}
+
+static int __maybe_unused at91_adc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	return clk_enable(st->per_clk);
+}
+
+static const struct dev_pm_ops __maybe_unused at91_adc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(at91_adc_suspend, at91_adc_resume)
+	SET_RUNTIME_PM_OPS(at91_adc_runtime_suspend, at91_adc_runtime_resume,
+			   NULL)
+};
 
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
-- 
2.34.1

