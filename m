Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB49446C90D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbhLHAlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbhLHAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C61C061756;
        Tue,  7 Dec 2021 16:38:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v19so410889plo.7;
        Tue, 07 Dec 2021 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=n7kELrhffxVMHCSp9WGkaFU2pI+FIFS+p4OTa80lrPVhYIJtx4NpnGuI+hLbPF3ovE
         MVn0osiS4L2ctrbSIwmi2j0ENDap4DVQwSafIuPQNqlrS1l6CXRKullKrHWLd4eEN/dj
         K7KU4kEAaD21RNWHFfP0Km7/zdA5e1CVDnqd0jpm8qsDLzZQKgRjVUCujcH73xOrZym5
         IMZEU3Lyh7q7i5cw2/GyVrrbjDPxHlXNnEBqj23pJ04CDaT+4GmmzSsaku6ALGKtCbHO
         Um9nwmn3iI3nyLpvZybcG9PNuZov8m5x3Bq+rohgceRXjQtz5AYJ2FRLR9O/9nOlNM6x
         Jb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=k22AlU0fqnx2FJL7ENxEb9EUNdgLh83wYP4vHerW2GvjWv+OXf1lWOWna2eN+QKXY1
         zyVd1eC9SzpSbknWWEvtkOyiBrcMv5rE1gD+dGXr6CoU4p23DUsAN+o8YS5MtKQieLz0
         PY/UQ0s9Fz7SpcJCgkfFiEUyGoDiiww5JaoumDV9zd/Xlx8kUoSbUvHA7sWjJHImMzth
         Pi1hCrq85oqETxsEzYd1huE1I04HVbQfob5Co4TNSUofOC0/p4AcF+8pJyWI/x6bT32T
         lv3odJ4LFiFjDVm0KEPtFfdCZ82GRT4JH9mN34SRRiHTShf47vgS9GqQzap2AjL29qtB
         Jebw==
X-Gm-Message-State: AOAM530Wtmzv9Sh1qoNtrCVpbqOLpjNOP1r10r8EhsvQVMaoZwgKk465
        SDzNfdAkbtBAlFAj/3ixcPoPIDGrIpA=
X-Google-Smtp-Source: ABdhPJwdkXLYram2X0VAx3+lx9ktYR/gKElEtr6KApvr9n1C0mOLopmtUweBQNkRlIEdAOG6llx6ug==
X-Received: by 2002:a17:903:2082:b0:142:7dff:f7dc with SMTP id d2-20020a170903208200b001427dfff7dcmr55643879plc.46.1638923881574;
        Tue, 07 Dec 2021 16:38:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:01 -0800 (PST)
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
Subject: [PATCH v3 08/15] dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
Date:   Tue,  7 Dec 2021 16:37:19 -0800
Message-Id: <20211208003727.3596577-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
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

