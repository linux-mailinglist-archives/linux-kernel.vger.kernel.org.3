Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762B48A93F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiAKIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348854AbiAKIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:21:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A83C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:21:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q14so16010212plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:from:date:subject:to:cc;
        bh=4rgqjIr0fp0ZpooxWdjgQePlEAijJqx3Po9zqgyLnN0=;
        b=1IeZeJt5+YiICwmtq0IQDBsDy3N3xMPK0ctGulubNVtbwIulNnyhYvL0jNUjQywgCh
         7H0WJxyCQw0xZTacVn7szfyZ10QZnzXRQdfKBm9eJG0W+erl5Ntym3eCpQfRcGCJrq0m
         WiWu3ksYYKjUn7DYm/PMdkJjBckTWshfExw9x+o3BjaZyHgU1NcpJG536UDyBvxkndlV
         sh/ct/LnRM/vow2tbi3Cu9SUbKsqHRV35hxFH7Cpu6b4H9FdymcIRBAB3aAyFcEbavzc
         Fs6VGqXOi1USwrXmMTzvgX62MZ5Cg5I71iiFrpFknW3RLIh9twD0eZeVDtJsLhJSTnsu
         RIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:to:cc;
        bh=4rgqjIr0fp0ZpooxWdjgQePlEAijJqx3Po9zqgyLnN0=;
        b=NWkj+mqPv2KM6JhSxIv5w2eTHIoPcgDvWKyuSeVL6kPkJueenaL2qKD4h/W/+1ec21
         LO/GsY2kLJaJFRQoLAPlrR9bS29eaZWxWN94UpEqOFvLnjwz2xLdey3VVBq82/Im5cR9
         bT7gpGNKCjzBj49x/7Rcbi6s6yAOKfEdWq6dDZx7z2mCa92KDEjTRWTjwo9u7FuHV1Oe
         Zksotj/iiFnjnjJ71vbmoIQhbwbBRLtt4dPvDQERc43NHwPomk9oc4uplygofi8j09/1
         o3RWRcrjF8BhMcpi0iwt1N05ivycOzSh24hXdTCRtXmh02QxKGY8C71IEyo2F7CKdEdf
         K2Vg==
X-Gm-Message-State: AOAM533JwVkTnSlkTErslJ9/m8mcGDuuioV231VwfGkdxhpQKzA1Ikkm
        xt63uCvDHgeWstk5ysiIi7w+3HUmkl0HX0P1
X-Google-Smtp-Source: ABdhPJzCf4R8NG/Y+20Mw98oB3d8amHejANAgPtDWQcdDkQU09jELNxNRdYldkHYRVE2Sxyx/q8p7w==
X-Received: by 2002:a17:90b:4c05:: with SMTP id na5mr1935709pjb.94.1641889293172;
        Tue, 11 Jan 2022 00:21:33 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id t1sm3451722pfg.29.2022.01.11.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:21:32 -0800 (PST)
Message-ID: <61dd3e0c.1c69fb81.cea15.8d98@mx.google.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Tue, 11 Jan 2022 21:07:47 +1300
Subject: [PATCH] iio: adc: ad_sigma_delta: IRQ sharing mechanism.
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows for multiple Analog Devices ADCs to be placed on the
same SPI bus. While it's not possible for them to share interrupts
arbitrarily, a special restricted form of sharing for this special case
is implemented here.

The first instance of an ADC using a given interrupt will acquire the
IRQ and register an object in a global list. Any subsequent instances
will increment a reference count on this object.

During a conversion, the active instance indicates that it is the
recipient of the interrupt by setting a pointer on the object shared
among it and the other instances.

The existing CS locking mechanism guarantees that no more than one
instance per bus will be expecting the interrupt at any time.

Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 191 +++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |   4 +
 2 files changed, 181 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index cd418bd8bd87..cd593af6ef3a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -13,6 +13,7 @@
 #include <linux/spi/spi.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/list.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -24,6 +25,161 @@
 
 #include <asm/unaligned.h>
 
