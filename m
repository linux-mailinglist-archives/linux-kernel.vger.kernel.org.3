Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4558C478409
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhLQEUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhLQEUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379AC06173E;
        Thu, 16 Dec 2021 20:20:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a23so969489pgm.4;
        Thu, 16 Dec 2021 20:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieSmX+5TUTroa8wpdRCdIiNWCBAnggfwpKp3Xk+VqbI=;
        b=F/po5oCu+WsIqbYhXeVZ/xLt7WIGKIk+eW+tUokvAvPAOMyyqFdtvIiU3sMkF051tz
         1KudGZ2tchYF7H5aEgcte1CHuMVLQPvSDj0bY6VBfOrA/crk7e0TOh7EZDCfP7n6D+e5
         JRHrctv0ZAsVGwumNjZRSE+fCPfybe6tikYYbzB0GiC2okkLCSvpXq1wBYSJcMFZyhS5
         hSI1IVGQEORmoGMiiqo/Nm14rjWtkUgd4C6CsoPWrHetIW2E4UpR8o2N59MWdEEVbPbf
         PtG5Erep4wOF+ngnr/7aU5YVyw2CeqL/8pZh20zkY2/f7w7FprylB+O7B/jNf57BgIh0
         H4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieSmX+5TUTroa8wpdRCdIiNWCBAnggfwpKp3Xk+VqbI=;
        b=Dt0A6sYnoKvGPRy3okxzxfi490PaseWCzBkhC4B8dfeJTY1BCOIi0Ly7xU7hVwgh1P
         0jNbSAiwaKRqZPmvKKAoTmRkjONgQtidcf/CWvdZ5di1C2P/lV+JXJ3HcUuud2nj8fr7
         BT3SJjf13LSfDA8q+MmD2cA4n0GJ/Tf4c/H0hEEPXv9HTjr7uA5V3t3J4phTv1RAVXwG
         CGITXs6VRVC7EPSC2BsODrFrSMK3oy3EK7HJ7xxByyrt0CIjNX5dlLPlA2/JGdcHzIZW
         BWhU+260HK9annx2WSjPzYlDel9O4S+zdyu0l72G95BZ7rHKB+zt8n6kWk1k3QWamI3Z
         zS4w==
X-Gm-Message-State: AOAM530CHZyRXdx9gwAAC5PVUVB+abtZtPqMHexHSKvB4PZMlfaro9z5
        L0zbeASvNsFPEp67z8vCfvT8RXK8mGU=
X-Google-Smtp-Source: ABdhPJyu0yis2GMSgTTY1EHcgCTH9yVzZcUbaIQtRNg7Fci35upHl+yrbt7ETwj85/2S0TfFTG/Edw==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr1238841pgr.489.1639714821151;
        Thu, 16 Dec 2021 20:20:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v4 6/6] dt-bindings: usb: Convert BDC to YAML
Date:   Thu, 16 Dec 2021 20:20:01 -0800
Message-Id: <20211217042001.479577-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217042001.479577-1-f.fainelli@gmail.com>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom BDC device controller Device Tree binding to YAML
to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/usb/brcm,bdc.txt      | 29 -----------
 .../devicetree/bindings/usb/brcm,bdc.yaml     | 49 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 50 insertions(+), 30 deletions(-)
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
index 000000000000..f72dc65d4919
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
@@ -0,0 +1,49 @@
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
+    minItems: 1
+    items:
+      - description: USB 2.0 or 3.0 PHY
+      - description: USB 3.0 PHY if there is a dedicated 2.0 PHY
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
+        usb@f0b02000 {
+                compatible = "brcm,bdc-udc-v2";
+                reg = <0xf0b02000 0xfc4>;
+                interrupts = <0x0 0x60 0x0>;
+                phys = <&usbphy_0 0x0>;
+                clocks = <&sw_usbd>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index b5b7dcaba8b6..4a8356add1c9 100644
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

