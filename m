Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645FD4C4CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbiBYRiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbiBYRiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:38:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE241CFE6;
        Fri, 25 Feb 2022 09:37:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so12232020ejc.8;
        Fri, 25 Feb 2022 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bZwpA1Ih/7cGxWJSLmyCFGC1CzE5h6NX4RJcebkcxjM=;
        b=Iy0CtH0KQ1YwGiUJvk/g6Fs4SLoWhssKTrLqVTU6ifAXiKxsr5qk46cc4txnxdgtXy
         qE6w8bEQnb/NtByYXNsgApM7Dg5JV+Ruj7od8uj0xAi5pp92eQfX+mA/Gayex+xxaP2K
         +QLTURAFqGaCD4zLcWKz0arNYsb4rQoCzt7LTcYPwGMKjl3cvMTVTKuR/5YQ118L1Xzu
         QSlSrtudTY13RyxCPbwZ/Af8LEXC6HndNyUvTrHxYzmP9cHa+ufvKIGvfQAjR7Q1Ov5i
         zsFRsdeAsu8XuYdkPlwsOFpW4ilBY7IVsHtmc0aKCt7K0VJyVe5yM6HRm9IyPPfXGmRg
         9EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bZwpA1Ih/7cGxWJSLmyCFGC1CzE5h6NX4RJcebkcxjM=;
        b=1PQcz8eWvzb510km2qDZsiRSCj6CFjnkLJiQBMXcfgpwZLqQRYOu9Soi9hne94y+J2
         5FvCG7JAO/ZAqTuXJsgNykcjyd258udkX/wl+oXKBgvm75h0S2b7sBvpOPJOqN//uSPE
         gCCtnD7MOEFeYERCMDsISC456OGcx/rZrXCNWTeda6pYUlxhmFJ/z6OXZaoO/KFf1n7X
         PNARIXHabMXVrzrYeF1EYt9tSMYAFp+vbg3edidxXuAcE+cwGJrrkrW7ptgHK9rRJYaa
         vzozDpJBu2cW5P3Zdp70RLnxDihtD0qt0rlAGCpS6Kb3o2tB3tOemnhwnWUkMwVYKIdl
         fGJA==
X-Gm-Message-State: AOAM533Wszbr1HQsKC3F57SXw++4W3j9bZnF9Z+kN5oLgzHVe3eorADd
        A4NCQNu41khs6L6HDUVFi+A=
X-Google-Smtp-Source: ABdhPJxYqWlapcSd5iouZ8kav+wYU+humGtyJFEzU/21Iy1c2SWoZs7dgILvXGd2kclfrboz7mrlFg==
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id z21-20020a1709063a1500b006cfea4ea1ccmr6992153eje.753.1645810656255;
        Fri, 25 Feb 2022 09:37:36 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906605700b006ccebe7f75dsm1238421ejj.123.2022.02.25.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:37:35 -0800 (PST)
Date:   Fri, 25 Feb 2022 18:37:34 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Message-ID: <20220225173734.GA7573@standask-GA-A55M-S2HP>
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
---
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

