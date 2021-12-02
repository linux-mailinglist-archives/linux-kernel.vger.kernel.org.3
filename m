Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1C466734
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359229AbhLBPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347573AbhLBPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:54:19 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D44EC06174A;
        Thu,  2 Dec 2021 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=OY2zTbK1ie6cFTyrDOMcePVtS2yQyfQeUBoaSJjVJcY=; b=o+
        7M2AA4ymceZJiSU6SXW4kEaI2rwGKYlRf6gYKbZ5BpOOdVsMx53fkyJZZi5VhgllO7tfXLD1BHgpc
        6hMDEGwMK9/ch9qS/6M2sNd1r8N5axFUlfuUuD1vz2DuSObNiU53Fi8qtDmtMHTvGrTGIxPbv4rdP
        kw/CnRQ/KxJUBFJWRbY52ERZzIZlJ9OM2tWDKTWzOt5n/Jn0vheYWU6sdZtrmH8tq3ecJQffsqPec
        G6ZIritKwllHEnTGmRF2WgM1yjRz4E4gAJ9qMCxZN627PHzQnIWsbaM94rm8coS3aRNqcNnwnhdu2
        SmW6rdq6LJ7HW4YmgQ9+S+hrc1paCF4Q==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1msoMH-0001G2-Fy; Thu, 02 Dec 2021 15:50:53 +0000
From:   John Keeping <john@metanate.com>
To:     linux-gpio@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio/rockchip: lock GPIOs used as interrupts
Date:   Thu,  2 Dec 2021 15:50:21 +0000
Message-Id: <20211202155022.2972779-1-john@metanate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard gpiochip request/release resource functions so that any
GPIOs used as interrupts are properly locked.  This allows libgpiod to
correctly show these GPIOs as in-use.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpio/gpio-rockchip.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index ce63cbd14d69a..c1b8e5dbbcc47 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -465,6 +465,22 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	return ret;
 }
 
+static int rockchip_irq_reqres(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank = gc->private;
+
+	return gpiochip_reqres_irq(&bank->gpio_chip, d->hwirq);
+}
+
+static void rockchip_irq_relres(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank = gc->private;
+
+	gpiochip_relres_irq(&bank->gpio_chip, d->hwirq);
+}
+
 static void rockchip_irq_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -536,6 +552,8 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
 	gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
 	gc->chip_types[0].chip.irq_set_type = rockchip_irq_set_type;
+	gc->chip_types[0].chip.irq_request_resources = rockchip_irq_reqres;
+	gc->chip_types[0].chip.irq_release_resources = rockchip_irq_relres;
 	gc->wake_enabled = IRQ_MSK(bank->nr_pins);
 
 	/*
-- 
2.34.1

