Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B496A465800
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353384AbhLAU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353213AbhLAUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:17 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C571C061748;
        Wed,  1 Dec 2021 12:51:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q17so18625717plr.11;
        Wed, 01 Dec 2021 12:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=ErkLAXD8PrLpwTlxaFyc/UrvrU0jJn8RFKnjQ3H4/8XUbQLpN38SnKk0fKmSIkXwKA
         apCrqIKrq7kzxTb8jyKuL+flofOxXPnvTFVjUknMe5nVzyXIaAxxr2GZe1Yck1TfRNcL
         iHLo8QkHwIO/ogo8PT+15jsAV4Z0c0LoLU2FZmoWtx1yKz7aVbrofpgJ5kxYqrPkSyW6
         1dpfonv/plehaQrsRYA2bBxAEaSyxj6elCeJw3cKFir+S1uREYVI+C++HmgprdDP066G
         iXLXNisK0nwP4v5m++kM53+tyeFu+PCFH5SY+yRPYstfGcap7NTAEziXNRSsQLv/3DLt
         GUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=tUkB2wFu1CcBzKw3tweUhwaH4aLInaX8ivjO1Elpc16LM4hbmYe29B1pwgR9ZVNa0Y
         TLPrJkB6dQNzIRTlu0HVzHV2w5Fv5guan9MQjNcU0gUTqrc3dLyMdKhzlMqzvW0PEVRP
         gRkTAanIpss5OHmF9bpNdXPmZFgnMhL8VbQ27x6HSl64IQMIHvdJ2SGJKUh4UOtwj/TG
         Lz/lBdi4Eyv7spDaqzBvjaE9jJgLQcu49PM0ZFWV6a9evq+0h4rBdGElBhNz+Ny0Rp2r
         nN4Sw7oDXU92oG0AKjwYU1JNecuIpAl+bmj04SnVB6zqUVVupoCSFl+982mybY92r4ba
         nMQQ==
X-Gm-Message-State: AOAM531rnGJF4V/LI836r7iJokd8rPlw1Ya0XfL5dzozwVTxQIV9Jeq5
        NcJS646v7isRcGJYY58wY38WOsFKWRU=
X-Google-Smtp-Source: ABdhPJwzsIeJDsohrkfmVSgFtGBs8Bt7OWtFvCZDZlO8UUOb+tkMHAOeqE/TTMesjEPO9rL4g++ILQ==
X-Received: by 2002:a17:90b:30c6:: with SMTP id hi6mr718068pjb.201.1638391914462;
        Wed, 01 Dec 2021 12:51:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:54 -0800 (PST)
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
Subject: [PATCH 08/14] dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
Date:   Wed,  1 Dec 2021 12:51:04 -0800
Message-Id: <20211201205110.41656-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two bindings are very similar and should be covered by the same
document, do that so we can get rid of an additional binding file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../brcm,bcm3380-l2-intc.txt                  | 39 -------------------
 .../brcm,bcm7120-l2-intc.yaml                 | 30 +++++++++++++-
 2 files changed, 28 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
deleted file mode 100644
index 37aea40d5430..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Broadcom BCM3380-style Level 1 / Level 2 interrupt controller
-
-This interrupt controller shows up in various forms on many BCM338x/BCM63xx
-chipsets.  It has the following properties:
-
-- outputs a single interrupt signal to its interrupt controller parent
-
-- contains one or more enable/status word pairs, which often appear at
-  different offsets in different blocks
-
-- no atomic set/clear operations
-
-Required properties:
-
-- compatible: should be "brcm,bcm3380-l2-intc"
-- reg: specifies one or more enable/status pairs, in the following format:
-  <enable_reg 0x4 status_reg 0x4>...
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an interrupt
-  source, should be 1.
-- interrupts: specifies the interrupt line in the interrupt-parent controller
-  node, valid values depend on the type of parent interrupt controller
-
-Optional properties:
-
-- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Example:
-
-irq0_intc: interrupt-controller@10000020 {
-	compatible = "brcm,bcm3380-l2-intc";
-	reg = <0x10000024 0x4 0x1000002c 0x4>,
-	      <0x10000020 0x4 0x10000028 0x4>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	interrupt-parent = <&cpu_intc>;
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
index e0c6dce40d13..8be7fe29e6a9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM7120-style Level 2 interrupt controller
+title: Broadcom BCM7120-style Level 2 and Broadcom BCM3380 Level 1 / Level 2
 
 maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
@@ -59,16 +59,31 @@ description: >
   ..
   31 ........................ X
 
+  The BCM3380 Level 1 / Level 2 interrrupt controller shows up in various forms
+  on many BCM338x/BCM63xx chipsets. It has the following properties:
+
+  - outputs a single interrupt signal to its interrupt controller parent
+
+  - contains one or more enable/status word pairs, which often appear at
+    different offsets in different blocks
+
+  - no atomic set/clear operations
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
-    const: brcm,bcm7120-l2-intc
+    items:
+      - enum:
+          - brcm,bcm7120-l2-intc
+          - brcm,bcm3380-l2-intc
 
   reg:
     description: >
       Specifies the base physical address and size of the registers
+    minItems: 1
+    maxItems: 4
 
   interrupt-controller: true
 
@@ -121,3 +136,14 @@ examples:
       brcm,int-map-mask = <0xeb8>, <0x140>;
       brcm,int-fwd-mask = <0x7>;
     };
+
+  - |
+    irq1_intc: interrupt-controller@10000020 {
+       compatible = "brcm,bcm3380-l2-intc";
+       reg = <0x10000024 0x4>, <0x1000002c 0x4>,
+             <0x10000020 0x4>, <0x10000028 0x4>;
+       interrupt-controller;
+       #interrupt-cells = <1>;
+       interrupt-parent = <&cpu_intc>;
+       interrupts = <2>;
+    };
-- 
2.25.1

