Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECD57DF81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiGVKYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiGVKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:24:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148679967A;
        Fri, 22 Jul 2022 03:24:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 70so4132932pfx.1;
        Fri, 22 Jul 2022 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKmNQ8jzp5T9yDlHBcPnxdkBT3bPgsI1Zy7bvplXzhs=;
        b=K/1y14MlRObPJ1LqAyB3L2LzpyCt8ulro5fYuTn2JfjbaSDxMPq+onPJsBu1oxo9Q9
         TxRl7TcnukFuuxiyZ2ebjuamw7IvnJn31YM2M/lST/StCcpCQKdmEnXFxKNnTU/E7TAP
         e2mGFLSobfVEJEttgHujCsQ8ILYu8gvhjb+jh0RRMoxbUcumQNQU+wNHeum3ejbPBkqx
         tGaz/ywyX9eVGNyuIZkD94Opve92tu2Wl3uz4RYpMZ5jqNvUiNCM7sKAx7llEk7rOB3T
         3LbP3PCf64FJoTPLJdW+hzmBKpix18zSgsyW52vspd9hSfCRV7tDP+2qbqicrMPuZ/w+
         l68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKmNQ8jzp5T9yDlHBcPnxdkBT3bPgsI1Zy7bvplXzhs=;
        b=d3fwrRVlOyPNyLycRKYYAeK9d1pzW5Av93tkRxtbVEjiImskfbbEavskcbS2+C9win
         qCDXUGi7TIdFS4k1kyWz9wYAeM9F/MUy3vU/ZXov3flI8/kognrJ7li3D8VX0Nhehms1
         3wrbADiXevFGFQMTHTz+TqY2boRmFMhVpvpRymiB0+tVSNxG4zRLTtduowzX3OsgLgCz
         FshG+SoYWdFu03ZkwIbgNpnGmuo9fxmY8oX/yA4Um+1vlANjhCry3oyMKS5kTe8nfZHw
         DKdO5R1qgsZ0In9Az3neib8M29s8xicU8tazXE5DH9fzkLoBRmeB4oe7cI6/2RtQ1/hp
         XZxQ==
X-Gm-Message-State: AJIora+MULgtMVWc/X3IpArN7rPruRIps5+oJGoTyu2OzBjhTUSct8rI
        hUemK17MC5U3NyGSMxHe2fUKfpIFjno=
X-Google-Smtp-Source: AGRyM1ujmkE7H/dKSC5luM05BdbGMVEn2CHVXsGjcX1E72ht3gAGdKv1Y45YEKH3Tv5yp/zCff0Hng==
X-Received: by 2002:a63:8b43:0:b0:41a:668b:399a with SMTP id j64-20020a638b43000000b0041a668b399amr2571892pge.554.1658485466445;
        Fri, 22 Jul 2022 03:24:26 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-82-239.emome-ip.hinet.net. [42.73.82.239])
        by smtp.gmail.com with ESMTPSA id h189-20020a6283c6000000b00528d620eb58sm3614551pfe.17.2022.07.22.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:24:26 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/13] dt-bindings: usb: Add MediaTek MT6370 TCPC
Date:   Fri, 22 Jul 2022 18:23:55 +0800
Message-Id: <20220722102407.2205-2-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722102407.2205-1-peterwu.pub@gmail.com>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add MediaTek MT6370 TCPC binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 0000000..72f56cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediatTek MT6370 Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  MediaTek MT6370 is a multi-functional device.
+  It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and
+  Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.7.4

