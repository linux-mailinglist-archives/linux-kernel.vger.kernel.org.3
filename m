Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5121B56CE06
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiGJImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGJImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:42:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0061618E28
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 01:42:08 -0700 (PDT)
Date:   Sun, 10 Jul 2022 08:42:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657442527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0aU2uK6Hq00aRiUHF1Fs4fQmJNx4UYc4lRlnh+YOhM=;
        b=r7NYq3bDZ3G/gWFDC9Gl6JwaFffjNxpQ/4Qj7yFqJghx0iDjlE08+vKWF5xZ5n2D4+b/9J
        lyyZ6rlrm79kXTqLHAxPxDXMbQ0t86+CVfNcJTPQ7zeDmlCFUbZy4eyWIriTCLUekax6is
        caINwN9Drm2b924ofsV052QkMiYOWYGUSLSVpDOA5raKl1DEOrByXzXIzrNqSW98WJdVjn
        R9z0AV90IqNVvogxv9vIWVbpnFDzndy/AbZsVnZLSP52anqL0OrG4OjjSq4Xk3yoaTCTkC
        s5wuS4udwtXCG4dGFZpkaNbbV73+mDwYzyuvCBxQZGeIJazWzDQ+WgI3bsi1nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657442527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0aU2uK6Hq00aRiUHF1Fs4fQmJNx4UYc4lRlnh+YOhM=;
        b=ebQUz0MOkbI+prZOesu7ynAAHdKUmVh07mxEHxw4f+IJyztnD41jSxpkJhEpS7qos1h3yH
        wpBvI6elqCCOZ1Dg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Remove dynamic allocation from
 populate_parent_alloc_arg()
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Richter <rric@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        tglx@linutronix.de
In-Reply-To: <20220707182314.66610-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165744252632.15455.17437610971796524721.tip-bot2@tip-bot2>
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

Commit-ID:     91a29af413def677495e447fb9a06957ebc8bed5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/91a29af413def677495e447fb9a06957ebc8bed5
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 07 Jul 2022 19:23:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Jul 2022 09:30:00 +01:00

gpio: Remove dynamic allocation from populate_parent_alloc_arg()

The gpiolib is unique in the way it uses intermediate fwspecs
when feeding an interrupt specifier to the parent domain, as it
relies on the populate_parent_alloc_arg() callback to perform
a dynamic allocation.

This is pretty inefficient (we free the structure almost immediately),
and the only reason this isn't a stack allocation is that our
ThunderX friend uses MSIs rather than a FW-constructed structure.

Let's solve it by providing a new type composed of the union
of a struct irq_fwspec and a msi_info_t, which satisfies both
requirements. This allows us to use a stack allocation, and we
can move the handful of users to this new scheme.

Also perform some additional cleanup, such as getting rid of the
stub versions of the irq_domain_translate_*cell helpers, which
are never used when CONFIG_IRQ_DOMAIN_HIERARCHY isn't selected.

Tested on a Tegra186.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Robert Richter <rric@kernel.org>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220707182314.66610-2-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 drivers/gpio/gpio-msc313.c               | 15 +++-----
 drivers/gpio/gpio-tegra.c                | 15 +++-----
 drivers/gpio/gpio-tegra186.c             | 15 +++-----
 drivers/gpio/gpio-thunderx.c             | 15 +++-----
 drivers/gpio/gpio-visconti.c             | 15 +++-----
 drivers/gpio/gpiolib.c                   | 42 +++++++++--------------
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 15 +++-----
 include/linux/gpio/driver.h              | 42 ++++++++++-------------
 8 files changed, 73 insertions(+), 101 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index b2c90bd..52d7b8d 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -550,15 +550,12 @@ static struct irq_chip msc313_gpio_irqchip = {
  * so we need to provide the fwspec. Essentially gpiochip_populate_parent_fwspec_twocell
  * that puts GIC_SPI into the first cell.
  */
-static void *msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+static int msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
+					      union gpio_irq_fwspec *gfwspec,
+					      unsigned int parent_hwirq,
+					      unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = gc->irq.parent_domain->fwnode;
 	fwspec->param_count = 3;
@@ -566,7 +563,7 @@ static void *msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
 	fwspec->param[1] = parent_hwirq;
 	fwspec->param[2] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 static int msc313e_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ff2d2a1..e4fb4cb 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -443,15 +443,12 @@ static int tegra_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
 	return 0;
 }
 
