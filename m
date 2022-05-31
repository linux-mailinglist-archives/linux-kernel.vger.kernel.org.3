Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB36539973
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiEaWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348390AbiEaWUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:20:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14419CF75;
        Tue, 31 May 2022 15:20:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 5F16E1F43F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654035602;
        bh=L1LFzcY2SS+Xz1rYP87W08WXZ151oxr1ApyX6lLzl/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAn59devWIMazgWA7WDdvX0I0LbRSMtm0nt30y1Udmz5jAZFslhBo9e5n7YK7fr4W
         IggvPxKYDtv/URk7XK+WQAN4SqG4qSi25nc7+qGTMaj++sWApmbJg1su2ka8Sjpn3m
         OG6eJnctPu5ooxqe+axl14PPOjy0vt7vd9JTOeJjo5mSV8gSyexL0yRWNnX/Xds+2M
         krTSzkWItWuGBkyIicZAvO+trl/anG7Wp/mJtZg9t9X/GC3/kHlhX08jFhhV6tBwqJ
         rGgb3SsajXHC1uAJvTXPGzsaBfDtCbB8OaUf5jBuxeeStzOzDno/l3e+z9Ql+GbHNt
         NxsgkrV/mPEpQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: pinctrl: mt8192: Use generic bias instead of pull-*-adv
Date:   Tue, 31 May 2022 18:19:54 -0400
Message-Id: <20220531221954.160036-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531221954.160036-1-nfraprado@collabora.com>
References: <20220531221954.160036-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafe19db7751 ("pinctrl: mediatek: Backward compatible to previous
Mediatek's bias-pull usage") allowed the bias-pull-up and bias-pull-down
properties to be used for setting PUPD/R1/R0 type bias on mtk-paris
based SoC's, which was previously only supported by the custom
mediatek,pull-up-adv and mediatek,pull-down-adv properties.

Since the bias-pull-{up,down} properties already have defines associated
thus being more descriptive and is more universal on MediaTek platforms,
and given that there are no mediatek,pull-{up,down}-adv users on mt8192
yet, remove the custom adv properties in favor of the generic ones.

Note that only mediatek,pull-up-adv was merged in the binding, but not
its down counterpart.

While at it, also add 'if' blocks to prevent bias-disable, bias-pull-up
and bias-pull-down to be used together, since they're mutually
exclusive.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>

---

Changes in v2:
- Dropped Fixes tag
- Added 'if' blocks to make bias-disable, bias-pull-up and
  bias-pull-down mutually exclusive

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index c8092b218f2f..6ce7e458d6fe 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -83,20 +83,21 @@ patternProperties:
           drive-strength-microamp:
             enum: [125, 250, 500, 1000]
 
-          mediatek,pull-up-adv:
-            description: |
-              Pull up settings for 2 pull resistors, R0 and R1. User can
-              configure those special pins. Valid arguments are described as below:
-              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
-              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
-              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
-              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
-
-          bias-pull-down: true
-
-          bias-pull-up: true
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+                description: normal pull down.
+              - enum: [100, 101, 102, 103]
+                description: PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0_
+                  defines in dt-bindings/pinctrl/mt65xx.h.
+
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+                description: normal pull up.
+              - enum: [100, 101, 102, 103]
+                description: PUPD/R1/R0 pull up type. See MTK_PUPD_SET_R1R0_
+                  defines in dt-bindings/pinctrl/mt65xx.h.
 
           bias-disable: true
 
@@ -123,6 +124,21 @@ patternProperties:
               properties:
                 drive-strength: false
 
+          - if:
+              required:
+                - bias-disable
+            then:
+              properties:
+                bias-pull-up: false
+                bias-pull-down: false
+
+          - if:
+              required:
+                - bias-pull-up
+            then:
+              properties:
+                bias-pull-down: false
+
         additionalProperties: false
 
 allOf:
-- 
2.36.1

