Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22329570BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGKUeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiGKUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:33:57 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6C4D171;
        Mon, 11 Jul 2022 13:33:56 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id ACBFA4185A;
        Tue, 12 Jul 2022 01:33:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1657571631; bh=MaueoK+Vek+754sVEgpdzODSHjawfPvA50v4dhfN/Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUyN2ykOv//CKv/tJeOSENlK89XZ7w6gIiozDhGnYV0lANmrH71OAaDBEouff89a3
         OEQEQk/j8KCqXLvEZcewNpkvCuI6tlkfuHuPk3j96rP3ZQ0UkjPPokWlfR/iCrJacX
         3H5HmgUiHArB3ktdg6qz5qQ3yju1zvj6fiRvlqGnu+mKzEzPgONgdK6ttTx0BZxBga
         LLmbtSfxzI6whgbjSkevVcGkuhyXqeCxdBRKkSRsqk50Jx+DfQxZnVJUL3/Vgpaw9t
         jRYNbbuJKsFHAcjpYq67RLsQm7E3vPFWg/ykfXRIORgHX/ZBojaJmoKjCt5ZunTz6A
         nYAb/EN11BkPA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Tue, 12 Jul 2022 01:33:39 +0500
Message-Id: <20220711203340.648007-2-nikita@trvn.ru>
In-Reply-To: <20220711203340.648007-1-nikita@trvn.ru>
References: <20220711203340.648007-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for clk based PWM controller

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
 - fix the file name.
Changes in v4:
 - Use generic node name in the dt bindings example.
Changes in v5:
 - make compatible required
---
 .../devicetree/bindings/pwm/clk-pwm.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
new file mode 100644
index 000000000000..ec1768291503
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
@@ -0,0 +1,46 @@
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
+  - compatible
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
2.35.3

