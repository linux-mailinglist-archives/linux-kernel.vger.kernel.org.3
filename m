Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497D246C8E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhLHAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242885AbhLHAlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DEC061746;
        Tue,  7 Dec 2021 16:37:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h24so739891pjq.2;
        Tue, 07 Dec 2021 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=lBrp7wUtHVgBa3Dthl4LzV2k6mAosTTh2BZ0GGwACqmq3CIzP6W2cGHLbkqw8KUcup
         h+QUfQyB70c7veObd+o1MrBmwUSgz1XXaByaTuvBrOqEohqZF0jkveUOzB0p2Emg76cY
         mdWrPtChMKjb5a9DYNB9DR6R2sqrveqvNvzwfFpXNjd0gHQlRD00azPVocrejvkKC1pO
         hmZDrR4AYV9kFaKwWPmaXoN+8E2reOKvB58j2+ZCoj7AY6tZXWy+thXOWMKjG7FnC+TM
         pie0ymYDoTbQ3jPnqMZEwelBfdXnxO/0N0P7BF5lcnf60Laou9L5nCnvPHI0eVaGPVES
         w/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=PFl5U0HZlP6CceUQhvvUCWBcEOnTff8+/N+6LZfOnvE06p4wqRJn+wmnKVGsGAwBo1
         FBLF7mRvOBLfoFeH4602eN8X3OQwoZJUDSV4mDs0V+pIdi/dVyULq7U+cXWbeYKHc58Y
         ox4nU+h6A5t0Xajf7bxJ7cLsf/BFozf58UaqXrKYLT4UrEfddVnmadV8ebiSxmjfyZAL
         YQ4j6rb7q29mCmaKDb2ap4/J61dy1F3cB0fjNVIh5GbMp1TP5IRBznIfvfPVftS4KpHR
         TADW5vqVv1kDdmbF/gSlMkcDMWw3/0vcAwWu6w6atIfGNck93RNmBphuVuzD5tuUAvno
         5/7Q==
X-Gm-Message-State: AOAM531SdO0YXVJSy3xu4uu2rJQt6HvbZW6IlOPgShkqrfsgB39qTqAb
        bOYFswMS6R5oRr52v603+YDCIYg1jys=
X-Google-Smtp-Source: ABdhPJzbYuklpDTPbalGGg11H25K1o5mWfgC3zU2r2fYb/whgxXYHS9O2jg9W2TxQF8vpjIQiSAXLw==
X-Received: by 2002:a17:902:e806:b0:142:830:eaa4 with SMTP id u6-20020a170902e80600b001420830eaa4mr54788413plg.16.1638923861843;
        Tue, 07 Dec 2021 16:37:41 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:41 -0800 (PST)
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
Subject: [PATCH v3 02/15] dt-bindings: reset: Convert Broadcom STB reset to YAML
Date:   Tue,  7 Dec 2021 16:37:13 -0800
Message-Id: <20211208003727.3596577-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB SW_INIT style reset controller binding to YAML.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/reset/brcm,brcmstb-reset.txt     | 27 -----------
 .../bindings/reset/brcm,brcmstb-reset.yaml    | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
deleted file mode 100644
index ee59409640f2..000000000000
--- a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Broadcom STB SW_INIT-style reset controller
-===========================================
-
-Broadcom STB SoCs have a SW_INIT-style reset controller with separate
-SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
-reset lines.
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible: should be brcm,brcmstb-reset
-- reg: register base and length
-- #reset-cells: must be set to 1
-
-Example:
-
-	reset: reset-controller@8404318 {
-		compatible = "brcm,brcmstb-reset";
-		reg = <0x8404318 0x30>;
-		#reset-cells = <1>;
-	};
-
-	&ethernet_switch {
-		resets = <&reset 26>;
-		reset-names = "switch";
-	};
diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
new file mode 100644
index 000000000000..e00efa88a198
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/brcm,brcmstb-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Broadcom STB SW_INIT-style reset controller
+
+description:
+  Broadcom STB SoCs have a SW_INIT-style reset controller with separate
+  SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
+  reset lines.
+
+  Please also refer to reset.txt in this directory for common reset
+  controller binding usage.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,brcmstb-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset: reset-controller@8404318 {
+      compatible = "brcm,brcmstb-reset";
+      reg = <0x8404318 0x30>;
+      #reset-cells = <1>;
+    };
+
+    ethernet_switch {
+      resets = <&reset 26>;
+      reset-names = "switch";
+    };
-- 
2.25.1

