Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7A579602
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiGSJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiGSJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:17:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEAD1FCD5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so581872wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWwRESa9J0yNbZSjwboqJyHJMna1CUnVXKB6rAgRc4g=;
        b=4Rkw/Zz4aSmR3I3I7F+AgW+Uia1wlPtvYovolwnrfGK9xqXvg5XZPl34TOFoDx/i4/
         eWL1RcNZDXoN/82lrZmVNs/XL91axqmAUiNScqUVEwZrkrvQq3+mebIu3ObkL2aBF1eJ
         C/TSqe/Sm0yWqmZQyhxwnJ7OKxurPdrDxp4lRu6vHLydeaAiUjwOGX8AQ952PLyheLNp
         1NKI5m7OIFq9AZg00WW2mRbAHiSHphKiIaDo2QzM+nFbBm/wf3hqyzeC5IIdxnA61lmF
         SxpaVCP3yoEEsncqf2hvGkxIG56WBx2U61mg0NoVux0NuuFtdc+QaJztHeeFHfcB5E0z
         3D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWwRESa9J0yNbZSjwboqJyHJMna1CUnVXKB6rAgRc4g=;
        b=XtHaZqnmB2uNPuts9MEhAhR7AoSa7z0UEzWr6d2c9cNlvsuEKfdSVqwvmodUWwaFuB
         cYiRcBHRUvCPeINnQkV3fXxJ0/4Km6LXzpXveiISYB2ZLmj3tqv4ZKU7Q/5h8+ZN3XuY
         GOeFZcUz5sFHE62ItcTuhse6voWW9uqArFCPac15rbGRgi3P2sUmA3bobih5D+dt9dkV
         16HeQukImd+L+JrO6vrwscLiQM4ypUIQN024ZwBDBGStVh0XcG65X0hja50w4TRrVOWN
         QJbvPhfJsn/gcR0At7kc4lTswBO5Mti9aaRmXEHm/la8w9V8mOqoefXVArXZiGPaDI6H
         miag==
X-Gm-Message-State: AJIora9g5Y5L4NYUK/hggw1cqdwT+EBVg2xdrOSn7sonmBEDjbtG00tL
        4RS4jpY0fYQLdqWZF+zUL7llpA==
X-Google-Smtp-Source: AGRyM1s2xTteGx/uUdFNVFd9HMvfqm+eJC3mfAgx17yl6DKt6zA87nTkC0mZp2BfN3nkABVTRxPegw==
X-Received: by 2002:a7b:c314:0:b0:3a0:5750:1b4a with SMTP id k20-20020a7bc314000000b003a057501b4amr35516371wmj.20.1658222274088;
        Tue, 19 Jul 2022 02:17:54 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:53 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 03/14] regulator: dt-bindings: Add interrupts support to TPS65219 PMIC bindings
Date:   Tue, 19 Jul 2022 11:17:31 +0200
Message-Id: <20220719091742.3221-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt properties in PMIC TPS65219 bindings

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 .../bindings/regulator/ti,tps65219.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
index 2c655432b889..6a60e62a313c 100644
--- a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
+++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
@@ -25,6 +25,17 @@ properties:
     description: Optional property that indicates that this device is
       controlling system power.
 
+  interrupts:
+    description: Short-circuit, over-current, under-voltage for regulators, PB interrupts.
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description: Specifies the PIN numbers and Flags, as defined in
+      include/dt-bindings/interrupt-controller/irq.h
+    const: 1
+
 patternProperties:
   "^buck[1-3]-supply$":
     description: Input supply phandle of one regulator.
@@ -71,12 +82,16 @@ patternProperties:
 required:
   - compatible
   - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
   - regulators
 
 additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -92,6 +107,13 @@ examples:
             ldo3-supply = <&vcc_3v3_sys>;
             ldo4-supply = <&vcc_3v3_sys>;
 
+            pinctrl-0 = <&pmic_irq_pins_default>;
+
+            interrupt-parent = <&gic500>;
+            interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+
             regulators {
                 buck1_reg: buck1 {
                     regulator-name = "VDD_CORE";
-- 
2.17.1

