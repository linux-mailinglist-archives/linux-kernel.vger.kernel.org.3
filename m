Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4F53CB2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiFCN5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiFCN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:57:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11971E0;
        Fri,  3 Jun 2022 06:56:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so10500641wrg.12;
        Fri, 03 Jun 2022 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgON9aED3Gy7Z9BeMM0BVK1opvH/pPoHogRzCESmP4k=;
        b=lJSK31jZz67cqgJQwIdAG8zb/6R45WFBk4YCPKv2LGif+gquIcDj6UeFHE09crKJYB
         bheiVblG7niOyyVjb/xVZbEUNP8V24fnh3MDps53nT6vJwjZ6G59ZZxz+EciSVgovpw8
         UyJnwqbeOzcVOyWyVRLBWptps+lar5dXefrsTgArqvCoZeff5XFtlsfZ5QX0/M1nq8IO
         dY/C9uUKzu5pVUfkoNjjggtDG9c91cLFsnzUFbDgDZEoMOaxYllFIRw8cOqEjJOteN7p
         SPOHxa3M/xiU4uSLDSjMg3EX40BXgeTkagxCPpGiCsrmlqsIxfPkMyQzZWGuLYlURICw
         iSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgON9aED3Gy7Z9BeMM0BVK1opvH/pPoHogRzCESmP4k=;
        b=LyJe/M1TEk07QL3X9epn0PQWHZHm1hjCOprShocUCe1Whtnj2Gmy5KVt4LnEFISxlX
         U+miZb84pPDjQuJMTTaffRz17JyxCg16T7pkJFrbKXqcVX4c0IAN+Ncog+S/xJK+oI21
         lF/cuWYevuDhCENAH4n+eAWhyu7J+s11jAdOqAMF3rEVt75ZbGdw62CGjroE54BqRgrs
         krMKjl8GZumH8FCqlb17qbRWqm3gB1C1CqEALa/Rq77nsIetxIw+8xRjeHsy4028yLiP
         Ig2bVV9ERAzTeqpHRi566z4+V/oYrCRzfSBDAxLsw9FUaBQOrL6Ulqx/dIvGJBExbSwp
         c8cA==
X-Gm-Message-State: AOAM530WB0YsUVdKVvubKxWqcvxJSWuNoy2B/XkFbKaeBhrTn1kSSA7W
        UxgxRXo2poxvuasNGMBNOAw=
X-Google-Smtp-Source: ABdhPJzCj58zHMX2wl+BEPG23yCwqpfPUMlsxAE2402WtIxoMq6Sr6hkyecZ972h4OyVJkPcIWfzaA==
X-Received: by 2002:adf:f610:0:b0:213:b4e1:7276 with SMTP id t16-20020adff610000000b00213b4e17276mr5488075wrp.712.1654264605312;
        Fri, 03 Jun 2022 06:56:45 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b0039456fb80b3sm13944284wms.43.2022.06.03.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:44 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Fri,  3 Jun 2022 14:57:09 +0100
Message-Id: <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
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

The AXP192 PMIC is different enough from the PMICs supported by
the AXP20x GPIO driver to warrant a separate driver. The AXP192
driver also supports interrupts and pinconf settings.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/gpio/x-powers,axp192-gpio.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
new file mode 100644
index 000000000000..7a985640ade8
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: X-Powers AXP192 GPIO Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+
+properties:
+  "#gpio-cells":
+    const: 2
+    description: >
+      The first cell is the pin number and the second is the GPIO flags.
+
+  compatible:
+    oneOf:
+      - enum:
+          - x-powers,axp192-gpio
+
+  gpio-controller: true
+
+patternProperties:
+  "^.*-pins?$":
+    $ref: /schemas/pinctrl/pinmux-node.yaml#
+
+    properties:
+      pins:
+        items:
+          enum:
+            - GPIO0
+            - GPIO1
+            - GPIO2
+            - GPIO3
+            - GPIO4
+            - N_RSTO
+
+      function:
+        enum:
+          - output
+          - input
+          - ldo
+          - pwm
+          - adc
+          - low_output
+          - floating
+          - ext_chg_ctl
+          - ldo_status
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+...
-- 
2.35.1

