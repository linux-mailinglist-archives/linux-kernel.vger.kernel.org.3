Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A124B89EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiBPN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:29:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiBPN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:29:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76516FDFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:28:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x4so2007562plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s464YmEOgKVNHNX8tgctZT1MC7zN2ZI9MvD5gSlTKx8=;
        b=YLFDwiFsjtKH7a7ZWqkAAN4KsvB0qTzPFRfwq5p8SyLzZGdXctS/CwZkY6HaKtzGYP
         oqGphKYMIXVtLY72kHqaharaHRlaT7QWfm0cnRTl6RZP4J0VBTgotNX+j6F6i3QT1egR
         c0vYmpbmI9TTAlUwL42vjEB4Dg02gNkRRdtFwM7CA+VmtKOHFTOOMAI1vDXAmLQj0jIP
         QxiZXpY7ss20HdlSCff4g2GVc/HbSO7OlDewVKixYeLuQw5pi5jTaVEnCyqAuCczdbFJ
         9TEUrmjcy/K30hwwEfZavOzbUgBZDPT+4L0ih71a61mZ/7ZxChYBGkEtI6yaIlAu3gzJ
         9jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s464YmEOgKVNHNX8tgctZT1MC7zN2ZI9MvD5gSlTKx8=;
        b=5DO+ez1uEhYlsZu3whjy2EMIkTH2O24wRG/V+jJmb83aWCJGpXenSIOE2h6Uj8WXOZ
         fqXUbAk2XB2Mva+OO7dWHLH2djL+iHoTTLCBZKjqWP9oD+D3NoMgG5PIYKsiJaNk6Ksh
         b06QBtmJ7Sb7Z1MCdKg2bsuG9uiIsHmZXXDKx2BoBr2agak9kbu+9SwfDjFLX4oiohIW
         a17Tlw+uaT4BVzzNVgTgRRc21r+ln4aa65nVLUNV7cT6Lz+qIQAlcSlbp7uNKjss8U2J
         SMQrsIqDBme6Zu7GyNtRaOinigewb7Klj5HJDMcF+AQJDDk6ZJBGbMgWV7jDFCFs54/d
         7EaA==
X-Gm-Message-State: AOAM531AoG71EmqrYJ1LZwT3pwg6ZuBNT1+2Py5JsaPFmGXaLSq9HT07
        eSc2sok0zofzLyXNKGbiJYNhgg==
X-Google-Smtp-Source: ABdhPJwZmzNMm/k6458FVvrVppd4t3q3/HGHH66dyyOJy1MNWV6JUNUNlZWKnwQrOGYxiXhxRw7Flw==
X-Received: by 2002:a17:90a:a795:b0:1b9:2f9a:c049 with SMTP id f21-20020a17090aa79500b001b92f9ac049mr1759543pjq.240.1645018131712;
        Wed, 16 Feb 2022 05:28:51 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c68sm5431002pga.1.2022.02.16.05.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:28:50 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Wed, 16 Feb 2022 21:28:29 +0800
Message-Id: <20220216132830.32490-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216132830.32490-1-shawn.guo@linaro.org>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding support for Qualcomm MPM interrupt controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../interrupt-controller/qcom,mpm.yaml        | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 000000000000..374ef155f45c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/qcom,mpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcom MPM Interrupt Controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description:
+  Qualcomm Technologies Inc. SoCs based on the RPM architecture have a
+  MSM Power Manager (MPM) that is in always-on domain. In addition to managing
+  resources during sleep, the hardware also has an interrupt controller that
+  monitors the interrupts when the system is asleep, wakes up the APSS when
+  one of these interrupts occur and replays it to GIC interrupt controller
+  after GIC becomes operational.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,mpm
+
+  reg:
+    maxItems: 1
+    description:
+      Specifies the base address and size of vMPM registers in RPM MSG RAM.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Specify the IRQ used by RPM to wakeup APSS.
+
+  mboxes:
+    maxItems: 1
+    description:
+      Specify the mailbox used to notify RPM for writing vMPM registers.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the MPM pin number for the interrupt, and the second
+      is the trigger type.
+
+  qcom,mpm-pin-count:
+    maxItems: 1
+    description:
+      Specify the total MPM pin count that a SoC supports.
+
+  qcom,mpm-pin-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: MPM pin number
+        - description: GIC SPI number for the MPM pin
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mboxes
+  - interrupt-controller
+  - '#interrupt-cells'
+  - qcom,mpm-pin-count
+  - qcom,mpm-pin-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mpm: interrupt-controller@45f01b8 {
+        compatible = "qcom,qcm2290-mpm";
+        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+        reg = <0x45f01b8 0x1000>;
+        mboxes = <&apcs_glb 1>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&intc>;
+        qcom,mpm-pin-count = <96>;
+        qcom,mpm-pin-map = <2 275>,
+                           <5 296>,
+                           <12 422>,
+                           <24 79>,
+                           <86 183>,
+                           <90 260>,
+                           <91 260>;
+    };
-- 
2.17.1

