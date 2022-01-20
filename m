Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007C0495229
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376939AbiATQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:15:07 -0500
Received: from box.trvn.ru ([194.87.146.52]:51099 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347315AbiATQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:15:03 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E2A2641A41;
        Thu, 20 Jan 2022 21:15:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642695301; bh=piWRjtUT3wYbqNm+c4Mr8L9osMBZFVJjWmgW1ZCv6/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eW8TzQFZBD6TxJqEvibx4E7TBS6PT3euaQYWC0qag2bYIcP1kYKdEwiYIdjogbPcF
         uiaAy8WXBkEHzedhhFQnFzn/Wl/eKYBvRCjDSkSvrNu+9HZzJobN1vZbI7VBUIV4fg
         PynclYuMw6H87AGuel3uTAnkQmrPtpMaiKCFTlDQEpZJG3EHiGZY5UhnrlrCp6k2RF
         8+jINqcW1S6+HZMQjJHiphpSH+/ZnwTZWx69MGcNUT5g4jowtEOcBhFOrRcj+lfeqs
         LzMvxbXHnh0K16+uSzT4TUyj1OkRaJRvE4MqX07E0xfi8xqi9Gpw3a6rCvd/4Oi49q
         BKivwhBOzqwJg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 2/3] dt-bindings: pwm: Document clk based PWM controller
Date:   Thu, 20 Jan 2022 21:14:41 +0500
Message-Id: <20220120161442.140800-3-nikita@trvn.ru>
In-Reply-To: <20220120161442.140800-1-nikita@trvn.ru>
References: <20220120161442.140800-1-nikita@trvn.ru>
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
---
 .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
new file mode 100644
index 000000000000..4fb2c1baaad4
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
+    pwm-flash {
+      compatible = "clk-pwm";
+      #pwm-cells = <2>;
+      clocks = <&gcc 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm_clk_flash_default>;
+    };
-- 
2.30.2

