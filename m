Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A514F44E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353302AbiDEUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443193AbiDEPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5287147AC6;
        Tue,  5 Apr 2022 06:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2940DB81BA3;
        Tue,  5 Apr 2022 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB8FC385A8;
        Tue,  5 Apr 2022 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166901;
        bh=VQT9QjB08IDzgtp+NOGCbEMHe3R/wkFrqbmn4S0oJGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K++dJ+SVAnTf3m6paasV0tDfYHhFre6VydI/IpAf9fgWFZDIsYhbdJJFCnuhVMslY
         j9BFeLEZbWpZdr3F3GipAaetDHRDs/MtzVGnCkngeZBECmCGLNnhsKEvjGqcfq5rA2
         KN9JvigjywPgtoHvrMWUJwm7dIPrnoZWMHN1Y4s3llYtFsZIt+fSCqzTjkf3ZsZVI+
         z9VKU1D4MTFsih1vd2L8tSSOZ38X3g3uKByIdKz3y0J/3ltwzEcZNfzAZ0ICf1XLhR
         ibHlVT2myKS/unUwXlhOJJmJxqimyO/OgpQKvIdqnygCHwK1sESbuau2HCGdMGEiBv
         VGSDGOjA2kU1g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbje7-001q4g-EZ; Tue, 05 Apr 2022 14:54:59 +0100
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
Subject: [PATCH v2 01/10] gpio: Don't fiddle with irqchips marked as immutable
Date:   Tue,  5 Apr 2022 14:54:35 +0100
Message-Id: <20220405135444.199295-2-maz@kernel.org>
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

In order to move away from gpiolib messing with the internals of
unsuspecting irqchips, add a flag by which irqchips advertise
that they are not to be messed with, and do solemnly swear that
they correctly call into the gpiolib helpers when required.

Also nudge the users into converting their drivers to the
new model.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 include/linux/irq.h    | 2 ++
 kernel/irq/debugfs.c   | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e59884cc12a7..48191e62a3cc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1475,6 +1475,11 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
 {
 	struct irq_chip *irqchip = gc->irq.chip;
 
+	if (irqchip->flags & IRQCHIP_IMMUTABLE)
+		return;
+
+	chip_warn(gc, "not an immutable chip, please consider fixing it!\n");
+
 	if (!irqchip->irq_request_resources &&
 	    !irqchip->irq_release_resources) {
 		irqchip->irq_request_resources = gpiochip_irq_reqres;
@@ -1633,7 +1638,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 		irq_domain_remove(gc->irq.domain);
 	}
 
-	if (irqchip) {
+	if (irqchip && !(irqchip->flags & IRQCHIP_IMMUTABLE)) {
 		if (irqchip->irq_request_resources == gpiochip_irq_reqres) {
 			irqchip->irq_request_resources = NULL;
 			irqchip->irq_release_resources = NULL;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788ccdba2..505308253d23 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -569,6 +569,7 @@ struct irq_chip {
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
+ * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -582,6 +583,7 @@ enum {
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
+	IRQCHIP_IMMUTABLE			= (1 << 11),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 2b43f5f5033d..bc8e40cf2b65 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
 };
 
 static void
-- 
2.34.1

