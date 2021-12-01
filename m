Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACD4657EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353055AbhLAU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353177AbhLAUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F0C061757;
        Wed,  1 Dec 2021 12:51:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z6so18649197plk.6;
        Wed, 01 Dec 2021 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=dkbhlmv1QoiDwCfIHWa9eyyy8BH/yNOh/+bNgglFZ3KVr/GuQVoGtYs5ZR1Euv/p66
         rcLzNtHYK1W0MWeZgrzM/DpF/VMOddlSZiF+vd6qUm+hXQoTWZR9w7hQM9Ky8ZVqOTfI
         A11n0gNrDcJ1snSiOGNg5xdNbL37VJrEhEgk64I42gsxkgRH/qTZ0Ph1B1pzRuR/8QrD
         50tlTdyQ/fXOrvGd+tUqpbGQ1DqIdXQiDrk59nWIwfCxxelWuW/F1fcrW8V38xJWPxb3
         yu1YLDCRWSzQ0fIABpReqssYthz5G/UfSsg1uIO1SIm++cW0iSVijixklRNqB+HsUZ4y
         68ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=EL/a04IfOomB4nWY1VOVGIINWmKUb3jtrJcCXRXxS1YlFtbkJuEVKwRzzcKEnBMwpE
         S4JLXT4RCNYsE1M0r6vjLmPUiklgHGJ0Vhl+6o1i94nPWv1ZT8NZS3XyhYviSmhG+d2d
         d+ziC1wcLcQjKJ+w/F2gekHXbrpmN2ohq3g/AywJAF+Og2ZLVwKGvteleIdxt+XR9v0n
         HDm95EvYq6piVD8wwIR8v+HG7p1BG3xzlxkBGBvksXusX9XdB/DWdKK36X1LHjEbWXvJ
         kuYLwFZSBav+V3X0eILrH3WCsNspVvbtc4z6TRRkQUPZgvptK+soHmy3s6U/sjuOkBg7
         /lCw==
X-Gm-Message-State: AOAM5302zcGJvOiu6r2JgfTnC7IftXo53J/LAomTdVnrIvx3Luj8v3WJ
        xKRBrxspj2zvMtH7oofaYgrS8PEWv54=
X-Google-Smtp-Source: ABdhPJxuZNFW3NvsbL7fKjrMHRPi1FeCRP3Q14olDON/29y4ghN7ZfkpPEt1PMqazqGOCHSLQ1cBrQ==
X-Received: by 2002:a17:90b:1a88:: with SMTP id ng8mr714991pjb.180.1638391905488;
        Wed, 01 Dec 2021 12:51:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:45 -0800 (PST)
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
Subject: [PATCH 04/14] dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
Date:   Wed,  1 Dec 2021 12:51:00 -0800
Message-Id: <20211201205110.41656-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB waketimer Device Tree binding to YAML to help
with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/rtc/brcm,brcmstb-waketimer.txt   | 20 ---------
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
deleted file mode 100644
index d946f28502b3..000000000000
--- a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Broadcom STB wake-up Timer
-
-The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
-ability to wake up the system from low-power suspend/standby modes.
-
-Required properties:
-- compatible     : should contain "brcm,brcmstb-waketimer"
-- reg            : the register start and length for the WKTMR block
-- interrupts     : The TIMER interrupt
-- clocks	 : The phandle to the UPG fixed clock (27Mhz domain)
-
-Example:
-
-waketimer@f0411580 {
-	compatible = "brcm,brcmstb-waketimer";
-	reg = <0xf0411580 0x14>;
-	interrupts = <0x3>;
-	interrupt-parent = <&aon_pm_l2_intc>;
-	clocks = <&upg_fixed>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
new file mode 100644
index 000000000000..9fe079917a98
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/brcm,brcmstb-waketimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB wake-up Timer
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+description:
+  The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
+  ability to wake up the system from low-power suspend/standby modes.
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: brcm,brcmstb-waketimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: the TIMER interrupt
+    maxItems: 1
+
+  clocks:
+    description: clock reference in the 27MHz domain
+    maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc@f0411580 {
+        compatible = "brcm,brcmstb-waketimer";
+        reg = <0xf0411580 0x14>;
+        interrupts = <0x3>;
+        interrupt-parent = <&aon_pm_l2_intc>;
+        clocks = <&upg_fixed>;
+    };
-- 
2.25.1

