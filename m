Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26851473008
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhLMPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:53 -0500
Received: from box.trvn.ru ([194.87.146.52]:54639 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhLMPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:51 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8321A4195F;
        Mon, 13 Dec 2021 20:03:46 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639407827; bh=Bj6NT80mGOa+q2RLJkazh5v6DMBUGRteGRVSbGmOJ1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDFTsckm73jiz0NYs/R2ohFhzou/DWehaVAgRdhCQcPijJcX1Slj/6XGRQTspY1PI
         MkebFnGxTD9H0PdLUT+IuUW4tYCVDk/V4A+VUQ9wA9AoMMuO116NuGXPR7OMCKTuQ+
         bAC2Z75l3NkiPG/feiHLkPX1ifl649694N+J2oXEdvdBkjBe0DBYNVcpmm9N3/SDY1
         r+ErBprF9LBhPWSCAHMF/PoUeQ5MBpAAGWDfTcYIdpFNT4LJLUeB8Pb6C48f7z2xEo
         3a+1RFHCJ+KdTakZ1dvoYwesuRwgpSn3hCpnBtI/mXmAJQpNP+dZpw6Gswxn1XYdr7
         TJglQ3qoaMU6A==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Mon, 13 Dec 2021 20:03:34 +0500
Message-Id: <20211213150335.51888-2-nikita@trvn.ru>
In-Reply-To: <20211213150335.51888-1-nikita@trvn.ru>
References: <20211213150335.51888-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for clk based PWM controller

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
--
Changes in v2:
 - Fix the file name.
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

