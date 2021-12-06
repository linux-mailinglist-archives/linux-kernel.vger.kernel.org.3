Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB946A000
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442823AbhLFP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390798AbhLFPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6404C08E883;
        Mon,  6 Dec 2021 07:32:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so44289362edd.9;
        Mon, 06 Dec 2021 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pb5Z2Y5uMygbHtQtEpm18vPIVNg80xjuixjOberPgMM=;
        b=U7vLfNUpevznWJFwvrwrQrk6OKOpyCNDGKGoEI3D9/w1UxeMP8qysPp698xO7rx2SS
         wSfHd5p9u5yWYnRfVCNfb47Q1S3awcjNt1pZIDd4W4b8/W9wx3qU8FOdo6CKBIh2WZel
         Upr41/XBO412JEnLrPOSxqSk3XfLeoVwfaZE6lUIJmW2gIBO531v3BTNbrJ09R4PH9ZU
         IF6d9bE499JmpvlWrLFvg8Lbi4FeFMfHhMpivkn+vYwvKWfDkAsWp8INeONTb1JFqk6x
         Cve+ex2U+h8sJQ70Rhvqe02iZbrx4VBYRRX7ZoF1fBsMmx/slGxmW6PadttcxOw75UhC
         cvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pb5Z2Y5uMygbHtQtEpm18vPIVNg80xjuixjOberPgMM=;
        b=iVhysmxWp150XOwFDgePJF3okWcEYpO3rl8nbxKwWW29H2rdSWsUlBFfMOTauvGRBf
         DpVHX0OrOfoWZi8/SgAgnC85zlp9djLCyxCyqKYuaCQ9OiosTyaGJt37aqrrPwouX62U
         rUX58HM8qJpGOhWZfH0YpM1aaE+uFrvEyj9ZxPnJlKhGOS77TAseQccis6KtpwFCNg30
         LsZ+h+03KuPj2Wh7NG3Moqpi/RmmyOvXZqUc0ert3wrEJnjKqJI2AzOuHX1xqTJV6WsG
         XpCH7pwElWFsSDOY0J+cW1R1Z7yNxbqmRoUSQQexEWhv9U34+aOZ8QROZRuaI7ab5Cb3
         Hhzg==
X-Gm-Message-State: AOAM531Hu9rkW6edQOD51brjfjFNt42HhSPzSUDdJR6VApwGvJ0HSauf
        E8oFMs1Mn9OmLfcwMvHVFSc=
X-Google-Smtp-Source: ABdhPJxxyPF4/TP/2TQrBAPJIWYJL9x06q2YWhLivS04KMl9UxI1N3cUnbELwICBV98/QH2+CpWXfg==
X-Received: by 2002:a17:907:3e96:: with SMTP id hs22mr46462981ejc.139.1638804755452;
        Mon, 06 Dec 2021 07:32:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id d19sm7364688edt.34.2021.12.06.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:32:35 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 4/7] clk: samsung: Make exynos850_register_cmu shared
Date:   Mon,  6 Dec 2021 16:31:18 +0100
Message-Id: <20211206153124.427102-5-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206153124.427102-1-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename exynos850_register_cmu to exynos_arm64_register_cmu and move it
to a new file called "clk-exynos-arm64.c".

This should have no functional changes, but it will allow this code to
be shared between other arm64 Exynos SoCs, like the Exynos7885 and
possibly ExynosAuto V9.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
Changes in v2:
  - New patch

Changes in v3:
  - Fix SPDX comment style in clk-exynos-arm64.h

Changes in v4:
  - Fix missing headers but still remove of_address.h
  - "__SAMSUNG_CLK_ARM64_H" -> "__CLK_EXYNOS_ARM64_H" in
    clk-exynos-arm64.h everywhere (only the comment at the end had the
    latter by accident)

 drivers/clk/samsung/Makefile           |  1 +
 drivers/clk/samsung/clk-exynos-arm64.c | 94 ++++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos-arm64.h | 20 ++++++
 drivers/clk/samsung/clk-exynos850.c    | 88 ++----------------------
 4 files changed, 119 insertions(+), 84 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index c46cf11e4d0b..901e6333c5f0 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EXYNOS_5420_COMMON_CLK)	+= clk-exynos5-subcmu.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos5433.o
 obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
 obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
+obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos-arm64.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
new file mode 100644
index 000000000000..b921b9a1134a
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ * Author: Dávid Virág <virag.david003@gmail.com>
+ *
+ * This file contains shared functions used by some arm64 Exynos SoCs,
+ * such as Exynos7885 or Exynos850 to register and init CMUs.
+ */
+#include <linux/clk.h>
+#include <linux/of_address.h>
+
+#include "clk-exynos-arm64.h"
+
+/* Gate register bits */
+#define GATE_MANUAL		BIT(20)
+#define GATE_ENABLE_HWACG	BIT(28)
+
+/* Gate register offsets range */
+#define GATE_OFF_START		0x2000
+#define GATE_OFF_END		0x2fff
+
+/**
+ * exynos_arm64_init_clocks - Set clocks initial configuration
+ * @np:			CMU device tree node with "reg" property (CMU addr)
+ * @reg_offs:		Register offsets array for clocks to init
+ * @reg_offs_len:	Number of register offsets in reg_offs array
+ *
+ * Set manual control mode for all gate clocks.
+ */
+static void __init exynos_arm64_init_clocks(struct device_node *np,
+		const unsigned long *reg_offs, size_t reg_offs_len)
+{
+	void __iomem *reg_base;
+	size_t i;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
+
+	for (i = 0; i < reg_offs_len; ++i) {
+		void __iomem *reg = reg_base + reg_offs[i];
+		u32 val;
+
+		/* Modify only gate clock registers */
+		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OFF_END)
+			continue;
+
+		val = readl(reg);
+		val |= GATE_MANUAL;
+		val &= ~GATE_ENABLE_HWACG;
+		writel(val, reg);
+	}
+
+	iounmap(reg_base);
+}
+
+/**
+ * exynos_arm64_register_cmu - Register specified Exynos CMU domain
+ * @dev:	Device object; may be NULL if this function is not being
+ *		called from platform driver probe function
+ * @np:		CMU device tree node
+ * @cmu:	CMU data
+ *
+ * Register specified CMU domain, which includes next steps:
+ *
+ * 1. Enable parent clock of @cmu CMU
+ * 2. Set initial registers configuration for @cmu CMU clocks
+ * 3. Register @cmu CMU clocks using Samsung clock framework API
+ */
+void __init exynos_arm64_register_cmu(struct device *dev,
+		struct device_node *np, const struct samsung_cmu_info *cmu)
+{
+	/* Keep CMU parent clock running (needed for CMU registers access) */
+	if (cmu->clk_name) {
+		struct clk *parent_clk;
+
+		if (dev)
+			parent_clk = clk_get(dev, cmu->clk_name);
+		else
+			parent_clk = of_clk_get_by_name(np, cmu->clk_name);
+
+		if (IS_ERR(parent_clk)) {
+			pr_err("%s: could not find bus clock %s; err = %ld\n",
+			       __func__, cmu->clk_name, PTR_ERR(parent_clk));
+		} else {
+			clk_prepare_enable(parent_clk);
+		}
+	}
+
+	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
+	samsung_cmu_register_one(np, cmu);
+}
diff --git a/drivers/clk/samsung/clk-exynos-arm64.h b/drivers/clk/samsung/clk-exynos-arm64.h
new file mode 100644
index 000000000000..0dd174693935
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos-arm64.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ * Author: Dávid Virág <virag.david003@gmail.com>
+ *
+ * This file contains shared functions used by some arm64 Exynos SoCs,
+ * such as Exynos7885 or Exynos850 to register and init CMUs.
+ */
+
+#ifndef __CLK_EXYNOS_ARM64_H
+#define __CLK_EXYNOS_ARM64_H
+
+#include "clk.h"
+
+void exynos_arm64_register_cmu(struct device *dev,
+		struct device_node *np, const struct samsung_cmu_info *cmu);
+
+#endif /* __CLK_EXYNOS_ARM64_H */
diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 568ac97c8120..17413135196d 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -9,93 +9,13 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/exynos850.h>
 
 #include "clk.h"
