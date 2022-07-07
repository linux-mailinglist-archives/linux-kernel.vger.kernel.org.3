Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4C56AA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiGGSYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiGGSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:24:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF52F02E;
        Thu,  7 Jul 2022 11:24:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a15so21014340pfv.13;
        Thu, 07 Jul 2022 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSl71Hk0BnT10NJnLI+ezCAWxmiJgLAkOV3Buo9ULGk=;
        b=VzP8hyDh6QNCMC3TKLzAt458raLYFpDYGfyszwQftA212O0NHmyP4ioT00sB2b8S/C
         6WV8doEI3U8UUrCW57uTUp7+JoTEhRdolIolfIzKUvZuqyyNXI5oY0vGkijfYqhXOzTK
         9f8fccaGB15o2/fRoRWJxpj0SAkQV4vUvodnx9+9syhI2BIa1BgXvwdoTeRwyPIjGj/E
         liwKTly6yl0DFNZa2rszHTQxwcWnf2RRThNjQUuH1BPoF4lEYkn4rBXQRypDLZw78HSV
         3oHLuweaBhoC+UmH0t+YZjTZQdaL+dyvK48NhI6gPtN6lVXEd0LhDjIQ1yA9yNVG+FLy
         0Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSl71Hk0BnT10NJnLI+ezCAWxmiJgLAkOV3Buo9ULGk=;
        b=wCXujsIKIlhUi/P3d8NUpU5aJY5ru24B4GOzaVrrA5gvCO0Dr7VxKmSFOwO6QEV05T
         3thfidDYDGlKGV1hRC+rBFFTKfiFghUJXC9q1yp4Wl64gooRjqeWeCRz5hZPaGAbKtwc
         neGI6B3HtK3B6RjacZK2C2tXKMIXTqiuz4i+BcBQiI1BiUwdF75yAlyD5PpYBnqIqdok
         CKhDQnfIqhsnWGHE8SLoQ8YsU8TzPAZjYe2SihXwpdIDS82+LCbJaO2p4bD/qctWXRui
         nR8DRW8FtTi5+it3D29BV/UXM578fihTfIWakIGVBNsBPondQ4rZl2XM7t5o13BsDVhS
         59vg==
X-Gm-Message-State: AJIora/MS0aX7lW1pw6mwDax15+Gqk3bpPT3Zyv31bh1/FhAjsx/h3yv
        oDexDu6I7flw6MKH3lTuynk=
X-Google-Smtp-Source: AGRyM1tPzGVr0Gv2TzaayGf6N5V5wiN70w72ancH39Az0FN3B4wMyUwrCwa2Au+ek10FwXP1szP/9g==
X-Received: by 2002:a63:f405:0:b0:40d:48c1:e32d with SMTP id g5-20020a63f405000000b0040d48c1e32dmr38803677pgi.25.1657218281959;
        Thu, 07 Jul 2022 11:24:41 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.85])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm28589279plg.148.2022.07.07.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:24:41 -0700 (PDT)
From:   prabhakar.csengg@gmail.com
X-Google-Original-From: prabhakar.mahadev-lad.rj@bp.renesas.com
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Richter <rric@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v8 1/6] gpio: Remove dynamic allocation from populate_parent_alloc_arg()
Date:   Thu,  7 Jul 2022 19:23:09 +0100
Message-Id: <20220707182314.66610-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

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
index de28a68daea0..54d9fa7da9c1 100644
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
index e6534ea1eaa7..5e108ba9956a 100644
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
index 9535f48e18d1..bfde94243752 100644
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
index fd5fff9adff0..3be2a08ae3a6 100644
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
index 54c3c6506503..6aeea1071b1b 100644
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
@@ -649,28 +659,14 @@ struct bgpio_pdata {
 
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
2.25.1

