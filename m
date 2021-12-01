Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91830465806
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353518AbhLAU7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbhLAUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34882C061574;
        Wed,  1 Dec 2021 12:52:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v19so18631837plo.7;
        Wed, 01 Dec 2021 12:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXZ0/ybbAQg9uwesPD/ypGEbhpQvjxTYTz5qeYJSb5s=;
        b=RqAZjsscvU0hDJajSSfKbV4IxUZ1YixeXmi/eM78Qa1wB2eHbsoywUKSQoiK/sRQqS
         6J8avig4d6I9znxje0E8zkDbwu3CmZX32YefFABy/U5fwFeLzOkAbRtUFWbriGslwcdr
         HD3j+NteFRp6aBetTcccwpbmHmRQKseOoePdez+N0vKBYKEt6x8pA4/RwnmXKHstsNk9
         puBXqI9Bh5n/IdnzwWS4IevbPPERDjVj2v2B7gyNi3igHumqPBpfgSKNgKW+eh2Rcwpb
         aZdhqDUeia03TIZ0zewd0NlWZKk+liu8gR+acEuJBNt7MaQ3BHFHmdV4L5ikuYZZ9tfL
         zXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXZ0/ybbAQg9uwesPD/ypGEbhpQvjxTYTz5qeYJSb5s=;
        b=SmDupfkSN1frp/EDNK7O+5I4CC5njFuOiVUbdiYjKukciiaw+yGIn9Nrqm3ioBAmAr
         ggJmCAs2+VOndxmsESyDWjqHkd9U62bvRvpQ3L1CDpn12eEvdlvm7VenBz4Q1GXAWzXs
         0cOZwCo3QVI73tKXjP/72816aLRQ8uhsLsXLiLs0yC0asGYeh6TnWf0HQdLElgF76KwJ
         TqsOKsrCbAxlXgAlNjwsQ6DlcZw4M7tyViUDezsRpYj4pSzvY9/aocXB79u8OUCNzf40
         NAhCfBl3GNqgprA2HVTCTROYcxOKZS7qB/ddA9uiVU99Pr2lz3xQINORtJCP0F/BORRx
         zoVg==
X-Gm-Message-State: AOAM530AdEJHro6Hirr8eiVKdgzexN7QL/tojEO7BefqoKirnbFdX6Gy
        ihEfq0wgxWHDVGl17Cv+D50jesElg8Q=
X-Google-Smtp-Source: ABdhPJzIcSFtZpvzNOMDOCXE0f6S4EaCgoh5EozgkKAH27+PLnIhHJdr6LwbAN6kRx55rIh+Vth9kw==
X-Received: by 2002:a17:902:b94b:b0:143:d3bc:9d83 with SMTP id h11-20020a170902b94b00b00143d3bc9d83mr10308246pls.6.1638391922345;
        Wed, 01 Dec 2021 12:52:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:52:01 -0800 (PST)
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
Subject: [PATCH 12/14] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Wed,  1 Dec 2021 12:51:08 -0800
Message-Id: <20211201205110.41656-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
 .../bindings/ata/brcm,sata-brcm.yaml          | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
deleted file mode 100644
index b9ae4ce4a0a0..000000000000
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* Broadcom SATA3 AHCI Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible         : should be one or more of
-			"brcm,bcm7216-ahci"
-			"brcm,bcm7425-ahci"
-			"brcm,bcm7445-ahci"
-			"brcm,bcm-nsp-ahci"
-			"brcm,sata3-ahci"
-			"brcm,bcm63138-ahci"
-- reg                : register mappings for AHCI and SATA_TOP_CTRL
-- reg-names          : "ahci" and "top-ctrl"
-- interrupts         : interrupt mapping for SATA IRQ
-
-Optional properties:
-
-- reset: for "brcm,bcm7216-ahci" must be a valid reset phandle
-  pointing to the RESCAL reset controller provider node.
-- reset-names: for "brcm,bcm7216-ahci", must be "rescal".
-
-Also see ahci-platform.txt.
-
-Example:
-
-	sata@f045a000 {
-		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
-		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
-		reg-names = "ahci", "top-ctrl";
-		interrupts = <0 30 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sata0: sata-port@0 {
-			reg = <0>;
-			phys = <&sata_phy 0>;
-		};
-
-		sata1: sata-port@1 {
-			reg = <1>;
-			phys = <&sata_phy 1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
new file mode 100644
index 000000000000..4098d56872ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/brcm,sata-brcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom SATA3 AHCI Controller
+
+description:
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA controller should have its own node.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: sata-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7216-ahci
+          - const: brcm,sata3-ahci
+      - items:
+          - enum:
+              - brcm,bcm7445-ahci
+          - const: brcm,sata3-ahci
+      - items:
+          - enum:
+              - brcm,bcm7425-ahci
+          - const: brcm,sata3-ahci
+      - items:
+          - const: brcm,bcm-nsp-ahci
+      - items:
+          - const: brcm,bcm63138-ahci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ahci
+      - const: top-ctrl
+
+  interrupts: true
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,bcm7216-ahci
+then:
+  properties:
+    resets: true
+    reset-names:
+      items:
+        - const: rescal
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@f045a000 {
+        compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+        reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
+        reg-names = "ahci", "top-ctrl";
+        interrupts = <0 30 0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sata0: sata-port@0 {
+            reg = <0>;
+            phys = <&sata_phy 0>;
+        };
+
+        sata1: sata-port@1 {
+            reg = <1>;
+            phys = <&sata_phy 1>;
+        };
+    };
-- 
2.25.1

