Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69D596474
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiHPVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiHPVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691197A516
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v3so14091053wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KhMhCXNUPulyEqbvrgq3B8jPysRuP6fKiM4Dgs7yiW0=;
        b=HZsN1CX0Bc02mQo0Nfq87Qc0PfrEXZBxl7w/Da2GFOWKgOjeQeG6tKD4h+Hs6eIhvV
         JVOdD0L2ygzPThCwdaNS5NT16fdbrHQQtytkBBhwc8pQp7Lzd+aoeF5+5oaw1P7/Q1Tl
         JGiLqu8Xs7TZyBc4+8PcVwGgXe4Vs+V6ZqpqCtWr6nNaXF8aPEeL6qPJwOZdgQ9H6BLb
         coj9jCxkSgV4LtSETI8gYMi1iOhBdZo0hhRffy/61izSoZ5eCaE2TP9JNSMbjwtuqzI1
         I2IGJWAgFOLMP0dY/N1P4ab74L4aP45w7D1qMFdp8hSjZ6II3aQLXFO3kXoHX/Ak8pYY
         fHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KhMhCXNUPulyEqbvrgq3B8jPysRuP6fKiM4Dgs7yiW0=;
        b=hmQ6zOiAVUPxMemN2Zvb44LCIIsTEkJmeir+iQdbNpIXjnB11LhWAXc6qOhASxUuqz
         McffqipWCuI+gpTkJx0GuPx86hFbHz69Bw0ewrtWs/Juhp3ksyZBrX1ngtHK6Ltb7pFm
         faw+7EkLO5OmyLxis8gW6vQxomsUPMM+K5Yap38nkfTA8xXWOC7tbCLIbAhMXE0q1G0v
         6n3i6Ris/IYI68fEBh92EkXr9kv+NLtpF4sKumEZ+nFNZyL4Nel4ixmbB1Dmslm4+bRF
         fLni+3khX92fYwxZsLvit0xdVPZ+mHIePmip/C2ly8XM9qLNsmNh4cORnBGgsz5PZ1C4
         +gjg==
X-Gm-Message-State: ACgBeo3KzW7XhkuAcoeYEFy4HpXZPGNTxneHYH+//vRxebhEuNY9XFhp
        YZPyviMewMa6zA00pY/weEfDuw==
X-Google-Smtp-Source: AA6agR7lVU/aqe0NWxi8r1nhfuQLGSXQNuJn88FM950tnhSF+WitfhmKyJrWGi/c5DMyRyqh8jX2Hw==
X-Received: by 2002:a5d:6da1:0:b0:220:b328:e4d4 with SMTP id u1-20020a5d6da1000000b00220b328e4d4mr12293232wrs.14.1660684501319;
        Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 06/10] pwm: dwc: split pci out of core driver
Date:   Tue, 16 Aug 2022 22:14:50 +0100
Message-Id: <20220816211454.237751-7-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
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

Moving towards adding non-pci support for the driver, move the pci
parts out of the core into their own module. This is partly due to
the module_driver() code only being allowed once in a module and also
to avoid a number of #ifdef if we build a single file in a system
without pci support.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/Kconfig       |  14 +++-
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
 drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
 5 files changed, 207 insertions(+), 157 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-pci.c
 create mode 100644 drivers/pwm/pwm-dwc.h

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3f3c53af4a56..a9f1c554db2b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -175,15 +175,23 @@ config PWM_CROS_EC
 	  Controller.
 
 config PWM_DWC
-	tristate "DesignWare PWM Controller"
-	depends on PCI || COMPILE_TEST
+	tristate "DesignWare PWM Controller core"
 	depends on HAS_IOMEM
 	help
-	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
+	  PWM driver for Synopsys DWC PWM Controller.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
 
+config PWM_DWC_PCI
+	tristate "DesignWare PWM Controller core"
+	depends on PWM_DWC && HAS_IOMEM && PCI
+	help
+	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-pci.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..a70d36623129 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
new file mode 100644
index 000000000000..2213d0e7f3c8
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-pci.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver (PCI part)
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ *
+ * Limitations:
+ * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
+ *   periods are one or more input clock periods long.
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+
+#include "pwm-dwc.h"
+
+static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct device *dev = &pci->dev;
+	struct dwc_pwm *dwc;
+	int ret;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
+	if (ret) {
+		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	dwc->base = pcim_iomap_table(pci)[0];
+	if (!dwc->base) {
+		dev_err(dev, "Base address missing\n");
+		return -ENOMEM;
+	}
+
+	ret = devm_pwmchip_add(dev, &dwc->chip);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(dev);
+	pm_runtime_allow(dev);
+
+	return 0;
+}
+
+static void dwc_pwm_remove(struct pci_dev *pci)
+{
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc_pwm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		if (dwc->chip.pwms[i].state.enabled) {
+			dev_err(dev, "PWM %u in use by consumer (%s)\n",
+				i, dwc->chip.pwms[i].label);
+			return -EBUSY;
+		}
+		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
+		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
+		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
+	}
+
+	return 0;
+}
+
+static int dwc_pwm_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
+		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
+		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
+
+static const struct pci_device_id dwc_pwm_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
+
+static struct pci_driver dwc_pwm_driver = {
+	.name = "pwm-dwc",
+	.probe = dwc_pwm_probe,
+	.remove = dwc_pwm_remove,
+	.id_table = dwc_pwm_id_table,
+	.driver = {
+		.pm = &dwc_pwm_pm_ops,
+	},
+};
+
+module_pci_driver(dwc_pwm_driver);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 56cde9da2c0e..90a8ae1252a1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -1,16 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DesignWare PWM Controller driver
+ * DesignWare PWM Controller driver core
  *
  * Copyright (C) 2018-2020 Intel Corporation
  *
  * Author: Felipe Balbi (Intel)
  * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
  * Author: Raymond Tan <raymond.tan@intel.com>
