Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC35A467883
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381192AbhLCNiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381185AbhLCNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:38 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C7C0617A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:35:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by albert.telenet-ops.be with bizsmtp
        id RpbA2600A3eLghq06pbAhz; Fri, 03 Dec 2021 14:35:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-002LQY-Ph; Fri, 03 Dec 2021 14:35:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-000kkk-7l; Fri, 03 Dec 2021 14:35:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] Input: gpio-keys - Use input_report_key()
Date:   Fri,  3 Dec 2021 14:35:07 +0100
Message-Id: <ec7f7eac6c603fb4b17725556cc3df87627c9a11.1638538079.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638538079.git.geert+renesas@glider.be>
References: <cover.1638538079.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the input_report_key() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/gpio_keys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index fc706918d7b103cb..ab077dfb90a76ac3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -456,7 +456,7 @@ static enum hrtimer_restart gpio_keys_irq_timer(struct hrtimer *t)
 	struct input_dev *input = bdata->input;
 
 	if (bdata->key_pressed) {
-		input_event(input, EV_KEY, *bdata->code, 0);
+		input_report_key(input, *bdata->code, 0);
 		input_sync(input);
 		bdata->key_pressed = false;
 	}
@@ -478,11 +478,11 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 		if (bdata->button->wakeup)
 			pm_wakeup_event(bdata->input->dev.parent, 0);
 
-		input_event(input, EV_KEY, *bdata->code, 1);
+		input_report_key(input, *bdata->code, 1);
 		input_sync(input);
 
 		if (!bdata->release_delay) {
-			input_event(input, EV_KEY, *bdata->code, 0);
+			input_report_key(input, *bdata->code, 0);
 			input_sync(input);
 			goto out;
 		}
-- 
2.25.1

