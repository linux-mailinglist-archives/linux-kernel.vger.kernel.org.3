Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72E46A448
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbhLFSbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347112AbhLFS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:29:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40FDC061D5E;
        Mon,  6 Dec 2021 10:26:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q17so7614770plr.11;
        Mon, 06 Dec 2021 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlWOtQhuKoAbExjB9TTANbBFdCEDUkxd3U6sjKMMDBU=;
        b=pzFYLXw+dgQQZ9vnU/aMWUbAlvWMVysoWrco4Ie804B20gDncofnLHx6qA19V9onoz
         5dhtA3wI7KqTNL0icF2mNs8dmvtldxC82f4ugzSHHYOzn1LhCNGmtl20zrn+aq2oli0b
         uUiwiQC5u0GFJPLoWCMCEHAWynShCwLnS947U67OM4wrpuifUS7mJF1wZt5p8pfkaATO
         xVGKFIxgBEN3wrHDB7HWRVrXRBeivh5IU6SuBnYQdNdG8gZn9Ldsx6yUHAcunG/8YDWe
         ZDLQncVbUuhbggTqkZ4T76sDaXASkGeM759fweoKI7QlRSwBYza2StEUwcd6CymvtHx0
         1p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlWOtQhuKoAbExjB9TTANbBFdCEDUkxd3U6sjKMMDBU=;
        b=Gp3k1wyPL7FkYEcAAxmGQxo8WXeumrWDN03XJglKQhw5wuCtBHYDpqZTOZTajal55C
         HvxVQrbSoHmfmqeXXoad2PDPT8QTGVOOIXIRQXgyHdnfCw+cVTGoaX2DQre/vYudzPE6
         3gu82JLwFpGausHENxhuxTmiJs5kuZSrQyQvXFZyM/SJOPbFui2/0n5uV1fHZEJN3rp2
         rGL479yPMN2QDbzPoSqi4w6JNSRrnJQ+oVOwI8d13ojipNmLIsnKHqSi5Xgc26BnnPyS
         x8uU33spqCQxfPKpdlEqN/Fp7RH7QG7iVdASNPskTzzaeBh80/QJX/GPQ8jiPecz2m0R
         hktQ==
X-Gm-Message-State: AOAM532n1wYuKc+orPOTeUtjX2tDb3ZyjaaMiFhDF/TWn46WOeFFOpcI
        +nlEtXC/AgAfSo9QrlBBMNgp8ZViJZg=
X-Google-Smtp-Source: ABdhPJwxLXZuEFBB8yWKy6KJpxvhIK8eLJgeHKt7kxDuT1bsOthhCiGJYW4+SyHyuycD0ow42bQWgA==
X-Received: by 2002:a17:90a:fe85:: with SMTP id co5mr261347pjb.110.1638815185903;
        Mon, 06 Dec 2021 10:26:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:25 -0800 (PST)
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
Subject: [PATCH v2 03/14] dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
Date:   Mon,  6 Dec 2021 10:26:05 -0800
Message-Id: <20211206182616.2089677-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
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

