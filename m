Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A464B43D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbiBNIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiBNIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD7E5F8FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:00 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B0022407DF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826619;
        bh=RUrvha3jd75o7xb7qinVq9MRNe4Hz0+UgFNjZM5U/KA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GHv29UtdT/V61WTDyx9yaS+IdCELdrolgeKusUgfzxrvCzeD6TVD4nvtUMOliGtUu
         o5eBvPm3iq9VbP9vpeskxtXqjDWTjQ5uvPwAF5AffgphbPlWHgFw3l48PvXbevyaQb
         45XOtHRJ38ZlhhSuQUjOMT7NrmK9L9tN9prE/kFldzP5FVUHKrZPvdB1cqiz0dLH7j
         K0md/jyE+UkVqZhYAW4Hgg2dIoHg1Nj64+88Ru4QUSoQ11veQcIHWcfwCsEYYE7txn
         Qu39hTgMLbmOplPLjq7AbODmN0S4OwecHAqsWrmIJvF3P3pXbdRQibPU+wa083XOvZ
         fvbMDMTRsxFyQ==
Received: by mail-wm1-f72.google.com with SMTP id b17-20020a05600c4e1100b0037cc0d56524so1093233wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUrvha3jd75o7xb7qinVq9MRNe4Hz0+UgFNjZM5U/KA=;
        b=pa+EmLVR0sVkX3dlWEN+RvDf4diwG8DG39iYcxpBoKTKoq6s1z9J/G9+P81UdLx2s5
         HSZ2hTzpii/gGqVQzaFqYkDoWG9yf0nu4XPXUMyRCjV5uXLZmXbhfaarSpFzTjU1G/WX
         rD2TJPSAFbp4/PjK5ObCqVdhPxL+i+P8qmLEGmtdqZl73ciGzWeLLnXOyiAkDLr5NOVQ
         bKE1byybJI8+ssiQsZGkajUOwwqe3QZ/2jyP19kAMg7S8ILxZxJpEPdfIZShZ2tAqY3w
         rIXf7lcx/G68C1QCGgKcttHec9Z4e6WlwOEFR/nP7h2kMIrPBkAF9Am5EaVzXbSjtndN
         NXpA==
X-Gm-Message-State: AOAM533ykRAMmDXTO7k3Auh/M0Q9HDUhEmE6RmEoiQrXJOhD4jo3jdDq
        1ZLZBDw5GBQIROiNlGK+l2yKCLs1ZyyYYjCa2/q5XJSrUmfhoHxrStCYcJcV5SCaMr+vCCoKnE0
        2ftsdavpxB5EfeST2owGOTNlcAbFRU2i8aCAQ2gJ/fg==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr14323037edd.405.1644826609097;
        Mon, 14 Feb 2022 00:16:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzkuxNo1QP+7t12yVjZD9t3Y/Itl5ApNf4frcHdZJDQgI3MTIUIYVP/fV2AVsdZ2EHF8ILcQ==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr14323005edd.405.1644826608899;
        Mon, 14 Feb 2022 00:16:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 06/15] dt-bindings: pwm: rockchip: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:56 +0100
Message-Id: <20220214081605.161394-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/pwm/pwm-rockchip.yaml | 74 ++++++++++---------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 81a54a4e8e3e..a336ff9364a9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -51,42 +51,44 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
-
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - rockchip,rk3328-pwm
-          - rockchip,rv1108-pwm
-
-then:
-  properties:
-    clocks:
-      items:
-        - description: Used to derive the functional clock for the device.
-        - description: Used as the APB bus clock.
-
-    clock-names:
-      items:
-        - const: pwm
-        - const: pclk
-
-  required:
-    - clocks
-    - clock-names
-
-else:
-  properties:
-    clocks:
-      maxItems: 1
-      description:
-        Used both to derive the functional clock
-        for the device and as the bus clock.
-
-  required:
-    - clocks
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3328-pwm
+              - rockchip,rv1108-pwm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Used to derive the functional clock for the device.
+            - description: Used as the APB bus clock.
+
+        clock-names:
+          items:
+            - const: pwm
+            - const: pclk
+
+      required:
+        - clocks
+        - clock-names
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+          description:
+            Used both to derive the functional clock
+            for the device and as the bus clock.
+
+      required:
+        - clocks
 
 additionalProperties: false
 
-- 
2.32.0

