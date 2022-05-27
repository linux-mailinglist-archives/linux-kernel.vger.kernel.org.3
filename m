Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1853630C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiE0M4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiE0M4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:56:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905C29CB1;
        Fri, 27 May 2022 05:56:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br17so6802390lfb.2;
        Fri, 27 May 2022 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dcyH7m92bzxTwEdfuRH/fSh8OmK+syZivJMBcZzMrm4=;
        b=DbhHorpb3yDC8h72hqhppfJ3D7ZnHk9hQTkXFAPYlUaFhVLyfz6rB3JLvHclScG9/L
         Hu5nkEhDf+IAj6XAjFevwW5KNL7vtqzCBKrG5/aechqulieMUDc3ZIjr4FyoQBLDQV4U
         SipVVdKcO0NOdGCaT5fNhM2D2F51mL1ld4NFB38uV++xWz0zw0dLgv0oLdaWXw3K8+X1
         j1av3Quli49X9W/iA2xJm0NdeeCEApyAm57wJeDacWvaETQhHtHRyFrdRNLkOn5By+s0
         Vqzmf85NNAzKS9dkjxS7VdwQbAIS7zZO6aobMtZp6vmxhetbNEwQJ1dMyK/YzWXo7Bzz
         gC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dcyH7m92bzxTwEdfuRH/fSh8OmK+syZivJMBcZzMrm4=;
        b=Q8TofiSz1TXgRfbojCKKYzklo0NxbWvtWfdwvzQrts2VTZzdDn0SWT4V5zq5JUjgDT
         /+947+Y1iK9tNzaqp2DLQRamOo5GsQk2tZ24wRX2Ms7AeXwfBxPRDuW7F39K0nCZIx5R
         D9mN4FnzOxYEBVhRrrne/TL1xJ5uVZ/a0axl0I2LXLJVPPRpgQjl14ZuIMIQGYI0sAx2
         l1C7B5mSlFo/fRCYs5YlpeiKCY+WppneJM4ce37P2xenK92RZMFooI4RHqILA/w0O5uw
         Hu1wuHIwFDvKGksKurjrlxx0DK/mPuB2kXZXl1NK/0NnyGqznI0VjoL6g8pfS4EkJtxo
         8+Bg==
X-Gm-Message-State: AOAM532knzBA8qI9l9ytRBPc6cC7sZchCDS30B4LVrCopIifEbAwsSw3
        KOxkaPUHaZezf/U6Rt36uiLZVRfyl4g=
X-Google-Smtp-Source: ABdhPJx8y3ash2TOIvgO8oHxvDtZ9AiZR6hm11R/Q+fSW8bGOVT9tSZx3bBFN3o7c7WqgA81sdIvQg==
X-Received: by 2002:a17:907:381:b0:6fe:9ca8:c4b4 with SMTP id ss1-20020a170907038100b006fe9ca8c4b4mr35975155ejb.147.1653656195811;
        Fri, 27 May 2022 05:56:35 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id q9-20020a50cc89000000b0042ac2705444sm2077314edi.58.2022.05.27.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:56:35 -0700 (PDT)
Date:   Fri, 27 May 2022 14:56:33 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert rda,8810pl-intc
 to YAML
Message-ID: <20220527125633.GA5145@standask-GA-A55M-S2HP>
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

Convert RDA Micro interrupt controller bindings to DT schema format.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---

Didn't know what to do about the interrupt sources listed in the original txt file,
so I've split them off into a separate file. Hope that's okay.

 .../interrupt-controller/rda,8810pl-intc.txt  | 61 -------------------
 .../interrupt-controller/rda,8810pl-intc.yaml | 43 +++++++++++++
 MAINTAINERS                                   |  2 +-
 .../dt-bindings/interrupt-controller/rda-ic.h | 40 ++++++++++++
 4 files changed, 84 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
 create mode 100644 include/dt-bindings/interrupt-controller/rda-ic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
deleted file mode 100644
index e0062aebf025..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-RDA Micro RDA8810PL Interrupt Controller
-
-The interrupt controller in RDA8810PL SoC is a custom interrupt controller
-which supports up to 32 interrupts.
-
-Required properties:
-
-- compatible: Should be "rda,8810pl-intc".
-- reg: Specifies base physical address of the registers set.
-- interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 2.
-
-The interrupt sources are as follows:
-
-ID	Name
-------------
-0:	PULSE_DUMMY
-1:	I2C
-2:	NAND_NFSC
-3:	SDMMC1
-4:	SDMMC2
-5:	SDMMC3
-6:	SPI1
-7:	SPI2
-8:	SPI3
-9:	UART1
-10:	UART2
-11:	UART3
-12:	GPIO1
-13:	GPIO2
-14:	GPIO3
-15:	KEYPAD
-16:	TIMER
-17:	TIMEROS
-18:	COMREG0
-19:	COMREG1
-20:	USB
-21:	DMC
-22:	DMA
-23:	CAMERA
-24:	GOUDA
-25:	GPU
-26:	VPU_JPG
-27:	VPU_HOST
-28:	VOC
-29:	AUIFC0
-30:	AUIFC1
-31:	L2CC
-
-Example:
-		apb@20800000 {
-			compatible = "simple-bus";
-			...
-			intc: interrupt-controller@0 {
-				compatible = "rda,8810pl-intc";
-				reg = <0x0 0x1000>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
new file mode 100644
index 000000000000..96d6285d0087
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/rda,8810pl-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: rda,8810pl-intc
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@0 {
+      compatible = "rda,8810pl-intc";
+      reg = <0x0 0x1000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f0a90b256b26..58a35519b7c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2590,7 +2590,7 @@ L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/rda.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
-F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
 F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
 F:	arch/arm/boot/dts/rda8810pl-*
diff --git a/include/dt-bindings/interrupt-controller/rda-ic.h b/include/dt-bindings/interrupt-controller/rda-ic.h
new file mode 100644
index 000000000000..8d257cce4f9e
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/rda-ic.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_RDA_IC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_RDA_IC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define RDA_IC_PULSE_DUMMY	0
+#define RDA_IC_I2C		1
+#define RDA_IC_NAND_NFSC	2
+#define RDA_IC_SDMMC1		3
+#define RDA_IC_SDMMC2		4
+#define RDA_IC_SDMMC3		5
+#define RDA_IC_SPI1		6
+#define RDA_IC_SPI2		7
+#define RDA_IC_SPI3		8
+#define RDA_IC_UART1		9
+#define RDA_IC_UART2		10
+#define RDA_IC_UART3		11
+#define RDA_IC_GPIO1		12
+#define RDA_IC_GPIO2		13
+#define RDA_IC_GPIO3		14
+#define RDA_IC_KEYPAD		15
+#define RDA_IC_TIMER		16
+#define RDA_IC_TIMEROS		17
+#define RDA_IC_COMREG0		18
+#define RDA_IC_COMREG1		19
+#define RDA_IC_USB		20
+#define RDA_IC_DMC		21
+#define RDA_IC_DMA		22
+#define RDA_IC_CAMERA		23
+#define RDA_IC_GOUDA		24
+#define RDA_IC_GPU		25
+#define RDA_IC_VPU_JPG		26
+#define RDA_IC_VPU_HOST		27
+#define RDA_IC_VOC		28
+#define RDA_IC_AUIFC0		29
+#define RDA_IC_AUIFC1		30
+#define RDA_IC_L2CC		31
+
+#endif
-- 
2.25.1

