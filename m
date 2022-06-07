Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0B5402F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiFGPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbiFGPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88453AA72;
        Tue,  7 Jun 2022 08:52:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so34592823ejc.7;
        Tue, 07 Jun 2022 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2SxCoof8DymB3I9wp46h0VaZBiQfBjpWfXpSzVj+5o=;
        b=PurdL5qFs4cfkceENzefWjMcIZyxFhTaDDk0IW82wnRS+3eM24lyfFBcKdqTTY2uhN
         WvYgu7YXXUF8rEdl6a3u7pQICetdT0YSAhZWuVU2pc7PWpWIcoZacArBog28IZ6dDniv
         Fh3R+uPBA3OLfPLywB19T5TGnDzwLvV6W3bxioESQc+Ki/tSa/5OMRPfJlmSaHs7Lskp
         McUNl0OY1q1YQoZ11zhkkTomGoBIFo2L2R974pKLUSb7EENqJrBUj0ToU1Ep+6rSpQoM
         abTj8N6pZML9bNb3Y1Tpe7tchTiOLIm4CWCDK1B9gcIK31/tpU3alvhx3ZRGfHlz44xJ
         4C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2SxCoof8DymB3I9wp46h0VaZBiQfBjpWfXpSzVj+5o=;
        b=eDMe8TNKRjWXSWKuSj3EFFcwynKGjGh8fsWXnmX3KkdA7G3JcT5nUnKVyiXMr13+p/
         vH3Ulw7xVFRfT003qYANj6bS2yPYsL4cbwsg2gtCpxmQNm7TlfbeqNXRG+6ANLBNCKtS
         T6EH9/tf5k2og3DK2n0HXq8oXPkKqDg4g8wjoIFApvSkKW3f6Y32b6aUk1ynIWHePyc9
         CL9eezGyZB4LL9hGwDycoMcnb3qWSG+snzzox8wDHQhGMYXTL4zyqwmEU3xTurxIsUli
         oQVIDZGpnGc9owNMqsl8qyPU4bF8L3t7lbX0ViYrPTcTsDGd2IGc2llKasSGvrdAsRMy
         s/JQ==
X-Gm-Message-State: AOAM531OuuYRcLRbk1lAy7FzndnMP/rvIqAYosLLCqf0IayTbKeN9Grz
        lOJw/LQu5OQVq6wABJt2DB8=
X-Google-Smtp-Source: ABdhPJwNhDuc47qvRAnW7NPKfjWxkmgrOuwo5EoAtwg9E12F62IkqIWh6qz3/aeg8+sVzhMERbphrA==
X-Received: by 2002:a17:906:f996:b0:711:d208:bfb2 with SMTP id li22-20020a170906f99600b00711d208bfb2mr9235516ejb.163.1654617155163;
        Tue, 07 Jun 2022 08:52:35 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id m26-20020a50ef1a000000b0042bae6fbee2sm10460495eds.74.2022.06.07.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:34 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 06/17] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Tue,  7 Jun 2022 16:53:13 +0100
Message-Id: <20220607155324.118102-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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
 .../bindings/gpio/x-powers,axp192-gpio.yaml   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
new file mode 100644
index 000000000000..a5ba894383b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
@@ -0,0 +1,57 @@
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
+    const: x-powers,axp192-gpio
+
+  gpio-controller: true
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
+
+additionalProperties: false
+
+...
-- 
2.35.1