-static void *tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					       unsigned int parent_hwirq,
-					       unsigned int parent_type)
+static int tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+					     union gpio_irq_fwspec *gfwspec,
+					     unsigned int parent_hwirq,
+					     unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = chip->irq.parent_domain->fwnode;
 	fwspec->param_count = 3;
@@ -459,7 +456,7 @@ static void *tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	fwspec->param[1] = parent_hwirq;
 	fwspec->param[2] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index de28a68..54d9fa7 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -621,16 +621,13 @@ static int tegra186_gpio_irq_domain_translate(struct irq_domain *domain,
 	return 0;
 }
 
-static void *tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-						 unsigned int parent_hwirq,
-						 unsigned int parent_type)
+static int tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+						union gpio_irq_fwspec *gfwspec,
+						unsigned int parent_hwirq,
+						unsigned int parent_type)
 {
 	struct tegra_gpio *gpio = gpiochip_get_data(chip);
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = chip->irq.parent_domain->fwnode;
 	fwspec->param_count = 3;
@@ -638,7 +635,7 @@ static void *tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	fwspec->param[1] = parent_hwirq;
 	fwspec->param[2] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 static int tegra186_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66dea..e1dedbc 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -408,18 +408,15 @@ static int thunderx_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	return 0;
 }
 
-static void *thunderx_gpio_populate_parent_alloc_info(struct gpio_chip *chip,
-						      unsigned int parent_hwirq,
-						      unsigned int parent_type)
+static int thunderx_gpio_populate_parent_alloc_info(struct gpio_chip *chip,
+						    union gpio_irq_fwspec *gfwspec,
+						    unsigned int parent_hwirq,
+						    unsigned int parent_type)
 {
-	msi_alloc_info_t *info;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return NULL;
+	msi_alloc_info_t *info = &gfwspec->msiinfo;
 
 	info->hwirq = parent_hwirq;
-	return info;
+	return 0;
 }
 
 static int thunderx_gpio_probe(struct pci_dev *pdev,
diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index e6534ea..5e108ba 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -103,15 +103,12 @@ static int visconti_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	return -EINVAL;
 }
 
-static void *visconti_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-						  unsigned int parent_hwirq,
-						  unsigned int parent_type)
+static int visconti_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+						union gpio_irq_fwspec *gfwspec,
+						unsigned int parent_hwirq,
+						unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = chip->irq.parent_domain->fwnode;
 	fwspec->param_count = 3;
@@ -119,7 +116,7 @@ static void *visconti_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	fwspec->param[1] = parent_hwirq;
 	fwspec->param[2] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 static int visconti_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9535f48..bfde942 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1107,7 +1107,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	struct irq_fwspec *fwspec = data;
-	void *parent_arg;
+	union gpio_irq_fwspec gpio_parent_fwspec = {};
 	unsigned int parent_hwirq;
 	unsigned int parent_type;
 	struct gpio_irq_chip *girq = &gc->irq;
@@ -1147,14 +1147,15 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	irq_set_probe(irq);
 
 	/* This parent only handles asserted level IRQs */
-	parent_arg = girq->populate_parent_alloc_arg(gc, parent_hwirq, parent_type);
-	if (!parent_arg)
-		return -ENOMEM;
+	ret = girq->populate_parent_alloc_arg(gc, &gpio_parent_fwspec,
+					      parent_hwirq, parent_type);
+	if (ret)
+		return ret;
 
 	chip_dbg(gc, "alloc_irqs_parent for %d parent hwirq %d\n",
 		  irq, parent_hwirq);
 	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
