Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D416A465807
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353537AbhLAU7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353231AbhLAUz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:55:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D448C061748;
        Wed,  1 Dec 2021 12:52:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x131so25778735pfc.12;
        Wed, 01 Dec 2021 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ8xAlI4hSswSbvUfQzU0yk70eEsNl8mqXnileditR0=;
        b=P7jAMatFuO2gBO52H1+kxEvaDz+iyNeFkordEyAJcRi4Vj6kyk3PidSDPqpvTfZgvp
         z0FwCjDhRVuklEb8hFfxZxI4eYmsNpzAZjhp2ztBRK5oMncDBhoAC6fh5wCepK1gb9uq
         od8gvMijXnLiphSYcbDV5yZbMdzauBGHZRgFLb9dUXBp17Zvsl9sXOeyWKg9NI310Wij
         R0hRDeN5JSPrW+NhW4kLS/bIiGD6zMdBhJ2rOjCrS3AX/UxquJbCbm8UTacrcNGZl2An
         TxfebEUudgws9C5qBG3fU7lhBIPp/tnUK2jRu3dzejlzPLhrP2Nc5xxF9xscoK1z4cSr
         wpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ8xAlI4hSswSbvUfQzU0yk70eEsNl8mqXnileditR0=;
        b=PR7GHLzbcE2xfuAg0nFcTC0D9oMemFhPew9EP51nS/RN/YeMFrUXOcCBfjmvOrlQAb
         5zvdR8UAAWjFDtL1myUP+SimnbXrbQcZGXcf2jWDBjtjbk0qHGLrktxRrzLq96Dl5ojQ
         I4+2bCHZhRVjRIV3d/H8UWxUJ9vf5I3vpI6sancunOKT6vpQbtwJM48/GYeKnsEBCqet
         vCNbInzx+U0hMU07rzJV39V+RYcg9AMmks1MDk8xvEQgfQv1AmBGm07dtFc4UtGIgENc
         lt17FT8bHWbNUwL+138xtkqmcTYQ2WtYGoLYFMLVpKBnZuj9wwfH+9D/Yl5liQxPZ+08
         CvTQ==
X-Gm-Message-State: AOAM531Q7Dt1F/eh3ZMo3pQBE7r0YW9a9d0trsEqjiVZUJ2iqn17xV3P
        A/YwbLIGpcuHSW4/9IL7trlbSdn5QPM=
X-Google-Smtp-Source: ABdhPJyHG2YWa2WK/7cn66OHUfOMYu2Sve8Z/qUvjukLqZPsVAwBovUicSsfxd27Qj5Rz98JFPE5bQ==
X-Received: by 2002:a05:6a00:1894:b0:4a4:f2fd:d7b8 with SMTP id x20-20020a056a00189400b004a4f2fdd7b8mr8450851pfh.9.1638391924648;
        Wed, 01 Dec 2021 12:52:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p20sm729117pfw.96.2021.12.01.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:52:04 -0800 (PST)
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
Subject: [PATCH 13/14] dt-bindings: bus: Convert GISB arbiter to YAML
Date:   Wed,  1 Dec 2021 12:51:09 -0800
Message-Id: <20211201205110.41656-14-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201205110.41656-1-f.fainelli@gmail.com>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB GISB bus arbiter to YAML to help with
validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/bus/brcm,gisb-arb.txt | 34 ----------
 .../bindings/bus/brcm,gisb-arb.yaml           | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
deleted file mode 100644
index 10f6d0a8159d..000000000000
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Broadcom GISB bus Arbiter controller
-
-Required properties:
-
-- compatible:
-    "brcm,bcm7278-gisb-arb" for V7 28nm chips
-    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
-    "brcm,bcm7435-gisb-arb" for newer 40nm chips
-    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
-    "brcm,bcm7038-gisb-arb" for 130nm chips
-- reg: specifies the base physical address and size of the registers
-- interrupts: specifies the two interrupts (timeout and TEA) to be used from
-  the parent interrupt controller. A third optional interrupt may be specified
-  for breakpoints.
-
-Optional properties:
-
-- brcm,gisb-arb-master-mask: 32-bits wide bitmask used to specify which GISB
-  masters are valid at the system level
-- brcm,gisb-arb-master-names: string list of the litteral name of the GISB
-  masters. Should match the number of bits set in brcm,gisb-master-mask and
-  the order in which they appear
-
-Example:
-
-gisb-arb@f0400000 {
-	compatible = "brcm,gisb-arb";
-	reg = <0xf0400000 0x800>;
-	interrupts = <0>, <2>;
-	interrupt-parent = <&sun_l2_intc>;
-
-	brcm,gisb-arb-master-mask = <0x7>;
-	brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
-};
diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
new file mode 100644
index 000000000000..483b019275cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/brcm,gisb-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom GISB bus Arbiter controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7445-gisb-arb
+          - const: brcm,gisb-arb
+      - items:
+          - const: brcm,bcm7278-gisb-arb
+      - items:
+          - const: brcm,bcm7435-gisb-arb
+      - items:
+          - const: brcm,bcm7400-gisb-arb
+      - items:
+          - const: brcm,bcm7038-gisb-arb
+      - items:
+          - const: brcm,gisb-arb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 3
+
+  brcm,gisb-arb-master-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      32-bits wide bitmask used to specify which GISB masters are valid at the
+      system level
+
+  brcm,gisb-arb-master-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      String list of the litteral name of the GISB masters. Should match the
+      number of bits set in brcm,gisb-master-mask and the order in which they
+      appear
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    gisb-arb@f0400000 {
+      compatible = "brcm,gisb-arb";
+      reg = <0xf0400000 0x800>;
+      interrupts = <0>, <2>;
+      interrupt-parent = <&sun_l2_intc>;
+      brcm,gisb-arb-master-mask = <0x7>;
+      brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
+    };
-- 
2.25.1

