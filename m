Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D103559516
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFXIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiFXIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:10:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935A40E44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:10:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so3114960ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppOb8unbJrDxFJbdCnHsLpI+FWVgE5qyktBxG9bYt5I=;
        b=pX3T/iNSMFIpiW6v3ZCV7BMrZgoqn2YBNw05bESjYlb9wXWCAGY4b5maOYnwRMKeJE
         RJDOE7s16k156GOhEACOHkOjaEc9jb28BlHN5+lKnePc0GH+PXBgee8IjqJv9v8V4fzp
         KSICDFuOJ5ie1i7Yt33pYlJ5F3Z0Qgs7RYzg/50fVVkmrRhVzC2illK2JWypyqE6EPTY
         aEPUJCGgZhqBYSTC7zf6juKchn9lplSoe8O/e4Z4XaGoVPo/PXRnrkWArs7FjECsdejr
         +EJc/SzkjGUd7jz4rqOy/v8MEHDQ8pqsIIYA6PpwDEcxLizlU/UE4v/ZQ7thQkDR9D0J
         Z4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppOb8unbJrDxFJbdCnHsLpI+FWVgE5qyktBxG9bYt5I=;
        b=S+bvb5yS03BV8IGdBaKJU7aLNN0gbzCSOaEBxfTb655p60Pc9+hBVTAoOs6CmvsBdj
         S5nUSBYeR6EQmvyDuESS1QmcErt3mLv69Z3W58qzWOxEHjWkYxM6vEZj19KfiGj70cmo
         VgrH3xmTfsMF0cexraXPBEMrQluWa/adSiNp1Wy1OTwXdmTU4srLKKSggAhyzojjkaFS
         JjmqjqqKmvfK5S9Fl4rZVOiZFFc9JrhhOm2f/9pppPFXTrjoW8i4brR+ZzehG05Kw6Gf
         WYDIYMD2Ibwr9BJ8Qh8owdqezE9fQc10nnFoaf26qiUD1Zt37SyDpNcrEf5KYHiRioCd
         zy9A==
X-Gm-Message-State: AJIora97k667RagFDWkRw7vf11w+Gxo23gTUYgJknNRRU8WoWTTIDbqH
        McoVOA55vSWru5sYeCObV0SkzA==
X-Google-Smtp-Source: AGRyM1vJuMKUo4MW2++Vvkwywwei/ikXA4qoE3wE7t12dNEqmfPn8ssrtIZjbW8wCJgoor2K2/tBAQ==
X-Received: by 2002:a17:906:7742:b0:708:ad9f:8e88 with SMTP id o2-20020a170906774200b00708ad9f8e88mr11710293ejn.735.1656058229952;
        Fri, 24 Jun 2022 01:10:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm1395924edt.24.2022.06.24.01.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:10:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL][PATCH] pinctrl: samsung: do not use bindings header with constants
Date:   Fri, 24 Jun 2022 10:10:22 +0200
Message-Id: <20220624081022.32384-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220605160508.134075-8-krzysztof.kozlowski@linaro.org
---

Hi Linus,

I have only one patch this cycle, so sending it directly.

Best regards,
Krzysztof


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

