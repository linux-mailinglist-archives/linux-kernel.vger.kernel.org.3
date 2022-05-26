Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC75355B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiEZVi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiEZVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:38:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2743EE00
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:38:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g12so3014308lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krTDvQQxmZRpLwBL3elypGrTug41WSsusjpj6VsdHWo=;
        b=r8qYluOm8pUI9Keqcsr7bDiIyEp8jPdOFUiItGwn1HfS2eHldL5k+sYXr9c6dCgTh7
         O5km6lA5HdvF2fTh91e4qFrFebPV7eisEnZ8jnInbdgcBlrIOzJz/IefP9gSfPnUc6/0
         e/TW8UW4mV9uS5nN2L86soVm8NMW3Y1Uinavslg92WdotVa3CO9EDuFemI2j7PBVs9WT
         HFlqc+ZUhE5wqJZqn7dd+FXIJZK62fub1JD7ORYMIC2GT79jAS6xH2aZ9wMUyUecPc3C
         X9On1iO5Nk8Cf5HGxdcUDMcU1SZXhmC58RohuoPVXAMt0XLPlVAT+xtPQ9tarJMEu4TN
         y/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krTDvQQxmZRpLwBL3elypGrTug41WSsusjpj6VsdHWo=;
        b=0nYCRC+aittV7hXUEZJpDdh67eT06ObGppQnCWJNqsjF/d7zckEu+eveN2BIWFoe3A
         AF4bFt4pjvaNiUWzE9Csij1xFsj9kuZSmgTzRmie2Zt7hdf9nRCyjm3LbIMaish+XWh2
         qOL2QJ9Jg0P1oAS8kKcSZs4orGdERtkALZ4iLlXKFNejYOPSC829pA9fth6i7WGQEWpM
         mu7LMeibmNyrvio957a8TzEOksyIVv2vGVbi8mS2JzctPHbpoy2oAq3DjFV5mkEegnfg
         uERByDLYzdBUqKMJ5pXe2BE6/RlohaChW1Eg3sRac3vs3nM6Eje/b4xUk3Tl1tk/0717
         l4Rw==
X-Gm-Message-State: AOAM533crR9TXy4mbdh8CVQe9GoAYD9wPSF1GHAUtteqw6NUgewiOrdL
        E/ZKyw86EjWScc/fZWsV9vRuQQ==
X-Google-Smtp-Source: ABdhPJyzctOZJOLxCZ5+dBGEIH0e30bdktLCK/BHl5wDISAC1FMQZkNpT1PjUa6kNZSzYIu27yre7g==
X-Received: by 2002:a2e:bc2a:0:b0:253:edc9:dc73 with SMTP id b42-20020a2ebc2a000000b00253edc9dc73mr12494262ljf.351.1653601104295;
        Thu, 26 May 2022 14:38:24 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0024f3d1daedfsm632591ljc.103.2022.05.26.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:38:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Add Nomadik MTU binding
Date:   Thu, 26 May 2022 23:36:21 +0200
Message-Id: <20220526213621.373727-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.3
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

The Nomadik MTU timer has been used in devicetrees forever
but somehow we missed to add a binding for it. Fix it
by simply adding it.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/timer/st,nomadik-mtu.yaml        | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml

diff --git a/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
new file mode 100644
index 000000000000..901848d298ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/st,nomadik-mtu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ST Microelectronics Nomadik Multi-Timer Unit MTU Timer
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: This timer is found in the ST Microelectronics Nomadik
+  SoCs STn8800, STn8810 and STn8815 as well as in ST-Ericsson DB8500.
+
+properties:
+  compatible:
+    items:
+      - const: st,nomadik-mtu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: The first clock named TIMCLK clocks the actual timers and
+      the second clock clocks the digital interface to the interconnect.
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: timclk
+      - const: apb_pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mfd/dbx500-prcmu.h>
+    timer@a03c6000 {
+      compatible = "st,nomadik-mtu";
+      reg = <0xa03c6000 0x1000>;
+      interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
+      clock-names = "timclk", "apb_pclk";
+    };
-- 
2.35.3

