Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D253153DCC8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbiFEQGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbiFEQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:05:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D904DF5A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:05:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so24741097ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNqgaebxE59a2xpXGgkpfpc65G6fkCReKHmHzYMPGcA=;
        b=EJmJTWZ/TZD/mv61lnGe5gafSPLr5OaV+l4dc7rj1YuHedcFYzAIqNgZB5JkA5FGtJ
         CAJIuki4a0NglCzD5hXyUYGlYAeGNFXd+dJtpB0UdQWC6WY+n6SBHp1FISYUFcCWoo+J
         DBlo/nsTd0a4Ique5Xpd0DqDKZ09hxnm3H2iExlJ/hickjfKJGUtx8ZTINo9XpzM7ziw
         blqIMFvtCgibEBdj0noItO6+DJZUJb8sEImfVwGV0J3YnLE4+tEXJW/tl1QzS/PBSBvs
         hJ+sl3yZsMSVYjXAukLiNJmX8VVRaSHodlfKJ9+cbmn5VaQP1dWmr3N+rrkSkLzEPcIq
         D8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNqgaebxE59a2xpXGgkpfpc65G6fkCReKHmHzYMPGcA=;
        b=NHR6fWKcAxFh0h3o1LKFekUXcyNaf3UOGEBMK6GODLC8M0KH6vHQwIa5TvbU7GpKyo
         a4WzQapkwIBmPeYQaN/Oko95tOppkhgqNs4z458//QZXUo0M9FysmUrZ7bpLtBJ7S1TU
         7iTlu/iQ0stsk6C1MAimTLCfOsQAn6wg51orYtioDaoT7y29J4RGKhz9ldVNS0Qbm22P
         V6tAfqRIo2RR5bT7sQleQeqzYr20NQqAkLECNzMC0F2bW52cO+ygSaLxdzmmtxqNZc7M
         AMj43AzivWNNy0GwwHIRKBkoDVvFDud9mFAumgWxMgiNRMDAM1l8tS5zgP4nYPLmvMnx
         bBdA==
X-Gm-Message-State: AOAM531/2Yjyo+MTcQsvHKGrKMJ4TzlcVj77r52Tclnx2aST6BUSpqQy
        KPA9wo2ciSNfUQvkpbd7n/yyaA==
X-Google-Smtp-Source: ABdhPJw6/qp9FGlzSQo4wMiMASHWdeVH9xL3mwpxk8gC8nP1EII0Q5WCeLN6SBC9ZygEpcbunwWSZw==
X-Received: by 2002:a17:907:c29:b0:704:fbb:1943 with SMTP id ga41-20020a1709070c2900b007040fbb1943mr17690903ejc.486.1654445133707;
        Sun, 05 Jun 2022 09:05:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0070b7875aa6asm3969963ejw.166.2022.06.05.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:05:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 7/8] pinctrl: samsung: do not use bindings header with constants
Date:   Sun,  5 Jun 2022 18:05:07 +0200
Message-Id: <20220605160508.134075-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC pin controller driver uses only three defines from the
bindings header with pin configuration register values, which proves
the point that this header is not a proper bindings-type abstraction
layer with IDs.

Define the needed register values directly in the driver and stop using
the bindings header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 6 ++----
 drivers/pinctrl/samsung/pinctrl-exynos.h  | 3 +++
 drivers/pinctrl/samsung/pinctrl-samsung.c | 4 +---
 drivers/pinctrl/samsung/pinctrl-samsung.h | 8 ++++++++
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 6d7ca1758292..a8212fc126bf 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -27,8 +27,6 @@
 #include <linux/soc/samsung/exynos-pmu.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 
-#include <dt-bindings/pinctrl/samsung.h>
-
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
 
@@ -173,7 +171,7 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
-	con |= EXYNOS_PIN_FUNC_EINT << shift;
+	con |= EXYNOS_PIN_CON_FUNC_EINT << shift;
 	writel(con, bank->pctl_base + reg_con);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
@@ -196,7 +194,7 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
-	con |= EXYNOS_PIN_FUNC_INPUT << shift;
+	con |= PIN_CON_FUNC_INPUT << shift;
 	writel(con, bank->pctl_base + reg_con);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index bfad1ced8017..7bd6d82c9f36 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -16,6 +16,9 @@
 #ifndef __PINCTRL_SAMSUNG_EXYNOS_H
 #define __PINCTRL_SAMSUNG_EXYNOS_H
 
+/* Values for the pin CON register */
+#define EXYNOS_PIN_CON_FUNC_EINT	0xf
+
 /* External GPIO and wakeup interrupt related definitions */
 #define EXYNOS_GPIO_ECON_OFFSET		0x700
 #define EXYNOS_GPIO_EFLTCON_OFFSET	0x800
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 26d309d2516d..4837bceb767b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -26,8 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
 
-#include <dt-bindings/pinctrl/samsung.h>
-
 #include "../core.h"
 #include "pinctrl-samsung.h"
 
@@ -614,7 +612,7 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	data = readl(reg);
 	data &= ~(mask << shift);
 	if (!input)
-		data |= EXYNOS_PIN_FUNC_OUTPUT << shift;
+		data |= PIN_CON_FUNC_OUTPUT << shift;
 	writel(data, reg);
 
 	return 0;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index fc6f5199c548..9af93e3d8d9f 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -53,6 +53,14 @@ enum pincfg_type {
 #define PINCFG_UNPACK_TYPE(cfg)		((cfg) & PINCFG_TYPE_MASK)
 #define PINCFG_UNPACK_VALUE(cfg)	(((cfg) & PINCFG_VALUE_MASK) >> \
 						PINCFG_VALUE_SHIFT)
+/*
+ * Values for the pin CON register, choosing pin function.
+ * The basic set (input and output) are same between: S3C24xx, S3C64xx, S5PV210,
+ * Exynos ARMv7, Exynos ARMv8, Tesla FSD.
+ */
+#define PIN_CON_FUNC_INPUT		0x0
+#define PIN_CON_FUNC_OUTPUT		0x1
+
 /**
  * enum eint_type - possible external interrupt types.
  * @EINT_TYPE_NONE: bank does not support external interrupts
-- 
2.34.1

