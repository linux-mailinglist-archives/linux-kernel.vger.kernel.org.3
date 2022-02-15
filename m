Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F94B72D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiBOQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:02:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbiBOQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:02:33 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF1BC2D;
        Tue, 15 Feb 2022 08:02:22 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 2/4] input: ps2-gpio: use ktime for IRQ timekeeping
Date:   Tue, 15 Feb 2022 17:02:06 +0100
Message-Id: <20220215160208.34826-3-danilokrummrich@dk-develop.de>
In-Reply-To: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
References: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using jiffies for the IRQ timekeeping is not sufficient for two reasons:

(1) Usually jiffies have a resolution of 1ms to 10ms. The IRQ intervals
    based on the clock frequency of PS2 protocol specification (10kHz -
    16.7kHz) are between ~60us and 100us only. Therefore only those IRQ
    intervals can be detected which are either at the end of a transfer
    or are overly delayed. While this is sufficient in most cases, since
    we have quite a lot of ways to detect faulty transfers, it can
    produce false positives in rare cases: When the jiffies value
    changes right between two interrupt that are in time, we wrongly
    assume that we missed one or more clock cycles.

(2) Some gpio controllers (e.g. the one in the bcm283x chips) may generate
    spurious IRQs when processing interrupts in the frequency given by PS2
    devices.

Both issues can be fixed by using ktime resolution for IRQ timekeeping.

However, it is still possible to miss clock cycles without detecting
them. When the PS2 device generates the falling edge of the clock signal
we have between ~30us and 50us to sample the data line, because after
this time we reach the next rising edge at which the device changes the
data signal already. But, the only thing we can detect is whether the
IRQ interval is within the given period. Therefore it is possible to
have an IRQ latency greater than ~30us to 50us, sample the wrong bit on
the data line and still be on time with the next IRQ. However, this can
only happen when within a given transfer the IRQ latency increases
slowly.

___            ______            ______            ______            ___
   \          /      \          /      \          /      \          /
    \        /        \        /        \        /        \        /
     \______/          \______/          \______/          \______/

    |-----------------|                 |--------|
         60us/100us                      30us/50us

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/input/serio/ps2-gpio.c | 80 ++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 5f68505dd473..246a583986e9 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/timekeeping.h>
 
 #define DRIVER_NAME		"ps2-gpio"
 
@@ -44,6 +45,29 @@
 
 #define PS2_CMD_RESEND		0xfe
 
