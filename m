Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40D74657C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbhLAU5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353128AbhLAUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903BC061574;
        Wed,  1 Dec 2021 12:51:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2745012pjb.0;
        Wed, 01 Dec 2021 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=MAOPY72HwGehZwBKZFZ5CLA8+g1E/nLgfb+oxVEyyJaSzIgI4KQvJPspoPsa4K+zN4
         wW7BjZdsrjA65P6aPsh9vyOnJdUWYWAcg3t9LEXmSEwicT78f0+bXp2qqGzFIFs9LQC3
         wpq8kca/LjoEh7iTWxazypDyn+XGmgdX07EraGRTLk1CjtZA9WJ8++cIQqXJoLrXiD99
         gzeeYPrkXNVfMeKkrFwrM40YpappcHjC4QpbyhSyTd1AN1Ydi2aRdpJ8bVUQ9NJ5/asU
         PpW+pn0b9wexfnVwDGDOUw1xyQr0G7bV2fbXESOxkL9BlQLwSa5a3BsyQjhjWfJq3YIx
         xOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22u1YgEGuUE2NUBm4aUIXRHhe1NgL4IlQ7p6nHAEJMg=;
        b=IpofWGd3WcW0KV4mZTzFTkDHLqQEUEFq49T1HRkp9ZobKkizLiwe7XjvFBJ0tcHz42
         1jnC715KiAIv3TimcK88+JPCtYUlhyx5WJ256RiTomwRVSgh22qel3QBA4MnEx85oRSR
         DzAV+OlbOHdtQRdhzA1WZz6jZW5TRAdQSEg+S9MCdEiU6+4zU/Bp3TEyq6p4rkDHSFY7
         nNKM+SeGCPCwg+eGFs2Zf47m9oHNdUwZMAlnKOmAAQyBWnkxD4WRl7jCteGip/Z4PnRB
         OBs6pH5OWtSbgFaMzR7RZUtcq9+CmRkRTSX0wdrOld1uDMk1ByF1+yFL7sm9p5mDopWd
         OwVg==
X-Gm-Message-State: AOAM533OvCG1FPg48CG0I+FVSNXlbURsjhsSOUThrGd4Yvle86X0St8U
        aWUWFnT/0NmpbxXodImep0pkkOPzP1c=
X-Google-Smtp-Source: ABdhPJwe4/s+fuxaZ1+Se1tx6tX1opDtPCkTVHDTETYaDgLHgMGE+XNEW1j8n5mSvuDaFU8Q9eGvFg==
X-Received: by 2002:a17:902:ba84:b0:142:5514:8dd6 with SMTP id k4-20020a170902ba8400b0014255148dd6mr10184851pls.19.1638391901421;
        Wed, 01 Dec 2021 12:51:41 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:40 -0800 (PST)
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
Subject: [PATCH 02/14] dt-bindings: reset: Convert Broadcom STB reset to YAML
Date:   Wed,  1 Dec 2021 12:50:58 -0800
Message-Id: <20211201205110.41656-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
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

