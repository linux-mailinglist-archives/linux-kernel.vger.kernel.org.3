Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB94657DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353417AbhLAU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353173AbhLAUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FBC061756;
        Wed,  1 Dec 2021 12:51:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u17so18626527plg.9;
        Wed, 01 Dec 2021 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlWOtQhuKoAbExjB9TTANbBFdCEDUkxd3U6sjKMMDBU=;
        b=lZTKhPQQV43klv8zTQt5iqg+E/DDSxf/ncHHYHsf9JXQitBi/fCQ0cLVobQG9aib+/
         l4wnaNs8A1CDFaKt47D7Z3OUHmzQxZyJHQGetpWv5TwMILXVrLYW3xxLAEfDPwvqIUu5
         thjurBv6KCYdiXVzpnHisVXXfCxTKcEoWh3wy6l/JFD1Ioarod0Xq4hiAX2fCZvG8hQB
         EhthPxxp7fiZq8S7U/Yc82i2Q5/FPbe20rk/Yv3RQA1ypu9hVhjHNmrVmzYBq9ELEat2
         aKvx4FlJYkfWcbBsDQiHIUsVzrMzJ/2rXQ+v2C6qIca+93DSzabLIzzZYDCg0yrnJ3Yb
         v22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlWOtQhuKoAbExjB9TTANbBFdCEDUkxd3U6sjKMMDBU=;
        b=2NhWhbyUq3AjLY3VgYFQlsOf0EhOQRQnUuicqzwHOjG/aS/9/b/+P/SYX+9fIzU5Xj
         v6bAurUUzcylhiuLGiMQSmn5qlyZaX0av/q2GI0y58LVrce3oF+gf3OQCV7swwKQmzaI
         VRmch04kjG7fCMaEJvvJLn0mbgIF/hzNbuFyGEcarbuPUxqgTEvfF/wLDr/G2SMoIv5D
         3hzn/0rZBg+by+ULmia3zXsswgdg6wQvmES1PuOYsS8NZLhl/gKbVjJrN57mIibdHBAL
         neXk9HITPUv+E7wLQQnzynel83ibPFETAmphT38P49bl6PEInv0/iSfGnJ/RgjUvmhTH
         klbg==
X-Gm-Message-State: AOAM531gKp0svmie0gFKM+xl7Fdcl28LgWzZ8lY5NlxhEuRSj09eQlP0
        YVr/t0WJxjFlO5nMp5xSiqFmBnF80vA=
X-Google-Smtp-Source: ABdhPJyW2b274f+K2vRZyym/4R4dqkGTJVftwQzrdRaUVa6uOjm30jtAp/1EnbYqeY/yqMAIEag0rw==
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id m14-20020a170902db0e00b0014213e4b456mr10239310plx.43.1638391903468;
        Wed, 01 Dec 2021 12:51:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:43 -0800 (PST)
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
Subject: [PATCH 03/14] dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
Date:   Wed,  1 Dec 2021 12:50:59 -0800
Message-Id: <20211201205110.41656-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB BCM7038 PWM Device Tree binding to YAML to help
with validation.

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

