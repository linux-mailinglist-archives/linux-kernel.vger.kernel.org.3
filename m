Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B546C8E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbhLHAlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhLHAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7EDC0617A1;
        Tue,  7 Dec 2021 16:37:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3138388pju.3;
        Tue, 07 Dec 2021 16:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTxDB4eLfNoAt8w3FT+NT9TqqcUIK/yExuWXnv5kEYI=;
        b=QtOXQEwsCZwXLR9N2JNPW5sYvZJ3Ycv78Bi6/fgcogUX7O+o97aeHlU9rwzEUtBRtm
         dSJRsv98Uz8OO7rR0EIPRhW+5UNGk2q2hcYnXH80wvu7GqlK8pJM0MSa2u5W0iewhpGD
         D1vi7jf9LKMIzVbJn9F5ufZt6Keb1IpR0sGCkZKV62MF0vnOisgvzZISbLEBq1UVy/hn
         R2HudA4F+W+q/RZcgth1iffnzN+6bxwwUUUE7o/Hmfr3c+VM4bSKcFFGDQa3+7EBhEWv
         XVIu9J39nH+uzdagYdUnXOxM4B7O08Iu5XvfN9qxsVSdeuT+qgyhpEL7JRAQrl/QR62A
         MYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTxDB4eLfNoAt8w3FT+NT9TqqcUIK/yExuWXnv5kEYI=;
        b=s8XIUxi6ojCguhE2vQM3K7e4HbtBgAyvCGoJqqNAGbfzj3EE7MrhZvuyCxXLuPpxWf
         TIs1o5/BOB7/F8hEmSDU466mpwbW0jKYUzw5ouO5LK5XEscH70XDISeo0T0eXULz/O0g
         E7eqv5MhIopgupmsK6IyAoxrOjkeLWJZ/WyZVK9QOb9BBgl6o7jdeUiE/wQfENJVitT2
         iRK6oLWaeYUh/6q/fqrH1Ssv8W1/e9XTt9PH2GKrist22yBB0Gw60KMtIFKPDSvWY4vH
         zzot+GjSfYn6kzR/AX1tCRXTytFzeBQ2cBDn9E8T8A8Mx9Q/xyU6TNnDwjCYoVuuXhYg
         iHAA==
X-Gm-Message-State: AOAM530K8DMvASZK7Vv0+e7goPZGb24pcDUV9BbxcTVlpbkEEL33jkYo
        j8vpKLRykr6zqn51bqB97T+E9Tkcekg=
X-Google-Smtp-Source: ABdhPJxAxybBWeUwWPaIqJtAAO7geI00gG0nPgCdizcgBLUXGFphx05S4H/Mm0Liu6HJzj0fI8zexQ==
X-Received: by 2002:a17:902:7890:b0:143:c4f7:59e6 with SMTP id q16-20020a170902789000b00143c4f759e6mr55886275pll.87.1638923865042;
        Tue, 07 Dec 2021 16:37:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
        Lee Jones <lee.jones@linaro.org>,
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
Subject: [PATCH v3 03/15] dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
Date:   Tue,  7 Dec 2021 16:37:14 -0800
Message-Id: <20211208003727.3596577-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB BCM7038 PWM Device Tree binding to YAML to help
with validation.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/pwm/brcm,bcm7038-pwm.txt         | 20 ---------
 .../bindings/pwm/brcm,bcm7038-pwm.yaml        | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
deleted file mode 100644
index 0e662d7f6bd1..000000000000
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
-
-Required properties:
-
-- compatible: must be "brcm,bcm7038-pwm"
-- reg: physical base address and length for this controller
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description
-  of the cells format
-- clocks: a phandle to the reference clock for this block which is fed through
-  its internal variable clock frequency generator
-
-
-Example:
-
-	pwm: pwm@f0408000 {
-		compatible = "brcm,bcm7038-pwm";
-		reg = <0xf0408000 0x28>;
-		#pwm-cells = <2>;
-		clocks = <&upg_fixed>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
new file mode 100644
index 000000000000..4080e098f746
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/brcm,bcm7038-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm7038-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@f0408000 {
+       compatible = "brcm,bcm7038-pwm";
+       reg = <0xf0408000 0x28>;
+       #pwm-cells = <2>;
+       clocks = <&upg_fixed>;
+    };
-- 
2.25.1

