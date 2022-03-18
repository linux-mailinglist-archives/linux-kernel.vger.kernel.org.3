Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447894DD292
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiCRB4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCRB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:56:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42F21DF04
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:54:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h2so8316907pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+oN2PkESqB41nkMUnSgEXHs7aUpmXvqHqu6nMf9ygI=;
        b=e9WddNIUJiPhK0Y81FA/RAxuWrUeVracIXuSi3Py1u61KIblEyW1HbOKaisIMnBTi8
         TDwzciOOyCOYx0UUy/P3oZnZ7JJRHI6lzJskdLBCaZK0+h7qSdeVxqLbgaNpoQELVCkU
         0zwHRWxvBUzUMAQFsx6V+6ZI0gsKLXAUjhI7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+oN2PkESqB41nkMUnSgEXHs7aUpmXvqHqu6nMf9ygI=;
        b=GM+/laTzaEJpSRr48T7Bv/N8noxeBjnNKUG5oy6Ko1nCPt2h6ERY62TRHNPTuTzYiM
         sR3y7WOhiCE1wq4MWUwMVX5byHauQid0iRla2y6F4+t3EHsHk3OOS+JnFQDJKscTwWMN
         PH4OsubDYWfR/u52dVOs4zQwwOu7SXCtHIFO0D59L+pY9dUEQEPrAm0ii/QVB44rWSLU
         FVKWyeCtxvRiNZSInPdCq+pPvRRmQQfhvaF/2Xc0YhU4Le1P9mwIcl52lytQYL69aqC/
         cxzlpZuzPmoArlA/XBxOZQeF0z4WZ8j4vR88iSjOSI7BxocjmkukKa6+8/+16Zgzfggb
         Wiwg==
X-Gm-Message-State: AOAM532jMPS6E8yXGo3CR9wbNtzxBIHlpPjeRFCf/I+0pvK/SDfavVF8
        Gsl1qF1ubc9SAYBwLrjLSy2z6Q==
X-Google-Smtp-Source: ABdhPJw+tLB09E1yBm6TENEEbz+loQSPysQXCshfbFNSGsjCJDorbQbkjCs89FjWuc0TJkwWng5j9Q==
X-Received: by 2002:a65:45c8:0:b0:380:352e:825b with SMTP id m8-20020a6545c8000000b00380352e825bmr5937245pgr.509.1647568494348;
        Thu, 17 Mar 2022 18:54:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:49cf:7701:359e:b28f])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f783abfa0esm8050201pfi.28.2022.03.17.18.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:54:53 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/3] dt-bindings: chrome: Add ChromeOS fingerprint binding
Date:   Thu, 17 Mar 2022 18:54:48 -0700
Message-Id: <20220318015451.2869388-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318015451.2869388-1-swboyd@chromium.org>
References: <20220318015451.2869388-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/chrome/google,cros-ec-fp.yaml    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
new file mode 100644
index 000000000000..b7fbaaa94d65
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-fp.yaml
@@ -0,0 +1,66 @@
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
+        reset-gpios = <&gpio_controller 5 GPIO_ACTIVE_LOW>;
+        boot0-gpios = <&gpio_controller 10 GPIO_ACTIVE_HIGH>;
+        vdd-supply = <&pp3300_fp_mcu>;
+      };
+    };
+...
-- 
https://chromeos.dev

