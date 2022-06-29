Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064615602DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiF2O37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiF2O3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6321269;
        Wed, 29 Jun 2022 07:29:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e28so17604783wra.0;
        Wed, 29 Jun 2022 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=un6FOGrLaQROKEAY9nSCj2eZpRsEUWt4G2drKQth4h4=;
        b=RWbgWr3SKAbWD5CDg+dOcH5Mpl9yzXSj2cuinVscASxUiANWyCRCw2cgNQdLwvRcoJ
         fEZKS9/sqpboMgLiDiwZDWLoB+bMRYhzUK5YzjrddAP/ArlpCMoYWFWXbwCEAx/buzX6
         Gmnf3L1rBS39xNBY9MibUw+BFSp9qetw/wWEfdgn8+7LOVPqzSBWduBtMAhURe80wLTz
         a7aUb2CoZPp7dC1fQ70h0/BgC3dUMuAFFCTtuE242ZhF9fewaR6j48pANGvknZFHFNNf
         dtG2EcX0UOm42Sn2r6kkG9/vaty0ySLBI35DHOoCL66PSJCLow1Tc02HXhUOnC7dNrkD
         CFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=un6FOGrLaQROKEAY9nSCj2eZpRsEUWt4G2drKQth4h4=;
        b=npGgplBhNCb06RMARMevkk8YcmMOe8IhwIWq7RUWFRL4+hj2Mn1kNeSrKantEigsgn
         lAAEFtdW+v6aIiHeTEUeZNqw+rEjNw21qs41KiDUNsZgznmh1FTNNUmeIbJ3jjKeyDOT
         Gv/b880J6gV5+D/lsMaZ10bdp926KT840lW4H9xJaDbvrRn3vbMnArPt1pKG9ln1yTHJ
         xwLSZT6u/Fojve7O+MpXngcvqkSJnYitw5+LMcsO/eo+NSz6kiKVUGX0QVNXmSMiq+ak
         ibh28tEYirYx9B/pQzFp4V2foCNpjcMwYxtYO/MtiplVOP0lawqsSrtWCHDep5oX5I8w
         dPDA==
X-Gm-Message-State: AJIora8DVN5L2UD18FB8KOKi/fP4p4BVaXIYl6J0YfWKl9lAycO7zEP7
        EwlNATyoT5H61YsBJ5cjXh8=
X-Google-Smtp-Source: AGRyM1us7cK1sEh6+QfaCGJhX9HKUKQ8xXgXHS382a/7gayxblhJYLvovDmJ6ykA/c4uk4l2MLK4MA==
X-Received: by 2002:adf:e988:0:b0:21b:8c9d:6ba3 with SMTP id h8-20020adfe988000000b0021b8c9d6ba3mr3585524wrm.10.1656512992631;
        Wed, 29 Jun 2022 07:29:52 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b0039c45fc58c4sm3362248wmp.21.2022.06.29.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 04/15] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Wed, 29 Jun 2022 15:30:35 +0100
Message-Id: <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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
index 000000000000..ceb94aa2bc97
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
+    pinctrl0: gpio {
+        compatible = "x-powers,axp192-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl0 0 0 6>;
+    };
-- 
2.35.1

