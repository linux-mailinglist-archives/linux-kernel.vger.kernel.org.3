Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124AA46C8F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhLHAl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbhLHAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88866C061574;
        Tue,  7 Dec 2021 16:37:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p13so989593pfw.2;
        Tue, 07 Dec 2021 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THIwWXg0h2F7s9TQGRLyH26oXehxL6H4hVbVlWji9hY=;
        b=pidoivv+69Yr2jAN9oH4Z705d89ITZ8RuzbseDWTjChk3h4auqu1wDth2wQCYlkZuQ
         1Iy5PzJ+CEYvrXxoFnAEST8l7D2K/bRtiN3p/s5cbvjHkT8669N0tqT7i/vo/FOQHW92
         azlxRjzBGH50hG/wrC+swpvgTZ2mRIP5Q43NPv/0X1wKsIrYjsv0LEIcUELmSOLyVk69
         nMM1ET9sBZl2XayzHApZCrh5kEqel5PLCaB0tWZ7I+ghoYkcY5mSLmNLTMBWl+IvGmQl
         fvRM7c5ccyF48ug15LJ2dXneTlAEPjc1s/oN9s7EsLv5jUpBM3OAuE18/jvnZ59AGzFs
         Gzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THIwWXg0h2F7s9TQGRLyH26oXehxL6H4hVbVlWji9hY=;
        b=2MrYT07zVja9ajDFR58jmwRe++4Ebd55Q5fra/ZCj3hojsqzbNEXJiBp7QWsnHA2wg
         kBriUhee6I8w4HTw8hl2sUNdhNEC3oj3R4wasRIqHlfSn7Ddo1bb6OB2zOAZ78W6T8N9
         K00yiSGrSg/T8jLAQ7IapgYd2zhsKWhIWGuuFbUrtJeQx/kFMibW6Lhvp9Q5gBar+qnx
         86+KZZrQ1vN+ruRXMvJckrJaVDGXpEWrk32rwMnECuLPQ+DLvBwyQUktTUt2KdwfUmHk
         auepuLhtjHpLSdVqXH0dZSDJbpLN+pCCKjG4fPV+sDX9+N3Gy+/UxaYjT0bs7ACvB+Bp
         JkcQ==
X-Gm-Message-State: AOAM533vPAl6Nj73xS4uzCwXLBVKjrS2SUxcs1rSdH6MP6X/vh/vL96m
        2omuMJY28aGwD3JmalJrFJwmB34DsYo=
X-Google-Smtp-Source: ABdhPJzZqyMLvlaWNRhkO9cmawnZEMcoaSL+880Or3pugpuJhCSbMtbcWHn1brSsPJ8OjVGNeTYH2w==
X-Received: by 2002:a63:e901:: with SMTP id i1mr27026983pgh.582.1638923871591;
        Tue, 07 Dec 2021 16:37:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:50 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v3 05/15] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
Date:   Tue,  7 Dec 2021 16:37:16 -0800
Message-Id: <20211208003727.3596577-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
validation.

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
 .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 106 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
