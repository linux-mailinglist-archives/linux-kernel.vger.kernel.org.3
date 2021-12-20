Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4847B528
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhLTV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLTV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:27:15 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F4C061574;
        Mon, 20 Dec 2021 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1faGECyfR52bXmakz5lSoUtDh6LEKGKd5jXgQcHemKA=; b=nMvp8O+NU2bo20m3lNbi9KCc5d
        lv73WlSe3U7HU6rFOw8j1+HIk+z0R8ZeLBt3jLfT1QP8kxIfhdO19IoDZy+GolRd23tgJnj5wZZYX
        Lm6kO+DhY2WmX/6DY/RVGPxuoME9xGVC9NjFUhq7vHHnE6OvNX3Fg+QQnL6yhnh7h7eU=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mzQ3t-0000zo-4z; Mon, 20 Dec 2021 22:19:13 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/14] dt-bindings: arm: airoha: Add binding for Airoha GPIO controller
Date:   Mon, 20 Dec 2021 22:18:52 +0100
Message-Id: <20211220211854.89452-13-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220211854.89452-1-nbd@nbd.name>
References: <20211220211854.89452-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
GPIOs

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../bindings/gpio/airoha,en7523-gpio.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml b/Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml
new file mode 100644
index 000000000000..66c00ec85731
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/airoha,en7523-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7523 GPIO controller
+
+maintainers:
+  - John Crispin <john@phrozen.org>
+
+description: |
+  Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
+  GPIOs.
+
+properties:
+  $nodename:
+    pattern: "^gpio@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - const: airoha,en7523-gpio
+
+  reg:
+    description: |
+      The first tuple points to the input register.
+      The second and third tuple point to the direction registers
+      The fourth tuple points to the output register
+    maxItems: 4
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio@1fbf0200 {
+        compatible = "airoha,en7523-gpio";
+        reg = <0x1fbf0204 0x4>,
+              <0x1fbf0200 0x4>,
+              <0x1fbf0220 0x4>,
+              <0x1fbf0214 0x4>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+    gpio1: gpio@1fbf0270 {
+        compatible = "airoha,en7523-gpio";
+        reg = <0x1fbf0270 0x4>,
+              <0x1fbf0260 0x4>,
+              <0x1fbf0264 0x4>,
+              <0x1fbf0278 0x4>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+
+...
-- 
2.34.1

