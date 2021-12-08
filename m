Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2346C8F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbhLHAlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbhLHAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37DC061746;
        Tue,  7 Dec 2021 16:37:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3166751pja.1;
        Tue, 07 Dec 2021 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyqPfy+ha7iGIoQvE1EgZWcwITDPm37FB0rLdMo+0Ks=;
        b=jYdtMpG43bG6ryDdlZDpEpcF4CIxBioDh79VliRdEhVpUfx4NLrIqUc4zB/85AEfJm
         vzYIuGRtp+b4loCsGDQtIhRKdUQONikYkkQUDudBtprTtP3Xu8ptuZuPKJrMW6COjNB8
         enniVlbjMOAlI+v6ulIxl63zOoFG22r4W6DYE5/xw7ujnp1+/AE2FMUbPyh6dXcNcL62
         rlbtp94qoYe6GkIp+2/wHCnUeeYsWJLqo9542sPswCAhDIbDdW6Xla+n0C05PzGjopH9
         0/l3ZpSVEVKeDLKaJ0bvTYG9567Q+1PfmW3GPHpHXsjs7hXzkDYVOt5usVQwrpaqIh2Z
         6STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyqPfy+ha7iGIoQvE1EgZWcwITDPm37FB0rLdMo+0Ks=;
        b=TGcTH7uv3vMNdi+juNSe6CI6Gm9Nu9QYlzasMcm1ZHjfg6eYxBNw7Un6XmLtDx2M4+
         +EZdxDr0WzygQGE0JgCXavYujpyK/h+ExzMztaEgFsdEpM0BI6K8lqtVlEBAKTrmEYNH
         Sj4xgL0ToaMfo7pt7yBQNu7KbHAghT6L1AQp1/DSvlhn9UekRXlohSSNOBQ9g8alUdyE
         DUx2gYVhaXsK1QveF5/m+wOtcDitHCLpCLDn0dz+mmy78BAEd8ViJUp2I7BdloB/kfby
         0N6QTwv/sDejQLeOqFbide109rLDEqtVpULeI3XbNmsk8BhXDr0ont+BoBR8rtAgKZM2
         v5eA==
X-Gm-Message-State: AOAM532qMAMo2un7O4NvC4L2NpsKh6uY9xz24s7yWKNlwvLzLVPR1wl+
        tmD2seK7wyxh4VyT22mAo/DCGKpVlm4=
X-Google-Smtp-Source: ABdhPJx3J7JloTBEkhsWQ2S4p3ZMKcVvK6dlu407gkOckE9/Hv1D/W9a5dPoPtHXzlaMz79HHifCIg==
X-Received: by 2002:a17:90b:390c:: with SMTP id ob12mr3022327pjb.212.1638923874760;
        Tue, 07 Dec 2021 16:37:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:54 -0800 (PST)
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
Subject: [PATCH v3 06/15] dt-binding: interrupt-controller: Convert BCM7038 L1 intc to YAML
Date:   Tue,  7 Dec 2021 16:37:17 -0800
Message-Id: <20211208003727.3596577-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB BCM7038 Level 1 interrupt controller Device
Tree binding to YAML to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../brcm,bcm7038-l1-intc.txt                  | 61 -------------
 .../brcm,bcm7038-l1-intc.yaml                 | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
deleted file mode 100644
index 5ddef1dc0c1a..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Broadcom BCM7038-style Level 1 interrupt controller
-
-This block is a first level interrupt controller that is typically connected
-directly to one of the HW INT lines on each CPU.  Every BCM7xxx set-top chip
-since BCM7038 has contained this hardware.
-
-Key elements of the hardware design include:
-
-- 64, 96, 128, or 160 incoming level IRQ lines
-
-- Most onchip peripherals are wired directly to an L1 input
-
-- A separate instance of the register set for each CPU, allowing individual
-  peripheral IRQs to be routed to any CPU
-
-- Atomic mask/unmask operations
-
-- No polarity/level/edge settings
-
-- No FIFO or priority encoder logic; software is expected to read all
-  2-5 status words to determine which IRQs are pending
-
-Required properties:
-
-- compatible: should be "brcm,bcm7038-l1-intc"
-- reg: specifies the base physical address and size of the registers;
-  the number of supported IRQs is inferred from the size argument
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an interrupt
-  source, should be 1.
-- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
-  node; valid values depend on the type of parent interrupt controller
-
-Optional properties:
-
-- brcm,irq-can-wake: If present, this means the L1 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Optional properties:
-
-- brcm,int-fwd-mask: if present, a bit mask to indicate which interrupts
-  have already been configured by the firmware and should be left unmanaged.
-  This should have one 32-bit word per status/set/clear/mask group.
-
-If multiple reg ranges and interrupt-parent entries are present on an SMP
-system, the driver will allow IRQ SMP affinity to be set up through the
-/proc/irq/ interface.  In the simplest possible configuration, only one
-reg range and one interrupt-parent is needed.
-
-Example:
-
-periph_intc: periph_intc@1041a400 {
-        compatible = "brcm,bcm7038-l1-intc";
-        reg = <0x1041a400 0x30 0x1041a600 0x30>;
-
-        interrupt-controller;
-        #interrupt-cells = <1>;
-
-        interrupt-parent = <&cpu_intc>;
-        interrupts = <2>, <3>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
new file mode 100644
index 000000000000..5ecb6faa70dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7038-l1-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM7038-style Level 1 interrupt controller
+
+description: >
+  This block is a first level interrupt controller that is typically connected
+  directly to one of the HW INT lines on each CPU.  Every BCM7xxx set-top chip
+  since BCM7038 has contained this hardware.
+
+  Key elements of the hardware design include:
+
+   - 64, 96, 128, or 160 incoming level IRQ lines
+
+   - Most onchip peripherals are wired directly to an L1 input
+
+   - A separate instance of the register set for each CPU, allowing individual
+     peripheral IRQs to be routed to any CPU
+
+   - Atomic mask/unmask operations
+
+   - No polarity/level/edge settings
+
+   - No FIFO or priority encoder logic; software is expected to read all
+     2-5 status words to determine which IRQs are pending
+
+   If multiple reg ranges and interrupt-parent entries are present on an SMP
+   system, the driver will allow IRQ SMP affinity to be set up through the
+   /proc/irq/ interface.  In the simplest possible configuration, only one
+   reg range and one interrupt-parent is needed.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm7038-l1-intc
+
+  reg:
+    description: >
+      Specifies the base physical address and size of the registers
+      the number of supported IRQs is inferred from the size argument
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    description: >
+     Specifies the interrupt line(s) in the interrupt-parent controller node;
+     valid values depend on the type of parent interrupt controller
+
+  brcm,irq-can-wake:
+    type: boolean
+    description: >
+      If present, this means the L1 controller can be used as a
+      wakeup source for system suspend/resume.
+
+  brcm,int-fwd-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      If present, a bit mask to indicate which interrupts have already been
+      configured by the firmware and should be left unmanaged. This should
+      have one 32-bit word per status/set/clear/mask group.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    periph_intc: interrupt-controller@1041a400 {
+      compatible = "brcm,bcm7038-l1-intc";
+      reg = <0x1041a400 0x30>, <0x1041a600 0x30>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+      interrupt-parent = <&cpu_intc>;
+      interrupts = <2>, <3>;
+    };
-- 
2.25.1