deleted file mode 100644
index 5d468ecd1809..000000000000
--- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Broadcom STB "UPG GIO" GPIO controller
-
-The controller's registers are organized as sets of eight 32-bit
-registers with each set controlling a bank of up to 32 pins.  A single
-interrupt is shared for all of the banks handled by the controller.
-
-Required properties:
-
-- compatible:
-    Must be "brcm,brcmstb-gpio"
-
-- reg:
-    Define the base and range of the I/O address space containing
-    the brcmstb GPIO controller registers
-
-- #gpio-cells:
-    Should be <2>.  The first cell is the pin number (within the controller's
-    pin space), and the second is used for the following:
-    bit[0]: polarity (0 for active-high, 1 for active-low)
-
-- gpio-controller:
-    Specifies that the node is a GPIO controller.
-
-- brcm,gpio-bank-widths:
-    Number of GPIO lines for each bank.  Number of elements must
-    correspond to number of banks suggested by the 'reg' property.
-
-Optional properties:
-
-- interrupts:
-    The interrupt shared by all GPIO lines for this controller.
-
-- interrupts-extended:
-    Alternate form of specifying interrupts and parents that allows for
-    multiple parents.  This takes precedence over 'interrupts' and
-    'interrupt-parent'.  Wakeup-capable GPIO controllers often route their
-    wakeup interrupt lines through a different interrupt controller than the
-    primary interrupt line, making this property necessary.
-
-- #interrupt-cells:
-    Should be <2>.  The first cell is the GPIO number, the second should specify
-    flags.  The following subset of flags is supported:
-    - bits[3:0] trigger type and level flags
-        1 = low-to-high edge triggered
-        2 = high-to-low edge triggered
-        4 = active high level-sensitive
-        8 = active low level-sensitive
-      Valid combinations are 1, 2, 3, 4, 8.
-    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-- interrupt-controller:
-    Marks the device node as an interrupt controller
-
-- wakeup-source:
-    GPIOs for this controller can be used as a wakeup source
-
-Example:
-	upg_gio: gpio@f040a700 {
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
-		gpio-controller;
-		interrupt-controller;
-		reg = <0xf040a700 0x80>;
-		interrupt-parent = <&irq0_intc>;
-		interrupts = <0x6>;
-		brcm,gpio-bank-widths = <32 32 32 24>;
-	};
-
-	upg_gio_aon: gpio@f04172c0 {
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
-		gpio-controller;
-		interrupt-controller;
-		reg = <0xf04172c0 0x40>;
-		interrupt-parent = <&irq0_aon_intc>;
-		interrupts = <0x6>;
-		interrupts-extended = <&irq0_aon_intc 0x6>,
-			<&aon_pm_l2_intc 0x5>;
-		wakeup-source;
-		brcm,gpio-bank-widths = <18 4>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
new file mode 100644
index 000000000000..8c27932df2c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/brcm,brcmstb-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB "UPG GIO" GPIO controller
+
+description: >
+  The controller's registers are organized as sets of eight 32-bit
+  registers with each set controlling a bank of up to 32 pins.  A single
+  interrupt is shared for all of the banks handled by the controller.
+
+maintainers:
+  - Doug Berger <opendmb@gmail.com>
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7445-gpio
+          - const: brcm,brcmstb-gpio
+
+  reg:
+    maxItems: 1
+    description: >
+      Define the base and range of the I/O address space containing
+      the brcmstb GPIO controller registers
+
+  "#gpio-cells":
+    const: 2
+    description: >
+      The first cell is the pin number (within the controller's
+      pin space), and the second is used for the following:
+      bit[0]: polarity (0 for active-high, 1 for active-low)
+
+  gpio-controller: true
+
+  "brcm,gpio-bank-widths":
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      Number of GPIO lines for each bank.  Number of elements must
+      correspond to number of banks suggested by the 'reg' property.
+
+  interrupts:
+    maxItems: 1
+    description: >
+      The interrupt shared by all GPIO lines for this controller.
+
+  "#interrupt-cells":
+    const: 2
+    description: |
+      The first cell is the GPIO number, the second should specify
+      flags.  The following subset of flags is supported:
+      - bits[3:0] trigger type and level flags
+        1 = low-to-high edge triggered
+        2 = high-to-low edge triggered
+        4 = active high level-sensitive
+        8 = active low level-sensitive
+      Valid combinations are 1, 2, 3, 4, 8.
+
+  interrupt-controller: true
+
+  wakeup-source:
+    type: boolean
+    description: >
+      GPIOs for this controller can be used as a wakeup source
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - "brcm,gpio-bank-widths"
+
+additionalProperties: false
+
+examples:
+  - |
+    upg_gio: gpio@f040a700 {
+        #gpio-cells = <2>;
+        #interrupt-cells = <2>;
+        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+        gpio-controller;
+        interrupt-controller;
+        reg = <0xf040a700 0x80>;
+        interrupt-parent = <&irq0_intc>;
+        interrupts = <0x6>;
+        brcm,gpio-bank-widths = <32 32 32 24>;
+    };
+
+    upg_gio_aon: gpio@f04172c0 {
+        #gpio-cells = <2>;
+        #interrupt-cells = <2>;
+        compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+        gpio-controller;
+        interrupt-controller;
+        reg = <0xf04172c0 0x40>;
+        interrupt-parent = <&irq0_aon_intc>;
+        interrupts = <0x6>;
+        wakeup-source;
+        brcm,gpio-bank-widths = <18 4>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..9ac67c885159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3761,7 +3761,7 @@ BROADCOM BRCMSTB GPIO DRIVER
 M:	Gregory Fong <gregory.0xf0@gmail.com>
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Supported
-F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
+F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 F:	drivers/gpio/gpio-brcmstb.c
 
 BROADCOM BRCMSTB I2C DRIVER
-- 
2.25.1

