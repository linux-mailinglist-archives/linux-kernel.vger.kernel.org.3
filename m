Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16B51ACB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353750AbiEDS23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376780AbiEDS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:28:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1636B1891;
        Wed,  4 May 2022 10:55:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so2566826edr.7;
        Wed, 04 May 2022 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ANFltAUzgpLPAk2XFYFvIrUK7ys9TmLY8dbgINzBWf8=;
        b=cgUcWauL6x/U8+l2hXpSKEshHXoEOVT2KpRMdSxOS4mxRFAeHAsJRdDfEFok5DGo0u
         HBeUK4u0dnN7dwNrPR5AW4q7ey38U2NjRsUEsFMurtAduXSfulH0oX3RRUbax3q11PfB
         VViVChudwB/AjS69qvwcO1zlRsIjb5cNK1j8lMOxTfQuMm5kKs5Pj8tux0d80RJpkymw
         FQhrviVudNGeEp63D6OyYD9YT0oHJR8ztqpy/rwAN33zDc625l9QDK4tvYtMDtIadQrD
         gHPH+KbL1Sz70dl84NQVc6Stp3ySoiVxgK7Rgb8APVYhGel4ribsF3hiT9utNUEq6mDi
         VTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ANFltAUzgpLPAk2XFYFvIrUK7ys9TmLY8dbgINzBWf8=;
        b=M3XRNt50rci5RSn0OMh1vULJXFgSqfdz7HnVH+jEFUfpCJo0RUC7vBnDJzbHkvLE15
         gX9Abw1shXc4oOnZ+K/rR6GoqDfjjxEfrYKysx5xsK15o5hWGbnBCtBSBzoCgQM4LDGp
         cDGoYEM70BS3V/2fvz8iY/OGOZ60rUxGwFoBLCCM+V4pHPkxxKufxks5/9JXH24Jgsnj
         /wWdE+xLQflPRmtxrMgVv8Fhn67DTbzj46cFQ1+1JOQ+IIvUb8NmVGPGfi1t/CQRH78C
         +EpG2rHyYKbK9i4+qPBDeShOyZQqKcywtSpjL62pK7Lvn2FrRURJPzY3yVlmLbIqPg9y
         ereQ==
X-Gm-Message-State: AOAM532Kuot2MwDa3HcBZoA6YS8ivVjc2YiSES/RMdIfOA3GRV7MJeUC
        MBMXftqKIRyXJxiMWmXvt7A=
X-Google-Smtp-Source: ABdhPJwEVMlQfgCa8wccsDAGEE4RbYmkj6BwXQXME2JWXPMoEMHLt75jWLHbzFKUg5xzO/KELY0WrQ==
X-Received: by 2002:aa7:cd7c:0:b0:425:e59d:7353 with SMTP id ca28-20020aa7cd7c000000b00425e59d7353mr24145369edb.365.1651686905184;
        Wed, 04 May 2022 10:55:05 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d9c3000000b0042617ba63cesm9366665eds.88.2022.05.04.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:55:04 -0700 (PDT)
Date:   Wed, 4 May 2022 19:55:02 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND,v2] dt-bindings: timer: Convert rda,8810pl-timer to
 YAML
Message-ID: <20220504175502.GA2573@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RDA Micro Timer bindings to DT schema format.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
  - Collect Krzysztof's and Manivannan's R-b's

It's been a month since the original v2, 2 months since v1,
so I figured it's about time for a resend.

 .../bindings/timer/rda,8810pl-timer.txt       | 20 --------
 .../bindings/timer/rda,8810pl-timer.yaml      | 47 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 48 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
deleted file mode 100644
index 4db542c9a0fd..000000000000
--- a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-RDA Micro RDA8810PL Timer
-
-Required properties:
-- compatible      :  "rda,8810pl-timer"
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain two interrupts.
-- interrupt-names :  Should be "hwtimer", "ostimer".
-
-Example:
-
-		apb@20900000 {
-			compatible = "simple-bus";
-			...
-			timer@10000 {
-				compatible = "rda,8810pl-timer";
-				reg = <0x10000 0x1000>;
-				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
-					     <17 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "hwtimer", "ostimer";
-			};
diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
new file mode 100644
index 000000000000..f9043a4488d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/rda,8810pl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL Timer
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    const: rda,8810pl-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: hwtimer
+      - const: ostimer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@20910000 {
+      compatible = "rda,8810pl-timer";
+      reg = <0x20910000 0x1000>;
+      interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+                   <17 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "hwtimer", "ostimer";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d5c2c035f82..cbf91f0ecbfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2563,7 +2563,7 @@ F:	Documentation/devicetree/bindings/arm/rda.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
-F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
 F:	arch/arm/boot/dts/rda8810pl-*
 F:	drivers/clocksource/timer-rda.c
 F:	drivers/gpio/gpio-rda.c
-- 
2.25.1

