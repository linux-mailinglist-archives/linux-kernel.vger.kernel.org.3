Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E314F4B28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573934AbiDEWxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443182AbiDEPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6D147518;
        Tue,  5 Apr 2022 06:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E3E6190C;
        Tue,  5 Apr 2022 13:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDFCC385A7;
        Tue,  5 Apr 2022 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166901;
        bh=WJDtWZlx8PhCLSQbiQxyxwVjD8Kor4/GI5UPPJoh1tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7sO+dfP4ImhYMQerSrgVvrKvDHH0K1NUbkRU3Tead6/Q57oB2bNx0OvgVFPFQqr7
         IuL0Q7hWkOQpY8BWqat0kIhKOCCniqIIWIDl//iqs/khijBRdC9mYmS07SRfiv/Lyb
         pIAH3gtNl99wtf5VHao4vwWH5ZhKa8/A5N3kQxsFsjH9XDXGYJdUbq0hunie9Qjb77
         EUx264vcf4L+HHqBd1R/+tBOA3J0n7qMytgfPvgIMt3TLVd+WYhly/NW2yBoaBSIk0
         eOgGVmAYN8kE8jP4EsimmLZtoeanauBM98gWg1EZdqS3cU4o6BNCiapbB5ciCUHdp4
         CL6RZBd/HFADQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbje7-001q4g-Oi; Tue, 05 Apr 2022 14:54:59 +0100
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
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 02/10] gpio: Expose the gpiochip_irq_re[ql]res helpers
Date:   Tue,  5 Apr 2022 14:54:36 +0100
Message-Id: <20220405135444.199295-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
References: <20220405135444.199295-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
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
index 48191e62a3cc..36e436a66e09 100644
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
index 98c93510640e..066bcfdf878d 100644
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
-- 
2.34.1

