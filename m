Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC40507093
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353422AbiDSOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353343AbiDSObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2731342
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:07 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378546;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqFowRIIM2M8+g8oIQx/C8ZfaouXGGsmaEPU61npqYQ=;
        b=MwSqJ6Sr3KbcQQv7XbnP32CuiS8GiDq0AvPGPdFgJf0+WLrOImFk3VEBwtEdR+KmNcSzHN
        fN+6VeaYWghepRkKtrHpKy0PsJrEHViIoRPYzjvMpdr8Ju8ksNm93tBJhe+8F1BOD+9EAN
        3EF5pBEWDlrDGb0sCYtFjAzFckz2gvjOJU8VvNm65zTPTN+1pSXhv/pNclultviI7p6cXx
        1E70PPaHAGqiASDFxlTeDcuVQT3XKzsEdrr6F/0p9miBDDs2IGi1Mc27LiRoeKlTFPla3O
        73QFij27Sr5tYDAwtD9x1S7yKtndC+c4Jsbzpvf6eaI38UeQy+/pBQK1y7IhVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378546;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqFowRIIM2M8+g8oIQx/C8ZfaouXGGsmaEPU61npqYQ=;
        b=E6rgrIgV2PnWuEOCxeiREA8d1D+mEe51jd1PG0LulXs9E8Z3FSawT0NwQb7pLpBmN4WJec
        OEvGaoZoR1Z0q3Ag==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Expose the gpiochip_irq_re[ql]res helpers
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-3-maz@kernel.org>
References: <20220419141846.598305-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854540.4207.15429511817140847503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     704f08753b6dcd0e08c1953af0b2c7f3fac87111
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/704f08753b6dcd0e08c1953af0b2c7f3fac87111
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:38 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:25 +01:00

gpio: Expose the gpiochip_irq_re[ql]res helpers

The GPIO subsystem has a couple of internal helpers to manage
resources on behalf of the irqchip. Expose them so that GPIO
drivers can use them directly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-3-maz@kernel.org
---
 drivers/gpio/gpiolib.c      | 6 ++++--
 include/linux/gpio/driver.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 48191e6..36e436a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1423,19 +1423,21 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_create_mapping(domain, offset);
 }
 
-static int gpiochip_irq_reqres(struct irq_data *d)
+int gpiochip_irq_reqres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
 	return gpiochip_reqres_irq(gc, d->hwirq);
 }
+EXPORT_SYMBOL(gpiochip_irq_reqres);
 
-static void gpiochip_irq_relres(struct irq_data *d)
+void gpiochip_irq_relres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
 	gpiochip_relres_irq(gc, d->hwirq);
 }
+EXPORT_SYMBOL(gpiochip_irq_relres);
 
 static void gpiochip_irq_mask(struct irq_data *d)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 98c9351..066bcfd 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -579,6 +579,10 @@ void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_disable_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
 
+/* irq_data versions of the above */
+int gpiochip_irq_reqres(struct irq_data *data);
+void gpiochip_irq_relres(struct irq_data *data);
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
