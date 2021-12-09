Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4646ECF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhLIQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:24:31 -0500
Received: from box.trvn.ru ([194.87.146.52]:56931 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241046AbhLIQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:24:25 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6EDD441F11;
        Thu,  9 Dec 2021 21:20:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639066839; bh=BOKVWso91hiNZpvj+AhezAp+AndmxMqwLC0Ey7R760U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYUalHmKS/SgSXHKoB4dgf2P8Z9h2cPuR/kjcSjd6WhWGpUSoCAWSFc5qHwhJpLJW
         flCON9hSdq5noiW1MbngkVJBFhTdzTV26bYV68qBSmZ4fGYXdlO5cjb2RVoMixnkvG
         y+RSSD0GqgJYW/V2iEJrUQK87oIHrKm+k6Y408WPHzXttAcuUUokPg2RZbRb4PFvFJ
         k6xSxcsDxKbHyk8/8Zj/rJ/ioRglVbh2wVDPONNDkNCRbb3qjrcomanEizHBRtSRSq
         tzE46ec7E0TfIlL829YXwpEJ/LoZf3PnoKBMSExjOM3tEVHxLYRg72nErhoShTwIra
         MMfbKhb8Bx1fw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Thu,  9 Dec 2021 21:20:19 +0500
Message-Id: <20211209162020.105255-2-nikita@trvn.ru>
In-Reply-To: <20211209162020.105255-1-nikita@trvn.ru>
References: <20211209162020.105255-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for clk based PWM controller

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
new file mode 100644
index 000000000000..2b2801d0278f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-clk.yaml#
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
+    pwm-flash {
+      compatible = "clk-pwm";
+      #pwm-cells = <2>;
+      clocks = <&gcc 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm_clk_flash_default>;
+    };
-- 
2.30.2

