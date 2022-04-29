Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303F351552D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380530AbiD2UKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiD2UKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:10:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D32E089;
        Fri, 29 Apr 2022 13:06:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id CC2F51F469D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651262803;
        bh=JRAg129iDB2/5CSYNVbbLVuyBCrEuyoaGLVzHKyj2fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RapoQLJhI54F0hG0vEaHBbuBphCdk16JCXEz99skfhaqxplQKqZ1A13z8r+P5xcWf
         vxSi8LrandGByTy8WQnwInxs7mYzXrHMGb2dwQjh7SvCm8EhpXG/xMOhhb37a+XVit
         Wbpk1Q6+KCz534aszmtjngOfSuE1KOLvYtd37kuYJTw7r8d08XkGAdzQlgkeIwl2Fa
         YREqh+nPIsskVk1lwHdOfnMJp8KeTWzCyBPmSJywfPhhjT3tftBlm5y42imQxavwRF
         wAQ1sHqC/Z8XF5Ql805WrNduQnFdOJX71pSBQQdzkXX6pHRgn8LD0UNgUgoyYXN5iZ
         Vlo8xTCE8aKew==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: pinctrl: mt8192: Add mediatek,pull-down-adv property
Date:   Fri, 29 Apr 2022 16:06:37 -0400
Message-Id: <20220429200637.2204937-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mediatek,pull-down-adv property to the pinctrl-mt8192 dt-binding
to allow configuring pull-down resistors on the pins of MT8192. It is
the same as in mt8183-pinctrl.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index c90a132fbc79..e462f49eae6f 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -117,6 +117,17 @@ patternProperties:
             $ref: /schemas/types.yaml#/definitions/uint32
             enum: [0, 1, 2, 3]
 
+          mediatek,pull-down-adv:
+            description: |
+              Pull down settings for 2 pull resistors, R0 and R1. User can
+              configure those special pins. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+
           bias-pull-down: true
 
           bias-pull-up: true
-- 
2.36.0

