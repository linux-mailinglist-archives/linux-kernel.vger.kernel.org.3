Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF949CEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiAZPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbiAZPf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:35:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49FC061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:35:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h21so8909695wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tj0guoNH4q4novDmtBoOtGAutOOdll1d2XmoKB6eeJQ=;
        b=KLDGbuNMN9AsrespV+rifmAQkBzvZnJJSTQRykm8Ve53hmVPqybnoLNAuP5qZ0+pMi
         l8TgXuBqYOTW+Kcn8Ug6O/JBDHeiOmZ1STSMk8uLpWNMP/IEoea9IpUlj41BhVOKB2ap
         tDsUpRwhvERDpDD6Oj+8MJtSG6+0Pxzs1xKqQdg0KcDxfSh4yeasNF7mEVrb5KSKs+jW
         Ag1eYx6in8ux1Frg6+JlhYd3ZP707cWCoc1eUi7mUIAGWdZMK04VE6v+SLyrrh3mv5hd
         kzRqv5YwA9VyrH43ttV+O6+k4gsr058EB92IpujSfJeS3oWZmPbjYwHVF7AKUsr5rnhP
         Cz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tj0guoNH4q4novDmtBoOtGAutOOdll1d2XmoKB6eeJQ=;
        b=jgFDOYedFEgqlaaEbaPmivs4fWFgdTQ/3IDkFUk4MUV2y/fmssDE1Wbc2t51ZunRbY
         niwi3f0aE2+uwE6oPFGKcpNq6Jvfz8RgoQ00pgvjcHB8hMQ82hz5La+1QAp/nMeR8XJ5
         Nub8tsUcr1LQ+esxS8ecOMeMSNl99y/CZHZsPT0Avc8C93VQ3vgBZZ/M1V3p8BL7RIYk
         bo6nz7/ZIp1l7aWF2gs9w7C/QLfkibBHkMRkmtfuU45OcbTXnk2XzR/r7fmTRfNhbzdh
         YX0HAgWMJKeS80qnbJoTb93v1sBOFv/SfN4FCPjF6foTBzIU9xDhoEzttHsJ2VGskSCR
         OEkQ==
X-Gm-Message-State: AOAM530aLDhmaHJAvVoASDOpqgdM/ZeorpuQ+bMAf8qAilIemZGHvB2Q
        Dz/jjY/z0PsYklmEPXz/Dn8koQ==
X-Google-Smtp-Source: ABdhPJxDVe28gY+kPTckZyTnR7HQC2FGkOhdqzuq6gh4Nnq6nenw4euktvSatUsoFs70CM1rv2AJTA==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr14030363wri.282.1643211324822;
        Wed, 26 Jan 2022 07:35:24 -0800 (PST)
Received: from mkorpershoek-XPS-13-9370.. (laubervilliers-656-1-151-143.w92-154.abo.wanadoo.fr. [92.154.18.143])
        by smtp.gmail.com with ESMTPSA id n10sm3360958wmr.25.2022.01.26.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:35:24 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v19 1/3] dt-bindings: input: Add bindings for Mediatek matrix keypad
Date:   Wed, 26 Jan 2022 16:35:17 +0100
Message-Id: <20220126153519.3637496-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220126153519.3637496-1-mkorpershoek@baylibre.com>
References: <20220126153519.3637496-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "fengping.yu" <fengping.yu@mediatek.com>

This patch add devicetree bindings for Mediatek matrix keypad driver.

Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 .../input/mediatek,mt6779-keypad.yaml         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
new file mode 100644
index 000000000000..2c76029224a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/mediatek,mt6779-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek's Keypad Controller device tree bindings
+
+maintainers:
+  - Fengping Yu <fengping.yu@mediatek.com>
+
+allOf:
+  - $ref: "/schemas/input/matrix-keymap.yaml#"
+
+description: |
+  Mediatek's Keypad controller is used to interface a SoC with a matrix-type
+  keypad device. The keypad controller supports multiple row and column lines.
+  A key can be placed at each intersection of a unique row and a unique column.
+  The keypad controller can sense a key-press and key-release and report the
+  event using a interrupt to the cpu.
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt6779-keypad
+      - items:
+          - enum:
+            - mediatek,mt6873-keypad
+          - const: mediatek,mt6779-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: Names of the clocks listed in clocks property in the same order
+    items:
+       - const: kpd
+
+  wakeup-source:
+    description: use any event on keypad as wakeup event
+    type: boolean
+
+  mediatek,debounce-us:
+    description: |
+      Debounce interval in microseconds, if not specified, the default
+      value is 16000
+    maximum: 256000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        kp@10010000 {
+          compatible = "mediatek,mt6779-keypad";
+          reg = <0 0x10010000 0 0x1000>;
+          interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
+          clocks = <&clk26m>;
+          clock-names = "kpd";
+        };
+    };
-- 
2.32.0

