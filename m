Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E046A46D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbhLFSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbhLFSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F7C0698C5;
        Mon,  6 Dec 2021 10:26:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so551585pjb.5;
        Mon, 06 Dec 2021 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=mXflqqCSqu7jgfThgaZhO/L5W9cJx9zfLPKfDRfXLNR8VGeCrrdomqPg574ueb8b/H
         JQQAN7LR4BhCLUGuDIGbAiIDxtMPgjP36PDM75blvH6LXPswzDnmIV71NimFKnLulh3k
         X1zaq/EjEsrcUNGPpd6ZRDgfYhT9cUwyOM99MWFtlf+vOV1Ohbgww8ZafFPjHiaJqsXt
         EtYWG717PgOAaBz+6Q7SJB4hsvix/gfd0WuwmAWcqKe25okx13Zd+ecKxMDumsLK9IXp
         8y+N20o7W9M9mwnwYYQ8zNTYKGc7Bq+W2EZFOY/9b81z1JhMRpiH6iejaDlua4byvtnW
         kalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHsb1rXkFFF/5VyRHKhImaCsYA2F/4ddGcGA/wMvypA=;
        b=UrWK/19jK4y0UjnnE/mjaAU+bx6CPKcTbPcUAQrLvE0PwIj+q+nnrRtRFRhY0eXB8b
         8Z6smVxYcQQ6VDHcDnNSStrlRvtNwa2kRqB1z/7PIA/iRa1iBehDYHr/zCf468m/43s8
         s7EPDZ3R9vUnMsHp/agM3do0rpHu8Lq7+MkeIMGBdBu3Awsf+x7wadZ9lfWtzsqSJFJf
         3n61AStdCasOiYlgcd3Zti7tgSlUZaN7/C9a6ATpThV5UTslPQF7Dal37q0i9GvvG76Q
         2PWvud/EDTjFp4oGki8H0lUeOR8BaY/olT9s38/zXDAh/2okVAnYy5WvYzu1XS2ovfOd
         xm1Q==
X-Gm-Message-State: AOAM531dhYwoupCfmUoQ7Fntd6PJu0v4Zalq31uL0ErhCImrHYcTYKEA
        7EXY5IlRvZ1CEu0uYAoyeOzLpVBbgJw=
X-Google-Smtp-Source: ABdhPJyWHg/xjf6fl5DH+njiD1fPZSp9NRNqPNBsQoRBEP2tRQ/Ndaa1r3dCQNHWppK0XoE/Y3zSGQ==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr234601pjb.11.1638815196416;
        Mon, 06 Dec 2021 10:26:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:35 -0800 (PST)
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
Subject: [PATCH v2 08/14] dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
Date:   Mon,  6 Dec 2021 10:26:10 -0800
Message-Id: <20211206182616.2089677-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
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

