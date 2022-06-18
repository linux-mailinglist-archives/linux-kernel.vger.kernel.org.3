Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133CC550724
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiFRVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiFRVkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48152EE3D;
        Sat, 18 Jun 2022 14:40:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so14556547ejj.12;
        Sat, 18 Jun 2022 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csfinoXwhwV39+rQKVo44DThlemiAKwiSzcYqKt0Ovc=;
        b=aJo5Bl/ie3tuaOFVibH5sKFG/O5P/8lQVlgZ+Sd6dpJXp2krwsYcXX2sCXbzdXFSBK
         bmH4aUDGYyKkmrAGGIDbNQT7TEaTAXBICChPeUcWul3DwABhOm4LSuD0KNlDYk3+4vm6
         2eve/K91LTIZvQOv6zxyR/Ksf5Vm6KoDp3aNI31CvzHLDhhkmDVcE8ClUnW0X01/oKti
         niEx7Cup2DJJqs5JPzHWNH2w2sylxhEzZn/BBLuAtMuG9SIAi3KDGORqlQrFXjpW/67V
         Eq1PKGiMeCWfi/ejdk9sn+wzhdJfbk+88ZA0TS/6fFN/M+67xE/C+gxIHigF80ZOWK6Z
         PrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csfinoXwhwV39+rQKVo44DThlemiAKwiSzcYqKt0Ovc=;
        b=Opn9KNuMvfFdRHrtQIcXg5QEjdJva4e/SS2ws8VWzpjCSa5keyYLeOYBBfqrDnA4Id
         HEOAWfYQkSE5iLWo5QXvrbnqg2MfdBp/ey8iDHkFPfPZ9fuC1xtOSk7bl2Ufi9Pd9B/j
         cKYY5WjZH1tMmevm6FRebEtRnwMPIM8nq/0wqXzXI7nhA0eZmE36F2tcJ1VPblosjbig
         Imzd28a71MboXWslCQCaet3621JEEwSr+4w61kbg/HquvXSbU8d4dQAp7DeJTY2X3Sk3
         4EyfVwWLh2U/b6i9fsZrcws+tXHFQ5ciAe/7dKFALL+xwrRvRp7pNGZnPBzqhXQUfdc9
         rVNg==
X-Gm-Message-State: AJIora90m6QhGrAbUKyWahUbOcdCGWeMn8EbT0t3YMcXsAD26TaNKH61
        4HVtcKGO7sS8vIhCZLIAvEY=
X-Google-Smtp-Source: AGRyM1skwJQsiHcbnYIJY++VnC97/Oftmq7KGsDV82CMhJPd0WshQrAe/k3xh3W82WXMTS2o1ezDWw==
X-Received: by 2002:a17:906:77d1:b0:712:57a7:e897 with SMTP id m17-20020a17090677d100b0071257a7e897mr14391500ejn.431.1655588405450;
        Sat, 18 Jun 2022 14:40:05 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906315b00b0071d3b6ed4eesm2644223eje.160.2022.06.18.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:05 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 06/16] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Sat, 18 Jun 2022 22:39:59 +0100
Message-Id: <20220618214009.2178567-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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
 .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
new file mode 100644
index 000000000000..1e368cac9d3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
@@ -0,0 +1,68 @@
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
+  compatible:
+    const: x-powers,axp192-gpio
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: >
+      The first cell is the pin number and the second is the GPIO flags.
+
+  gpio-ranges:
+    maxItems: 1
+
+patternProperties:
+  "-pins$":
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
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl0: gpio@0 {
+        compatible = "x-powers,axp192-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl0 0 0 6>;
+    };
-- 
2.35.1

