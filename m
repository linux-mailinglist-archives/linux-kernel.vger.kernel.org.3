Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8258C411
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiHHHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiHHHfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:35:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368C6399;
        Mon,  8 Aug 2022 00:35:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q30so9824991wra.11;
        Mon, 08 Aug 2022 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5U3mxEHoJ4j0IaPwuYR+EkUg8ARPqLGxlFWvfIK89d4=;
        b=eS4uVBWF/h2cfOJPjUFgee0cwP/FtrazBNExTcWrHtpBDdkHJuLQ3vHMFtHIe70h2n
         A373KF/RdDDLdL+0XsQAki9vOoPit1LG8pzXZLtIruK6LG13Ppp1KbmZy+mh0WpFIfp0
         nF2w+ReA44wk6oE/Hq4sNE/MHKB95S/zKE8jg3OX8HlbUFzpWjmvOESpjm0zjyPEaCg+
         NEisDVvWQ+sVV++G6DkAl2EX0QUAhLqxwtkVW0E5TgWM66MY85UbZ+9Ig6NvGEasiP2X
         8GE6vDiF99kOgzU3oXO/OkIjIa6/v9m4Ll5Phgiok8JsLNVEMGYk+4n872iLarA1n2q2
         86Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5U3mxEHoJ4j0IaPwuYR+EkUg8ARPqLGxlFWvfIK89d4=;
        b=YQZ6KOMP5r0YvycFVa+H8BifkMhJazOQN2vaSwYa509FHNQybgDlr2G03kIRsooD9D
         EGiGBCfnWEJmiG9igm2sc5BjUqhExjh2POYMn3A1Z8xnxgFxin8kP777NnDuYuOQVad/
         6g0oPVDcymKUwU2vulTR1fnayMlrr3gtH1Q5jXQ68zjDp/yHfbsylaHxF3JN+Eskgqxu
         GB1Ii+RKtZ5K4VE0RSdrweur/zOnGebRfEoqjFuXAuI4AtAI3gFdlxI4xSrhA2L4UElU
         dOzHHvRNHQrCEOXjQmtMzkH/xVcoLi+AF3mV+I/Q97My+WcSpRgsgooRNr2CGZt5eriR
         NlWg==
X-Gm-Message-State: ACgBeo04wxPEy738fJCi+BYblF7dweLNoM1iYk+mZsc4ajVbSv6vNLY7
        3iFgI/CppuYU7xMa1r7AA8c=
X-Google-Smtp-Source: AA6agR4W+zEOcTCD/s/iQ29zJzIlUDGH9E2BoNthICuNIsPZjHK1Y3NLtwv7qRXORgqI8AiXJ6XiTg==
X-Received: by 2002:adf:f004:0:b0:21f:fdad:deb2 with SMTP id j4-20020adff004000000b0021ffdaddeb2mr10869569wro.279.1659944138532;
        Mon, 08 Aug 2022 00:35:38 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:35:38 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for Qualcomm SMBCHG
