Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F34657A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353277AbhLAU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353126AbhLAUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A84C06175D;
        Wed,  1 Dec 2021 12:51:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so18898366pjr.5;
        Wed, 01 Dec 2021 12:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=FYVCsy5HygTaGGtShSbQsAvYPLc2w/7ZTB05srpm2LzZB+wkiJ3Nn7QpEsaeSgGmPj
         +vlE2ycGHLkd75e6jWOeU4FWp5YeNgsARj6l/ebhbmShWQsscKJ7D6dGpZtrNVZ4uoT0
         2gFV4sKsvprstsU7xJo1Q5k5iY9sBZWIP/Sx9TroQ1DQWCCJtxhnRdQhyyDi+wL13mm2
         5zev9SmX32IFmEtoXcmvojmTqQ3GA9zyT9vU+jHTi9A1Z0w18XogRJxm3LvgSmBmK9pL
         94EtXueZpBvGqlNJt7aC6lTyoaq7fHryURIDHeu5J08zxFBQ7xvQi0JohXd7takxVJVh
         7wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=TR2Zl6eGASepNFgE99od9tCqqBVDRqSOawx0s9GQH1nehp0bVgvUei9NpyA/FHQAc2
         2lRgZwLFJ7/Q/C6fIJfebsySOeDJ38FZBpSVbTO4HgP7Om2qAELs6JkvVbQjzxnCM4fA
         EvqRwELuvD8FU8a48OO8NHbh1muCBdGspyQyZJ0mBUIihfbevLEBt8Jh1DAi79j1l+pb
         bj7vw10nKEhajHH2gltBBzH/q7IQfwJd7Yo+meJLRshLGEofKiOb419rlXcOwcwEYwE3
         Et1yqwJxqa07fF8Qmwsx0K5j1aGpyREo+RNe8mtT/sC3itYJZnewZ+oA3MKAbxzRWDp7
         Ynbw==
X-Gm-Message-State: AOAM531fICaUOU/IOGTwDFF9XPGPGxXSY6jMs6OdxQRv4yP+YzHdz3H2
        O2Lf9KTrf1c3LrwkB8YKaiFu0hzjKc8=
X-Google-Smtp-Source: ABdhPJwHzRvEaBbpXXFrDBpnfhlkM8jTyvUa66WT//nOJrVwU/fUe+YFZfhL4JjqAiXTwn+wP3jIJw==
X-Received: by 2002:a17:902:7fc5:b0:143:6d84:88eb with SMTP id t5-20020a1709027fc500b001436d8488ebmr10066145plb.61.1638391899426;
        Wed, 01 Dec 2021 12:51:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:38 -0800 (PST)
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
        Matt Mackall <mpm@selenic.com>,
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
Subject: [PATCH 01/14] dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML
Date:   Wed,  1 Dec 2021 12:50:57 -0800
Message-Id: <20211201205110.41656-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
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