+/* The PS2 protocol specifies a clock frequency between 10kHz and 16.7kHz,
+ * therefore the maximal interrupt interval should be 100us and the minimum
+ * interrupt interval should be ~60us. Let's allow +/- 20us for frequency
+ * deviations and interrupt latency.
+ *
+ * The data line must be samples after ~30us to 50us after the falling edge,
+ * since the device updates the data line at the rising edge.
+ *
+ * ___            ______            ______            ______            ___
+ *    \          /      \          /      \          /      \          /
+ *     \        /        \        /        \        /        \        /
+ *      \______/          \______/          \______/          \______/
+ *
+ *     |-----------------|                 |--------|
+ *          60us/100us                      30us/50us
+ */
+#define PS2_CLK_FREQ_MIN_HZ		10000
+#define PS2_CLK_FREQ_MAX_HZ		16700
+#define PS2_CLK_MIN_INTERVAL_US		((1000 * 1000) / PS2_CLK_FREQ_MAX_HZ)
+#define PS2_CLK_MAX_INTERVAL_US		((1000 * 1000) / PS2_CLK_FREQ_MIN_HZ)
+#define PS2_IRQ_MIN_INTERVAL_US		(PS2_CLK_MIN_INTERVAL_US - 20)
+#define PS2_IRQ_MAX_INTERVAL_US		(PS2_CLK_MAX_INTERVAL_US + 20)
+
 struct ps2_gpio_data {
 	struct device *dev;
 	struct serio *serio;
@@ -52,6 +76,8 @@ struct ps2_gpio_data {
 	struct gpio_desc *gpio_data;
 	bool write_enable;
 	int irq;
+	ktime_t t_irq_now;
+	ktime_t t_irq_last;
 	struct ps2_gpio_data_rx {
 		unsigned char cnt;
 		unsigned char byte;
@@ -59,6 +85,8 @@ struct ps2_gpio_data {
 	struct ps2_gpio_data_tx {
 		unsigned char cnt;
 		unsigned char byte;
+		ktime_t t_xfer_start;
+		ktime_t t_xfer_end;
 		struct completion complete;
 		struct mutex mutex;
 		struct delayed_work work;
@@ -69,6 +97,9 @@ static int ps2_gpio_open(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	drvdata->t_irq_last = 0;
+	drvdata->tx.t_xfer_end = 0;
+
 	enable_irq(drvdata->irq);
 	return 0;
 }
@@ -130,6 +161,7 @@ static void ps2_gpio_tx_work_fn(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ps2_gpio_data *drvdata = to_ps2_gpio_data(dwork);
 
+	drvdata->tx.t_xfer_start = ktime_get();
 	enable_irq(drvdata->irq);
 	gpiod_direction_output(drvdata->gpio_data, 0);
 	gpiod_direction_input(drvdata->gpio_clk);
@@ -140,20 +172,30 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 	unsigned char byte, cnt;
 	int data;
 	int rxflags = 0;
-	static unsigned long old_jiffies;
+	s64 us_delta;
 
 	byte = drvdata->rx.byte;
 	cnt = drvdata->rx.cnt;
 
-	if (old_jiffies == 0)
-		old_jiffies = jiffies;
+	drvdata->t_irq_now = ktime_get();
 
-	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+	/* We need to consider spurious interrupts happening right after a TX xfer
+	 * finished.
+	 */
+	us_delta = ktime_us_delta(drvdata->t_irq_now, drvdata->tx.t_xfer_end);
+	if (unlikely(us_delta < PS2_IRQ_MIN_INTERVAL_US))
+		goto end;
+
+	us_delta = ktime_us_delta(drvdata->t_irq_now, drvdata->t_irq_last);
+	if (us_delta > PS2_IRQ_MAX_INTERVAL_US && cnt) {
 		dev_err(drvdata->dev,
 			"RX: timeout, probably we missed an interrupt\n");
 		goto err;
+	} else if (unlikely(us_delta < PS2_IRQ_MIN_INTERVAL_US)) {
+		/* Ignore spurious IRQs. */
+		goto end;
 	}
-	old_jiffies = jiffies;
+	drvdata->t_irq_last = drvdata->t_irq_now;
 
 	data = gpiod_get_value(drvdata->gpio_data);
 	if (unlikely(data < 0)) {
@@ -217,7 +259,7 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 			goto err;
 		}
 		cnt = byte = 0;
-		old_jiffies = 0;
+
 		goto end; /* success */
 	default:
 		dev_err(drvdata->dev, "RX: got out of sync with the device\n");
@@ -229,7 +271,6 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 
 err:
 	cnt = byte = 0;
-	old_jiffies = 0;
 	__ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
 end:
 	drvdata->rx.cnt = cnt;
@@ -241,20 +282,32 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 {
 	unsigned char byte, cnt;
 	int data;
-	static unsigned long old_jiffies;
+	s64 us_delta;
 
 	cnt = drvdata->tx.cnt;
 	byte = drvdata->tx.byte;
 
-	if (old_jiffies == 0)
-		old_jiffies = jiffies;
+	drvdata->t_irq_now = ktime_get();
+
+	/* There might be pending IRQs since we disabled IRQs in __ps2_gpio_write().
+	 * We can expect at least one clock period until the device generates the
+	 * first falling edge after releasing the clock line.
+	 */
+	us_delta = ktime_us_delta(drvdata->t_irq_now,
+				  drvdata->tx.t_xfer_start);
+	if (unlikely(us_delta < PS2_CLK_MIN_INTERVAL_US))
+		goto end;
 
-	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+	us_delta = ktime_us_delta(drvdata->t_irq_now, drvdata->t_irq_last);
+	if (us_delta > PS2_IRQ_MAX_INTERVAL_US && cnt > 1) {
 		dev_err(drvdata->dev,
 			"TX: timeout, probably we missed an interrupt\n");
 		goto err;
+	} else if (unlikely(us_delta < PS2_IRQ_MIN_INTERVAL_US)) {
+		/* Ignore spurious IRQs. */
+		goto end;
 	}
-	old_jiffies = jiffies;
+	drvdata->t_irq_last = drvdata->t_irq_now;
 
 	switch (cnt) {
 	case PS2_START_BIT:
@@ -295,11 +348,11 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 			goto err;
 		}
 
+		drvdata->tx.t_xfer_end = ktime_get();
 		drvdata->mode = PS2_MODE_RX;
 		complete(&drvdata->tx.complete);
 
 		cnt = 1;
-		old_jiffies = 0;
 		goto end; /* success */
 	default:
 		/* Probably we missed the stop bit. Therefore we release data
@@ -315,7 +368,6 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 
 err:
 	cnt = 1;
-	old_jiffies = 0;
 	gpiod_direction_input(drvdata->gpio_data);
 	__ps2_gpio_write(drvdata->serio, drvdata->tx.byte);
 end:
-- 
2.35.1

