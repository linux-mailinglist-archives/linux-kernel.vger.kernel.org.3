Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D34FAA9D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiDIUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiDIUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:08 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60249F81
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:05:00 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 39A072C4653;
        Sat,  9 Apr 2022 21:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPHDw3Kn6paq26RqJYO+850bOj9HsiGkdLK+KjbbhMQ=;
        b=MFqYIlk3KrXbM6hnuqutSH4942YHk2W3DEQ8Dj9KoEfpLF2DbX6s1oJbRycxwli7zNd6la
        gCCrGNg5hPKbEgSbYhpLYbvaiVAKuPlUeRmr1cp+a2A05QdkZA2RD0NTpU+o6bwq0vWuQf
        ZHJNtAopa1hxcCPifwYhJeRQSkjToXkyCAGSNJyxD1Ge0PvgkeDWwMbONmFunkE1xxuXJr
        8v2jaOY7id61jKtwh+BLPxM0diVL2BA7WRQGkDWRAtWTPj3L+bQzO0oqiN900tBkNeUJlb
        +B/xbWU/b3hYSfnBGVn+/qmfAUdiYAZmYOwMbJWaQVahFzZDx6DykvwFB3Y6oQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: gpio: realtek-otto: Add rtl9300 compatible
Date:   Sat,  9 Apr 2022 21:55:46 +0200
Message-Id: <7dfad6c63cea64ccd84907f1cf9f7c9c6d1ce3e9.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "realtek,rlt9300-gpio", "realtek,otto-gpio" compatible for GPIO
nodes on the RTL930x SoC series. This SoC requires an extra register
range, defining the interrupt CPU mapping registers.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../bindings/gpio/realtek,otto-gpio.yaml      | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
index 100f20cebd76..3c511e9af377 100644
--- a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
@@ -28,10 +28,10 @@ properties:
       - enum:
           - realtek,rtl8380-gpio
           - realtek,rtl8390-gpio
+          - realtek,rtl9300-gpio
       - const: realtek,otto-gpio
 
-  reg:
-    maxItems: 1
+  reg: true
 
   "#gpio-cells":
     const: 2
@@ -50,6 +50,23 @@ properties:
   interrupts:
     maxItems: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: realtek,rtl9300-gpio
+then:
+  properties:
+    reg:
+      items:
+        - description: GPIO and interrupt control
+        - description: interrupt CPU map
+else:
+  properties:
+    reg:
+      items:
+        - description: GPIO and interrupt control
+
 required:
   - compatible
   - reg
@@ -74,5 +91,17 @@ examples:
         interrupt-parent = <&rtlintc>;
         interrupts = <23>;
       };
+  - |
+      gpio@3300 {
+        compatible = "realtek,rtl9300-gpio", "realtek,otto-gpio";
+        reg = <0x3300 0x1c>, <0x3338 0x8>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        ngpios = <24>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&rtlintc>;
+        interrupts = <13>;
+      };
 
 ...
-- 
2.35.1

