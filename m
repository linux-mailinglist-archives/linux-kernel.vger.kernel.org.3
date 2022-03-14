Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43C4D904C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiCNXXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiCNXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:23:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416353ED01
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:22:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h2so12647097pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyWdovKVVCckXPMjkBj5HOPvtLszaKccs4KJAJEq75c=;
        b=gd/mpRXNZIF2VJdhjrLi5gZn3MaoHKTxbzU32xOXPIrp3qJNtVn6dQJgNfe7YX2j3a
         0g6yWNRohfn/hYKnCPTBUKRaBDmFmuo4rg5wBkDIZUcGmLJkulgryIjlY7jlcImn5fje
         0yHTrpHkUEFXVtaPZcvTQVA1k3hFk9UNtXfCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyWdovKVVCckXPMjkBj5HOPvtLszaKccs4KJAJEq75c=;
        b=eMJTqwzaDzjMJS3Lqy4kcjX75viBW1E+qwehL4JZrJMg3MHT/A79aBvDsVHbxZZKjw
         eDE0MCwuVOpUZT1UQ6a/iq/+Pbgj4MxyaESTzQVDrdlxaqQ9jBB4pg0WXZLwxAlGp8DY
         vc32xUBYKz1B8MXdBCR9rWubTrS9ffvDAcptY352vHKGIZKKaNsteGTZ8dd/viZYU3UY
         IS30GQ51seeDAvgjGk7TRTqY3DFXjDZyM/pCkkqYcufcS7sl8xSynxHCx2zGrfHGxiZG
         kSDknGTTXXsu+Aq7NeuLeTRWeZXDwxzzjDuNqhyLJCarDgd/F1tV8J1XDTJLjzhLWqdv
         2HZg==
X-Gm-Message-State: AOAM530PRTl0ihwtS631U9aVpd+1dC7e0DxRfp7/ys34VpRzUB/toFBF
        WdZZXRQbNIERCEfdrWQ0PpYBnw==
X-Google-Smtp-Source: ABdhPJyue0rrmnVO9lVVYRhVoQVCMl+3aMPwsv3nWUscpquVVlGIatiElmPKoYdE5bfjygLAnc8Xog==
X-Received: by 2002:a05:6a00:1ac7:b0:4f7:442d:a5cb with SMTP id f7-20020a056a001ac700b004f7442da5cbmr25805567pfv.42.1647300137761;
        Mon, 14 Mar 2022 16:22:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c7b4:6b67:b9a2:ab68])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b004f6f267dcc9sm20759886pfm.187.2022.03.14.16.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 16:22:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
Date:   Mon, 14 Mar 2022 16:22:13 -0700
Message-Id: <20220314232214.4183078-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220314232214.4183078-1-swboyd@chromium.org>
References: <20220314232214.4183078-1-swboyd@chromium.org>
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

Add a binding to describe the fingerprint processor found on Chromeboks
with a fingerprint sensor.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/mfd/google,cros-ec-fp.yaml       | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
new file mode 100644
index 000000000000..05d2b2b9b713
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec-fp.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/google,cros-ec-fp.yaml#
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
+  reset-gpios:
+    maxItems: 1
+    description: reset signal (active low).
+
+  boot0-gpios:
+    maxItems: 1
+    description: boot signal (low for normal boot; high for bootloader).
+
+  vdd-supply:
+    description: Power supply for the fingerprint controller.
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
+        boot0-gpios = <&gpio_controller 10 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pp3300_fp_mcu>;
+      };
+    };
+...
-- 
https://chromeos.dev