- *
- * Limitations:
- * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
- *   periods are one or more input clock periods long.
  */
 
 #include <linux/bitops.h>
@@ -21,51 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
-#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
-#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
-#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
-#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
-#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
-#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
-
-#define DWC_TIMERS_INT_STS	0xa0
-#define DWC_TIMERS_EOI		0xa4
-#define DWC_TIMERS_RAW_INT_STS	0xa8
-#define DWC_TIMERS_COMP_VERSION	0xac
-
-#define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
-
-/* Timer Control Register */
-#define DWC_TIM_CTRL_EN		BIT(0)
-#define DWC_TIM_CTRL_MODE	BIT(1)
-#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
-#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
-#define DWC_TIM_CTRL_INT_MASK	BIT(2)
-#define DWC_TIM_CTRL_PWM	BIT(3)
-
-struct dwc_pwm_ctx {
-	u32 cnt;
-	u32 cnt2;
-	u32 ctrl;
-};
-
-struct dwc_pwm {
-	struct pwm_chip chip;
-	void __iomem *base;
-	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
-};
-#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-
-static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
-{
-	return readl(dwc->base + offset);
-}
-
-static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
-{
-	writel(value, dwc->base + offset);
-}
+#include "pwm-dwc.h"
 
 static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
 {
@@ -196,7 +148,7 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 {
 	struct dwc_pwm *dwc;
 
@@ -211,109 +163,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	dev_set_drvdata(dev, dwc);
 	return dwc;
 }
-
-static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
-{
-	struct device *dev = &pci->dev;
-	struct dwc_pwm *dwc;
-	int ret;
-
-	dwc = dwc_pwm_alloc(dev);
-	if (!dwc)
-		return -ENOMEM;
-
-	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
-
-	pci_set_master(pci);
-
-	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret) {
-		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
-
-	dwc->base = pcim_iomap_table(pci)[0];
-	if (!dwc->base) {
-		dev_err(dev, "Base address missing\n");
-		return -ENOMEM;
-	}
-
-	ret = devm_pwmchip_add(dev, &dwc->chip);
-	if (ret)
-		return ret;
-
-	pm_runtime_put(dev);
-	pm_runtime_allow(dev);
-
-	return 0;
-}
-
-static void dwc_pwm_remove(struct pci_dev *pci)
-{
-	pm_runtime_forbid(&pci->dev);
-	pm_runtime_get_noresume(&pci->dev);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int dwc_pwm_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		if (dwc->chip.pwms[i].state.enabled) {
-			dev_err(dev, "PWM %u in use by consumer (%s)\n",
-				i, dwc->chip.pwms[i].label);
-			return -EBUSY;
-		}
-		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
-		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
-		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
-	}
-
-	return 0;
-}
-
-static int dwc_pwm_resume(struct device *dev)
-{
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
-		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
-		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
-	}
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
-
-static const struct pci_device_id dwc_pwm_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
-	{  }	/* Terminating Entry */
-};
-MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
-
-static struct pci_driver dwc_pwm_driver = {
-	.name = "pwm-dwc",
-	.probe = dwc_pwm_probe,
-	.remove = dwc_pwm_remove,
-	.id_table = dwc_pwm_id_table,
-	.driver = {
-		.pm = &dwc_pwm_pm_ops,
-	},
-};
-
-module_pci_driver(dwc_pwm_driver);
+EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
 
 MODULE_AUTHOR("Felipe Balbi (Intel)");
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
new file mode 100644
index 000000000000..68f98eb76152
--- /dev/null
+++ b/drivers/pwm/pwm-dwc.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+
+#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
+#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
+#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
+#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
+#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
+#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
+
+#define DWC_TIMERS_INT_STS	0xa0
+#define DWC_TIMERS_EOI		0xa4
+#define DWC_TIMERS_RAW_INT_STS	0xa8
+#define DWC_TIMERS_COMP_VERSION	0xac
+
+#define DWC_TIMERS_TOTAL	8
+#define DWC_CLK_PERIOD_NS	10
+
+/* Timer Control Register */
+#define DWC_TIM_CTRL_EN		BIT(0)
+#define DWC_TIM_CTRL_MODE	BIT(1)
+#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
+#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
+#define DWC_TIM_CTRL_INT_MASK	BIT(2)
+#define DWC_TIM_CTRL_PWM	BIT(3)
+
+struct dwc_pwm_ctx {
+	u32 cnt;
+	u32 cnt2;
+	u32 ctrl;
+};
+
+struct dwc_pwm {
+	struct pwm_chip chip;
+	void __iomem *base;
+	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
+};
+#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
+{
+	return readl(dwc->base + offset);
+}
+
+static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
+{
+	writel(value, dwc->base + offset);
+}
+
+extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
-- 
2.35.1

