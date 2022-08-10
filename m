Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C458E51D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiHJDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:05:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7A7B1E1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:05:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10dc1b16c12so16335493fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VoTUorVB9HyzFfV2C/VGInjiRUKcMUhtoE/4tJPuAVI=;
        b=gMyYIEwIcENjOzYY0rhgt9UlAiPWe6Ye5InpGwOxfZzB0nFQUR8tOartcbbJndnvLt
         uCm0HtxP/CEjUrdjyE2rZIU+wBeZEPzvyDiNm0seF1ql3VjDk2ui0DdpyUgm28xVMaRM
         MEeLytYCZ/2dt8a/SbmtvxDLS0aY0VKfR3myznuA/8iHZB8w6gPNzy3z3cVxduTC4XLU
         lJijJMrpqmK/dSg8uuP79vR2JFyDAZN4yOa0dzN7v4ELD4XD3JBgHUQbs8RgNCJ+eSMf
         uc3CNVtEH6bSnn4w1oa2D/OrJHcdtvfRN0obaFPafRNTFWBAKFFqPrTSuWCRj1QCmPpQ
         mjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VoTUorVB9HyzFfV2C/VGInjiRUKcMUhtoE/4tJPuAVI=;
        b=euAenqzuL1eFzhTaIGir9oQwp5fjVTQzf4i0tPw0PO5ZhbAbMHckZmzYviB/7o/L4m
         LiTjjmGlngW/UpjRL0WWXUN0xPAEP8BtIulempSaxpJu8yz1UNjgD7UcuIttdCax61Nb
         nrnQHhvfGkeLPbgDKRwZlQ/h3ueOL61b3VzrFlkFnC2qjaxJvJ+cGNSgNZtZ6k9CQTj2
         kPQ8xQ1RVsQ/H85jJzPek7xlByosMDT86XL3N+kKlvakaHxsEYleXwy25F4rkLXwhiMA
         Np31jm+7ZUNKhyicBSaLzNumQyDxJOnVZuE4Jb3QJSg7w+iMtVfM3H/8YXL7GTcvWyG/
         fZKw==
X-Gm-Message-State: ACgBeo2VO4z1Tcd9rUN/yxCqGTSmJWczUqVrp66xWyuuEndVXoiZKj3z
        JmrYcfNnqheMYCi0WS118/w0eg==
X-Google-Smtp-Source: AA6agR6Q4EHw/Pz75ueki6qIR9HWoMlc5nsLZ6+4VxfuV0l8szB92xxBf41GXX6Kk40xjvXNVukxHA==
X-Received: by 2002:a05:6870:c1cd:b0:fe:1295:6e34 with SMTP id i13-20020a056870c1cd00b000fe12956e34mr643556oad.137.1660100703637;
        Tue, 09 Aug 2022 20:05:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s20-20020a0568080b1400b0032f0fd7e1f8sm409004oij.39.2022.08.09.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:05:03 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: Add Lenovo Yoga C630 EC
Date:   Tue,  9 Aug 2022 22:04:59 -0500
Message-Id: <20220810030500.2793882-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the Embedded Controller found in the Qualcomm
Snapdragon-based Lenovo Yoga C630.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../power/supply/lenovo,yoga-c630-ec.yaml     | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
new file mode 100644
index 000000000000..2dceb57a56b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lenovo Yoga C630 Embedded Controller.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm Snapdragon-based Lenovo Yoga C630 has an Embedded Controller
+  (EC) which handles things such as battery and USB Type-C. This binding
+  describes the interface, on an I2C bus, to this EC.
+
+properties:
+  compatible:
+    const: lenovo,yoga-c630-ec
+
+  reg:
+    const: 0x70
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  '^connector@\d$':
+    $ref: /schemas/connector/usb-connector.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c1 {
+      clock-frequency = <400000>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@70 {
+        compatible = "lenovo,yoga-c630-ec";
+        reg = <0x70>;
+
+        interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        connector@0 {
+          compatible = "usb-c-connector";
+          reg = <0>;
+          power-role = "source";
+          data-role = "host";
+        };
+
+        connector@1 {
+          compatible = "usb-c-connector";
+          reg = <1>;
+          power-role = "source";
+          data-role = "host";
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@1 {
+              reg = <1>;
+              lenovo_ec_dp_in: endpoint {
+                   remote-endpoint = <&mdss_dp_out>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.37.1

