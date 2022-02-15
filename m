Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D234B724C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiBOQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:02:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiBOQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:02:32 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F365BA;
        Tue, 15 Feb 2022 08:02:20 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 1/4] input: ps2-gpio: refactor struct ps2_gpio_data
Date:   Tue, 15 Feb 2022 17:02:05 +0100
Message-Id: <20220215160208.34826-2-danilokrummrich@dk-develop.de>
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

Refactor struct ps2_gpio_data in order to clearly separate RX and TX
state data.

This change intends to increase code readability and does not bring any
functional change.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/input/serio/ps2-gpio.c | 70 ++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 8970b49ea09a..5f68505dd473 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -52,13 +52,17 @@ struct ps2_gpio_data {
 	struct gpio_desc *gpio_data;
 	bool write_enable;
 	int irq;
-	unsigned char rx_cnt;
-	unsigned char rx_byte;
-	unsigned char tx_cnt;
-	unsigned char tx_byte;
-	struct completion tx_done;
-	struct mutex tx_mutex;
-	struct delayed_work tx_work;
+	struct ps2_gpio_data_rx {
+		unsigned char cnt;
+		unsigned char byte;
+	} rx;
+	struct ps2_gpio_data_tx {
+		unsigned char cnt;
+		unsigned char byte;
+		struct completion complete;
+		struct mutex mutex;
+		struct delayed_work work;
+	} tx;
 };
 
 static int ps2_gpio_open(struct serio *serio)
@@ -73,7 +77,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
-	flush_delayed_work(&drvdata->tx_work);
+	flush_delayed_work(&drvdata->tx.work);
 	disable_irq(drvdata->irq);
 }
 
@@ -85,9 +89,9 @@ static int __ps2_gpio_write(struct serio *serio, unsigned char val)
 	gpiod_direction_output(drvdata->gpio_clk, 0);
 
 	drvdata->mode = PS2_MODE_TX;
-	drvdata->tx_byte = val;
+	drvdata->tx.byte = val;
 
-	schedule_delayed_work(&drvdata->tx_work, usecs_to_jiffies(200));
+	schedule_delayed_work(&drvdata->tx.work, usecs_to_jiffies(200));
 
 	return 0;
 }
@@ -98,12 +102,12 @@ static int ps2_gpio_write(struct serio *serio, unsigned char val)
 	int ret = 0;
 
 	if (in_task()) {
-		mutex_lock(&drvdata->tx_mutex);
+		mutex_lock(&drvdata->tx.mutex);
 		__ps2_gpio_write(serio, val);
-		if (!wait_for_completion_timeout(&drvdata->tx_done,
+		if (!wait_for_completion_timeout(&drvdata->tx.complete,
 						 msecs_to_jiffies(10000)))
 			ret = SERIO_TIMEOUT;
-		mutex_unlock(&drvdata->tx_mutex);
+		mutex_unlock(&drvdata->tx.mutex);
 	} else {
 		__ps2_gpio_write(serio, val);
 	}
@@ -111,12 +115,20 @@ static int ps2_gpio_write(struct serio *serio, unsigned char val)
 	return ret;
 }
 
+static inline struct ps2_gpio_data *
+to_ps2_gpio_data(struct delayed_work *dwork)
+{
+	struct ps2_gpio_data_tx *txd = container_of(dwork,
+						    struct ps2_gpio_data_tx,
+						    work);
+
+	return container_of(txd, struct ps2_gpio_data, tx);
+}
+
 static void ps2_gpio_tx_work_fn(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
-	struct ps2_gpio_data *drvdata = container_of(dwork,
-						    struct ps2_gpio_data,
-						    tx_work);
+	struct ps2_gpio_data *drvdata = to_ps2_gpio_data(dwork);
 
 	enable_irq(drvdata->irq);
 	gpiod_direction_output(drvdata->gpio_data, 0);
@@ -130,8 +142,8 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 	int rxflags = 0;
 	static unsigned long old_jiffies;
 
-	byte = drvdata->rx_byte;
-	cnt = drvdata->rx_cnt;
+	byte = drvdata->rx.byte;
+	cnt = drvdata->rx.cnt;
 
 	if (old_jiffies == 0)
 		old_jiffies = jiffies;
@@ -220,8 +232,8 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 	old_jiffies = 0;
 	__ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
 end:
-	drvdata->rx_cnt = cnt;
-	drvdata->rx_byte = byte;
+	drvdata->rx.cnt = cnt;
+	drvdata->rx.byte = byte;
 	return IRQ_HANDLED;
 }
 
@@ -231,8 +243,8 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 	int data;
 	static unsigned long old_jiffies;
 
-	cnt = drvdata->tx_cnt;
-	byte = drvdata->tx_byte;
+	cnt = drvdata->tx.cnt;
+	byte = drvdata->tx.byte;
 
 	if (old_jiffies == 0)
 		old_jiffies = jiffies;
@@ -284,7 +296,7 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 		}
 
 		drvdata->mode = PS2_MODE_RX;
-		complete(&drvdata->tx_done);
+		complete(&drvdata->tx.complete);
 
 		cnt = 1;
 		old_jiffies = 0;
@@ -305,9 +317,9 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 	cnt = 1;
 	old_jiffies = 0;
 	gpiod_direction_input(drvdata->gpio_data);
-	__ps2_gpio_write(drvdata->serio, drvdata->tx_byte);
+	__ps2_gpio_write(drvdata->serio, drvdata->tx.byte);
 end:
-	drvdata->tx_cnt = cnt;
+	drvdata->tx.cnt = cnt;
 	return IRQ_HANDLED;
 }
 
@@ -403,11 +415,11 @@ static int ps2_gpio_probe(struct platform_device *pdev)
 	/* Tx count always starts at 1, as the start bit is sent implicitly by
 	 * host-to-device communication initialization.
 	 */
-	drvdata->tx_cnt = 1;
+	drvdata->tx.cnt = 1;
 
-	INIT_DELAYED_WORK(&drvdata->tx_work, ps2_gpio_tx_work_fn);
-	init_completion(&drvdata->tx_done);
-	mutex_init(&drvdata->tx_mutex);
+	INIT_DELAYED_WORK(&drvdata->tx.work, ps2_gpio_tx_work_fn);
+	init_completion(&drvdata->tx.complete);
+	mutex_init(&drvdata->tx.mutex);
 
 	serio_register_port(serio);
 	platform_set_drvdata(pdev, drvdata);
-- 
2.35.1

