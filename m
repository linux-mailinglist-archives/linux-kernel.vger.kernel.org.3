Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D548C574971
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiGNJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbiGNJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:45:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7E17E17;
        Thu, 14 Jul 2022 02:45:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2520328pjf.2;
        Thu, 14 Jul 2022 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=fWGF1ctfDmnVtVVRRM36dynmdVl5bGA5h+FhA/rID6Nz0G4nnvxzp6sBGGMWZzEIM8
         Ti/CupQerEuuJ/t+arQqrcuFTRxO0y+JmIUVMnNsVLsz9777aWANmt6xDH+oeYV8l5Va
         AWQK9BAJnyZ6LOo3ljekYK4Tg9MWmPV0qTZCKsFgs4w49HQ4alVZH1bU3HdDWSGuJOGA
         JSHBvZH6fCUKAoGvugqzKZp98FzCfg1oru3zJdFKKVGFsTinD8hKy/64/8xifmY+4Zkx
         NfUZ6eZb63b5mV0JDdPEoxVGLeZUT+2WCSI0F0Jx8NAVbl2DgLTj4G3u4aR55lUU3HQC
         gyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=5/fFq5FrcR3OAOhTyFhFjv1gAuIBdpF/F2YVugUxjqaMJFEK/yu/hcBFwGTUneB42r
         lZwQMBaMQ34JrJHsmADbhE61AKk7wVk4f/kPaABe1btA3SKNzaMrmOF449L3l9i0iCJO
         TX8jmjLGGhg0pEeGC/wRQJyXjytzqyZU/57fXKY9dEErEU3GjCf+ER1ttkE05IEnwrDs
         e4xsnT1jMUslp48tmrzlaqUGUx1wYTJ8iytiwvfCGiMgwSrcoOe0yAdYRIcAJ7XcJJku
         izEgjXeQGq7pniVGkeno6t+1H9RkklE03CYA7Qhe+blhQpc/9jj0KSb6TX1fhXpkPNR3
         +eqg==
X-Gm-Message-State: AJIora8xGYUt3m0N4BEsaC+xmjR/7hwQm3wtvmGhIngtrH4cxv0iaTup
        zDj17j5XCbX+l/SdVJgpDxWW7Ceu4/g=
X-Google-Smtp-Source: AGRyM1tUr9tR7jln7dFmubnwg490ShbAWDJfkuJr+RTXFGwsJjS7W6AtAl4lhV9QSY8VQ/DodM9emw==
X-Received: by 2002:a17:903:189:b0:16c:39b2:c217 with SMTP id z9-20020a170903018900b0016c39b2c217mr8102829plg.113.1657791937720;
        Thu, 14 Jul 2022 02:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:488:5f89:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b0052acb753b8bsm1169233pfk.158.2022.07.14.02.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:45:37 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Thu, 14 Jul 2022 17:45:23 +0800
Message-Id: <1657791925-23929-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657791925-23929-1-git-send-email-u0084500@gmail.com>
References: <1657791925-23929-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the documentation for Richtek rtq6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3
- change the node name to be generic 'adc' in binding example.

Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.

---
 .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
new file mode 100644
index 00000000..88e0086
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+  interface, and the device provides full information for system by reading
+  out the loading current and power.
+
+  The device monitors both of the drops across sense resistor and the BUS
+  voltage, converts into the current in amperes, and power in watts through
+  internal analog-to-digital converter ADC. The programmable calibration,
+  adjustable conversion time, and averaging function are also built in for
+  more design flexibility.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+
+properties:
+  compatible:
+    const: richtek,rtq6056
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt IN+/IN- sensing node resistor
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adc@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

