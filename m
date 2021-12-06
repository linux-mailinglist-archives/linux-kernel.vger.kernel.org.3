Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97EB46A40E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbhLFS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbhLFS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D04C061746;
        Mon,  6 Dec 2021 10:26:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so11451251pjb.5;
        Mon, 06 Dec 2021 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=eNQHw5bfEmKeuRKOeqsmOdr5LTKwGGQ4WS71oUXDJjIUPS3gmmLXbFhVfn1pD6JIQZ
         sEBhgXmd+sFmLmY4WS3muh5TtMOz4OgkBaNEzmS/65lY+9ZpaE8QnzKsX6RiZQTiEv99
         JZE6IAMriRlo+yW+wp75BYhnU8QYbfHLSNjEiAxd4P3DAoaq5AIO5arpHLV3Tp93cB4b
         wAwemYajz2mCMxxZMmPz+fHFcajsbYyB/oBR46+kxY5YEucIMkSzSvk45NSSJnOWnBC2
         hIksqvcGOP2cjMar/65cjZ5Rb3Lk9BMRssurnQicHAuMI6XMi9DkEndBiIy/7NUiXjF8
         j7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzt07ce1bSe7/IbkVLZBOEgGkOAfA/4NDEECalTgWJE=;
        b=O7GzEctdaguL/Fry4RxPz5EzvkKKF/6pTuGWNHjHbrL9tWISR4uYYicspNJ1LMQonn
         dLVd8AL3hhZXdE1R91L5HV/WIeaJUsOeESLce2ZNNq1CpLUepkTMrjz8vhFQyVONEnv5
         OCeesrLBlA49aTA9806YfVU0kqKYkDRCrlvip3ZzZwqgrwZLdEUdKOLiUKXAzI3fu1Yj
         ZdK1MYo5/Ubd+lDfbiNnVqO33t2dekOAgfcxkn4ElkwaN8UHlgXbGcsY2pYQPnd/J62K
         nQ5eE8ObRImIEk43QaDieVzNd1iv2T+QPkpWs08HuFyzTC3xiVuNino45gN+t3j70omk
         OflQ==
X-Gm-Message-State: AOAM533G8owyDcnB2TiVspqfG+4obMg92DGvPF99ebgYFeAnyGBtt0sm
        PE+MLk1zA2G5zj7KKtOAMWbX4RqCYgk=
X-Google-Smtp-Source: ABdhPJyB6ohvgdqzysJ/iWhFHVpDgmJ/i2d87Fww1cHgwneBy7bvAqmq0tAzypchOKnczWpiapqscQ==
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr205063pjb.177.1638815181930;
        Mon, 06 Dec 2021 10:26:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:21 -0800 (PST)
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
Subject: [PATCH v2 01/14] dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML
Date:   Mon,  6 Dec 2021 10:26:03 -0800
Message-Id: <20211206182616.2089677-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
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

