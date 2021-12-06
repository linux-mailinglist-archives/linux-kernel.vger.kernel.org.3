Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740A746A43C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbhLFSan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbhLFSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB9C061746;
        Mon,  6 Dec 2021 10:26:49 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l64so5744411pgl.9;
        Mon, 06 Dec 2021 10:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUJ+46P2lZKqa9GcjTNExLZ59H82MAk46ZsUw+ykybM=;
        b=kU99L9Y51Kn0GGffgfdtTjU/trqWSkETe6sPE8NiMvNFQNV2DltAKs5XPjrhg+Jjdu
         exnXIWjBG2i4J4LI3YfCX6rl84hDrkLokZvi2WeNmCIw2OzDExSBZNa54ZJ14bH+cRe/
         a2h61/lL/Pcm1Fy2cqut2yGHOOFNKDqyUOsTTucu/ezxcRk8KbWcuDijMq0EuDx7RxvX
         Wk+Wy+HfxzPlh5PcKFH0qmcbxMVrAmvOvu8AXclMUXKqWG7P2xu0SlzXjmxYYkpmgkj2
         yU6HRKB/d5Gw+X17XbYZBqwI713hQgUqw8L2s1tyqIhWFfKnzFLRo3eygriopY6SPs1V
         CJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUJ+46P2lZKqa9GcjTNExLZ59H82MAk46ZsUw+ykybM=;
        b=VBSE6auKRm98cbTtPJeVtdnJ4kthb/4nGfliom7PpaCzXo0Dbou3fQNBeLHNlvfLcf
         ybdB28r6u5zgPx96BilTJ0DUs94MpTsuvpUvgYmaCGmGEYLJabfW7eBeFpbYdSxSEY+f
         9iYYen8z31C7/3Yz6BXm7XaHM+DhEeJQdrHtLIiX/DgwzSZOOAPg6V7TRdps735hCZZa
         2CgGu5SU22EwjqaKE13sP8oaMGWZdLasZSE3H6eAMRDM6c+Rj9fbYNMRPIzvLGKbKf1P
         S44y2cCPu6JYx+eOtOPeLZ0GVmqhXm8NMwj+ncW7eKwADol0BLAd3H4/L3Dyhnj44GN5
         M6YQ==
X-Gm-Message-State: AOAM533sokH1jIbPgKbyVFDla6TFcnAbme73VtHGdbaXaxX4FfQoRHAL
        YLrvyTZGbaInpzrJEQy8Yn0b78U3Seg=
X-Google-Smtp-Source: ABdhPJyigbdo9ZoRF96SOLo/9a6fD0t0h/AKLi0RxRvpjjnuQwdBtTHDjlTwh+2xmgk5SXv2yxaa1Q==
X-Received: by 2002:a05:6a00:1ac9:b0:49f:b38d:fe7 with SMTP id f9-20020a056a001ac900b0049fb38d0fe7mr38788631pfv.63.1638815208600;
        Mon, 06 Dec 2021 10:26:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a22sm12773097pfh.111.2021.12.06.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:26:48 -0800 (PST)
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
Subject: [PATCH v2 14/14] dt-bindings: usb: Convert BDC to YAML
Date:   Mon,  6 Dec 2021 10:26:16 -0800
Message-Id: <20211206182616.2089677-15-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206182616.2089677-1-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom BDC device controller Device Tree binding to YAML
to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/usb/brcm,bdc.txt      | 29 ------------
 .../devicetree/bindings/usb/brcm,bdc.yaml     | 46 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 47 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
deleted file mode 100644
index c9f52b97cef1..000000000000
--- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Broadcom USB Device Controller (BDC)
-====================================
-
-Required properties:
-
-- compatible: must be one of:
-                "brcm,bdc-udc-v2"
-                "brcm,bdc"
-- reg: the base register address and length
-- interrupts: the interrupt line for this controller
-
-Optional properties:
-
-On Broadcom STB platforms, these properties are required:
-
-- phys: phandle to one or two USB PHY blocks
-        NOTE: Some SoC's have a single phy and some have
-        USB 2.0 and USB 3.0 phys
-- clocks: phandle to the functional clock of this block
-
-Example:
-
-        bdc@f0b02000 {
-                compatible = "brcm,bdc-udc-v2";
-                reg = <0xf0b02000 0xfc4>;
-                interrupts = <0x0 0x60 0x0>;
-                phys = <&usbphy_0 0x0>;
-                clocks = <&sw_usbd>;
-        };
diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.yaml b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
new file mode 100644
index 000000000000..48831b62ab31
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/brcm,bdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom USB Device Controller (BDC)
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bdc-udc-v2
+          - brcm,bdc
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  phys:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+  clocks:
+    maxItems: 1
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
+        bdc@f0b02000 {
+                compatible = "brcm,bdc-udc-v2";
+                reg = <0xf0b02000 0xfc4>;
+                interrupts = <0x0 0x60 0x0>;
+                phys = <&usbphy_0 0x0>;
+                clocks = <&sw_usbd>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2109b6fe8ea3..b18c7fa42a4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3679,7 +3679,7 @@ M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-usb@vger.kernel.org
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/usb/brcm,bdc.txt
+F:	Documentation/devicetree/bindings/usb/brcm,bdc.yaml
 F:	drivers/usb/gadget/udc/bdc/
 
 BROADCOM BMIPS CPUFREQ DRIVER
-- 
2.25.1

