Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26E4D6B11
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiCKXyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCKXyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:54:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97421652B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:53:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w27so17753536lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBNusC+uzmE0NrjzdEt+MgpvOycN0Iv0sdzR/jIW3O4=;
        b=BrfZpw80bcUCAJ5ook8HcxZEJWCjo6aPyYHhqWwrcM44fXo5pV9/zdwN95JErycKdm
         YDdaejMurLJPrt6zHvZjsHRVeuyRyELshiFLI3ZwonMcKOUNy8Fsl2bxZjxO7dLjXD1B
         idkf5Bf8tOnMN/co5ONgYf0Equ52FR8PDDV0ydxbK2Qt2tvVfySh8lXb/PXMZPx2CY0z
         ioGBrk6RTOSVsTm6GYi4pwUPP/bB0YJK5jyMFshkvkEyRUQl0TlH2XQzWojDK+3kKfKR
         NKuqynUfHM+c+H1iKIhRjKE/LYF2D7um0oKm82+4iCA8rgQ6OjJ7y04grwkfxUJGqwxW
         KULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBNusC+uzmE0NrjzdEt+MgpvOycN0Iv0sdzR/jIW3O4=;
        b=PTmNc7abkLM48FoXTqGF6THNx9MgHslv49NeY9y6HpOA5iDKu4j/Ztx4+XJoESWQAi
         +G2jo/ytnBGG/E0zq3nWcQyHpNgnDjyAQO0qcZRhFClc1aOR0a8QAbV+rQGdKMTzHCYD
         y5JfHKLS+FadPuR9+13NTg0jbOANz5W7VvXQLwfWLNkzlQ3Jo7YwPE+zDg4fWYvXrMVJ
         uS3ogUvrFjyaf9mFRJQCYGRXB3Dgz1VgU8xa3wfG6c1UZtEE++0qb/rxYodR39GC8ch7
         Yzxj9sPGc3KAQpwoTPXGXlECJMZ8gZ3pKCQT0enK0MAKQTFreAkgJmvO6oILd3I7Il9D
         ei9g==
X-Gm-Message-State: AOAM5328e8fgpjTYOMMB625yu5uIvJ8+BapusNpxh4aovSdQygbngWnn
        iW8bOEhbjOIlLNrXaZc+VfL++g==
X-Google-Smtp-Source: ABdhPJyHLFY2Ff1XzOmbH3oaRd1mU0jpYboeQk159tp3ZmzfUn0rb4lidtgNvzDq+TyX+ABJEvS2KQ==
X-Received: by 2002:a19:7612:0:b0:448:307a:4bca with SMTP id c18-20020a197612000000b00448307a4bcamr7559415lff.361.1647042804911;
        Fri, 11 Mar 2022 15:53:24 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e1548000000b002463639d0f2sm1967691ljv.68.2022.03.11.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 15:53:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: gnss: Rewrite common bindings in YAML
Date:   Sat, 12 Mar 2022 00:51:16 +0100
Message-Id: <20220311235119.523374-1-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

