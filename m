Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B5513DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiD1VwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352485AbiD1VwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11806C3E39;
        Thu, 28 Apr 2022 14:48:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i2so4624596qke.12;
        Thu, 28 Apr 2022 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsHLgickfWiQ7IuTrWQL7pBea0q42fG7zHQIYbkEfSM=;
        b=lEkcK5oty8z+u4W1KpAM6fz6VMksMG3XO7YO8itOxuHUyOU/kChJT+9krku4HThtUK
         2yTEas5EPk+1UEKNn+Dk/HpUckaQVsGZTXE7bQGKW7MF+3+ZJAZ4CwTBU0uTMglatLYH
         tY8snzqnsLbnsHVnggk++zlJB0SLM9s3Ut9BuSzyIkOT29leK4sama7L5Uwo4nXSV8Wh
         vtBfoEdVmTB6iHBsFHnQK/VZgx2y/4CZMDBjtAbwh5XrJX4FlYi+uwJUFIcwo75FJYLv
         yxLZF+FAQ5zbBaWpIxlkCgZXYm7HEz+H32KPsCeN1wMkmlfj5oY2IObnhulP40TkRj0N
         Dujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsHLgickfWiQ7IuTrWQL7pBea0q42fG7zHQIYbkEfSM=;
        b=JSojjKNftd6XiGcqmjKUs7nEhpV25WVVKB3h9MjTBNTaCokWPbqhjO55+Wq6puNVjc
         aMK8FooPrxXwDek/Ro26myItAEOKPa6xdfZtLnbXdUD0KHD+3a9aZoxtR3/WQUhXhFJH
         ekvGB/qd2P9I1CXy6xpWSAc0PyZl3klepD9PYP+XYKQrbcVHcf/y00WXxPIUkF3NTWiv
         GD5fKGOhP/A2rEAjBUh9IqTzbAEOCQxUSftwx0/G5OGyU4hROVzVEoOgCrDzjHO6e2wX
         X7S6lIpCg6ebrbmS52aobZZc3F9SlF286JkQU6luSH1fEF460XPA11nGSSnFEbw9ILs0
         3XSw==
X-Gm-Message-State: AOAM530tm6TyXRm7BnHj2Z99Dk0WnAzry0TaXuCYwlfHn/xfsjDfEIBa
        7tnMOyVOIAhVLBroI5ubTCo=
X-Google-Smtp-Source: ABdhPJw0Pjvg4DmZSvpSkEKHOHv17Qd/78xNeyUxAbwn8J7IFj3T8YEDO+akNRaq1aATIHCHyE3Aug==
X-Received: by 2002:a05:620a:858:b0:69f:9bc4:1db5 with SMTP id u24-20020a05620a085800b0069f9bc41db5mr5023484qku.206.1651182530865;
        Thu, 28 Apr 2022 14:48:50 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:50 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 06/15] dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
Date:   Thu, 28 Apr 2022 17:48:29 -0400
Message-Id: <20220428214838.1040278-7-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 pinctrl binding Documentation

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Nothing done
---
 .../bindings/pinctrl/fsl,imxrt1170.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
new file mode 100644
index 000000000000..2e880b3e537c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,imxrt1170.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MXRT1170 IOMUX Controller
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@benettiengineering.com>
+  - Jesse Taube <Mr.Bossman075@gmail.com>
+
+description:
+  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+  for common binding part and usage.
+
+properties:
+  compatible:
+    const: fsl,imxrt1170-iomuxc
+
+  reg:
+    maxItems: 1
+
+# Client device subnode's properties
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 6 integers and represents the mux and config
+          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+          be found in <arch/arm/boot/dts/imxrt1170-pinfunc.h>. The last
+          integer CONFIG is the pad setting value like pull-up on this pin. Please
+          refer to i.MXRT1170 Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "mux_reg" indicates the offset of mux register.
+            - description: |
+                "conf_reg" indicates the offset of pad configuration register.
+            - description: |
+                "input_reg" indicates the offset of select input register.
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "input_val" indicates the select input value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iomuxc: iomuxc@400e8000 {
+        compatible = "fsl,imxrt1170-iomuxc";
+        reg = <0x400e8000 0x4000>;
+        pinctrl_lpuart1: lpuart1grp {
+            fsl,pins =
+              <0x16C 0x3B0 0x620 0x0 0x0  0xf1>,
+              <0x170 0x3B4 0x61C 0x0 0x0	0xf1>;
+        };
+    };
-- 
2.35.1

