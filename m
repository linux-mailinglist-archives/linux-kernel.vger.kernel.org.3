Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651646A48A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbhLFSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbhLFSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F6C061746;
        Mon,  6 Dec 2021 10:26:43 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n26so10969805pff.3;
        Mon, 06 Dec 2021 10:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWLp0FHWwgS2RqUsytUTgTzk16sQKrqviKuiWZaiYOo=;
        b=NqHYH+cuQCJ0IRpQhjth4Khm7QCtrOs/zMXpXMrIZvswc8Ml42q1UykGun+46SbFB6
         uxNCME+zQn4Sea5gH2f1aXR8hJnk+gpfVMxgTb/OHOkFJtDzJFgv/t6kCp7ECCpPLjNQ
         9lTg7gSR3kdBSRmw4O5jIxvGH5Fz8bcJ2pDvEM1EV52T9KTSfQuXyQV6SG6u+M5mBEig
         jHSAsvG6REgCzBhaZLLIvL35xGxCTRr9WzeeoSEe4I0aKQuMrSqz+ye7B56itKDFNfir
         Lqxy96OTFeCBMnQ+WVCiB5+LOztNvBngQl7NY6CKfAcWU0DRdV2PEQRICMN0by0ItVMI
         zLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWLp0FHWwgS2RqUsytUTgTzk16sQKrqviKuiWZaiYOo=;
        b=kNfaUzFWJLXa4hc6UmtXX/69QqJTfz8zovx+OTALYeTAKPCBEph6QdNECmIG+wJs+3
         kOfCWmPzKO6WlEDrSddJg6peXoKHMr2x3xPfo0PHS5qJ+wUnSfoxp2GXGT1t8mrmviNn
         aNI4boqmJ2wgX9J8SkREHBRzQEx/TzB3rby+cNlNEKqLcJ7zTK0W+JNKVXGH3i6uiPL6
         5j31Jrp+OQkhqoGAh99sYft2m2HSwS0Yg1ZfFUAhKvsdYkjENkU8NQIwB9Umd8RNB6XA
         GHwLXaHZ9iB60SHFvnnIyH0utzpBYv5fGtO3wcmVscJb3bElIW/adqjQlZzLZcCblNf9
         2NXA==
X-Gm-Message-State: AOAM531LIo3n9baB5pkalp6JNDExeDcNSdIdPgb3D7O1xAviO84a9JdJ
        NZRpeH6/L1e8XAI+SSfuQL23YAB9T3o=
X-Google-Smtp-Source: ABdhPJwdlvaJOGGS5gAPxuxh90jlgYxt/7bcNg68Q73FLbYH6te1IIg+6ffJiY77vdVff9L+rJrEYQ==
X-Received: by 2002:a05:6a00:124d:b0:4ad:574d:4d2f with SMTP id u13-20020a056a00124d00b004ad574d4d2fmr11197071pfi.24.1638815202670;
        Mon, 06 Dec 2021 10:26:42 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:42 -0800 (PST)
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
Subject: [PATCH v2 11/14] dt-bindings: thermal: Convert Broadcom TMON to YAML
Date:   Mon,  6 Dec 2021 10:26:13 -0800
Message-Id: <20211206182616.2089677-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
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
index 9ac67c885159..2109b6fe8ea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3936,7 +3936,7 @@ M:	Markus Mayer <mmayer@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
 F:	drivers/thermal/broadcom/brcmstb*
 
 BROADCOM STB DPFE DRIVER
-- 
2.25.1

