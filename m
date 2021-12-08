Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923E46C8D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhLHAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbhLHAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:10 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA5C061746;
        Tue,  7 Dec 2021 16:37:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id j11so597070pgs.2;
        Tue, 07 Dec 2021 16:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=dE3SBRjaU2Y9Ll3skSCpNRoaLe4U4IgQwCl+p7mQF7mU+RtncumJn6JQcCL3M5md9Z
         +M9NDu9CqMP1F6b5H5qwfbgm/qELonGxbQBY+SGSePbP/ShSRit/CDi80Wl+AUsqIF6N
         +qJBU/0Kbn1qthCN2g4RVFpz0r0xD3ybLmhl3v7mlF0KvHLlqcaeMAjGcH4Cs2U24eFg
         ZBJg672k/LKMq55f6wSeY3WpFwDQEdCocR0AEK/NPUvc/xwuFusvPjvUHZ1A379CN76j
         CzvvgZ7Z9kuGvV2Y55yea2+H//6w0slmxVdZ2Ui2fNSyJA0NXgIE0OGOidq5PZn436Dl
         fe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=A6LfLLhYF7dbdT8Wu0qJUVMVoSGhRIpUxxF3VSLaujhBIvaoYSR8JxC1JAK1VFeckX
         rxAoSjiKedvbkC1VUF3167sR/xmfWgarLBT8kXUSSx7l4/DawYV9W2q807syqfieTXJI
         cf0BI3dVmMYPiGOD0JP4ZkunRsR+G4Kurmq3w78FeApPnO6W/WPibz3nv5sScj7Fu9BS
         RzOvgHE/tFazFUI7F8Vx8CwSpQovPiqHCNKcsOhS1gve5R3eN9ooBLxYLjQ0cuN+uo61
         99gt3/y4UdGJbOOjpUs3k/oteVhjq0y7vlLllmCVb8lRUFFFILoo4nyyBopDhjrMqQSo
         V/Ug==
X-Gm-Message-State: AOAM531NhDeKC8oihnBA6k3/LWDcRoqlU/eN894hIt8nJHl3z3+82mdy
        GPEdFm9esd7y+opBOAJpy4iZ5cF98ms=
X-Google-Smtp-Source: ABdhPJyIgeihBB0FcpLgt6ApUyOqXenN/IoOAZWKj7y+zefPUC8iLYH4pidr3M8JIvz4OctUZIcKaA==
X-Received: by 2002:a63:211b:: with SMTP id h27mr26815869pgh.203.1638923858628;
        Tue, 07 Dec 2021 16:37:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v3 01/15] dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML
Date:   Tue,  7 Dec 2021 16:37:12 -0800
Message-Id: <20211208003727.3596577-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB SDHCI controller Device Tree binding to YAML.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  53 ----------
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
deleted file mode 100644
index ae2074184528..000000000000
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* BROADCOM BRCMSTB/BMIPS SDHCI Controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-brcmstb driver.
-
-NOTE: The driver disables all UHS speed modes by default and depends
-on Device Tree properties to enable them for SoC/Board combinations
-that support them.
-
-Required properties:
-- compatible: should be one of the following
-  - "brcm,bcm7425-sdhci"
-  - "brcm,bcm7445-sdhci"
-  - "brcm,bcm7216-sdhci"
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-
-	sdhci@84b0000 {
-		sd-uhs-sdr50;
-		sd-uhs-ddr50;
-		sd-uhs-sdr104;
-		sdhci,auto-cmd12;
-		compatible = "brcm,bcm7216-sdhci",
-			   "brcm,bcm7445-sdhci",
-			   "brcm,sdhci-brcmstb";
-		reg = <0x84b0000 0x260 0x84b0300 0x200>;
-		reg-names = "host", "cfg";
-		interrupts = <0x0 0x26 0x4>;
-		interrupt-names = "sdio0_0";
-		clocks = <&scmi_clk 245>;
-		clock-names = "sw_sdio";
-	};
-
-	sdhci@84b1000 {
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
-		mmc-hs400-enhanced-strobe;
-		supports-cqe;
-		non-removable;
-		bus-width = <0x8>;
-		compatible = "brcm,bcm7216-sdhci",
-			   "brcm,bcm7445-sdhci",
-			   "brcm,sdhci-brcmstb";
-		reg = <0x84b1000 0x260 0x84b1300 0x200>;
-		reg-names = "host", "cfg";
-		interrupts = <0x0 0x27 0x4>;
-		interrupt-names = "sdio1_0";
-		clocks = <&scmi_clk 245>;
-		clock-names = "sw_sdio";
-	};
diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
new file mode 100644
index 000000000000..dccd5ad96981
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/brcm,sdhci-brcmstb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BRCMSTB/BMIPS SDHCI Controller binding
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7216-sdhci
+          - const: brcm,bcm7445-sdhci
+          - const: brcm,sdhci-brcmstb
+      - items:
+          - enum:
+              - brcm,bcm7445-sdhci
+          - const: brcm,sdhci-brcmstb
+      - items:
+          - enum:
+              - brcm,bcm7425-sdhci
+          - const: brcm,sdhci-brcmstb
+
+  reg:
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: host
+      - const: cfg
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      handle to core clock for the sdhci controller.
+
+  clock-names:
+    items:
+      - const: sw_sdio
+
+  sdhci,auto-cmd12:
+    type: boolean
+    description: Specifies that controller should use auto CMD12
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@84b0000 {
+      sd-uhs-sdr50;
+      sd-uhs-ddr50;
+      sd-uhs-sdr104;
+      sdhci,auto-cmd12;
+      compatible = "brcm,bcm7216-sdhci",
+                   "brcm,bcm7445-sdhci",
+                   "brcm,sdhci-brcmstb";
+      reg = <0x84b0000 0x260>, <0x84b0300 0x200>;
+      reg-names = "host", "cfg";
+      interrupts = <0x0 0x26 0x4>;
+      interrupt-names = "sdio0_0";
+      clocks = <&scmi_clk 245>;
+      clock-names = "sw_sdio";
+    };
+
+    mmc@84b1000 {
+      mmc-ddr-1_8v;
+      mmc-hs200-1_8v;
+      mmc-hs400-1_8v;
+      mmc-hs400-enhanced-strobe;
+      supports-cqe;
+      non-removable;
+      bus-width = <0x8>;
+      compatible = "brcm,bcm7216-sdhci",
+           "brcm,bcm7445-sdhci",
+            "brcm,sdhci-brcmstb";
+      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
+      reg-names = "host", "cfg";
+      interrupts = <0x0 0x27 0x4>;
+      interrupt-names = "sdio1_0";
+      clocks = <&scmi_clk 245>;
+      clock-names = "sw_sdio";
+    };
-- 
2.25.1

