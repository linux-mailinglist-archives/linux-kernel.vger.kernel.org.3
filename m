Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971FE4657F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353262AbhLAU60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353197AbhLAUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BDC061574;
        Wed,  1 Dec 2021 12:51:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g19so25790505pfb.8;
        Wed, 01 Dec 2021 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyqPfy+ha7iGIoQvE1EgZWcwITDPm37FB0rLdMo+0Ks=;
        b=ahgMQi9NYSNiOMyIDOAM6LIuztlz9rrwQqWzWcsdhBtI8f/vR9SsvblGWW9jNbhiuz
         nNh+mGDLb4wXunnnrJVzBdgJ8rEMjDBbdt1EArr7LL+vC1n/D7Z/xpS44C3yoHPerP0h
         U5qhXQFdVjR2RcJOitSOzu9usXf4lOIBg4t/ZODQy6w7HuRyqjeIBCr0FcTQieB7OW9U
         rv1z/rnWLCjJhq+cH1fyNPnApIx2+JMxg2v7gzDzDGKLoXqYoGw1ygKznEW+QLFL6PEK
         8BwyJIXWc9UuPkr59NBN9P7oub36O8xYBUiTM+092br/myTG7S+Kf5SQwtaUgcPnYLhC
         wyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyqPfy+ha7iGIoQvE1EgZWcwITDPm37FB0rLdMo+0Ks=;
        b=FTIlHI2r46dq8G/U49HSoEuI3KbryxbkKGxO4fqYrTDaGl5iFv/mdKxdV3X9YZsyVl
         C7Dl+gYciAXwecdED+UUgdZ0vtV/vzq5eksUhSNmHIipclSxrs4BafEGQLInLhLya91h
         KhEVHjMwjvpfCHkI6wQ+LsGUNgggOqpmVuAvQFU/U6uewVzvg6yT8XLYxzKTjRd80/Mg
         x4BcZIqd+W8DI0VsfcGnXcEQ6BtsN6oHVPwaIa0l0MjbXtDcQJaMT+9MRuOcdcgLE3+D
         3jTpNrwbqDN7X/XDn6ZyCnhOwH1/WAVejqMuH22+eTbg+3zF5qPDoy3hgr3+B3YImtDI
         /6AQ==
X-Gm-Message-State: AOAM532agRT31VRTtw7y1RiM+lDKVErvwvqqT+TOJtCF+u9UgAZ7RI8m
        U+jJ9ckUwlrnl0yML37LSF1Pp9KvFAM=
X-Google-Smtp-Source: ABdhPJyQBLDrAU6fZBRUfkRwFJYFHbLSgrB7zO4DZiT6BGmVfKzKjvYw4t4k/65pmx1Yj1+fOHrR0w==
X-Received: by 2002:a05:6a00:cc8:b0:49f:c4a9:b9f1 with SMTP id b8-20020a056a000cc800b0049fc4a9b9f1mr8409092pfv.32.1638391910140;
        Wed, 01 Dec 2021 12:51:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:49 -0800 (PST)
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
Subject: [PATCH 06/14] dt-binding: interrupt-controller: Convert BCM7038 L1 intc to YAML
Date:   Wed,  1 Dec 2021 12:51:02 -0800
Message-Id: <20211201205110.41656-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
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

