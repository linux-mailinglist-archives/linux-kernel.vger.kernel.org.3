Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31BB466392
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357940AbhLBMZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358184AbhLBMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:25:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F0C061397
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:21:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4530320pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 04:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jM9EApcDDLI/s4BAHO7HR69hLfkrMUsostlIb7EIuxg=;
        b=U7/YUXtgHem9eXajI+v+rSaRM7u8XID5Tbk6B90kTtSQCXH83aJ75/XO5L5o62CLlW
         Z1BSR5Qc7BlGi3JlATqJ0dauoWKRgkK/5Mp+DFzEAUpQcn2z/uEMpo587id/byiDhWL2
         U7+G/sAqhsFHuB5H+xadhszDaGT1Lm+xRaTjCZSHF95x6DSyd1rNN4nWv9WeCCoGcRQi
         Hqta+AMezDOGbKBCvbK4G8YhU4UY2ZEpEzEGGz7upPZ3z54ZLNzvTQsAbIIjDl4m5tgn
         hoUT0ycmK6rDCAdZgYpGEnLueKGQJcg/IB8P/rwkpxQGeSMqrHPpSrWYuAhwEju7a/0Z
         gcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jM9EApcDDLI/s4BAHO7HR69hLfkrMUsostlIb7EIuxg=;
        b=Lv2wCyuIWG+yVdGAYgej4yQuF4NhYVWptyK8VHsLH2AEa4ftwYeOGnV1qNjpkZVn/d
         fZ5NhetLlNX+0bkePURTWZIp2bgF6ezvLAFBLGtHzSRXAtOEu3BlOfUaSWSeFeMSFEE2
         MrzSE7J45IfCYwTzB0HzW1h9ul3Q41uZ5jDKlKZo8g0KMt7CoXmdi5Rinrsf75koeNxF
         O9YdRypaWQUqbZVCUdsluacZER9fQcLeGYjul0XqoSffTGG9bzYQjuaFkKXJrALSknvc
         9hAjC0J+UYKnMS71mL3YAyVxwRnS5ZaCMaDAwnDSkL+Z74+ysBA9PY8Le+jJ9ojb6LCd
         mwOQ==
X-Gm-Message-State: AOAM530GNgIFb+cHyHGO8rQqnCv/2QsBeo2NSbxQP1Jh1E0//eHLRdCr
        AvxxAFc8W+S3HEAl+Jj1nkamkw==
X-Google-Smtp-Source: ABdhPJzvJ9WrT4ikb15JxTPqXu4k1bO63dWrJr6KPRpZOUiAB9K6D2+bBnlUMYiPQvmtS9yDdyYljQ==
X-Received: by 2002:a17:90b:3b44:: with SMTP id ot4mr5772191pjb.202.1638447710120;
        Thu, 02 Dec 2021 04:21:50 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m15sm3608894pfk.186.2021.12.02.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 04:21:49 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/3] irqchip: Pass platform_device pointer to init_cb
