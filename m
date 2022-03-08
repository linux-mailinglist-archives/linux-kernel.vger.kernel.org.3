Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D44D1190
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiCHIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbiCHIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:06:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452D3E5FA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:05:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso1537991pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gpyd4vP7EgbsF/QazldQl0vAIMM6wCSjCpTQL1+8JT0=;
        b=RxKZB+eXnGoxRqS7To6BRcp7L/xoKH3MiQE7MaSX36Cp95HJlW539qNkfCtjY0D+EH
         8nWKL+kd8pCZf0n0xErEWp7tIvEoVcrRZIN4x7HTPsbYtyWZaeL8XOfW+ImG4IK8uZEE
         t+c0lznP6tTw1dlSS2WkaF7XV02RnXHz+zrXJ94hJ6+0dB90UuoYr7lcf/aJf5af4eJt
         L7NXm6E0cJegZkTqlCYT8/NJqU2bf5nSCjXxZOlAcMCuX8Ayl3IbEh7aZLZ00kd1JvS9
         97vJzQcd/d4xN0DU1K5tVivKmLDng94uPhvwjJLtumMp63WFKw6h/qJqz9QaIiW1IOBM
         nYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gpyd4vP7EgbsF/QazldQl0vAIMM6wCSjCpTQL1+8JT0=;
        b=bpQE1daeaxhUtrEtbTzN+9+3alrXsdch7uF8jRFi+Z0QeFFU2or75K/eR1+7aiJaXV
         dG6d6BSG4sHqZ2hbsrXDI+18C/40CGD4Fft3dKx3QEBiNvmTMmFpBqKOaAojxmwsXhtK
         TbulNCylecmAbU6xnFUlZde4X1VkljqDnSchXW9bIf1ZrcBhd1xtoVTHFOy5iz4RO4zg
         WH5jhzI7fKrz5OTJ/TKyBC9F0Y2x5KtS2Z1mya9dObv9mlnPk3bEHikhPYVOF/Uf1+QN
         uGgrsmsEAPdkAutdegRzhqAcLehXkgXKDxaq2Rhf2GAQRYGy68Tp3G8cNKNu+4xJ5RV3
         Rdwg==
X-Gm-Message-State: AOAM532yo1DZLEw6CwLwP8cEjzf/JCl/WYVKimTmYXwPhmPnRqDLD4a1
        TFk3yTSfkHPGBFIs3smGhXhswQ==
X-Google-Smtp-Source: ABdhPJyDMXcmBjhYC8k5benndhKrf13YcU1b9bD1VkpnhFHeggVTEOSJQQw+HAx+NllBmkH1l2E99Q==
X-Received: by 2002:a17:90b:1e4e:b0:1bf:2ff9:5ab0 with SMTP id pi14-20020a17090b1e4e00b001bf2ff95ab0mr3387373pjb.132.1646726756587;
        Tue, 08 Mar 2022 00:05:56 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm1944212pjb.52.2022.03.08.00.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:05:56 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Tue,  8 Mar 2022 16:05:33 +0800
Message-Id: <20220308080534.3384532-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308080534.3384532-1-shawn.guo@linaro.org>
References: <20220308080534.3384532-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../interrupt-controller/qcom,mpm.yaml        | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 000000000000..509d20c091af
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,96 @@
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
+    description:
+      Specify the total MPM pin count that a SoC supports.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,mpm-pin-map:
+    description:
+      A set of MPM pin numbers and the corresponding GIC SPIs.
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
+        compatible = "qcom,mpm";
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
2.25.1