+static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private);
+
+struct ad_sigma_delta_interrupt {
+	/* Constant from time of creation */
+	int			irq;
+	struct spi_master	*master;
+
+	/* Protected by global lock */
+	struct list_head	list;
+	int			refcnt;
+
+	/* Protected by lock on corresponding SPI bus */
+	struct ad_sigma_delta	*active;
+};
+
+static DEFINE_MUTEX(interrupt_lock);
+static LIST_HEAD(interrupt_list);
+
+static void adsdi_enable(struct ad_sigma_delta *a)
+{
+	struct ad_sigma_delta_interrupt *intr = a->interrupt;
+
+	WARN_ON(intr->active);
+	intr->active = a;
+	pr_debug("ad_sigma_delta: enable %d for %p\n", intr->irq, a);
+	enable_irq(intr->irq);
+}
+
+static void adsdi_disable(struct ad_sigma_delta *a, int nosync)
+{
+	struct ad_sigma_delta_interrupt *intr = a->interrupt;
+
+	if (nosync)
+		disable_irq_nosync(intr->irq);
+	else
+		disable_irq(intr->irq);
+
+	pr_debug("ad_sigma_delta: disable %d for %p\n", intr->irq, intr->active);
+
+	/* In the case of a timeout, it's possible for adsdi_disable to
+	 * be called twice by the same instance (if the interrupt runs
+	 * between the call to check and the call to disable).
+	 *
+	 * We still need to disable first before checking intr->active.
+	 * Then we can roll back if we've done it twice.
+	 */
+	if (intr->active != a) {
+		WARN_ON(intr->active);
+		pr_debug("ad_sigma_delta: double-disable\n");
+		enable_irq(intr->irq);
+	}
+
+	intr->active = NULL;
+}
+
+static int adsdi_get(struct ad_sigma_delta_interrupt **intr_ret,
+		     int irq, struct spi_master *master,
+		     int flags)
+{
+	struct ad_sigma_delta_interrupt *intr = NULL;
+	struct list_head *ptr;
+	int ret = 0;
+
+	mutex_lock(&interrupt_lock);
+
+	/* Try to find an existing instance */
+	list_for_each(ptr, &interrupt_list) {
+		struct ad_sigma_delta_interrupt *i = list_entry(ptr,
+			struct ad_sigma_delta_interrupt, list);
+
+		if (i->irq == irq) {
+			/* No instance will attempt to wait for the
+			 * interrupt without the SPI bus locked, which
+			 * we can rely on to ensure correct operation.
+			 * However, we would like to detect
+			 * misconfiguration that would lead to unsafe
+			 * access.
+			 */
+			if (i->master != master) {
+				pr_err(
+				    "ad_sigma_delta: SPI master mismatch on IRQ %d\n",
+				    irq);
+				ret = -EINVAL;
+				goto fail_search;
+			}
+
+			intr = i;
+			break;
+		}
+	}
+
+	/* Allocate a new one if necessary */
+	if (!intr) {
+		intr = kmalloc(sizeof(*intr), GFP_KERNEL);
+		if (!intr) {
+			ret = -ENOMEM;
+			pr_err("ad_sigma_delta: can't allocate memory\n");
+			goto fail_search;
+		}
+
+		intr->irq = irq;
+		intr->refcnt = 0;
+		intr->active = NULL;
+		intr->master = master;
+
+		ret = request_irq(irq,
+				  ad_sd_data_rdy_trig_poll,
+				  flags | IRQF_NO_AUTOEN,
+				  "ad_sigma_delta",
+				  intr);
+		if (ret)
+			goto fail_search;
+
+		pr_debug("ad_sigma_delta: sharing interrupt %d\n", irq);
+		list_add(&intr->list, &interrupt_list);
+	}
+
+	intr->refcnt++;
+	*intr_ret = intr;
+
+fail_search:
+	mutex_unlock(&interrupt_lock);
+	return ret;
+}
+
+static void adsdi_put(struct ad_sigma_delta_interrupt *intr)
+{
+	mutex_lock(&interrupt_lock);
+	if (!--intr->refcnt) {
+		pr_debug("ad_sigma_delta: interrupt %d deallocated\n",
+			intr->irq);
+		free_irq(intr->irq, intr);
+		list_del(&intr->list);
+		kfree(intr);
+	}
+	mutex_unlock(&interrupt_lock);
+}
+
+static void devm_adsdi_release(void *arg)
+{
+	adsdi_put(arg);
+}
+
+static int devm_adsdi_get(struct device *dev,
+			  struct ad_sigma_delta_interrupt **intr_ret,
+			  int irq, struct spi_master *master,
+			  int flags)
+{
+	const int ret = adsdi_get(intr_ret, irq, master, flags);
+
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_adsdi_release, *intr_ret);
+}
 
 #define AD_SD_COMM_CHAN_MASK	0x3
 
@@ -221,11 +377,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 		goto out;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	adsdi_enable(sigma_delta);
 	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
 	if (timeout == 0) {
 		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->spi->irq);
+		adsdi_disable(sigma_delta, 0);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -294,7 +450,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	adsdi_enable(sigma_delta);
 	ret = wait_for_completion_interruptible_timeout(
 			&sigma_delta->completion, HZ);
 
@@ -314,7 +470,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 out:
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		adsdi_disable(sigma_delta, 0);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -361,7 +517,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		goto err_unlock;
 
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	adsdi_enable(sigma_delta);
 
 	return 0;
 
@@ -379,7 +535,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	wait_for_completion_timeout(&sigma_delta->completion, HZ);
 
 	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
+		adsdi_disable(sigma_delta, 0);
 		sigma_delta->irq_dis = true;
 	}
 
@@ -425,7 +581,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->spi->irq);
+	adsdi_enable(sigma_delta);
 
 	return IRQ_HANDLED;
 }
@@ -438,10 +594,17 @@ static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 
 static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 {
-	struct ad_sigma_delta *sigma_delta = private;
+	struct ad_sigma_delta_interrupt *intr = private;
+	struct ad_sigma_delta *sigma_delta = intr->active;
+
+	WARN_ON(!sigma_delta);
+	if (!sigma_delta)
+		return IRQ_NONE;
 
+	pr_debug("ad_sigma_delta: interrupt %d fired for %p\n",
+		intr->irq, sigma_delta);
 	complete(&sigma_delta->completion);
-	disable_irq_nosync(irq);
+	adsdi_disable(sigma_delta, 1);
 	sigma_delta->irq_dis = true;
 	iio_trigger_poll(sigma_delta->trig);
 
@@ -486,11 +649,11 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
-			       ad_sd_data_rdy_trig_poll,
-			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-			       indio_dev->name,
-			       sigma_delta);
+	ret = devm_adsdi_get(dev,
+			&sigma_delta->interrupt,
+			sigma_delta->spi->irq,
+			sigma_delta->spi->master,
+			sigma_delta->info->irq_flags);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index c525fd51652f..62f38cfe807b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -54,6 +54,9 @@ struct ad_sigma_delta_info {
 	unsigned long irq_flags;
 };
 
+/* Data relating to interrupt sharing */
+struct ad_sigma_delta_interrupt;
+
 /**
  * struct ad_sigma_delta - Sigma Delta device struct
  * @spi: The spi device associated with the Sigma Delta device.
@@ -76,6 +79,7 @@ struct ad_sigma_delta {
 	uint8_t			comm;
 
 	const struct ad_sigma_delta_info *info;
+	struct ad_sigma_delta_interrupt *interrupt;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
-- 
2.30.2