Date:   Thu,  2 Dec 2021 20:21:20 +0800
Message-Id: <20211202122122.23548-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202122122.23548-1-shawn.guo@linaro.org>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to just pass device_node for callback in IRQCHIP_DECLARE
case, but not so much for IRQCHIP_PLATFORM_DRIVER one, because
platform_driver probe/init usually needs device pointer for various
purposes, e.g. resource allocation, service request, device prefixed
message output, etc.  Create a new callback type irqchip_init_cb_t which
takes platform_device pointer as parameter, and update the existing
IRQCHIP_PLATFORM_DRIVER users accordingly.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/irqchip/irq-bcm7038-l1.c |  3 ++-
 drivers/irqchip/irq-bcm7120-l2.c | 10 ++++++----
 drivers/irqchip/irq-brcmstb-l2.c | 10 ++++++----
 drivers/irqchip/irq-mchp-eic.c   |  4 +++-
 drivers/irqchip/irq-meson-gpio.c |  7 +++++--
 drivers/irqchip/irqchip.c        |  4 ++--
 drivers/irqchip/qcom-pdc.c       |  4 +++-
 include/linux/irqchip.h          |  8 +++++++-
 8 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index a62b96237b82..d52a598f73df 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -396,9 +396,10 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-static int __init bcm7038_l1_of_init(struct device_node *dn,
+static int __init bcm7038_l1_of_init(struct platform_device *pdev,
 			      struct device_node *parent)
 {
+	struct device_node *dn = pdev->dev.of_node;
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;
 
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index d80e67a6aad2..82a75eb11523 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -341,17 +341,19 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	return ret;
 }
 
-static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
+static int __init bcm7120_l2_intc_probe_7120(struct platform_device *pdev,
 					     struct device_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
+	return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
+				     bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
+static int __init bcm7120_l2_intc_probe_3380(struct platform_device *pdev,
 					     struct device_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
+	return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
+				     bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
 }
 
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index e4efc08ac594..52886fbcea18 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -270,16 +270,18 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_edge_intc_of_init(struct platform_device *pdev,
 	struct device_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
+	return brcmstb_l2_intc_of_init(pdev->dev.of_node, parent,
+				       &l2_edge_intc_init);
 }
 
-static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_lvl_intc_of_init(struct platform_device *pdev,
 	struct device_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
+	return brcmstb_l2_intc_of_init(pdev->dev.of_node, parent,
+				       &l2_lvl_intc_init);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(brcmstb_l2)
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index c726a19837d2..1ab34af841f6 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -199,8 +199,10 @@ static const struct irq_domain_ops mchp_eic_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int mchp_eic_init(struct device_node *node, struct device_node *parent)
+static int mchp_eic_init(struct platform_device *pdev,
+			 struct device_node *parent)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct irq_domain *parent_domain = NULL;
 	int ret, i;
 
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index d90ff0b92480..1c841189defa 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -436,7 +436,8 @@ static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
 	.translate	= meson_gpio_irq_domain_translate,
 };
 
-static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_irq_controller *ctl)
+static int meson_gpio_irq_parse_dt(struct device_node *node,
+				   struct meson_gpio_irq_controller *ctl)
 {
 	const struct of_device_id *match;
 	int ret;
@@ -462,8 +463,10 @@ static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_i
 	return 0;
 }
 
-static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *parent)
+static int meson_gpio_irq_of_init(struct platform_device *pdev,
+				  struct device_node *parent)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct irq_domain *domain, *parent_domain;
 	struct meson_gpio_irq_controller *ctl;
 	int ret;
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 3570f0a588c4..62e6dbc3c4d0 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -36,7 +36,7 @@ int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *par_np = of_irq_find_parent(np);
-	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
+	irqchip_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb)
 		return -EINVAL;
@@ -55,6 +55,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
 
-	return irq_init_cb(np, par_np);
+	return irq_init_cb(pdev, par_np);
 }
 EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 173e6520e06e..b66ac9dd46c3 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -359,8 +359,10 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 	return 0;
 }
 
-static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
+static int qcom_pdc_init(struct platform_device *pdev,
+			 struct device_node *parent)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
 	int ret;
 
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae..da33a21c0297 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -36,13 +36,19 @@ extern of_irq_init_cb_t typecheck_irq_init_cb;
 #define IRQCHIP_DECLARE(name, compat, fn)	\
 	OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
 
+typedef int (*irqchip_init_cb_t)(struct platform_device *,
+				 struct device_node *);
+extern irqchip_init_cb_t typecheck_irqchip_init_cb;
+#define typecheck_irqchip_init_cb(fn) \
+	(__typecheck(typecheck_irqchip_init_cb, &fn) ? fn : fn)
+
 extern int platform_irqchip_probe(struct platform_device *pdev);
 
 #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
 static const struct of_device_id drv_name##_irqchip_match_table[] = {
 
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
-				    .data = typecheck_irq_init_cb(fn), },
+				    .data = typecheck_irqchip_init_cb(fn), },
 
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
 	{},								\
-- 
2.17.1

