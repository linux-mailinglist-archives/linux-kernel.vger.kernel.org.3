Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000E4C176C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbiBWPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiBWPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:44:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3BEBF962;
        Wed, 23 Feb 2022 07:44:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27570B820C9;
        Wed, 23 Feb 2022 15:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE5C340F4;
        Wed, 23 Feb 2022 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645631063;
        bh=Qfdv6adW74CN704wOxVv3M2DoN5MT3Ou0BkWhDGVEyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPiA2G1VQMiKzHixzoxIVSA8sDLUzgBQ7SskBO4Sr51RGpDl/lqZNxmO9CvJGe50n
         z8ABeO1WumlYLrKX/lcRdlIh20cVGMyd4uCnCuOX2SoQyCW2t36GKA9Er/aSAsO53u
         7yD5rqlSdf3zXxx6V9jsZFSBcmSOMCzs+/5cwFJJH7iF7iRRQmmzUTCA7R3c5HX+c1
         XTaVLThvgFHIGJRSev/v7o+xGZbeDo7Ne/kBPQIY3NnFjBxklYVzD9tREZh0HBE780
         WsXgjDUwxWxMZfnPEpF09ZkWrnhIzBgbdHFc/MwMN5V1naLh3xP6RnjoFefySWPSFj
         fnzIz9HDsHlNQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nMtoT-009wgt-P3; Wed, 23 Feb 2022 15:44:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 2/5] gpio: Expose the gpiochip_irq_re[ql]res helpers
Date:   Wed, 23 Feb 2022 15:44:02 +0000
Message-Id: <20220223154405.54912-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223154405.54912-1-maz@kernel.org>
References: <20220223154405.54912-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO subsystem has a couple of internal helpers to manage
resources on behalf of the irqchip. Expose them so that GPIO
drivers can use them directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpiolib.c      | 6 ++++--
 include/linux/gpio/driver.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 515838708b00..408ff8f262d3 100644
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
index b0728c8ad90c..89291c02854d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -576,6 +576,10 @@ void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_disable_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
 
+/* irq_data versions of the above */
+int gpiochip_irq_reqres(struct irq_data *data);
+void gpiochip_irq_relres(struct irq_data *data);
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
-- 
2.30.2

