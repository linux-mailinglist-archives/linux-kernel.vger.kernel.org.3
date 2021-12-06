Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2897F46A466
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbhLFSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347278AbhLFSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C5C0698C0;
        Mon,  6 Dec 2021 10:26:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so369300pjb.1;
        Mon, 06 Dec 2021 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEHmtnBmv7jOA8xbBwMk+/p1lp/o/+UqjyoV8bzclQ0=;
        b=Dt7PElBrejLQorB8gg+mCqmyrGmxyrSzUdN4liR5GhswF1Tq8oT9bIvFMwPsjxzCAX
         8bSbOjKEGtHj6oXLxn9ExAC0NMv0jEMQfpLzvXBA3T3t+3ib+vAuvONSOxTud8hKjdgi
         9XjJoKWJ0bRTpM0mjLoBLFoI7ceEmuMbyoEsZeNMCA73/hRQYT132bbAGhzRoMKOw8BF
         rmtvTUlLQ5xjltblpLDQk0TfchSiluM9kPbdkZaO74ltNHXino/A3Dhqg2hr1HYt+jEL
         J4FL6dAxq64peNEYXs94xrTSOEeBJR11k+TnRpFcBtOwQE7szTbZZOrNV/obURfzc60k
         QUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEHmtnBmv7jOA8xbBwMk+/p1lp/o/+UqjyoV8bzclQ0=;
        b=mNvsG1KpCZA/SAtrlHd0jsCF+6YB5KMD2S0hh9LSAIglbQWNVe+4IHKHD9br1S4FgS
         Wnl7W8PL/EG+T0QOfknH9oOhKuno2JW8KoccK0oeti0wv2B3dVyBIsLvFp27sGFM7L2L
         JDWBNSgUJD7YD9BO71Gd4dLWQnkZSeZhoqfVAhihzjmkIBtobRo/efeECKGBNcBs9CxZ
         Tdntmf3qV/uVVcrN0fA9Ws+jTt5ZZqv3N7qKklAIEWBYw8N4pjfQMVQeyDlyAYxO/MDj
         msQjzDOXuyCff0jjHXPPeSfY0o9SFPZoh10uVaLqlE5IqxiIzmaxyW5eDNFnlZ7ARDUq
         4eeQ==
X-Gm-Message-State: AOAM530yh238M2dnaB7s7yD2uYmANt5HSz7e783nN5im5FYoIYjFa/Wa
        8+5Sa9TSI/X8n77Iko+40tis3fY1+yI=
X-Google-Smtp-Source: ABdhPJxRoNVg+5pWwvG4jcCSWuIicHxKyg+vaBWc7iivBM/rQhv97QUDFZVpxflLD2YLTikBuCpcHg==
X-Received: by 2002:a17:90b:1b07:: with SMTP id nu7mr262769pjb.140.1638815190071;
        Mon, 06 Dec 2021 10:26:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:29 -0800 (PST)
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
Subject: [PATCH v2 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
Date:   Mon,  6 Dec 2021 10:26:07 -0800
Message-Id: <20211206182616.2089677-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
validation.

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

