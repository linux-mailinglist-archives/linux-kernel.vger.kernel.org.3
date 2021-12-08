Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F046C961
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhLHAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhLHAmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:42:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBEC061A32;
        Tue,  7 Dec 2021 16:38:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so929072pfc.12;
        Tue, 07 Dec 2021 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ8xAlI4hSswSbvUfQzU0yk70eEsNl8mqXnileditR0=;
        b=EGu3uZIbLaEBePdglON7vYbDMGLf5/o8A88zHP1YMlXBXUGfu2xB+w4ms1CC/zZ6hf
         MrRb6H3IS/B/lia3MmnQnUvAF6aGa8i9R06A/LOsBrpAOtUz7us/EwbRPEQ719MtC01Y
         Uwd60WLkGKXv55piJsC273ZpBfyY3WR+Cp5xYWeDT/LWwjWYpwmFgcCnnl/SZa9dZIYL
         bJjkgJd5ByKuqJ/VnmZlcA6cRLBBBEqHN9kOe7nuUN9qoEEUyRuwJo7VibTj07/nZ5EV
         Kp669APQwpsPmFg459XPsOCgupw5KRLBt7VmxZLiOMaPO1yK/+q4hAR7Jcw+by8WRIk7
         yTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ8xAlI4hSswSbvUfQzU0yk70eEsNl8mqXnileditR0=;
        b=CLJGxzFP1j9lERxvjYo578D2koiwGXs1taJY/jJVMMSXxGaB+0k7Yez8CU5jF9GcxE
         f+vAiz4XdVlqmvW6m46lr1oq2SPi6Pfw3Cp3oUmq9mObKtbYaJURJ4TNEWySWBLfqIJa
         lxPm72Ov9dFLcKbo7aapH+XWRBiazSHWKzFZEArxBrh+iTemQ16ooWDtIAZqe2MwOPkK
         ITOTC2BS6ZJHU5QCp3HCdlej7ZhdQbX+iCrH0mcJGXQ2CAkDGoEJpgsqav3deSV0gMpl
         WcKjOkV0Q3BzuICMhQwF6Yjdivz2izca21BjbZeWbjr6NTQaOWLZog5mYaQfHUO/G5uo
         F5jw==
X-Gm-Message-State: AOAM533CWJMtysKn5eOOtwely/TouQwbq1IdP/+uN14kMmaD4DLwLnq4
        KWiFX34buKMJwFSqogOyZPAW9+0NS7g=
X-Google-Smtp-Source: ABdhPJynMlYbPx1MswgWpo1IWFDQ4IZefqflzdOagpbFyO3GbqL8QlBkC8W7YlwsGNxrUcl5uq3mSw==
X-Received: by 2002:a63:130c:: with SMTP id i12mr26988571pgl.297.1638923901111;
        Tue, 07 Dec 2021 16:38:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:20 -0800 (PST)
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
Subject: [PATCH v3 14/15] dt-bindings: bus: Convert GISB arbiter to YAML
Date:   Tue,  7 Dec 2021 16:37:25 -0800
Message-Id: <20211208003727.3596577-15-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB GISB bus arbiter to YAML to help with
validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/bus/brcm,gisb-arb.txt | 34 ----------
 .../bindings/bus/brcm,gisb-arb.yaml           | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
deleted file mode 100644
index 10f6d0a8159d..000000000000
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Broadcom GISB bus Arbiter controller
-
-Required properties:
-
-- compatible:
-    "brcm,bcm7278-gisb-arb" for V7 28nm chips
-    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
-    "brcm,bcm7435-gisb-arb" for newer 40nm chips
-    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
-    "brcm,bcm7038-gisb-arb" for 130nm chips
-- reg: specifies the base physical address and size of the registers
-- interrupts: specifies the two interrupts (timeout and TEA) to be used from
-  the parent interrupt controller. A third optional interrupt may be specified
-  for breakpoints.
-
-Optional properties:
-
-- brcm,gisb-arb-master-mask: 32-bits wide bitmask used to specify which GISB
-  masters are valid at the system level
-- brcm,gisb-arb-master-names: string list of the litteral name of the GISB
-  masters. Should match the number of bits set in brcm,gisb-master-mask and
-  the order in which they appear
-
-Example:
-
-gisb-arb@f0400000 {
-	compatible = "brcm,gisb-arb";
-	reg = <0xf0400000 0x800>;
-	interrupts = <0>, <2>;
-	interrupt-parent = <&sun_l2_intc>;
-
-	brcm,gisb-arb-master-mask = <0x7>;
-	brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
-};
diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
new file mode 100644
index 000000000000..483b019275cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/brcm,gisb-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom GISB bus Arbiter controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7445-gisb-arb
+          - const: brcm,gisb-arb
+      - items:
+          - const: brcm,bcm7278-gisb-arb
+      - items:
+          - const: brcm,bcm7435-gisb-arb
+      - items:
+          - const: brcm,bcm7400-gisb-arb
+      - items:
+          - const: brcm,bcm7038-gisb-arb
+      - items:
+          - const: brcm,gisb-arb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 3
+
+  brcm,gisb-arb-master-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      32-bits wide bitmask used to specify which GISB masters are valid at the
+      system level
+
+  brcm,gisb-arb-master-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      String list of the litteral name of the GISB masters. Should match the
+      number of bits set in brcm,gisb-master-mask and the order in which they
+      appear
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
+    gisb-arb@f0400000 {
+      compatible = "brcm,gisb-arb";
+      reg = <0xf0400000 0x800>;
+      interrupts = <0>, <2>;
+      interrupt-parent = <&sun_l2_intc>;
+      brcm,gisb-arb-master-mask = <0x7>;
+      brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
+    };
-- 
2.25.1

