Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A474C1375
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiBWM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiBWM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:57:54 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7F8E094
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e13so901267plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gpyd4vP7EgbsF/QazldQl0vAIMM6wCSjCpTQL1+8JT0=;
        b=E7V2nNWC+ebjB9OizOIDqcJ2x3xgHFzfgiXjJr0YRjP3kTrq96iaiKBZgb5Rm4X3EN
         Pd1am9duErfEAzbCmSx6GPhkF/wOey1bLlYOcFy3iEzJhRyhSXFAbSk5qm4C4KY7fAZq
         t2TMDuWRZMjJE6+VwbOPLG7LHh9WmoX5R3PNVRS/MrJskCHz51cL+fNZgWpH0GHbQAYv
         el1PzdOJO3UIcaGqNmOIphcffgw2JDQbhax52uO/5+IfD8/5HBwBFERuX2q252M2Zc/Y
         WVNePkii7LexIgRlSs9PWW4VSfDw9p04LbmeOV3iT0f1G6P7jTmPf0EHoWfAb6Dqf6Yo
         WRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gpyd4vP7EgbsF/QazldQl0vAIMM6wCSjCpTQL1+8JT0=;
        b=xN9P+bNunvmFYM4oG9rwnVkkrLlnQLTzV8E/Q/xlqrVaD4NOX9IUb66pnWcMiqbEiM
         cIAqaNXC5+w41t69NKNwziCOcsTBSmapwo26VQWZsV3ysbA8nCcApb3gSqliF4ygX/FD
         H4fK/qvnhmyVvBeu49tM28NCm1wbfdDFdkdhTk8kSnGhQ9vPp749l1ghxJnaxcPgTZyq
         /R3kL5L1xUUQV+aEbpEWE4Q3Bnha7E8giIeUGyVk/p8EjsY9PwZPNYDfRPcAjsPtIJCN
         SPE+NRwRT2LdjOyt+ELoGiloNdO/zvjczfoecUOAkwfZ+Ang+s/E02T5TJmVHSVN6K7d
         /p2A==
X-Gm-Message-State: AOAM533DVFqgDrA5sqv0T3tYJ69t+YXoI84wglRc5I9WgwCl+Aqg4GUm
        fc+jLlf4kLKLroDi/IqdXtGKKw==
X-Google-Smtp-Source: ABdhPJx6n9/CeWhHPrqJMfspDzJDPCGI1x0rvizUiWRysgrWf99/an1PBiJeX235MOAA0OC8/dgMPQ==
X-Received: by 2002:a17:902:db04:b0:14c:f43b:e9df with SMTP id m4-20020a170902db0400b0014cf43be9dfmr27648150plx.76.1645621038420;
        Wed, 23 Feb 2022 04:57:18 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z23sm22136243pfj.87.2022.02.23.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 04:57:17 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/3] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Wed, 23 Feb 2022 20:55:35 +0800
Message-Id: <20220223125536.230224-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223125536.230224-1-shawn.guo@linaro.org>
References: <20220223125536.230224-1-shawn.guo@linaro.org>
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

