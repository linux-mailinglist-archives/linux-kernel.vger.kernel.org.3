Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C083B46A47C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347156AbhLFSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbhLFSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B6C061746;
        Mon,  6 Dec 2021 10:26:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b13so7644447plg.2;
        Mon, 06 Dec 2021 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMguhbDPLlBsGaFyDhaEHdw9cD0LjPHChE0ShcCNQmo=;
        b=WcX1YxeUHujtnpmhknxX67pqcGzfnhE7LaqRGQ3kJpJVmmabBDfKBdzu44SrvPUXzz
         l8Br3qGV0XAs9fe/EJUUsxba8Im+TviK22yqgpi7SpAy9Ug35WA4H3YocHaqiG5ZpNsa
         cJAEsTBhrZYgvc6bzLOrijfZByDJbPontK7bY8zEUqJ0ICylDFwWNcFcs4yiMFVU6U+Z
         fL8SHUYfLM56ajViNOfuOmzPQUq+B7RevQjXnOhBYE3hP7Kqz7LxYfxjkyWHejMNkXkt
         yDVOmkOWbbpFCdJ8L8CR5e6NpcUXB4JkMrhh4joatJ1/iMiXhZmG+woxEG3DTx5eiZm+
         Ydkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMguhbDPLlBsGaFyDhaEHdw9cD0LjPHChE0ShcCNQmo=;
        b=8ArBakeJEAaQtDor+epahBpXcWZ2oI1AMXt7SUIbZjUt3+2gAdtRhQeSW6RxzQ56tg
         sutHFdIMEY38X2zS1ciyNdK4bjzUB9mFz7bQ7EQm7OPFpJWEF19F9ToZ58hFRVZ/UZIl
         6D52AkLQydN5y0d3tgTs1F0qOvyN4hWhck3J74LI5695zgCKNjQiVHMKkW1nhQEMQp1l
         laVM0375q2NMRbpuGxBGD/eIKieJ/1ZGthhkfa9tQ7dQghEhbaBiUX64jkcKn6+d69fm
         wqTsly2gA3tU0hN96sxe91WtKrrbNcAkE1yl7Rs/A/2n5aXCNSOmGlzl+vB7ZA2DLudw
         9wzw==
X-Gm-Message-State: AOAM531/UXp1rI8ZOXdBmZvPfQY/+1ib0TjQuZO59h9DwSjmo/pbpS7T
        OYi/nDxxXGtVP9bCRgx48kT+rAau1fg=
X-Google-Smtp-Source: ABdhPJxBx2i6aQwCIbyyW0LzmXHbVJnh2s06Ie4/DP5Sgcd3MoKZcjoZNl4BIR7/42LS2VQsV/ND/A==
X-Received: by 2002:a17:902:d4d0:b0:141:c13d:6c20 with SMTP id o16-20020a170902d4d000b00141c13d6c20mr46404783plg.44.1638815198589;
        Mon, 06 Dec 2021 10:26:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:38 -0800 (PST)
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
Subject: [PATCH v2 09/14] dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
Date:   Mon,  6 Dec 2021 10:26:11 -0800
Message-Id: <20211206182616.2089677-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB L2 generic Level 2 interrupt controller Device
Tree binding to YAML to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../interrupt-controller/brcm,l2-intc.txt     | 31 ---------
 .../interrupt-controller/brcm,l2-intc.yaml    | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
deleted file mode 100644
index 021cf822395c..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Broadcom Generic Level 2 Interrupt Controller
-
-Required properties:
-
-- compatible: should be one of:
-	      "brcm,hif-spi-l2-intc" or
-	      "brcm,upg-aux-aon-l2-intc" or
-	      "brcm,l2-intc" for latched interrupt controllers
-              should be "brcm,bcm7271-l2-intc" for level interrupt controllers
-- reg: specifies the base physical address and size of the registers
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an
-  interrupt source. Should be 1.
-- interrupts: specifies the interrupt line in the interrupt-parent irq space
-  to be used for cascading
-
-Optional properties:
-
-- brcm,irq-can-wake: If present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Example:
-
-hif_intr2_intc: interrupt-controller@f0441000 {
-	compatible = "brcm,l2-intc";
-	reg = <0xf0441000 0x30>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	interrupt-parent = <&intc>;
-	interrupts = <0x0 0x20 0x0>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
new file mode 100644
index 000000000000..b1e812e7c714
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Generic Level 2 Interrupt Controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,hif-spi-l2-intc
+              - brcm,upg-aux-aon-l2-intc
+          - const: brcm,l2-intc
+      - items:
+          - const: brcm,bcm7271-l2-intc
+      - items:
+          - const: brcm,l2-intc
+
+  reg:
+    maxItems: 1
+    description: >
+      Specifies the base physical address and size of the registers
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts: true
+
+  brcm,irq-can-wake:
+    type: boolean
+    description: >
+      If present, this means the L2 controller can be used as a wakeup source
+      for system suspend/resume.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+examples:
+  - |
+    hif_intr2_intc: interrupt-controller@f0441000 {
+      compatible = "brcm,l2-intc";
+      reg = <0xf0441000 0x30>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+      interrupt-parent = <&intc>;
+      interrupts = <0x0 0x20 0x0>;
+    };
-- 
2.25.1

