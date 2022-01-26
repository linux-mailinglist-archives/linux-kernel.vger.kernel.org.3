Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A649CA38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiAZM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:59:31 -0500
Received: from box.trvn.ru ([194.87.146.52]:60139 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbiAZM7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:59:30 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E93954190B;
        Wed, 26 Jan 2022 17:59:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1643201957; bh=G71ArfVpNaJiU2mdnPLkKivWdWK1kkqUzewN9Q+lh/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIekuro3EB6cfyXeyMJtHmzCgwpUV2H5mGPA06TUSHeqvP2ZH0rMn8io8NWa35IYZ
         KoWSVYWl4zlTXBezrtqg/o5eKyplh6rX859DLc/eXG3zSdCKMwB2oy64ZgZkeT01jg
         L2jiJAORFuCFdRpPWURhmau4sBguiQR5bVKfHeHrH619+JMTLIj/yTsrfPTTNul3Yk
         R4pepu2OZJLgA1XpC1RbezlVaxHF+2OprubRFKS/57uAW/+lNJi+7/ZO+KE6ridRzz
         0JRwqt3XPA9ABV4XFhbQIKE8FuPDjGAOOSdbO6A+NjYdZUXdp6ngveetgNcyd4lH7G
         yD+T3wY/1Ht+w==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Wed, 26 Jan 2022 17:58:48 +0500
Message-Id: <20220126125849.75572-2-nikita@trvn.ru>
In-Reply-To: <20220126125849.75572-1-nikita@trvn.ru>
References: <20220126125849.75572-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for clk based PWM controller

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
--
Changes in v2:
 - fix the file name.
Changes in v4:
 - Use generic node name in the dt bindings example.
---
 .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
new file mode 100644
index 000000000000..d3416ba549b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock based PWM controller
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description: |
+  Some systems have clocks that can be exposed to external devices.
+  (e.g. by muxing them to GPIO pins)
+  It's often possible to control duty-cycle of such clocks which makes them
+  suitable for generating PWM signal.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: clk-pwm
+
+  clocks:
+    description: Clock used to generate the signal.
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+unevaluatedProperties: false
+
+required:
+  - clocks
+
+examples:
+  - |
+    pwm {
+      compatible = "clk-pwm";
+      #pwm-cells = <2>;
+      clocks = <&gcc 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm_clk_flash_default>;
+    };
-- 
2.34.1

