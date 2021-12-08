Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9D46C94D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhLHAmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbhLHAlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936FC0698D4;
        Tue,  7 Dec 2021 16:38:18 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g16so601893pgi.1;
        Tue, 07 Dec 2021 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8msp/vCJlnHmyzzIp13SSEK8bBrWiNp5GqSs8r2plI=;
        b=JmfbtVkRAW+N7m+nN7xBu2hLb5lxM2Na7suALIz7xYiRxtvD+6Lj9layQIJlJdKZOq
         MEWfikq3ov+kBhNwkhF8rto4oNN8OcrB5RnnVtQHO10e6QOJBvc1mSB5kfwGPzYxqlYR
         PTbKZ4oN6DdeVOdnAZk2vWrqdTHD6/x8QGTPq6uztkpaSBlWFCSmMbDSvGrv268Rhe2t
         tvBXoyKvLzfP4VFrZ5lJv3ltNzBXDX8eAtd268uboaLryMElO5rW3+YCzymyDL6Exyeh
         zPiGgfCLNu3djXAqDF1cR4F1FGXB3REWPS0E7M9lc/rMG8ELreo3C1RmpQPrQ8kutCNO
         G2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8msp/vCJlnHmyzzIp13SSEK8bBrWiNp5GqSs8r2plI=;
        b=xC8vPR1H+DuBRAXCjWKGIMU1WH3J6frtvnSmIHdlDU5Etjm8hs0Bz6d0hymvvjs+ZF
         xnGwcEg8toLcftuiAr2YlGU2bsklfmYDy7zE7+7e3GQnDaJCxAjwtTTUDYs1UvMZO//q
         eBrQZGKYHJyR9WktfjhyiQmlG9vGVDJmbyDdJjkocF/QeRB8FZF4LoZN8I7EL7Hasm+G
         Ci39vuquAFRadttE2eYn2AGPKoy2h11E6IxrUM2tH3gdsLi3ZNB6iMMqrjccTHnN2zsH
         /fX2lcxaMKATMBZ2diu8PQ68bDPnM1r/TdJeTDbmksyiA0e5tWXlq9NCQUuCIlv556S6
         yThA==
X-Gm-Message-State: AOAM532BOwI8LPX22dCUsOk9eJ6mJ6T8xnVkKBLzO6fdRCU/uOckJveu
        itNNAEaXNoeykMlGG1vgpLKVcjO9WMk=
X-Google-Smtp-Source: ABdhPJw/2aenhqEPiqsBLTWFRdMbzGNkVsn5kNLFkkJ1A66P9ktIedrFhwQoeabu3mZVlNxlaFZh2Q==
X-Received: by 2002:a63:e901:: with SMTP id i1mr27028438pgh.582.1638923897905;
        Tue, 07 Dec 2021 16:38:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:17 -0800 (PST)
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
Subject: [PATCH v3 13/15] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Tue,  7 Dec 2021 16:37:24 -0800
Message-Id: <20211208003727.3596577-14-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
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
 .../bindings/ata/brcm,sata-brcm.yaml          | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 45 deletions(-)
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
index 000000000000..3e24f45c65af
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -0,0 +1,98 @@
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
+          - enum:
+              - brcm,bcm63138-ahci
+          - const: brcm,sata3-ahci
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
+  dma-coherent: true
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,bcm7216-ahci
+          - brcm,bcm63138-ahci
+then:
+  properties:
+    resets:
+      maxItems: 1
+    reset-names:
+      enum:
+        - rescal
+        - ahci
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

