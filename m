Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5C4DD0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCQXCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCQXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:02:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F15147AFD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g17so11492130lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSX5XIgPOxOnww4CSR+De8Pza4n5HUdUiMJxEJQrB3g=;
        b=Q1I0OAkdlWp2ovUowkKLdVu5Tl2OF3/hoLP+Ms0FV58ym9H2/pNLXkYAmepbSzxYMv
         hHxBJ0J9fqVyh6Od6b+vJMIf344dM1oAXiwugVQ77TtAElFs9AJsTXg0zcp/vCfJD7I0
         7zfN/0iXhrUiGp1T1nGVtIRqQo3oq0eZ7eOgAETWKMOaeJTHsVxC5c91SKHlQjLr0JZs
         2rXaDMrdPPQcWEstGktivxNdlWZAkHEm4Pw+Q4j+1SenDTDjdQ1c7BZ/rQa4GiFXVPNs
         /zs0t/ebgyv/TQ6ifaoGmjSplVmif4QYgiuydL+ho4gnRQHObAQE8xONQk1TKYyPhw8+
         hcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSX5XIgPOxOnww4CSR+De8Pza4n5HUdUiMJxEJQrB3g=;
        b=5kZ9RrOtUe143FQw/f+k89w53Pr4Y988ZAYvt0f1jGh23iO3gM81BPQuCevhpcMhzu
         VPaZzGMVw+bktA2d1AxgPtbVP0hNKq2KhcCU43SGVYbVRmk+xGadxg+xc1QLRVOkuYrB
         4jwXtjkR0jmj71w7X0jPHj1HfD6sTLH40hOoyY04+OHnfXPrHkNAEDxFFwg+WC8ZyRMA
         bi9APO95SoztehX0pXjNiJqQBdl3w1KHEcqf7xbCuYQRFFiSYDmnmhFGriij6xZsbDB5
         27bH/4vnxz+PffHtWZbCdAYrWtkTUhYtaL6YpXK7smHElhfr2oCq49MTyyHnFQnC98pa
         G/eg==
X-Gm-Message-State: AOAM533iRZEENdrAj3XofUYQLi5CnO6+Au2wJgiefLC03TszOrQN+yVM
        EhKRKnpyyQM4698vH52DEhbEVw==
X-Google-Smtp-Source: ABdhPJzQQjqeagfBYCPNZB0Tkvyhlfgd9tcMTINgyASzLqGQsXqA0aViXmo8vOh8EqWmc736dbfazg==
X-Received: by 2002:a05:6512:1054:b0:448:9c69:c6d2 with SMTP id c20-20020a056512105400b004489c69c6d2mr4132649lfb.583.1647558049926;
        Thu, 17 Mar 2022 16:00:49 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm191876ljv.35.2022.03.17.16.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:00:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5 v2] dt-bindings: gnss: Rewrite common bindings in YAML
Date:   Thu, 17 Mar 2022 23:58:40 +0100
Message-Id: <20220317225844.1262643-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the text-based GNSS common bindings to use
a YAML schema.

Cc: devicetree@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collected Krzysztof's review tag
- No changes just resending
---
 .../devicetree/bindings/gnss/gnss-common.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/gnss/gnss.txt         | 37 -------------
 2 files changed, 55 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt

diff --git a/Documentation/devicetree/bindings/gnss/gnss-common.yaml b/Documentation/devicetree/bindings/gnss/gnss-common.yaml
new file mode 100644
index 000000000000..963b926e30a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/gnss-common.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gnss/gnss-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Global Navigation Satellite Systems (GNSS)
+  receiver devices
+
+maintainers:
+  - Johan Hovold <johan@kernel.org>
+
+description: |
+  This document defines device tree properties common to Global Navigation
+  Satellite System receivers.
+
+properties:
+  $nodename:
+    pattern: "^gnss(@.*)?$"
+
+  lna-supply:
+    description: A separate regulator supplying power for the Low Noise
+      Amplifier (LNA). This is an amplifier connected between the GNSS
+      device and the receiver antenna.
+
+  enable-gpios:
+    description: A GPIO line that will enable the GNSS receiver when
+      asserted. If this line is active low, the GPIO phandle should
+      consequently be tagged with the GPIO_ACTIVE_LOW flag so the operating
+      system can rely on asserting the line to enable the GNSS device.
+    maxItems: 1
+
+  timepulse-gpios:
+    description: When a timepulse is provided to the GNSS device using a
+      GPIO line, this is used.
+    maxItems: 1
+
+  current-speed:
+    description: The baudrate in bits per second of the device as it comes
+      online, current active speed.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+      gnss {
+        compatible = "u-blox,neo-8";
+        vcc-supply = <&gnss_reg>;
+        timepulse-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+        current-speed = <4800>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/gnss/gnss.txt b/Documentation/devicetree/bindings/gnss/gnss.txt
deleted file mode 100644
index d6dc9c0d8249..000000000000
--- a/Documentation/devicetree/bindings/gnss/gnss.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-GNSS Receiver DT binding
-
-This documents the binding structure and common properties for GNSS receiver
-devices.
-
-A GNSS receiver node is a node named "gnss" and typically resides on a serial
-bus (e.g. UART, I2C or SPI).
-
-Please refer to the following documents for generic properties:
-
-	Documentation/devicetree/bindings/serial/serial.yaml
-	Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Required properties:
-
-- compatible	: A string reflecting the vendor and specific device the node
-		  represents
-
-Optional properties:
-- lna-supply	: Separate supply for an LNA
-- enable-gpios	: GPIO used to enable the device
-- timepulse-gpios	: Time pulse GPIO
-
-Example:
-
-serial@1234 {
-	compatible = "ns16550a";
-
-	gnss {
-		compatible = "u-blox,neo-8";
-
-		vcc-supply = <&gnss_reg>;
-		timepulse-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
-
-		current-speed = <4800>;
-	};
-};
-- 
2.35.1

