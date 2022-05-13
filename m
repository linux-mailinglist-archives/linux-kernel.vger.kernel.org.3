Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE7526AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384048AbiEMUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384051AbiEMUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:06:05 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFA2E0B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q8so11384904oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGS8MF/Xhbljo/V0X6FBR6Q+x7h80TWkximSoLlEBGs=;
        b=CmOfYQdg9+gMBNGJb8V6ihuztQ8FNs8jaHFh5eGott+ezBfNrjvHcHGxBorUwAIEqX
         qAzQ/4UATx6e+qvwPnZvbT9Fk9azzf2JfOOkJnhNgNawXxrrHfjEmVBrTooOUpsu58k6
         tQgYpbUvngnrB5wKN8W9ev4qlAIOk5KSqtI1EPRq11vgNpHLrnaF17cgPgqkqpKCZ0wT
         Id631eLL34pQGWM5D4fuTiZTaTID8P/gMt+HHX4u1+E2tzfMA2ktMudWCPCA9bm7B14w
         ilTYjul5h1hshcXjwbpsE9cWKRrCwPOMaVzFGG01WAzqXAZb1IWY0/UMLACWNnHUB9E5
         07DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGS8MF/Xhbljo/V0X6FBR6Q+x7h80TWkximSoLlEBGs=;
        b=AAPVbqcTwZ3YWjN/D1NrpMdaR9YbN+41Tb/hZ6oau4QsBM5R64TibrE2S+ZtuNqd2J
         fglmoxrespsM4WL5JoKLkSD9/dqqtYm2Rlw9Ofc2jAq3VBos0aFotDPZpj0FbY5HMD53
         v0qX1qV0Kc9f0w/8eFGQlQVXmtyjVOJ51emOG4+WjIUttUPSasHBeodkGu1Jf7gMPePW
         bUXtk7IvhB9HlfIrjMbKDMlV2TO2qZH0Hw99RvMLnHmC84OIywRgKhrouRot1bDOJM67
         eMXm9rJEtSbMHSuliZT3JhwfCssENkxXVDyBGFIc/tZnzCcWIbMN6xneVK8WmOahVSTm
         QBJA==
X-Gm-Message-State: AOAM530uecpukuHT60nVzu0isiTE3jIlYxjLCmhgv9OvZ3GZpT3JA21c
        +h8FT79D3/hfmYgSuTfkE0QnZA==
X-Google-Smtp-Source: ABdhPJyaYLtsabZdK86Y5vR/ME4xk7GD1jIO0mxufKrtFS3B3Uzds2Kifbu14ucRKplsaNjIAz7Chg==
X-Received: by 2002:a05:6808:2126:b0:326:e464:beab with SMTP id r38-20020a056808212600b00326e464beabmr8669661oiw.25.1652472356598;
        Fri, 13 May 2022 13:05:56 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm1456962oti.16.2022.05.13.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:05:56 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 6/6] dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
Date:   Fri, 13 May 2022 21:05:12 +0100
Message-Id: <20220513200512.501156-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513200512.501156-1-caleb.connolly@linaro.org>
References: <20220513200512.501156-1-caleb.connolly@linaro.org>
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

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../power/supply/qcom,pmi8998-charger.yaml    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
new file mode 100644
index 000000000000..277c47e048b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-charger
+      - qcom,pm660-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
+      - const: bat-ov
+      - const: wdog-bark
+      - const: usbin-icl-change
+
+  io-channels:
+    items:
+      - description: USB in current in uA
+      - description: USB in voltage in uV
+
+  io-channel-names:
+    items:
+      - const: usbin_i
+      - const: usbin_v
+
+  monitored-battery:
+    description: phandle to the simple-battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <4>;
+
+      charger@1000 {
+        compatible = "qcom,pmi8998-charger";
+        reg = <0x1000>;
+
+        interrupts = <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+        io-channels = <&pmi8998_rradc 3>,
+                      <&pmi8998_rradc 4>;
+        io-channel-names = "usbin_i",
+                           "usbin_v";
+
+        monitored-battery = <&battery>;
+      };
+    };
-- 
2.36.1

