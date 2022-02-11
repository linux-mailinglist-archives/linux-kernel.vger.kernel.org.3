Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DB4B2226
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiBKJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:39:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBKJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:39:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A07F5B;
        Fri, 11 Feb 2022 01:39:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8965A61F34;
        Fri, 11 Feb 2022 09:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB456C340E9;
        Fri, 11 Feb 2022 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644572361;
        bh=YdvJVa1OctIgoaQy0xV0Ubxux8AGjVOaAA3jVzMYpfw=;
        h=From:To:Cc:Subject:Date:From;
        b=dvTI61ByXBlwe3DsVnSXYdmQ/7HNLlnyeSQrEs+bVUIJdMVdoNKs7hKhiyl66k4/u
         gpdffEPBAe/bPnpM8/SkBO35YWRiI4SNZkaTeD7sZf0ZJEc3Id4ZVd7e8oA9XiIEcI
         Gejpcgwa4e/u6l4xuwd79tVEB/FOt7N8zNfaFQ5mD5A6ah/oeIhGgFeTSbWiyRqfFo
         T0RAsNv8QASOeM2f4LxGcSaTMbQ2QNGVkT/n9aRpal8Y4JYtWUYosQYhKXeIZx0U/C
         2OO8n97ZCQbz3F/at5n527rLDuvPZoqSxtA+mn1J74I4ntxkz+g8TyNO4oNaRvwcqC
         ahwqjbOXVtRMw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nISOd-00784U-42; Fri, 11 Feb 2022 09:39:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     kernel-team@android.com, Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: tegra186: Fix chip_data type confusion
Date:   Fri, 11 Feb 2022 09:39:04 +0000
Message-Id: <20220211093904.1112679-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, kernel-team@android.com, treding@nvidia.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com
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

The tegra186 GPIO driver makes the assumption that the pointer
returned by irq_data_get_irq_chip_data() is a pointer to a
tegra_gpio structure. Unfortunately, it is actually a pointer
to the inner gpio_chip structure, as mandated by the gpiolib
infrastructure. Nice try.

The saving grace is that the gpio_chip is the first member of
tegra_gpio, so the bug has gone undetected since... forever.

Fix it by performing a container_of() on the pointer. This results
in no additional code, and makes it possible to understand how
the whole thing works.

Fixes: 5b2b135a87fc ("gpio: Add Tegra186 support")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-tegra186.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 34b36a8c035f..8d298beffd86 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -343,9 +343,12 @@ static int tegra186_gpio_of_xlate(struct gpio_chip *chip,
 	return offset + pin;
 }
 
+#define to_tegra_gpio(x) container_of((x), struct tegra_gpio, gpio)
+
 static void tegra186_irq_ack(struct irq_data *data)
 {
-	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct tegra_gpio *gpio = to_tegra_gpio(gc);
 	void __iomem *base;
 
 	base = tegra186_gpio_get_base(gpio, data->hwirq);
@@ -357,7 +360,8 @@ static void tegra186_irq_ack(struct irq_data *data)
 
 static void tegra186_irq_mask(struct irq_data *data)
 {
-	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct tegra_gpio *gpio = to_tegra_gpio(gc);
 	void __iomem *base;
 	u32 value;
 
@@ -372,7 +376,8 @@ static void tegra186_irq_mask(struct irq_data *data)
 
 static void tegra186_irq_unmask(struct irq_data *data)
 {
-	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct tegra_gpio *gpio = to_tegra_gpio(gc);
 	void __iomem *base;
 	u32 value;
 
@@ -387,7 +392,8 @@ static void tegra186_irq_unmask(struct irq_data *data)
 
 static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 {
-	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct tegra_gpio *gpio = to_tegra_gpio(gc);
 	void __iomem *base;
 	u32 value;
 
-- 
2.34.1

