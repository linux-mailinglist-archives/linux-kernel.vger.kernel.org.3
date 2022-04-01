Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871A4EFB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352918AbiDAU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbiDAU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:29:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36791AFB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:27:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so4273932edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAoIntk9Icd3bmVcFvqZzW4v1A6fl47DD1Y7M0nV1IQ=;
        b=vImCi7X8ua2jZNYMsn/SLG0jECLtAMJ2VYieJfBTIwUm44lTxWaqMTEHcsUiv+MCYc
         Cfkt1jfR7iJn795Gun0VO3JlqnKrNKskcetNLpgORRNPa/Dgg2ggbbcGDPLmf9ckE0vv
         5zM8gBcdPUzLxZYLs+MAOCjFftTLFxwoffC0T9fx13pUziFMwJqrJcVCUsnEX8as/Nvp
         7BLbBO2fEbKsfhPn8M6PXfe1iw/g1P6Remltvot7RXm+ESQBT6OuPZ9Jmt9LV4smbnmu
         kktpHcS2mJ6QLr6vjqORN18dcdQghPm2CXjHKFd+RN9X0z3qkw3z6oPYZEUweP1NL2Ri
         CD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAoIntk9Icd3bmVcFvqZzW4v1A6fl47DD1Y7M0nV1IQ=;
        b=ebFa824gg65HMSdskVts1cGrP5sMB3O+P5+/BFzTmDDlnkCl79FiyfAH3OkjyaXqtn
         0byA8dUo+BQ7TNiPUGOS5JS8lx8A6WaL6RlsK4wtldrRrekcRvXFQgffUyX22ewrPJpM
         S3OBeFb0/Ujgs4ygZz1/QVD0W/7Wz2jFe/URFIGCwMd47ZnRWJrEsS+TaJfHILWgiDxS
         W2TQFWDER4u9mEzy5OlaoE7KNfLHLTOiTfHF2Zu0MF+4bdq6Qqkq1O1OEu0VHUAP5MTk
         fzLaqOz/v5hpbLdU4JXd+4jlbG+WY2dQr4i+rK5MYVH9q4tf1hjCDuDYvhKSzKc0T45B
         18UQ==
X-Gm-Message-State: AOAM533IWgD8oGY7/fyvXKHfjjS7X8pi1aFBkqCItetxQgdmrgtYvuNj
        6d5JIEQWxBg597aetV1TlXLLRQ==
X-Google-Smtp-Source: ABdhPJzDdeMkyNBKunc+WbWXyy+TbvIDLmbxeMCjZJyLExFw+xUYQIp/cVJsCjqQwOY4wHpaJVQpXA==
X-Received: by 2002:a05:6402:270b:b0:419:3383:7a9f with SMTP id y11-20020a056402270b00b0041933837a9fmr22753644edd.191.1648844831457;
        Fri, 01 Apr 2022 13:27:11 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1619346edl.22.2022.04.01.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:27:11 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings for smb2 driver
Date:   Fri,  1 Apr 2022 21:26:43 +0100
Message-Id: <20220401202643.877609-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401202643.877609-1-caleb.connolly@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
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
drivers.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
new file mode 100644
index 000000000000..1bea1fef78b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#
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
+      - qcom,pmi8998-smb2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: usb plugin
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <4>;
+
+      smb2@1000 {
+        compatible = "qcom,pmi8998-smb2";
+        reg = <0x1000>;
+
+        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
+        interrupt-names = "usb-plugin";
+
+        io-channels = <&pmi8998_rradc 3>,
+                      <&pmi8998_rradc 4>;
+        io-channel-names = "usbin_i",
+                           "usbin_v";
+      };
+    };
-- 
2.35.1

