Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBA46C93D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhLHAm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbhLHAlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B476C061746;
        Tue,  7 Dec 2021 16:38:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h24so740492pjq.2;
        Tue, 07 Dec 2021 16:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWLp0FHWwgS2RqUsytUTgTzk16sQKrqviKuiWZaiYOo=;
        b=AZK8MKZ3uaoX14tgiQTawpe9good0zorcQOvO35ByjZgHgPKgtW8TSv46ryWj2sIos
         l9vSQIk0qaL1s3GmTwTZrnWI145gml/eXvG0h8RZKJSkF4Gt0ouXg76C7VlNIiZDb3/v
         VLU1yzidNSfk9Bt7bn4IdgEF9bA4mts1epsur7GJz6f3dzPj3uw7BVBnq2j8vN0jmQ+F
         utiIrUb6pY+AVKjZhW89hQdHE1jy9XToWyoy6gGmlzCl5L/jlxGAAe5NdETKpOk88B+V
         BldTmw3MdSz7fQC/zIjL7UU5zsXi77znx9AN6y8askp6gMlqHi4jFTCNaO3KSQv37CXq
         DDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWLp0FHWwgS2RqUsytUTgTzk16sQKrqviKuiWZaiYOo=;
        b=Bdfg70iJm6WaxHRM1lr8X2PWYFaHk5KrBGUwB037cixID8STXEA3KRsbUhdulUU3ie
         r7C/Ai2r7AwwCgo7T1PxJBiJKJJHaPy0gMVecGucObOX3XWPIEHBKsOLXoIh8Uk2+MAs
         F+CJQxxWP191/W6HFvH6lj64HdEwtg58NbSoNUh3YpoSliKjFhsxfgmrUU7TmqEXQSbA
         lU9dOQiDCZxCiIWIVTKbtNs+98LYvpFDBOPNToL5g7gMbF0xODx3kKGnhDqkissjjzkI
         l4bLfmBTtjqfJKpcYSPLujc8FcDgYDnc1+tACdjUbfMobRhhzRmLMnKvp+6If9eTZUC6
         wZbA==
X-Gm-Message-State: AOAM533SD/HIhAMN2XZzW4KltisvvISi3CbIuGdYwXmhH7PVz4s5tJ5F
        yZA0/OpA0q2C+aGpQRGfdm4amZIIS0g=
X-Google-Smtp-Source: ABdhPJx5ei4rA9QeHZ9ueZVRMOHZYxS0oo146YGITxD3zAB+cRn6GtLTBsA4R8BwbZ0bpWRWcuahiQ==
X-Received: by 2002:a17:902:c7c2:b0:143:bdf7:1670 with SMTP id r2-20020a170902c7c200b00143bdf71670mr54962164pla.61.1638923891321;
        Tue, 07 Dec 2021 16:38:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:10 -0800 (PST)
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
Subject: [PATCH v3 11/15] dt-bindings: thermal: Convert Broadcom TMON to YAML
Date:   Tue,  7 Dec 2021 16:37:22 -0800
Message-Id: <20211208003727.3596577-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
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

