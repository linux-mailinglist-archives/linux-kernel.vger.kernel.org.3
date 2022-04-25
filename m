Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C450E29E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiDYOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiDYOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:07:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CACBB82C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:04:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p4so2923882edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/KjYfxWY6dO26Q/Gz+eZoR2t9LGmKY4e8SrCiDCtaw=;
        b=qoct3X/M96zwh5rBzwzAzpVicsmVVPwtHu1jI+7dbJcKQTYvl1zG/c4Hec0mNj2VBy
         AuM5tT36C0XiFizxUMpVWsmMw+06MZHLkQLez8dKeF1PlYpyUQysLBPGXGFIddlaFPaM
         O8PNjbcUBUygXEYh88H+WcRiEtP4jAsPkuB29I4DpCIwCdXMS6WW1fMmqXxH6lUrUR3y
         F0z3iHqwGUyxyRnrH2sMG0ImODkYqGc+uHeng4+RSUvjbPPL0f5qw3uutRoklRAHFHr3
         8qkoX2UeEyY2A+2tFlzdwVGcXMnQYu1jVZKMYqyyagoK5c7O3565R0kRc6ipV9OsTvss
         jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/KjYfxWY6dO26Q/Gz+eZoR2t9LGmKY4e8SrCiDCtaw=;
        b=crWJG3kkfTijsJeYleSs8GIX34BPoUMpueCQRg5sgaPLZfhbajTZSFxo6unUc8/JQK
         OYYYYCietGI5cwh98Yi7krpB4E34FqbXYr0PXt+Ka1sV8tuYQJb+jxLoEbz+wiYmdHmK
         F4oDbgVHpWvrrrmoYkG8WFpuhVmbcBmcc4VJfmteSyLaG/fa0xT06YGF3t9OJ12dtsKC
         m52M1OYdeW3eUEFBLATnSpAUGS+3ONLtUNCiXmAdTtml9aCfN5Voxe5xYYIPgoo/WqC6
         kM5dKUbeUxOWJ7Hnb1o0/cAKFrp457O8XctRkYbFS+PDWWIQq5FrFTcERvHXwHUGWGDp
         q76Q==
X-Gm-Message-State: AOAM531BOf1nnge1IeZQ+5Ym699X2de/F/HA+vs6Zgi8lQi+6ce5MTkv
        K1WUKKK3+Fh2va73r4+AKuFiPQ==
X-Google-Smtp-Source: ABdhPJykCgU1o5E3oYd27kWf/cilZ8TlR93/84M5TvIIClDxB48S9+chsPS5lEeoQ7jZ0QFZ4XMLgw==
X-Received: by 2002:a50:c31e:0:b0:425:e127:2901 with SMTP id a30-20020a50c31e000000b00425e1272901mr7328570edb.134.1650895483991;
        Mon, 25 Apr 2022 07:04:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm3663554eje.183.2022.04.25.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:04:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: stm32: narrow DH STM32MP1 SoM boards
Date:   Mon, 25 Apr 2022 16:04:35 +0200
Message-Id: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for DH STM32MP1 SoM boards allows invalid combinations,
e.g. st,stm32mp153 SoC on a dh,stm32mp157c-dhcom-som SoM.

Split the enums to properly match valid setups.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/stm32/stm32.yaml  | 37 +++++++++++--------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index fa0a1b84122e..2f83f2760e6a 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -14,21 +14,6 @@ properties:
     const: "/"
   compatible:
     oneOf:
-      - description: DH STM32MP1 SoM based Boards
-        items:
-          - enum:
-              - arrow,stm32mp157a-avenger96 # Avenger96
-              - dh,stm32mp153c-dhcom-drc02
-              - dh,stm32mp157c-dhcom-pdk2
-              - dh,stm32mp157c-dhcom-picoitx
-          - enum:
-              - dh,stm32mp153c-dhcom-som
-              - dh,stm32mp157a-dhcor-som
-              - dh,stm32mp157c-dhcom-som
-          - enum:
-              - st,stm32mp153
-              - st,stm32mp157
-
       - description: emtrion STM32MP1 Argon based Boards
         items:
           - const: emtrion,stm32mp157c-emsbc-argon
@@ -65,6 +50,13 @@ properties:
           - enum:
               - st,stm32mp135f-dk
           - const: st,stm32mp135
+
+      - description: DH STM32MP153 SoM based Boards
+        items:
+          - const: dh,stm32mp153c-dhcom-drc02
+          - const: dh,stm32mp153c-dhcom-som
+          - const: st,stm32mp153
+
       - items:
           - enum:
               - shiratech,stm32mp157a-iot-box # IoT Box
@@ -79,6 +71,21 @@ properties:
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
 
+      - description: DH STM32MP1 SoM based Boards
+        items:
+          - enum:
+              - arrow,stm32mp157a-avenger96 # Avenger96
+          - const: dh,stm32mp157a-dhcor-som
+          - const: st,stm32mp157
+
+      - description: DH STM32MP1 SoM based Boards
+        items:
+          - enum:
+              - dh,stm32mp157c-dhcom-pdk2
+              - dh,stm32mp157c-dhcom-picoitx
+          - const: dh,stm32mp157c-dhcom-som
+          - const: st,stm32mp157
+
       - description: Engicam i.Core STM32MP1 SoM based Boards
         items:
           - enum:
-- 
2.32.0

