Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2C4DBBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354255AbiCQA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbiCQA7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:59:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987F13CCD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l8so5569691pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVaSiMrGUBcuxr+BXheMhCpTwOTEdY3UKmynqOZB7GE=;
        b=laiMa1UGEj7YbxyVRZ7aUO9i2EcvkGLOGcVqw5do55ZZ0ighV06QEkme6Dd7iBf3nF
         qSL3a1C7XNtfO27iCLFd13f3TDzDZJC9+J7gM6ug1YOavfLB/h5sFsrmO/JLPkOXn7vM
         FkrYbi7f5hydijrpe6WfdHplPq9VFdm15W61Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVaSiMrGUBcuxr+BXheMhCpTwOTEdY3UKmynqOZB7GE=;
        b=Pmj3ggZ8lypqTLQQrg3tBS9DQg7bCrBP6v740p9PhA00v1olLvgtuhos/l2XuukaRm
         eW8YyJvHvnnevZMSUkBuSDMUguVYe4RlLzNmGZ6ekJ9UmjnRyvtyHe+XNMtOVVsybPwN
         tVkAVBZSt7AAhtDfU9944bmKYWpqBHvqm219ptZkI/p/vowynZaO/5GCc6+EPcFcBWuJ
         yF1Tu4rBv4Fl7KMNhPaoF1qP+m9XSCizXL7poOQcDsJUwGcZ+RyYzFQmUDJB70OOv9B7
         shvRPCaM96qYT1uJAA1Yv7ueYkl5NUZCrtEPxnXmWqq6Zqu488l/LWdjOhQVwj+hob7E
         JiRA==
X-Gm-Message-State: AOAM533u++quR+R/fNWhaDAwOh9eg5xkXJhagTtoC8loJyg4XBmWxQCm
        G/SrWF0SVeI/nsAGYfasNLPyzQ==
X-Google-Smtp-Source: ABdhPJw5GSVzk93O9AbsNKLeH45njGoSIqITsaIK4AQ+v4ZD3t8POB/0cPylVtYlqcqNRymomj4wGw==
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id b6-20020a056a00114600b004c9ede0725amr2144828pfm.35.1647478698387;
        Wed, 16 Mar 2022 17:58:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id l20-20020a056a00141400b004f65cedfb09sm4433445pfu.48.2022.03.16.17.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:58:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: chrome: Add ChromeOS fingerprint binding
Date:   Wed, 16 Mar 2022 17:58:12 -0700
Message-Id: <20220317005814.2496302-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220317005814.2496302-1-swboyd@chromium.org>
References: <20220317005814.2496302-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to describe the fingerprint processor found on Chromebooks
with a fingerprint sensor.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/chrome/google,cros-ec-fp.yaml    | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
new file mode 100644
index 000000000000..ba4212e6b583
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/chrome/google,cros-ec-fp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS Embedded Fingerprint Controller
+
+description:
+  Google's ChromeOS embedded fingerprint controller is a device which
+  implements fingerprint functionality such as unlocking a Chromebook
+  without typing a password.
+
+maintainers:
+  - Tom Hughes <tomhughes@chromium.org>
+
+properties:
+  compatible:
+    const: google,cros-ec-fp
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 3000000
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios: true
+  boot0-gpios:
+    maxItems: 1
+    description: Assert for bootloader mode.
+
+  vdd-supply: true
+
+  google,cros-ec-spi-pre-delay:
+    description:
+      This property specifies the delay in usecs between the
+      assertion of the CS and the first clock pulse.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 0
+      - minimum: 0
+
+  google,cros-ec-spi-msg-delay:
+    description:
+      This property specifies the delay in usecs between messages.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 0
+      - minimum: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - boot0-gpios
+  - vdd-supply
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+      ec@0 {
+        compatible = "google,cros-ec-fp";
+        reg = <0>;
+        interrupt-parent = <&gpio_controller>;
+        interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+        spi-max-frequency = <3000000>;
+        google,cros-ec-spi-msg-delay = <37>;
+        google,cros-ec-spi-pre-delay = <5>;
+        reset-gpios = <&gpio_controller 5 GPIO_ACTIVE_LOW>;
+        boot0-gpios = <&gpio_controller 10 GPIO_ACTIVE_HIGH>;
+        vdd-supply = <&pp3300_fp_mcu>;
+      };
+    };
+...
-- 
https://chromeos.dev