Date:   Mon,  8 Aug 2022 08:34:52 +0100
Message-Id: <20220808073459.396278-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add DT schema for the switch-mode battery charger found on Qualcomm
PMICs such as PMI8994. Due to lack of documentation, some interrupt
descriptions might be inaccurate.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/power/supply/qcom,smbchg.yaml    | 205 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
new file mode 100644
index 000000000000..d825a9c10b3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,smbchg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMIC Switch-Mode Battery Charger
+
+maintainers:
+  - Yassine Oudjana <y.oudjana@protonmail.com>
+  - Alejandro Tafalla <atafalla@dnyon.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8994-smbchg
+      - qcom,pmi8996-smbchg
+
+  reg:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+      phandle of battery characteristics node.
+      The charger uses the following properties:
+      - charge-term-current-microamp
+      - constant-charge-current-max-microamp
+      - voltage-max-design-microvolt
+      The constant-charge-current-max-microamp and voltage-max-design-microvolt
+      properties must be set.
+      See Documentation/devicetree/bindings/power/supply/battery.yaml
+
+  interrupts:
+    items:
+      - description: Charger error
+      - description: Charger inhibited
+      - description: Charger precharge safety timer timeout
+      - description: Charger charge safety timer timeout
+      - description: Charger pre to fast charging switch threshold reached
+      - description: Charger recharge threshold reached
+      - description: Charger taper threshold reached
+      - description: Charger charge termination threshold reached
+      - description: Battery hot
+      - description: Battery warm
+      - description: Battery cold
+      - description: Battery cool
+      - description: Battery overvoltage
+      - description: Battery low
+      - description: Battery missing
+      - description: Battery thermistor missing # unconfirmed
+      - description: USB input undervolt
+      - description: USB input overvolt
+      - description: USB input source detected
+      - description: OTG regulator failure
+      - description: OTG regulator overcurrent
+      - description: Automatic input current limiting done
+      - description: USB ID pin changed
+      - description: DC input undervolt
+      - description: DC input overvolt
+      - description: Power OK
+      - description: Temperature shutdown
+      - description: Watchdog timeout
+      - description: Flash failure
+      - description: OTST2 # unknown
+      - description: OTST3 # unknown
+
+  interrupt-names:
+    items:
+      - const: chg-error
+      - const: chg-inhibit
+      - const: chg-prechg-sft
+      - const: chg-complete-chg-sft
+      - const: chg-p2f-thr
+      - const: chg-rechg-thr
+      - const: chg-taper-thr
+      - const: chg-tcc-thr
+      - const: batt-hot
+      - const: batt-warm
+      - const: batt-cold
+      - const: batt-cool
+      - const: batt-ov
+      - const: batt-low
+      - const: batt-missing
+      - const: batt-term-missing
+      - const: usbin-uv
+      - const: usbin-ov
+      - const: usbin-src-det
+      - const: otg-fail
+      - const: otg-oc
+      - const: aicl-done
+      - const: usbid-change
+      - const: dcin-uv
+      - const: dcin-ov
+      - const: power-ok
+      - const: temp-shutdown
+      - const: wdog-timeout
+      - const: flash-fail
+      - const: otst2
+      - const: otst3
+
+  otg-vbus:
+    type: object
+
+    description:
+      OTG regulator subnode.
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+  - interrupts
+  - interrupt-names
+  - otg-vbus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    battery: battery {
+        compatible = "simple-battery";
+
+        charge-full-design-microamp-hours = <4070000>;
+        charge-term-current-microamp = <100000>;
+        voltage-min-design-microvolt = <3400000>;
+        voltage-max-design-microvolt = <4400000>;
+    };
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@1000 {
+            compatible = "qcom,pmi8996-smbchg";
+            reg = <0x1000>;
+
+            interrupts = <0x2 0x10 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x1 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x2 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x3 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x4 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x5 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x10 0x6 IRQ_TYPE_EDGE_RISING>,
+                         <0x2 0x10 0x7 IRQ_TYPE_EDGE_RISING>,
+                         <0x2 0x12 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x1 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x4 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x5 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x6 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x12 0x7 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x13 0x1 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x13 0x2 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x13 0x3 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x13 0x4 IRQ_TYPE_EDGE_RISING>,
+                         <0x2 0x13 0x5 IRQ_TYPE_EDGE_RISING>,
+                         <0x2 0x13 0x6 IRQ_TYPE_EDGE_FALLING>,
+                         <0x2 0x14 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x14 0x1 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x0 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x1 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x2 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x3 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x4 IRQ_TYPE_EDGE_BOTH>,
+                         <0x2 0x16 0x5 IRQ_TYPE_EDGE_BOTH>;
+            interrupt-names = "chg-error",
+                              "chg-inhibit",
+                              "chg-prechg-sft",
+                              "chg-complete-chg-sft",
+                              "chg-p2f-thr",
+                              "chg-rechg-thr",
+                              "chg-taper-thr",
+                              "chg-tcc-thr",
+                              "batt-hot",
+                              "batt-warm",
+                              "batt-cold",
+                              "batt-cool",
+                              "batt-ov",
+                              "batt-low",
+                              "batt-missing",
+                              "batt-term-missing",
+                              "usbin-uv",
+                              "usbin-ov",
+                              "usbin-src-det",
+                              "otg-fail",
+                              "otg-oc",
+                              "aicl-done",
+                              "usbid-change",
+                              "dcin-uv",
+                              "dcin-ov",
+                              "power-ok",
+                              "temp-shutdown",
+                              "wdog-timeout",
+                              "flash-fail",
+                              "otst2",
+                              "otst3";
+
+            monitored-battery = <&battery>;
+
+            otg-vbus { };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3796fd700727..7e9f5893c0eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16951,6 +16951,14 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
+QUALCOMM SMBCHG DRIVER
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+M:	Alejandro Tafalla <atafalla@dnyon.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
+
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
 M:	Thara Gopinath <thara.gopinath@gmail.com>
-- 
2.37.1

