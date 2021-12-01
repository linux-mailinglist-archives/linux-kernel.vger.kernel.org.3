Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803B6465805
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbhLAU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353227AbhLAUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE9C061748;
        Wed,  1 Dec 2021 12:52:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id k4so14706496pgb.8;
        Wed, 01 Dec 2021 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaFrCtDyOBQjn78eEwNTMD4fjx9RYha6T+8s8u4JaVg=;
        b=m8WuaqXum7TlgyUMJql6UwS/PzNafwkv21FvbsYMchVk/M8vBc8EKdhVtMtXVeTNcl
         luADZO0XWw5zRLtTGo311KBY5TRvjkIJJb+lvc9gyUSP4Fjzkx2uDq4tYSqVecjqwDNb
         OaniVmM6O4sPNpP/3OlVYmV6OaJlykplsrizrcfCRninjkfkh/4bZgTgzSVB9LNZHv91
         IKeQY05cSZby7z8NqNX/kXMca8YMD2JouqLBRK4LCqOsOL6IBMvJnUMRfhpamiCDLymh
         KPQ7gQtIc0m3xwsmTi0Qm10VMTVriNkUCdRZC4oi7+DP1HrX75gxR9/0LR4P+Loz0E8Q
         0yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaFrCtDyOBQjn78eEwNTMD4fjx9RYha6T+8s8u4JaVg=;
        b=LHzq2wq9dpZ8mQb7vMsi2L7TJzy4NenJ5Pkv9C5FZMt6KU8JMj0RoEAdZdKPO48CJQ
         xxWzTtZQRsMtjw1rZs2zNTOm0pi4FnoykdimyNQDolvDaUmJMonDFoUlm7KiwlCN27Nc
         UdtmkhaXuu0oraJk3hnHxG65cJkcTMstXFqPe28zT23pkA9HSGYfiijV69uQZJTm43Ih
         d9l7/c74Pd+Q1mqWHQuZXqypjMQ831PBbhd7QIjJkwIFCIEenWYzUoBRKPDudXbueiff
         RddUAzCjD7VgHRzBwoWqkHbFn2TISJU/W8v1Y/W2fdVqmdHsyXtoWuu2+SSDP1SPd6mw
         6ueg==
X-Gm-Message-State: AOAM532PPqGfQGf1+rC0Nc5OnPFNT2wtd5cfZoHQ6m498vnL987CHSpX
        yCt/NG90NiAbv+3P8rb7eGrk/m13z2g=
X-Google-Smtp-Source: ABdhPJwiZxHWKnEwVc8U1pBM7nHOOcAx3PSvBztgnEO4bSLjrlbOQ1ZGl7b1BzCUbHjhnWaMhtHYOQ==
X-Received: by 2002:a05:6a00:1ad0:b0:49f:d04e:78da with SMTP id f16-20020a056a001ad000b0049fd04e78damr8489446pfv.77.1638391920296;
        Wed, 01 Dec 2021 12:52:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:51:59 -0800 (PST)
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
Subject: [PATCH 11/14] dt-bindings: thermal: Convert Broadcom TMON to YAML
Date:   Wed,  1 Dec 2021 12:51:07 -0800
Message-Id: <20211201205110.41656-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom AVS TMON Device Tree binding to YAML to help with
validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/thermal/brcm,avs-tmon.txt        | 23 --------
 .../bindings/thermal/brcm,avs-tmon.yaml       | 57 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 58 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
deleted file mode 100644
index 74a9ef09db8b..000000000000
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Broadcom STB thermal management
-
-Thermal management core, provided by the AVS TMON hardware block.
-
-Required properties:
-- compatible: must be one of:
-	"brcm,avs-tmon-bcm7216"
-	"brcm,avs-tmon-bcm7445"
-	"brcm,avs-tmon"
-- reg: address range for the AVS TMON registers
-- interrupts: temperature monitor interrupt, for high/low threshold triggers,
-	      required except for "brcm,avs-tmon-bcm7216"
-- interrupt-names: should be "tmon"
-
-Example:
-
-	thermal@f04d1500 {
-		compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
-		reg = <0xf04d1500 0x28>;
-		interrupts = <0x6>;
-		interrupt-names = "tmon";
-		interrupt-parent = <&avs_host_l2_intc>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
new file mode 100644
index 000000000000..fb5c273b8bc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,avs-tmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB thermal management
+
+description: Thermal management core, provided by the AVS TMON hardware block.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,avs-tmon-bcm7216
+              - brcm,avs-tmon-bcm7445
+          - const: brcm,avs-tmon
+
+  reg:
+    maxItems: 1
+    description: >
+      Address range for the AVS TMON registers
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: tmon
+
+  "#thermal-sensor-cells":
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#thermal-sensor-cells"
+
+examples:
+  - |
+     thermal@f04d1500 {
+          compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
+          reg = <0xf04d1500 0x28>;
+          interrupts = <0x6>;
+          interrupt-names = "tmon";
+          interrupt-parent = <&avs_host_l2_intc>;
+          #thermal-sensor-cells = <0>;
+     };
diff --git a/MAINTAINERS b/MAINTAINERS
index 78161abc384f..11808be8e128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3947,7 +3947,7 @@ M:	Markus Mayer <mmayer@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
 F:	drivers/thermal/broadcom/brcmstb*
 
 BROADCOM STB DPFE DRIVER
-- 
2.25.1

