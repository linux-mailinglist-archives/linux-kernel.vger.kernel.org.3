Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693AD46A42C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347574AbhLFSad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347362AbhLFSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65BC061746;
        Mon,  6 Dec 2021 10:26:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so8393203pjb.1;
        Mon, 06 Dec 2021 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I18/cMLsQhJOofktwki/zSWiGzzVEzrVRJ9sFw5GkOk=;
        b=nYcOF5vXym3mhpVAYnFbV12nN0McdPMuRRQKLbVmJth1q+Mp+tVHfYO/CScszMCnIS
         wnTneCF7yjgss9ikFrghR+rzsQNL3gZKerBKx+b7MPG9BpZfR+8WQsydrUwLOSK4UUC9
         iM4QxWFvpuITmeJzOZxGM/cbOXfy/qbRqakUyHAiDWbiDBLLpInDa576iGdjQQZcNlmq
         glV7GztKKqlmeqNWi4FGul6HeG5Zh3WYQnJVbTeTdEOzVnjaRyGgEDROHFv3OHbpQ0i2
         F3cuB4mRKaLN+Nv4Lz6CgCnQhHfuEMaF8Yx/fl6U4bbJlf816/RaO4NkCMpv3BwpFFtN
         Q2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I18/cMLsQhJOofktwki/zSWiGzzVEzrVRJ9sFw5GkOk=;
        b=78xHj7ZsR4adaAYD0bQiZDepISDs5Ewe/npibi9HoN70p9MVb5xn1EmK7GNY56dgu7
         b8mauCVjALsV8RXdAUzpth8gueOo4kKdEzAqtN158VMCEtMqGoSJOE83wvnAvTA/9qsX
         KJYfQlEI+uBDXlgTEv/7gNljvWaaSJtSx29xG0Lt+0blii5vKxW6lgpHe0f6fFmiKdEN
         N4N4lmWseexIY4Ynhv55jevXRSVeFlQ1M5EsDUh0GXm5MiKY/FvW1/LwCEMefwX0+vKk
         TYtW6msggdIhgU7biNgpz0+v6dXtsNf9mHvgbInJHo0LG1OCzb9/c0LkJNv1DQOfgQy6
         K8aQ==
X-Gm-Message-State: AOAM532fkSTL3qQiN+by3N6W6EhK0pOOhTyhhZ9Rey4IbksRpInn44e3
        Qzfu8A+SY9AnFZEEcXE7W3YFre8PkSQ=
X-Google-Smtp-Source: ABdhPJzBy0O21Nc2EF1bYgkBVgbj1vC2wiovbxWRmuqR9Q3XkDy4IsPPsVR2UzVgwg/eFntTN4tNoQ==
X-Received: by 2002:a17:90a:9a8e:: with SMTP id e14mr198493pjp.231.1638815204680;
        Mon, 06 Dec 2021 10:26:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:44 -0800 (PST)
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
Subject: [PATCH v2 12/14] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Mon,  6 Dec 2021 10:26:14 -0800
Message-Id: <20211206182616.2089677-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
to help with validation.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

