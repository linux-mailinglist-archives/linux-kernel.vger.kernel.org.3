Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4DE48AE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbiAKNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiAKNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:04:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA96C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:04:11 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n7Gom-0001Dn-3J; Tue, 11 Jan 2022 14:04:04 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1n7Gol-00EHkV-0r; Tue, 11 Jan 2022 14:04:03 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/1] iio: adc: tsc2046: rework the trigger state machine
Date:   Tue, 11 Jan 2022 14:04:02 +0100
Message-Id: <20220111130402.3404769-1-o.rempel@pengutronix.de>
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

Initially this was designed to:
| Fix sleeping in atomic context warning and a deadlock after iio_trigger_poll()
| call
|
| If iio_trigger_poll() is called after IRQ was disabled, we will call
| reenable_trigger() directly from hard IRQ or hrtimer context instead of
| IRQ thread. In this case we will run in to multiple issue as sleeping in atomic
| context and a deadlock.
|
| To avoid this issue, rework the trigger to use state machine. All state
| changes are done over the hrtimer, so it allows us to drop fsleep() and
| avoid the deadlock.

Since this issue was fixed by: 9020ef659885 ("iio: trigger: Fix a scheduling
whilst atomic issue seen on tsc2046"). This patch is a cleanup to make
state machine easier to follow.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 144 ++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index e8fc4d01f30b..c373da11bff1 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -82,6 +82,10 @@
 #define TI_TSC2046_DATA_12BIT			GENMASK(14, 3)
 
 #define TI_TSC2046_MAX_CHAN			8
+#define TI_TSC2046_MIN_POLL_CNT			3
+#define TI_TSC2046_EXT_POLL_CNT			3
+#define TI_TSC2046_POLL_CNT \
+	(TI_TSC2046_MIN_POLL_CNT + TI_TSC2046_EXT_POLL_CNT)
 
 /* Represents a HW sample */
 struct tsc2046_adc_atom {
@@ -123,14 +127,23 @@ struct tsc2046_adc_ch_cfg {
 	unsigned int oversampling_ratio;
 };
 
+enum tsc2046_state {
+	TSC2046_STATE_SHUTDOWN,
+	TSC2046_STATE_STANDBY,
+	TSC2046_STATE_POLL,
+	TSC2046_STATE_POLL_IRQ_DISABLE,
+	TSC2046_STATE_ENABLE_IRQ,
+};
+
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
 	const struct tsc2046_adc_dcfg *dcfg;
 
 	struct iio_trigger *trig;
 	struct hrtimer trig_timer;
-	spinlock_t trig_lock;
-	unsigned int trig_more_count;
+	enum tsc2046_state state;
+	int poll_cnt;
+	spinlock_t state_lock;
 
 	struct spi_transfer xfer;
 	struct spi_message msg;
@@ -411,21 +424,62 @@ static const struct iio_info tsc2046_adc_info = {
 	.update_scan_mode = tsc2046_adc_update_scan_mode,
 };
 
-static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
+static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
 {
 	struct tsc2046_adc_priv *priv = container_of(hrtimer,
 						     struct tsc2046_adc_priv,
 						     trig_timer);
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->trig_lock, flags);
-
-	disable_irq_nosync(priv->spi->irq);
-
-	priv->trig_more_count++;
-	iio_trigger_poll(priv->trig);
+	/* This state machine should address following challenges :
+	 * - the interrupt source is based on level shifter attached to the X
+	 *   channel of ADC. It will change the state every time we switch
+	 *   between channels. So, we need to disable IRQ if we do
+	 *   iio_trigger_poll().
+	 * - we should do iio_trigger_poll() at some reduced sample rate
+	 * - we should still trigger for some amount of time after last
+	 *   interrupt with enabled IRQ was processed.
+	 */
 
-	spin_unlock_irqrestore(&priv->trig_lock, flags);
+	spin_lock_irqsave(&priv->state_lock, flags);
+	switch (priv->state) {
+	case TSC2046_STATE_ENABLE_IRQ:
+		if (priv->poll_cnt < TI_TSC2046_POLL_CNT) {
+			priv->poll_cnt++;
+			hrtimer_start(&priv->trig_timer,
+				      ns_to_ktime(priv->scan_interval_us *
+						  NSEC_PER_USEC),
+				      HRTIMER_MODE_REL_SOFT);
+
+			if (priv->poll_cnt >= TI_TSC2046_MIN_POLL_CNT) {
+				priv->state = TSC2046_STATE_POLL_IRQ_DISABLE;
+				enable_irq(priv->spi->irq);
+			} else {
+				priv->state = TSC2046_STATE_POLL;
+			}
+		} else {
+			priv->state = TSC2046_STATE_STANDBY;
+			enable_irq(priv->spi->irq);
+		}
+		break;
+	case TSC2046_STATE_POLL_IRQ_DISABLE:
+		disable_irq_nosync(priv->spi->irq);
+		fallthrough;
+	case TSC2046_STATE_POLL:
+		priv->state = TSC2046_STATE_ENABLE_IRQ;
+		/* iio_trigger_poll() starts hrtimer */
+		iio_trigger_poll(priv->trig);
+		break;
+	case TSC2046_STATE_SHUTDOWN:
+		break;
+	case TSC2046_STATE_STANDBY:
+		fallthrough;
+	default:
+		dev_warn(&priv->spi->dev, "Got unexpected state: %i\n",
+			 priv->state);
+		break;
+	}
+	spin_unlock_irqrestore(&priv->state_lock, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -434,16 +488,20 @@ static irqreturn_t tsc2046_adc_irq(int irq, void *dev_id)
 {
 	struct iio_dev *indio_dev = dev_id;
 	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
-
-	spin_lock(&priv->trig_lock);
+	unsigned long flags;
 
 	hrtimer_try_to_cancel(&priv->trig_timer);
 
-	priv->trig_more_count = 0;
-	disable_irq_nosync(priv->spi->irq);
-	iio_trigger_poll(priv->trig);
+	spin_lock_irqsave(&priv->state_lock, flags);
+	if (priv->state != TSC2046_STATE_SHUTDOWN) {
+		priv->state = TSC2046_STATE_ENABLE_IRQ;
+		priv->poll_cnt = 0;
 
-	spin_unlock(&priv->trig_lock);
+		/* iio_trigger_poll() starts hrtimer */
+		disable_irq_nosync(priv->spi->irq);
+		iio_trigger_poll(priv->trig);
+	}
+	spin_unlock_irqrestore(&priv->state_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -452,49 +510,42 @@ static void tsc2046_adc_reenable_trigger(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
-	unsigned long flags;
-	int delta;
+	ktime_t tim;
 
 	/*
 	 * We can sample it as fast as we can, but usually we do not need so
 	 * many samples. Reduce the sample rate for default (touchscreen) use
 	 * case.
-	 * Currently we do not need a highly precise sample rate. It is enough
-	 * to have calculated numbers.
-	 */
-	delta = priv->scan_interval_us - priv->time_per_scan_us;
-	if (delta > 0)
-		fsleep(delta);
-
-	spin_lock_irqsave(&priv->trig_lock, flags);
-
-	/*
-	 * We need to trigger at least one extra sample to detect state
-	 * difference on ADC side.
 	 */
-	if (!priv->trig_more_count) {
-		int timeout_ms = DIV_ROUND_UP(priv->scan_interval_us,
-					      USEC_PER_MSEC);
-
-		hrtimer_start(&priv->trig_timer, ms_to_ktime(timeout_ms),
-			      HRTIMER_MODE_REL_SOFT);
-	}
-
-	enable_irq(priv->spi->irq);
-
-	spin_unlock_irqrestore(&priv->trig_lock, flags);
+	tim = ns_to_ktime((priv->scan_interval_us - priv->time_per_scan_us) *
+			  NSEC_PER_USEC);
+	hrtimer_start(&priv->trig_timer, tim, HRTIMER_MODE_REL_SOFT);
 }
 
 static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
+	unsigned long flags;
 
 	if (enable) {
-		enable_irq(priv->spi->irq);
+		spin_lock_irqsave(&priv->state_lock, flags);
+		if (priv->state == TSC2046_STATE_SHUTDOWN) {
+			priv->state = TSC2046_STATE_STANDBY;
+			enable_irq(priv->spi->irq);
+		}
+		spin_unlock_irqrestore(&priv->state_lock, flags);
 	} else {
-		disable_irq(priv->spi->irq);
-		hrtimer_try_to_cancel(&priv->trig_timer);
+		spin_lock_irqsave(&priv->state_lock, flags);
+
+		if (priv->state == TSC2046_STATE_STANDBY ||
+		    priv->state == TSC2046_STATE_POLL_IRQ_DISABLE)
+			disable_irq_nosync(priv->spi->irq);
+
+		priv->state = TSC2046_STATE_SHUTDOWN;
+		spin_unlock_irqrestore(&priv->state_lock, flags);
+
+		hrtimer_cancel(&priv->trig_timer);
 	}
 
 	return 0;
@@ -668,10 +719,11 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &tsc2046_adc_trigger_ops;
 
-	spin_lock_init(&priv->trig_lock);
+	spin_lock_init(&priv->state_lock);
+	priv->state = TSC2046_STATE_SHUTDOWN;
 	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL_SOFT);
-	priv->trig_timer.function = tsc2046_adc_trig_more;
+	priv->trig_timer.function = tsc2046_adc_timer;
 
 	ret = devm_iio_trigger_register(dev, trig);
 	if (ret) {
-- 
2.30.2

