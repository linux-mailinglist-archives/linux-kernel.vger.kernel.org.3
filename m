Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2894DD100
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiCQXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiCQXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:02:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEB14FFCF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so9201625ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1h6v43X9Wm6mV5ATOpHxZMr+fhOw297iiR7I0VujGPQ=;
        b=wsTHgw2VBBcm8YG8qFRGs1WpXu6JyF6Icf7SYw2oQ2KyRk6OOMy2lcGej02iEPfdBj
         aaisFTjvISJ8vBPGrFZDgxnzDIAx2m9MvaNK3aXJy/1F7w1v+N6EGnDH2YwJmwJJrlwz
         VTQI7fG36ROUtvLL9CDQgS193hnT7stsgy523VSeAkEVoyT1L1rgo0DhplRoubiltQM7
         ut796lq+9aEWQHFf/n0TH5zDYRG0EaPaPuJVm5lO/Z2uOXTn40j63YijDtaxdnz4qaqz
         PCpEV4UmXZKUZ2l7b23KU8nGmJO5l3L0ooot97t0ugw4djgP28PQWTI52F4wwS09BAiC
         GLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1h6v43X9Wm6mV5ATOpHxZMr+fhOw297iiR7I0VujGPQ=;
        b=rxAo02hlqJMVUidsXYsNsmklgK3pRVCQEIYeHmiTveYIuHmcEiZaU3uHt5xebVipKg
         ic5Cw5Zof0IE3BRtvSLcvo1ZGcMR/a+PBmW3p8JwOfFqGv1roCSPKYSURbRICJYfrWK0
         Z713vJU35MriXW8X4ADuC5UEqIZVCfY2REdQu+u396LqgKIB9deFNrpjXgP7nG44X4/b
         InRiSBM+fJc/8wYM/OTiwg7kRZSgOEow2xqLCJhCq9YnAlJc9TGvjDE3z08xpPYS8AyR
         0kRSBLX0M0qDSuxGSEkipw6e7q5OiZxOSv/wzJNcPa9n2+7K/hvelym5+6tE5tTLqofW
         6SYg==
X-Gm-Message-State: AOAM531pa63u7HJBU3mycsbXH6h6EYdpFnfgdSdoQVbdqomcv0dYRtMS
        xiVOio7DP6S5NSd2yj1qxlQFsfvPLlRHJg==
X-Google-Smtp-Source: ABdhPJwsJWZmyw0Dj/XqEo3qOAjEFzd2Ly8PIdTH8f3QVrdumsfKQ80WpyvQczrfw2PPEZouvhCfVA==
X-Received: by 2002:a05:651c:4c6:b0:249:68fe:916e with SMTP id e6-20020a05651c04c600b0024968fe916emr1409054lji.288.1647558056520;
        Thu, 17 Mar 2022 16:00:56 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm191876ljv.35.2022.03.17.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:00:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/5 v2] dt-bindings: gnss: Rewrite Mediatek bindings in YAML
Date:   Thu, 17 Mar 2022 23:58:44 +0100
Message-Id: <20220317225844.1262643-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317225844.1262643-1-linus.walleij@linaro.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the Mediatek GNSS bindings in YAML.

Cc: devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch since Krzysztof pointed out there is really just
  one more binding to convert, so why not.
---
 .../devicetree/bindings/gnss/mediatek.txt     | 35 ------------
 .../devicetree/bindings/gnss/mediatek.yaml    | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
deleted file mode 100644
index 80cb802813c5..000000000000
--- a/Documentation/devicetree/bindings/gnss/mediatek.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Mediatek-based GNSS Receiver DT binding
-
-Mediatek chipsets are used in GNSS-receiver modules produced by several
-vendors and can use a UART interface.
-
-Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
-properties.
-
-Required properties:
-
-- compatible	: Must be
-
-			"globaltop,pa6h"
-
-- vcc-supply	: Main voltage regulator (pin name: VCC)
-
-Optional properties:
-
-- current-speed		: Default UART baud rate
-- gnss-fix-gpios	: GPIO used to determine device position fix state
-			  (pin name: FIX, 3D_FIX)
-- reset-gpios		: GPIO used to reset the device (pin name: RESET, NRESET)
-- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
-- vbackup-supply	: Backup voltage regulator (pin name: VBAT, VBACKUP)
-
-Example:
-
-serial@1234 {
-	compatible = "ns16550a";
-
-	gnss {
-		compatible = "globaltop,pa6h";
-		vcc-supply = <&vcc_3v3>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/gnss/mediatek.yaml b/Documentation/devicetree/bindings/gnss/mediatek.yaml
new file mode 100644
index 000000000000..273732225c1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gnss/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek GNSS Receiver Device Tree Bindings
+
+allOf:
+  - $ref: gnss-common.yaml#
+
+maintainers:
+  - Johan Hovold <johan@kernel.org>
+
+description:
+  Mediatek chipsets are used in GNSS-receiver modules produced by several
+  vendors and can use a UART interface.
+
+properties:
+  compatible:
+    const: globaltop,pa6h
+
+  vcc-supply:
+    description:
+      Main voltage regulator, pin name VCC.
+
+  reset-gpios:
+    maxItems: 1
+    description: An optional reset line, with names such as RESET or NRESET.
+      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.
+
+  timepulse-gpios:
+    description: Comes with pin names such as PPS1 or 1PPS.
+
+  vbackup-supply:
+    description:
+      Regulator providing backup voltage, pin names such as VBAT or VBACKUP.
+
+required:
+  - compatible
+  - vcc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+        gnss {
+            compatible = "globaltop,pa6h";
+            vcc-supply = <&vcc_3v3>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.35.1

