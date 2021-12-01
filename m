Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839FE465803
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353398AbhLAU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353219AbhLAUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E36C06174A;
        Wed,  1 Dec 2021 12:51:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 137so17782510pgg.3;
        Wed, 01 Dec 2021 12:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMguhbDPLlBsGaFyDhaEHdw9cD0LjPHChE0ShcCNQmo=;
        b=WSdJzNWaIlNUXMBlW74KT6jtcQ/b51HgolRv2gDvsk+B+iyLlCEVj06vchhEowJDWc
         GQ1KXUts3yyGu3q2wxIdv4+mrPhlUxqPrIKGtUDxZ8Atwejmt/UVAI7Rs6/NCPmpPt71
         RvEuAKuVo2rW7oG57AQO1TummmompC1VHX0SiUvQlziSaZmSCY7HPMcaRqgIQ3dMJzOj
         LrFrRsw8zp/f/DeP7QvFDooZaLocE/KLneIPhfokSWI77xL75ZBQpxcsmdq2PQvnY4n0
         fxANo1P5xH42RthBL3Uj2aLQ4sLTlAV/ud0Ev5fb9ymKGfrVddxj0eR+MNNeUsq5tMgC
         csdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMguhbDPLlBsGaFyDhaEHdw9cD0LjPHChE0ShcCNQmo=;
        b=kQeZJCR6xJAoI8yOOYF19eOlYxGUoHL5yF+sLB2pQrHQ7+Rw7AGfY3TM4hSmHGgrt+
         H9AKHCz32XW+Iy+H5D8dI8A4JKdhbNK+IqnC6k4mRNwopt5wh5cOFBHJWSzuXQlDatph
         xUWI7SXRcJS/TagqaYGM3E2fsy6nx1hY9ldMVnqejfG4xEP6k/EZ4Vnr4k58Y/6v0xrj
         wdIBYW98xaGsS4bqhQHgQQdwFbns3XATsztI51nCpkGi2cTaBdwyBtsIgzOavMMJbvvo
         iKzqIUIs/8cnstIspHuouc/xC7qmdrWFa+kLcUPzrPsgXMxsnMX8Ok1IinrIgekzDw+Y
         LcBA==
X-Gm-Message-State: AOAM5302shmTUOVMENf/ydlyRpSMG3JCbOrtp3SWvxCD4ZxX5LCGVQ/c
        IP3oyyxi5qFOdmwBUQBhtd95fYKCkJw=
X-Google-Smtp-Source: ABdhPJyhYPqigqfiAZTXUuruN2RSDO7VVigD5tnrTw4+2ZM6A0ZySvz+/9vEhQbTiP4hjqoD0NvkMw==
X-Received: by 2002:a05:6a00:8cc:b0:4a8:262:49e1 with SMTP id s12-20020a056a0008cc00b004a8026249e1mr8696983pfu.28.1638391916406;
        Wed, 01 Dec 2021 12:51:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:55 -0800 (PST)
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
Subject: [PATCH 09/14] dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
Date:   Wed,  1 Dec 2021 12:51:05 -0800
Message-Id: <20211201205110.41656-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
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

