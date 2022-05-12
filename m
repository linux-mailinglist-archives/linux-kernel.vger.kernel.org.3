Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1392525274
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356441AbiELQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356435AbiELQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:23:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1671E5EF6;
        Thu, 12 May 2022 09:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB91EB82910;
        Thu, 12 May 2022 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33602C385B8;
        Thu, 12 May 2022 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652372606;
        bh=ayDGTSbvOD0tdrbfv4NKgk8mgGeMGHbuLc4H/PqcZjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JE+rxu5jRBMrizoydjSF8Uh73G48X0pYfddSBcucZekWgGiw05GhmDs69PoBQ2RR6
         CUSAf9XTY2D2/KGxc268qYRv1cdAHUjOkEZd7T0crsmOP3UIDCliQbVBVOJB/NNSdr
         oGWKqVF68iSGVnbOaDTIZc1OM4iT9OijXrRWQmdhsBDScDcQ6KGRLsiZXK8c0OsHdA
         0NrI5uocM9UuEtVVBsqwTEvTHBDSga60Ju6GTAdehCl6lzHBI0FoEu7AVq/lSSMFtA
         YNe8Rz0uSLD//QGLHgXSV7dtgtunjjDqTtFh4+WuIZnzXsZNZC9aWcKu2PhbWG2PHq
         YmpEMj20zpcEA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1npBb1-00AvqB-Ix; Thu, 12 May 2022 17:23:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     kernel-team@android.com, Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Richter <rric@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] gpio: Remove dynamic allocation from populate_parent_alloc_arg()
Date:   Thu, 12 May 2022 17:23:20 +0100
Message-Id: <20220512162320.2213488-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com, daniel@thingy.jp, romain.perier@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, jonathanh@nvidia.com, rric@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp, agross@kernel.org, bjorn.andersson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpiolib is unique in the way it uses intermediate fwspecs
when feeding an interrupt specifier to the parent domain, as it
relies on the populate_parent_alloc_arg() callback to perform
a dynamic allocation.

THis is pretty inefficient (we free the structure almost immediately),
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

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Robert Richter <rric@kernel.org>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpio/gpio-msc313.c               | 15 ++++-----
 drivers/gpio/gpio-tegra.c                | 15 ++++-----
 drivers/gpio/gpio-tegra186.c             | 15 ++++-----
 drivers/gpio/gpio-thunderx.c             | 15 ++++-----
 drivers/gpio/gpio-visconti.c             | 15 ++++-----
 drivers/gpio/gpiolib.c                   | 42 ++++++++++--------------
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 15 ++++-----
 include/linux/gpio/driver.h              | 42 +++++++++++-------------
 8 files changed, 73 insertions(+), 101 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index b2c90bdd39d0..52d7b8d99170 100644
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
index ff2d2a1f9c73..e4fb4cb38a0f 100644
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
index 84c4f1e9fb0c..9beb689cffbc 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -547,16 +547,13 @@ static int tegra186_gpio_irq_domain_translate(struct irq_domain *domain,
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
@@ -564,7 +561,7 @@ static void *tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	fwspec->param[1] = parent_hwirq;
 	fwspec->param[2] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 
 static int tegra186_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46ea..e1dedbca0c85 100644
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
index 47455810bdb9..1d281156ca2a 100644
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
index c813a6adbb6e..ed26608fc93a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1113,7 +1113,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	struct irq_fwspec *fwspec = data;
-	void *parent_arg;
+	union gpio_irq_fwspec gpio_parent_fwspec = {};
 	unsigned int parent_hwirq;
 	unsigned int parent_type;
 	struct gpio_irq_chip *girq = &gc->irq;
@@ -1153,14 +1153,15 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
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
@@ -1172,7 +1173,6 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 			 "failed to allocate parent hwirq %d for hwirq %lu\n",
 			 parent_hwirq, hwirq);
 
-	kfree(parent_arg);
 	return ret;
 }
 
@@ -1236,34 +1236,28 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
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
@@ -1272,7 +1266,7 @@ void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
 	fwspec->param[2] = 0;
 	fwspec->param[3] = parent_type;
 
-	return fwspec;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_fourcell);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4fbf8d3938ef..6d27d1b00ddf 100644
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
index cb689264f3e9..600b3af1320f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -11,6 +11,8 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#include <asm/msi.h>
+
 struct gpio_desc;
 struct of_phandle_args;
 struct device_node;
@@ -22,6 +24,13 @@ enum gpio_lookup_flags;
 
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
 
@@ -102,9 +111,10 @@ struct gpio_irq_chip {
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
@@ -623,28 +633,14 @@ struct bgpio_pdata {
 
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
 
-- 
2.34.1

