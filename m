Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF9583B12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiG1JRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiG1JRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:17:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08226402C9;
        Thu, 28 Jul 2022 02:17:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so2108341ejr.5;
        Thu, 28 Jul 2022 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y78Ct4fFXNg/6yn3eXTXocHBOF2oFMofyGfsSfBm76E=;
        b=lRZeChtcl6QKLLncrcd65RtuwmC+AmJfYNZCNuFqvTeDNN4N2du0je1r2yULwLjsJj
         XjEA6s32GZvsv0PEdvL3uIaEbHrolSNrHjxLdZ+/8ugi/gmXvnVM1OBfMd2E4nL6/GS6
         g6+LY5Mnq0QUFXTNh+b6sNXic9Ll1g5OD5OvO7QhAGRZLHubcpQBAtDEG1mq1Qk/WWfW
         ujXRrL3Hj1Mgz+kswZgeWv9KpuKm5ObbdV09AHc8MDKR/QgP//V+OpJnvL5qJLdYRa9B
         SrsKS5GldctkLI632cSlX1igJL7d/IhogXaFj2ZjLvUDYdD4cBYtBLNxXfT/GwcA7ISY
         5A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y78Ct4fFXNg/6yn3eXTXocHBOF2oFMofyGfsSfBm76E=;
        b=sltU7GuGR3HGCV2XPTFwdkRMVNjTozEiR2044kFm2A4ljM3M1/6VcekBzbGdC3MNhE
         aXX/Jm/FiPxLiW8OWvSMZEyYRR8NChZztPT2Jmc6kNarb6JAQ/SRjibthqwMyL3WnbRg
         mkNfENoyruOpRZiO4WfB9r6kCSO8J4FoWNsIKJi3uqOv7mwT6g7r+xNjVyVDzmh1NSLd
         Q6VV0TI2GCgwhYBDyDKSZK6vsmNhgnp9rgJGoNJyPfCslqMzGnJ0DhEETUD8lPwRMqaW
         vfZ/ofLQh0Ck6gE0QD5wXumSSIvFiEAQ4jTijX3fMC5AO/mnJ6EPuiluzb0Hfi4T7Cxa
         kS6w==
X-Gm-Message-State: AJIora/bHhCc0wcB4aJ7sUFKh9dqdTJG0/kys5zauZT2z5TpknLutxCy
        2/i6Q2socQybUhbeQ0snT1zUrsEZtZrNo00gKWY=
X-Google-Smtp-Source: AGRyM1vjbD5Pyz6kINYX/l0Ve6gjd8ITkXtHl6Gw2228CXHIBLWySFdFwrh1TYKdI179iB0D7VczFw==
X-Received: by 2002:a17:906:9754:b0:72f:58fe:41ce with SMTP id o20-20020a170906975400b0072f58fe41cemr20289114ejy.467.1658999853312;
        Thu, 28 Jul 2022 02:17:33 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709062f1700b0072ff4515792sm195760eji.54.2022.07.28.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:17:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, elder@linaro.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH RFC v1 2/2] devicetree: bindings: bus: add Wiegand driver documentation
Date:   Thu, 28 Jul 2022 11:17:12 +0200
Message-Id: <20220728091712.13395-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728091712.13395-1-m.zatovic1@gmail.com>
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wiegand write-only driver requires definitions of two GPIO lines
in the devicetree. This adds the documentation of their
definitions.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../devicetree/bindings/bus/wiegand-gpio.yaml | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/wiegand-gpio.yaml

diff --git a/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml b/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
new file mode 100644
index 000000000000..74733aadc61e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/wiegand-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand write-only GPIO driver
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description: |
+  Wiegand interface is a wiring standard popularized in the 1980s. To this day
+  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
+  particularly for access control applications. It utilizes two wires to
+  transmit the data - D0 and D1.
+
+  Both data lines are initially pulled up. To send a bit of value 1, the D1
+  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
+  Standard Wiegand formats include 26, 36 and 37 bit and they reserve the first
+  and last bits for parity. The first(MSB) parity bit is set to 1 if the parity
+  of the first half of the payload is odd. The last(LSB) parity bit is set to 1
+  if the parity of the second half of the payload even.
+
+properties:
+  $nodename:
+    pattern: "^wiegand-gpio(@[0-9a-f]+)?$"
+
+  compatible:
+    contains:
+      const: gpio,wiegand-gpio
+    description:
+      Shall contain "wiegand-gpio" for the driver to match with this node.
+
+  wiegand-data-hi-gpios:
+    description:
+      gpio used to transmit bits the value of which is 1, it should be
+      flagged as active high with GPIO_ACTIVE_HIGH from
+      <dt-bindings/gpio/gpio.h>.
+    maxItems: 1
+
+  wiegand-data-lo-gpios:
+    description:
+      gpio used to transmit bits the value of which is 1, it should be
+      flagged as active high with GPIO_ACTIVE_HIGH from
+      <dt-bindings/gpio/gpio.h>.
+    maxItems: 1
+
+required:
+  - compatible
+  - wiegand-data-hi-gpios
+  - wiegand-data-lo-gpios
+
+additionalProperties: true
+
+examples:
+  - |
+    wiegand-gpio {
+        compatible = "wiegand-gpio";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart1_wiegand>;
+        wiegand-data-hi-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+        wiegand-data-lo-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+        status = "okay";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a519530e44e..c7db1e41cc02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21589,6 +21589,7 @@ F:	drivers/rtc/rtc-sd3078.c
 WIEGAND WRITE-ONLY GPIO DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
 F:	drivers/bus/wiegand-gpio.c
 F:	drivers/bus/wiegand-gpio.h
 
-- 
2.37.1

