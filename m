Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93508467882
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381172AbhLCNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381181AbhLCNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:37 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05BC06179C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:35:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by albert.telenet-ops.be with bizsmtp
        id RpbA260083eLghq06pbAhy; Fri, 03 Dec 2021 14:35:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-002LQZ-La; Fri, 03 Dec 2021 14:35:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-000kks-8R; Fri, 03 Dec 2021 14:35:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RFC 3/3] Input: gpio-keys - Fix ghost events with both-edge irqs
Date:   Fri,  3 Dec 2021 14:35:08 +0100
Message-Id: <356b31ade897af77a06d6567601f038f56b3b2a2.1638538079.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638538079.git.geert+renesas@glider.be>
References: <cover.1638538079.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using interrupts instead of GPIOs, the driver auto-generates
key-release events, either immediately or after a delay.  This works
fine with rising-edge or falling-edge interrupts, but causes ghost
events with both-edge interrupts.  Indeed, the driver will generate a
pair of key press/release events when pressing the key, and another pair
when releasing the key.

Fix this by not auto-generating key-release events for both-edge
interrupts.  Rename release_delay to auto_release_delay to clarify its
use.

Note that unlike with GPIOs, the driver cannot know the state of the key
at initialization time, or after resume.  Hence the driver assumes the
key is not pressed at initialization time, and does not reconfigure the
trigger type for wakeup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on rskrza1.

Are these limitations acceptable? Or should users only use rising-edge
or falling-edge interrupts?
There are several existing users of IRQ_TYPE_EDGE_BOTH.
---
 drivers/input/keyboard/gpio_keys.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ab077dfb90a76ac3..dfcbedec226cb4cf 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -38,7 +38,8 @@ struct gpio_button_data {
 	unsigned short *code;
 
 	struct hrtimer release_timer;
-	unsigned int release_delay;	/* in msecs, for IRQ-only buttons */
+	int auto_release_delay;	/* in msecs, for IRQ-only buttons */
+				/* a negative value means no auto-release */
 
 	struct delayed_work work;
 	struct hrtimer debounce_timer;
@@ -474,25 +475,25 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 
 	spin_lock_irqsave(&bdata->lock, flags);
 
-	if (!bdata->key_pressed) {
+	if (!bdata->key_pressed || bdata->auto_release_delay < 0) {
 		if (bdata->button->wakeup)
 			pm_wakeup_event(bdata->input->dev.parent, 0);
 
-		input_report_key(input, *bdata->code, 1);
+		input_report_key(input, *bdata->code, !bdata->key_pressed);
 		input_sync(input);
 
-		if (!bdata->release_delay) {
+		if (!bdata->auto_release_delay) {
 			input_report_key(input, *bdata->code, 0);
 			input_sync(input);
 			goto out;
 		}
 
-		bdata->key_pressed = true;
+		bdata->key_pressed = !bdata->key_pressed;
 	}
 
-	if (bdata->release_delay)
+	if (bdata->auto_release_delay > 0)
 		hrtimer_start(&bdata->release_timer,
-			      ms_to_ktime(bdata->release_delay),
+			      ms_to_ktime(bdata->auto_release_delay),
 			      HRTIMER_MODE_REL_HARD);
 out:
 	spin_unlock_irqrestore(&bdata->lock, flags);
@@ -630,7 +631,6 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			return -EINVAL;
 		}
 
-		bdata->release_delay = button->debounce_interval;
 		hrtimer_init(&bdata->release_timer,
 			     CLOCK_REALTIME, HRTIMER_MODE_REL_HARD);
 		bdata->release_timer.function = gpio_keys_irq_timer;
@@ -638,10 +638,20 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
 
-		/*
-		 * For IRQ buttons, there is no interrupt for release.
-		 * So we don't need to reconfigure the trigger type for wakeup.
-		 */
+		if (irq_get_trigger_type(bdata->irq) == IRQ_TYPE_EDGE_BOTH) {
+			bdata->auto_release_delay = -1;
+			/*
+			 * Unlike with GPIOs, we do not know what the state of
+			 * the key is at initialization time, or after resume.
+			 * So we don't reconfigure the trigger type for wakeup.
+			 */
+		} else {
+			bdata->auto_release_delay = button->debounce_interval;
+			/*
+			 * There is no interrupt for release.  So we don't
+			 * need to reconfigure the trigger type for wakeup.
+			 */
+		}
 	}
 
 	bdata->code = &ddata->keymap[idx];
-- 
2.25.1

