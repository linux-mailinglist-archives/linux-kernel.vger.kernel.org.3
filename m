Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4644E8190
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiCZOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiCZOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7E20C18A;
        Sat, 26 Mar 2022 07:43:29 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d142so8114001qkc.4;
        Sat, 26 Mar 2022 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2C1oqouZR3DRln/8x4EzORvUeh+GDuA9PIs3GFZUW9Q=;
        b=mr6Yrd7v52v8AFZdDMwC9u6k13oHScxjsofGUO6ylK4yy1Bl8Ke+IT3McYy7iHsHv2
         xYmG+PG2Kxp7YmerlpoGCw0bIq8rwva+zqlThoXM0ru8hyEHP1p/CIbQxVRGtxukQb+o
         kjxe4qcx+Cshkp9DKITRKm4quXLstRwBj5KtNKjIJNvPJOceKkMqZhdM1kakvRBUXkou
         PnLnhrXHZwWZz0Xd3WZgdDu0obyvlM/3LL8YH2rNIxa1ihULjleIe2WHQmFHErFrOznN
         EneuwOY2pNi050+K5EQPcyK5+G7MqM7pKfdMqk02WBKg4imxPGl2LEI2W2nVQ9SMDutD
         OOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2C1oqouZR3DRln/8x4EzORvUeh+GDuA9PIs3GFZUW9Q=;
        b=ufekIOVehPmJ7uAJS2cCvQsu/uzOleTX6qcaZ5+z1e0tcjbBRlXACmXX0RKCpD267m
         T1zVlev1MzMWphJuxrVlzv3ZUjnl6LPNxe/s3QHzqkjDOuyTeNp3DVDG5xMDXja4eMU1
         kCClLiI0HYK+hTS1X00oEphlrN+JU53H8TbJuDsfYTds9WW0MHWmyviTAHCc5nJqq0VR
         kFyXL1k4A3SakQ/EYAcjrGnA35lgp58n+y1WvN8tYsAbte6xbyhGJ73NoIA/Yw4q+LY7
         peEAOPW45uSRL4DDZvUe7Yuf7kEm7pUgN5SbbrbYViTBBeW6ai9n/Dfyvioug3QrAblK
         kTUw==
X-Gm-Message-State: AOAM5315sM48rl8TtSkAMFpe+a+RiMP9bU9C+CT4l852XgECnRGsDNLg
        MytP9VWPP1CDVdL2cZnsDNI=
X-Google-Smtp-Source: ABdhPJz8Znwza5a397XKJ/gMT8Q2GZg3/+25AimFYpLFgglX9SdfOKK2mfGGj8u0leCgg+Q/VzgqWw==
X-Received: by 2002:a05:620a:4409:b0:67d:af50:e422 with SMTP id v9-20020a05620a440900b0067daf50e422mr9985432qkp.405.1648305808220;
        Sat, 26 Mar 2022 07:43:28 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:27 -0700 (PDT)
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
Subject: [PATCH v1 03/12] dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
Date:   Sat, 26 Mar 2022 10:43:04 -0400
Message-Id: <20220326144313.673549-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 pinctrl binding Documentation

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
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
2.34.1