-	ret = irq_domain_alloc_irqs_parent(d, irq, 1, parent_arg);
+	ret = irq_domain_alloc_irqs_parent(d, irq, 1, &gpio_parent_fwspec);
 	/*
 	 * If the parent irqdomain is msi, the interrupts have already
 	 * been allocated, so the EEXIST is good.
@@ -1166,7 +1167,6 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 			 "failed to allocate parent hwirq %d for hwirq %lu\n",
 			 parent_hwirq, hwirq);
 
-	kfree(parent_arg);
 	return ret;
 }
 
@@ -1230,34 +1230,28 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
 	return !!gc->irq.parent_domain;
 }
 
-void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+int gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = gc->irq.parent_domain->fwnode;
 	fwspec->param_count = 2;
 	fwspec->param[0] = parent_hwirq;
 	fwspec->param[1] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_twocell);
 
-void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
-					      unsigned int parent_hwirq,
-					      unsigned int parent_type)
+int gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
+					     union gpio_irq_fwspec *gfwspec,
+					     unsigned int parent_hwirq,
+					     unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec = kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = gc->irq.parent_domain->fwnode;
 	fwspec->param_count = 4;
@@ -1266,7 +1260,7 @@ void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
 	fwspec->param[2] = 0;
 	fwspec->param[3] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_fourcell);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index fd5fff9..3be2a08 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -966,16 +966,13 @@ static int pmic_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
 	return 0;
 }
 
-static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+static int pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type)
 {
 	struct pmic_gpio_state *state = gpiochip_get_data(chip);
-	struct irq_fwspec *fwspec;
-
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec = &gfwspec->fwspec;
 
 	fwspec->fwnode = chip->irq.parent_domain->fwnode;
 
@@ -985,7 +982,7 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	/* param[2] must be left as 0 */
 	fwspec->param[3] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 static int pmic_gpio_probe(struct platform_device *pdev)
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b1e0f1f..ad5b92b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -12,6 +12,8 @@
 #include <linux/property.h>
 #include <linux/types.h>
 
+#include <asm/msi.h>
+
 struct gpio_desc;
 struct of_phandle_args;
 struct device_node;
@@ -23,6 +25,13 @@ enum gpio_lookup_flags;
 
 struct gpio_chip;
 
+union gpio_irq_fwspec {
+	struct irq_fwspec	fwspec;
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	msi_alloc_info_t	msiinfo;
+#endif
+};
+
 #define GPIO_LINE_DIRECTION_IN	1
 #define GPIO_LINE_DIRECTION_OUT	0
 
@@ -103,9 +112,10 @@ struct gpio_irq_chip {
 	 * variant named &gpiochip_populate_parent_fwspec_fourcell is also
 	 * available.
 	 */
-	void *(*populate_parent_alloc_arg)(struct gpio_chip *gc,
-				       unsigned int parent_hwirq,
-				       unsigned int parent_type);
+	int (*populate_parent_alloc_arg)(struct gpio_chip *gc,
+					 union gpio_irq_fwspec *fwspec,
+					 unsigned int parent_hwirq,
+					 unsigned int parent_type);
 
 	/**
 	 * @child_offset_to_irq:
@@ -646,28 +656,14 @@ struct bgpio_pdata {
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 
-void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+int gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type);
+int gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
+					     union gpio_irq_fwspec *gfwspec,
 					     unsigned int parent_hwirq,
 					     unsigned int parent_type);
-void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
-					      unsigned int parent_hwirq,
-					      unsigned int parent_type);
-
-#else
-
-static inline void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
-						    unsigned int parent_hwirq,
-						    unsigned int parent_type)
-{
-	return NULL;
-}
-
-static inline void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
-						     unsigned int parent_hwirq,
-						     unsigned int parent_type)
-{
-	return NULL;
-}
 
 #endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