-
-/* Gate register bits */
-#define GATE_MANUAL		BIT(20)
-#define GATE_ENABLE_HWACG	BIT(28)
-
-/* Gate register offsets range */
-#define GATE_OFF_START		0x2000
-#define GATE_OFF_END		0x2fff
-
-/**
- * exynos850_init_clocks - Set clocks initial configuration
- * @np:			CMU device tree node with "reg" property (CMU addr)
- * @reg_offs:		Register offsets array for clocks to init
- * @reg_offs_len:	Number of register offsets in reg_offs array
- *
- * Set manual control mode for all gate clocks.
- */
-static void __init exynos850_init_clocks(struct device_node *np,
-		const unsigned long *reg_offs, size_t reg_offs_len)
-{
-	void __iomem *reg_base;
-	size_t i;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base)
-		panic("%s: failed to map registers\n", __func__);
-
-	for (i = 0; i < reg_offs_len; ++i) {
-		void __iomem *reg = reg_base + reg_offs[i];
-		u32 val;
-
-		/* Modify only gate clock registers */
-		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OFF_END)
-			continue;
-
-		val = readl(reg);
-		val |= GATE_MANUAL;
-		val &= ~GATE_ENABLE_HWACG;
-		writel(val, reg);
-	}
-
-	iounmap(reg_base);
-}
-
-/**
- * exynos850_register_cmu - Register specified Exynos850 CMU domain
- * @dev:	Device object; may be NULL if this function is not being
- *		called from platform driver probe function
- * @np:		CMU device tree node
- * @cmu:	CMU data
- *
- * Register specified CMU domain, which includes next steps:
- *
- * 1. Enable parent clock of @cmu CMU
- * 2. Set initial registers configuration for @cmu CMU clocks
- * 3. Register @cmu CMU clocks using Samsung clock framework API
- */
-static void __init exynos850_register_cmu(struct device *dev,
-		struct device_node *np, const struct samsung_cmu_info *cmu)
-{
-	/* Keep CMU parent clock running (needed for CMU registers access) */
-	if (cmu->clk_name) {
-		struct clk *parent_clk;
-
-		if (dev)
-			parent_clk = clk_get(dev, cmu->clk_name);
-		else
-			parent_clk = of_clk_get_by_name(np, cmu->clk_name);
-
-		if (IS_ERR(parent_clk)) {
-			pr_err("%s: could not find bus clock %s; err = %ld\n",
-			       __func__, cmu->clk_name, PTR_ERR(parent_clk));
-		} else {
-			clk_prepare_enable(parent_clk);
-		}
-	}
-
-	exynos850_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
-	samsung_cmu_register_one(np, cmu);
-}
+#include "clk-exynos-arm64.h"
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
@@ -404,7 +324,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 
 static void __init exynos850_cmu_top_init(struct device_node *np)
 {
-	exynos850_register_cmu(NULL, np, &top_cmu_info);
+	exynos_arm64_register_cmu(NULL, np, &top_cmu_info);
 }
 
 /* Register CMU_TOP early, as it's a dependency for other early domains */
@@ -892,7 +812,7 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
 
 static void __init exynos850_cmu_peri_init(struct device_node *np)
 {
-	exynos850_register_cmu(NULL, np, &peri_cmu_info);
+	exynos_arm64_register_cmu(NULL, np, &peri_cmu_info);
 }
 
 /* Register CMU_PERI early, as it's needed for MCT timer */
@@ -1069,7 +989,7 @@ static int __init exynos850_cmu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	info = of_device_get_match_data(dev);
-	exynos850_register_cmu(dev, dev->of_node, info);
+	exynos_arm64_register_cmu(dev, dev->of_node, info);
 
 	return 0;
 }
-- 
2.34.1

