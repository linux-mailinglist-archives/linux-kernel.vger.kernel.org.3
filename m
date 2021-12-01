Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2119465809
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353560AbhLAU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353232AbhLAUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3660C06174A;
        Wed,  1 Dec 2021 12:52:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z6so18649904plk.6;
        Wed, 01 Dec 2021 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+SJkx7gZpNSKY4hP5L7YJpSZTXuOMEA5gcyCCsEvsg=;
        b=HlQUEM8THquWt6x0dLOJGG/7ST0cRNjhD2RO0NxDe9QDgSRYzpjnChlTkF+gPXhz62
         qVgHu+jifwqKySgi9hwWXucaQbivTi3wBwJEieRnadI95e+5Dzfjd4spx/f3E6IqpqwR
         lpSQZy00/0SlBL4eK7QRcv0WUfW3zqgVt8QkZZ4J1ibQiZi36+bieo67cjUPwRDAwDIB
         R5Jq3sfjH22mxgMpjYrqRm/mwO/ZJfGXda01W/4VRt2MREcIyfQBQraq40rIlrfsV825
         6Vm5O3PqWnB00RDHSa+RE2CtLEJCLuX2Q1TVb91F/wl1g5qZk69eWgpneUfXRnExaumJ
         zG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+SJkx7gZpNSKY4hP5L7YJpSZTXuOMEA5gcyCCsEvsg=;
        b=h1lVr1At93Gj6bXPHRuhpVmU00IYelLkhCvt0QPbG3kdErq9ypb3UtL3zGrWTMIY/L
         MUkbUx5OKXfWt9uSD3XexvK94o8HrfVqQa7yrwJC3cigDSZQa5J2zOBJ1211mpE1g8hK
         YTjV/vhtHUJCtHk9KzzTH3dr7cq2JUvd2MtoTEUZQH2YP12Ht8EpkRZ9748koikRPtgy
         ON2+6+of5CAZtGzRUEOSlTY8z0wR+ivrj0zZevOmsNWosmcIurEGdp4ZguKt3AN0UvY0
         X2YvyVU11Bsgd6SC1GYMegMA/lWBdRgA9kKSca00D16ZgpOhgWvP7qVcxFArmvH4j6Fb
         sdhQ==
X-Gm-Message-State: AOAM532mYqSlR60Gxf0MsbX9+Ithp8/F1LeHO4bftgRZ+9abgDctxRsm
        ABpDKrtzhH2Xb6m7cecK3rObQ8JnG1Q=
X-Google-Smtp-Source: ABdhPJycFkYcanZu711/X/cGVfD11g1lE+wluwV3VRtNHqKIZWwA+CdO5KEBLg047YADwpUvmJSe5Q==
X-Received: by 2002:a17:90b:19c8:: with SMTP id nm8mr725245pjb.163.1638391926915;
        Wed, 01 Dec 2021 12:52:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:52:06 -0800 (PST)
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
Subject: [PATCH 14/14] dt-bindings: usb: Convert BDC to YAML
Date:   Wed,  1 Dec 2021 12:51:10 -0800
Message-Id: <20211201205110.41656-15-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom BDC device controller Device Tree binding to YAML
to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/usb/brcm,bdc.txt      | 29 ------------
 .../devicetree/bindings/usb/brcm,bdc.yaml     | 46 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 47 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
deleted file mode 100644
index c9f52b97cef1..000000000000
--- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Broadcom USB Device Controller (BDC)
-====================================
-
-Required properties:
-
-- compatible: must be one of:
-                "brcm,bdc-udc-v2"
-                "brcm,bdc"
-- reg: the base register address and length
-- interrupts: the interrupt line for this controller
-
-Optional properties:
-
-On Broadcom STB platforms, these properties are required:
-
-- phys: phandle to one or two USB PHY blocks
-        NOTE: Some SoC's have a single phy and some have
-        USB 2.0 and USB 3.0 phys
-- clocks: phandle to the functional clock of this block
-
-Example:
-
-        bdc@f0b02000 {
-                compatible = "brcm,bdc-udc-v2";
-                reg = <0xf0b02000 0xfc4>;
-                interrupts = <0x0 0x60 0x0>;
-                phys = <&usbphy_0 0x0>;
-                clocks = <&sw_usbd>;
-        };
diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.yaml b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
new file mode 100644
index 000000000000..48831b62ab31
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/brcm,bdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom USB Device Controller (BDC)
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bdc-udc-v2
+          - brcm,bdc
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  phys:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+        bdc@f0b02000 {
+                compatible = "brcm,bdc-udc-v2";
+                reg = <0xf0b02000 0xfc4>;
+                interrupts = <0x0 0x60 0x0>;
+                phys = <&usbphy_0 0x0>;
+                clocks = <&sw_usbd>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index 11808be8e128..2f657775eb59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3690,7 +3690,7 @@ M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-usb@vger.kernel.org
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/usb/brcm,bdc.txt
+F:	Documentation/devicetree/bindings/usb/brcm,bdc.yaml
 F:	drivers/usb/gadget/udc/bdc/
 
 BROADCOM BMIPS CPUFREQ DRIVER
-- 
2.25.1

