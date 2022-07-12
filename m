Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2302A571672
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiGLKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiGLKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:01:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3BAAB17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay25so4429738wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpoBQEqf1FX/xxVS6a/Y6dGWkWZLpnNqTu+RF9kvMB8=;
        b=ZxIPjfmmKG7nPkW21HPuvveRvBQRN2VPvrHoixdudUQ69aZFLtj37zP+pscxN3ITxd
         0Hle0tOgXYYPxtphuifUfUHcED7aAl+em6qCpJvm4nIx+DQz8uKSqDR9kGRhw30u+puM
         xc80Mh3AdMYjzsHYY8FXGSBEabD071y/JzlsJL1Z7SEPGkFeZjWGf5ZW+fCTmfqyP9kK
         ZFTxvm1XQFtPewjYVFYmHlKTD+4wvxgE8n4l08ugtlqkkowYd6RcmvQyeR7CZ4JL6Emt
         1v2jQziFZ3VcplI19V4YUcSSe5wNenSxFt/8zH4bg80zdXdXQrTNh9UCCLB3PGlanEUd
         D6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpoBQEqf1FX/xxVS6a/Y6dGWkWZLpnNqTu+RF9kvMB8=;
        b=LzHvYk28j3lpaSEm7lOQdf6Wk5evDXRK/AapA3IY3qFMummUwpU2QFOrRQS7sD1k8P
         /6hwFZw4PCtriOmvRTyQuk00YtP2roRACvUpzo3zL38tOyy/1GMU2zppGmM2NWPNS5Z9
         9cL+7qcilkTpa4hSFBTMGVMLo8vK2syK5n56X2zcnyyB39ZVI8FBt0TWk0x8rYsU6K4M
         z8e+xVyefiop/CvxtSQXCQV4j380lY6uIEGpULw6RYtjWm9eEYZ20rRsCVHDxzxuEodL
         FUigd0Ha0K/9DUY0Qt3eNGPD5o2GnA1tAmyXkQ+Dvzzt9sstS5N4GMl5kBDQVFjajvrv
         YA9A==
X-Gm-Message-State: AJIora8dY3NznIXc1li/MQMxPj6dInTy50ILj6haSV+2I/5Lga+m26Dy
        mKyCdggawCJuBT9tSTnqC8fL6g==
X-Google-Smtp-Source: AGRyM1us87Y4745B6dID19IxgWRlP96FRRxcReXjQTIFqgdm9VOMnJ+zCnmD1Vfk0w0ANPi4RkkqoA==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr2907142wmj.113.1657620078679;
        Tue, 12 Jul 2022 03:01:18 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b0039747cf8354sm8895314wmc.39.2022.07.12.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:01:18 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 3/7] pwm: dwc: add of/platform support
Date:   Tue, 12 Jul 2022 11:01:09 +0100
Message-Id: <20220712100113.569042-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712100113.569042-1-ben.dooks@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
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

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
 drivers/pwm/Kconfig                           |  5 +-
 drivers/pwm/pwm-dwc.c                         | 53 +++++++++++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synposys.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
new file mode 100644
index 000000000000..38ac0da75272
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-synposys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys PWM controller
+
+maintainers:
+   - Ben Dooks <ben.dooks@sifive.com>
+
+properties:
+  "#pwm-cells":
+    description: |
+      See pwm.yaml in this directory for a description of the cells format.
+
+  clocks:
+    items:
+      - description: Interface bus clock
+      - description: PWM reference clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: timer
+
+  compatible:
+    oneOf:
+      - items:
+        - const: snps,pwm
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..e1aa645c1084 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -166,9 +166,10 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI
+	depends on PCI || OF
 	help
-	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
+	  PWM driver for Synopsys DWC PWM Controller attached to either a
+	  PCI or platform bus.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 61f11e0a9319..235cb730c888 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
@@ -319,6 +320,58 @@ static struct pci_driver dwc_pwm_driver = {
 
 module_pci_driver(dwc_pwm_driver);
 
+#ifdef CONFIG_OF
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	int ret;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return dev_err_probe(dev, PTR_ERR(dwc->base),
+				     "failed to map IO\n");
+
+	ret = pwmchip_add(&dwc->chip);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc_pwm_plat_remove(struct platform_device *pdev)
+{
+	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&dwc->chip);
+	return 0;
+}
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name		= "dwc-pwm",
+		.of_match_table  = dwc_pwm_dt_ids,
+	},
+	.probe	= dwc_pwm_plat_probe,
+	.remove	= dwc_pwm_plat_remove,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm");
+#endif /* CONFIG_OF */
+
+
 MODULE_AUTHOR("Felipe Balbi (Intel)");
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
 MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
-- 
2.35.1

