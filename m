Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB066466393
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358102AbhLBMZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358193AbhLBMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:25:16 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C6C0613F9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:21:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so4499941pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 04:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RXntCnFaEu15rLId3/xepqIAwJ07mxfKidhEo2IC6sM=;
        b=IDZog2Aj9ymOUvZTrDhnO4TI4GKvzb0uPRslB4rapwq2iqDQEpd9XRf3WBK2A56ncG
         +a40DWq9uzKiTvmeOPXqQHVTcFGWI1hAOlUg5VKWJayvOiXYIzCobtEGqLytyXyHNs12
         7+gFU5ekMQNTwWK3dQUWAqCuuaEEbHZYk2OFZ8uK30Cm5LsnU2BcbWlBptXQJ0BTtHTt
         /d3T/iudDP5qoS2naY29oWXnTWThaDEgd1b6uE5dgDdI+NJ182eq7ZEsm3GUhbZb7V/s
         +SIFHywFP43eL4txRKSwmIPASoykjjcjxDvhxv/NqyInFKW5InpIZ5c61mv/y4VHLxjq
         ZsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RXntCnFaEu15rLId3/xepqIAwJ07mxfKidhEo2IC6sM=;
        b=YQ2Dhy4WrDbjuenZuxB6OWxg7IPjq+H5T6XAFj6R8xyrxJYFg1NM1cZmZppvycxRhQ
         jhVLlBxudSY8vsVezUxfD1Hjb2a+B7otGBpqJSPwAaNp6GDKuBTOepvDudNkbciy/5fh
         PLJtqZ1knJtY2CDkscL4cb74k6RXnNMKZ7EPW4/4i8hLdkaURmdA81c0914Ks/Nx/Atw
         D7uKxzNOasv/sghOok71tGNN09YEgOiijcf4tCg8or5nLTeQkc2E63eFkq841lSCI22C
         0L3yEjyx6rV5P8XSR3uFYxFSvpkxFhLrUXgr9LNqle3X+lVKNy8U/NO8oJEJsGLAs1oQ
         J/dw==
X-Gm-Message-State: AOAM532eomr9AqZFEyxXmKJAX1qwLI4lO09ptIkHv6AleuiCZwXvZ9kC
        vTQkMRllJWxQ0vekfPEtOki3YA==
X-Google-Smtp-Source: ABdhPJyBwBIRvIcq28MB98tASpBu8JrAk/Ww97FS+l9dyA2L7h41/yE8gDDdbl83I7oHUWvAFQgw3Q==
X-Received: by 2002:a17:90b:4d0a:: with SMTP id mw10mr5675382pjb.89.1638447712913;
        Thu, 02 Dec 2021 04:21:52 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m15sm3608894pfk.186.2021.12.02.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 04:21:52 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Thu,  2 Dec 2021 20:21:21 +0800
Message-Id: <20211202122122.23548-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202122122.23548-1-shawn.guo@linaro.org>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding support for Qualcomm MPM interrupt controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../interrupt-controller/qcom,mpm.yaml        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 000000000000..22e87fe2eb8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,72 @@
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
+      - const: qcom,qcm2290-mpm
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mboxes
+  - interrupt-controller
+  - '#interrupt-cells'
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
+    };
-- 
2.17.1

