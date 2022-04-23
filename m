Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F017450C85C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiDWI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiDWI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:57:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E95203F7C;
        Sat, 23 Apr 2022 01:54:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so18109915lfu.1;
        Sat, 23 Apr 2022 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slEgsUhcpTsk6NTAyDsCJUv5IgUxOVRWBoNa+XCmx3I=;
        b=ZwJdeXcocc6D1JyXbcHLDqjWpcp+bA/N3hvB66GOHRE0JpLY/N8Mz7ZzM7jXDhcy3q
         zAOvMjl76rYYCRi6Ta/ONKiCKnxjzQsaIjk0Lj7LLGPFQw72TQAq3ocfnYkiaU2wAchX
         R00FDTmEx0dXWjRGwSr6BB6o+kJLt2cX8G/YOUCKFAoxdUS9oqyl8iez4CCadu8yo9gy
         HZMl8uF1hbR99bg4ZZuXny7ZZ4BfWLhkUn4G5GRDPAT9vdG/t0wCCT2WEpAurxa9l8Yu
         uFsVk00vTDeFhH1BZtf9f/TawQPQeQX7UQPZNbaSnnQ4Vo/hyLVluE4VsHlBweCWhLcm
         bdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slEgsUhcpTsk6NTAyDsCJUv5IgUxOVRWBoNa+XCmx3I=;
        b=KKPfd8OS2EwG4zmdEV5kOKqFSJJkEISx5l6tKxeH/huCTVBDLMhq1Q0PiY33n8cU59
         jAFNf9EVkdqFTFqY1FPFOkEHYvflxUAu8YRFmoF3hXRse4C2uWmM63kEhaTSzd6kqgG5
         TPcAEPRNIKKlTdbvKjEC9O8Ir8ObGcgm4AkRm0hXFA+nZkWB9hwbU40COIPHEUue5VAj
         NEq49CCaPd7VBimBPcET2cl8IHXmDWv9LiTy3s77gpKkETmcyAMNg0m4fUCiTjKGwQse
         IHKmRNO4qPh8X+68RxPNfYIOsTFPrjuxWjqHNncO+R7b87zw9mBVU53LRwUvZLFTRqxL
         NqKA==
X-Gm-Message-State: AOAM531ivp6XSXt8BKbDrtpWWBGdvhx/CK7/5CoOxQfJK2CC/GmfMDSa
        B71Jif8L8qii+0xQANAE2RUVoOFOZvc=
X-Google-Smtp-Source: ABdhPJwNhSN8/A9voPImEH0IkdCMBwsRTvFzmBnEB9GYBgpyngFstSVA7OvT8xMSOeIx1KxALpRJZg==
X-Received: by 2002:a05:6512:39c1:b0:44a:e25d:47fd with SMTP id k1-20020a05651239c100b0044ae25d47fdmr6049463lfu.580.1650704045893;
        Sat, 23 Apr 2022 01:54:05 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:54:05 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/5] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Sat, 23 Apr 2022 11:53:16 +0300
Message-Id: <20220423085319.483524-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for the Silicon Mitus
SM5703 MFD.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/mfd/siliconmitus,sm5703.yaml     | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
new file mode 100644
index 000000000000..32197be57cce
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5703 multi-function device bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  Silicon Mitus SM5703 is a multi-function device, that consists of several
+  modules, designed for a mobile phone use. It consists of
+  LDO, Buck, USBLDO and VBUS regulators, a flash LED driver, a MUIC unit,
+  a fuel gauge and a battery charger circuit. The MUIC and Fuel-Gauge units
+  are separate from the main MFD, having their own i2c lines, while the
+  LED driver, regulators and charger are sharing the main i2c bus of the MFD.
+
+properties:
+  compatible:
+    const: siliconmitus,sm5703
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  regulators:
+    $ref: /schemas/regulator/siliconmitus,sm5703-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  reset-gpios:
+    description:
+      GPIO which is connected to the MRSTB pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - regulators
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic@49 {
+          compatible = "siliconmitus,sm5703";
+          reg = <0x49>;
+
+          reset-gpios = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
+          pinctrl-0 = <&mrstb_default>;
+
+          regulators {
+            sm5703_ldo1: ldo1 {
+              regulator-min-microvolt = <2800000>;
+              regulator-max-microvolt = <2800000>;
+            };
+
+            sm5703_ldo2: ldo2 {
+              regulator-min-microvolt = <1500000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_ldo3: ldo3 {
+              regulator-min-microvolt = <3300000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_usbldo1: usbldo1 { };
+
+            sm5703_usbldo2: usbldo2 { };
+
+            sm5703_vbus: vbus { };
+          };
+        };
+      };
+...
-- 
2.35.1

