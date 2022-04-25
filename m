Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9095A50E1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiDYNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiDYNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C509BDE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:31:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v1so14442766ljv.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccosb5OLlMLmZzgxt/IQ3pX0ynIyPqTno6b0V3kf4QY=;
        b=h7uireBSCGtFURN6YqTRU6eeR3CHZOnsJGdnJeqP6QwMQSj2SGyD6UbXohwPydwgpb
         vmp6zbfchpXP81+EMOgnQ6MZBbHkyY+H4yQJgu97wVoKnngHY0EhbUDlsCHJWCWJOO55
         ivlRGRKFNW6E+Wcrd419jbvv0nqOCS8FuzKv8YcVTHRAUJ1b4xfdBe+mJkWIk6FPRvLy
         NXvWLG8SAvVKJJ0hmO9ASek+ULoemo+DFdWIJR+7SwMOvu6bmOAjjCB7A6VYeShtF2II
         fBr7jitEgZWVGOD0KrQl+SLq9Cylu1iLDtOwjDbx64PfOPqPBDHlSZFYZ1M5Tpp9qfVm
         00XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccosb5OLlMLmZzgxt/IQ3pX0ynIyPqTno6b0V3kf4QY=;
        b=QKJlog7IOpNFoAcyUtqqsr1P7BXztNNEgjdzZqyib/atp1OMF0xO9aKl9qJq4vsd5S
         0l0FvPbAbJz+dUgFMcdClFASLgm8VWbcSFxgPwAZb9uWZBlXGgoiQN+VyPe3vOxiOrm3
         8B4WRAqqaoXXDL0P7Vro47TCKQ5C7LoeMQBHfJsa5/9BOJw8XYxoiogIOHGMHymKqoIL
         WRkFVTcsfz8uw+EpLlS5UEuJ08sSUSHd+0ZvMo6ZmxqKJxBvwRCpw/D1MecEPMeN6oFL
         Y9ihZWpcxh992Y1bl2PGiMfkIWewt/9Dg0eW3ZNpgeANNPdG7VoO0GPQJgV+q5tjgVuA
         +78Q==
X-Gm-Message-State: AOAM533ZCVzO4ofDcIl9IVRo+OEIexOV6JSN/I3E5onYN922kyg3SVA7
        X9j2ugC9lVU3FLPeYOqhZLR7Dw==
X-Google-Smtp-Source: ABdhPJwNvTMsZhVhg8b9FrfRFyxjyOQegcTFZsO1MwPyhBNFwitqNOpsc85qd0SqXs/hSiiuG2mNFA==
X-Received: by 2002:a2e:701a:0:b0:24f:a7d:2b2c with SMTP id l26-20020a2e701a000000b0024f0a7d2b2cmr5702849ljc.51.1650893512260;
        Mon, 25 Apr 2022 06:31:52 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id v7-20020a196107000000b0046d05202c61sm1414553lfb.65.2022.04.25.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:31:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] dt-bindings: gnss: Rewrite Mediatek bindings in YAML
Date:   Mon, 25 Apr 2022 15:29:47 +0200
Message-Id: <20220425132947.1311171-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the Mediatek GNSS bindings in YAML.

Cc: devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Add the missed gnss-fix-gpios.
- Move allOf to right before the properties.
- Keep the description on timepulse-gpios because it documents
  which pins are used on this chip.
ChangeLog v1->v2:
- New patch since Krzysztof pointed out there is really just
  one more binding to convert, so why not.
---
 .../devicetree/bindings/gnss/mediatek.txt     | 35 -----------
 .../devicetree/bindings/gnss/mediatek.yaml    | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
deleted file mode 100644
index 80cb802813c5..000000000000
--- a/Documentation/devicetree/bindings/gnss/mediatek.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Mediatek-based GNSS Receiver DT binding
-
-Mediatek chipsets are used in GNSS-receiver modules produced by several
-vendors and can use a UART interface.
-
-Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
-properties.
-
-Required properties:
-
-- compatible	: Must be
-
-			"globaltop,pa6h"
-
-- vcc-supply	: Main voltage regulator (pin name: VCC)
-
-Optional properties:
-
-- current-speed		: Default UART baud rate
-- gnss-fix-gpios	: GPIO used to determine device position fix state
-			  (pin name: FIX, 3D_FIX)
-- reset-gpios		: GPIO used to reset the device (pin name: RESET, NRESET)
-- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
-- vbackup-supply	: Backup voltage regulator (pin name: VBAT, VBACKUP)
-
-Example:
-
-serial@1234 {
-	compatible = "ns16550a";
-
-	gnss {
-		compatible = "globaltop,pa6h";
-		vcc-supply = <&vcc_3v3>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/gnss/mediatek.yaml b/Documentation/devicetree/bindings/gnss/mediatek.yaml
new file mode 100644
index 000000000000..45cf01b27700
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gnss/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek GNSS Receiver Device Tree Bindings
+
+maintainers:
+  - Johan Hovold <johan@kernel.org>
+
+description:
+  Mediatek chipsets are used in GNSS-receiver modules produced by several
+  vendors and can use a UART interface.
+
+allOf:
+  - $ref: gnss-common.yaml#
+
+properties:
+  compatible:
+    const: globaltop,pa6h
+
+  vcc-supply:
+    description:
+      Main voltage regulator, pin name VCC.
+
+  reset-gpios:
+    maxItems: 1
+    description: An optional reset line, with names such as RESET or NRESET.
+      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.
+
+  timepulse-gpios:
+    description: Comes with pin names such as PPS1 or 1PPS.
+
+  gnss-fix-gpios:
+    maxItems: 1
+    description: GPIO used to determine device position fix state, pin names
+      FIX or 3D_FIX.
+
+  vbackup-supply:
+    description:
+      Regulator providing backup voltage, pin names such as VBAT or VBACKUP.
+
+required:
+  - compatible
+  - vcc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+        gnss {
+            compatible = "globaltop,pa6h";
+            vcc-supply = <&vcc_3v3>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.35.1

