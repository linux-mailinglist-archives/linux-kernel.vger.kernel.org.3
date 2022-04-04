Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13344F1BE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381918AbiDDVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379983AbiDDScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:32:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51327FFB;
        Mon,  4 Apr 2022 11:30:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s21so1384384pgs.4;
        Mon, 04 Apr 2022 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Us6wl0q/gwpRDfhlxNog2kgLvXIfSCvVL7Nr5vhLBX8=;
        b=mB4WyIQGue7DvaUx4D9COiqiKi0aII624/cqdrNZJlThXAmTEreD6QUdvmieq6VdtJ
         2YODxJtQ6TzJJO5qnUxXBPO5u4oiMekkSLfUoxFrJh34IocF4Ps9aqIQeYVkCox0Rg5j
         bqCuDju3NmeirJ0h/qIfHZ8PO8ImWf7brggesYsPW0Bhb/G5PpMU/7FT6HGWJZrL7TPZ
         F7cl+8zwrBW/U0fwak2MYExbLnPdVNksh0dfx9WIRzN0UEXUSy1h4pC6jpRPMgFHjbS6
         iEUQslZrsCik1TP3xEJel6dHS15Ixq93DFyhCpxUSK/yLJwDwPcCvkLgVHtfP2H94Vx3
         FKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Us6wl0q/gwpRDfhlxNog2kgLvXIfSCvVL7Nr5vhLBX8=;
        b=enqiYt1DmSvbAJmKNTa6MpiZprt8yAgWCsETwyglH11Mp4KI4mENjRdsEDVRlDUxlI
         USm4cJXNbGU3aTE4EGRwrQCkPSSLC7FpW79hW8WmiN3xHXMN9J0r78672iCdTO8kpDtI
         UfnZKXhBeFuevBAus2abvhgSkOvBE6BOSBia+qc5NDNpEwmQmEplreVBichDGSUuXZzm
         AWD8xJD/hHjhzMBLFzUQsl40n33fNyc+jwAbYB5DbqHsA/Gde2B1xRf7BC4K2a8z7dAG
         kBAoz+IWrhylMUrh2Rdfq8j7tmO52YkbgkqQ/0QtXfUdvKpvX3RcwYBHOTqEpI7EZYRg
         maQQ==
X-Gm-Message-State: AOAM530jbnl0PrIh1u13CiWIrUF0XLkTPB0LQgyKwOYUcP+T5yxNH9iK
        414B6aKnMzzdh67g+auE4LI=
X-Google-Smtp-Source: ABdhPJzTxAnneoPAFMDLgXiuo+NRQ2lyhuVefbgbtFbo8F/6GMQz2MlZF5WVGGeySrDhRcHJIjPiAA==
X-Received: by 2002:a05:6a00:b8e:b0:4fa:de88:9fc7 with SMTP id g14-20020a056a000b8e00b004fade889fc7mr929643pfj.56.1649097015518;
        Mon, 04 Apr 2022 11:30:15 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm162656pjb.10.2022.04.04.11.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:30:15 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: serial: Update Qualcomm geni based QUP UART bindings
Date:   Mon,  4 Apr 2022 23:59:36 +0530
Message-Id: <20220404182938.29492-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
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

Similar to I2C controller, move geni based QUP UART controller binding
out from parent schema to an individual binding and let parent refer to
child schema later on. UART binding also stand incomplete right now
similar to I2C, complete it along this process.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
- s/i2c/I2C
- s/uart/UART
- Sort nodes alphabetically
- Add Krzystof's Rb tag
---
 .../serial/qcom,serial-geni-qcom.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml

diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
new file mode 100644
index 000000000000..05a6999808d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/qcom,serial-geni-qcom.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Geni based QUP UART interface
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,geni-uart
+      - qcom,geni-debug-uart
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: se
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: qup-core
+      - const: qup-config
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: UART core irq
+      - description: Wakeup irq (RX GPIO)
+
+  operating-points-v2: true
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    #include <dt-bindings/interconnect/qcom,sc7180.h>
+
+    serial@a88000 {
+        compatible = "qcom,geni-uart";
+        reg = <0xa88000 0x7000>;
+        interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "se";
+        clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+        pinctrl-0 = <&qup_uart0_default>;
+        pinctrl-names = "default";
+        interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
+        interconnect-names = "qup-core", "qup-config";
+    };
+...
-- 
2.25.1

