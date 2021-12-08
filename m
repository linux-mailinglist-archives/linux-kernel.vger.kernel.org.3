Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633D946C8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbhLHAl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbhLHAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B563C061574;
        Tue,  7 Dec 2021 16:37:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so969914pfk.5;
        Tue, 07 Dec 2021 16:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=RY8aknDhSmwRWqHq5/gyYg+OixgGcd+L84xrr8VjZ5xXUWre0muqdYtD/koIxpDqWx
         nnkbinr8oLrDEPiLCJ28LngVMFmXOr4OSl1wDm4XeRi6Q8DXeN28Y1mmSlhNZ3MnRFid
         ouXI74KvXfIKTipHV2cCgwHD7IxeONDsucEz/plfX36Ha4yS2cTaCMPRpKzKjUf6RjkS
         PmkTlt+YlVcII4MNja2oKDhnzfLmQ+xkIUAysPcvZG8fXIFcV1BjEm1JdSDn/oIDc9BW
         cBh5CgBs7mFF3yGEi1ko2gfNsyYEVlwrQxXb+Cqq5tvDB4lD1ezUmbM9fIAW5zXc/Cg2
         1EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2A5xiMCMD01rja8VsVDsIJrjuLJ0aPnQc2VQht4HL0=;
        b=b/OOsZa8gOOzs9qXZrxNVyZJW8VSj5Atdzsslgm8KpM4NEK2A/BpGs+KytzZUL9PMU
         f1JcuVJ0tU0C61VHvrRyfZJFwFbC/vTI/6FRZs9EaloR2TLix8TFY+BVX1iImOgXuRQw
         wz6d+CxsNdoSapYb8mRmIswuIGrh8CrSRSkZ9pbLyBi664nV7V48WX9PbULTSa1w6vGs
         e6b4yTRBWz5ykrEsev0cqYT9wZ+5y+ndB1m+zwj4Y9G+O9atD2PcxNk/KacL76R6ksuD
         oavyZQTAC9fz3jFulwpnY8Q51piheB5Tl085HWzVHzp+cEkpYoK5xMXijJO5H/zn+vg1
         OoLw==
X-Gm-Message-State: AOAM531ORQcQAqWOF++5t8v8T+5cVXyH+5Oaxi6TsoJ+BNVw/CSANgcx
        08Ms5aUQYJXYPZYd9rRhKKUUZZ3UeL4=
X-Google-Smtp-Source: ABdhPJz4zUke9kE45M+n5cv9y2vrJrCgM5/UWqrI/GHc1RZRgPaQFZFFg1S9D1/vpMceVEvcvw4gHg==
X-Received: by 2002:a63:e08:: with SMTP id d8mr19157589pgl.27.1638923868230;
        Tue, 07 Dec 2021 16:37:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:47 -0800 (PST)
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
Subject: [PATCH v3 04/15] dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
Date:   Tue,  7 Dec 2021 16:37:15 -0800
Message-Id: <20211208003727.3596577-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
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

