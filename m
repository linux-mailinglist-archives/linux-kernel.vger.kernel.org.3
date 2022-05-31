Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2353996D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348372AbiEaWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbiEaWUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:20:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4D9E9C3;
        Tue, 31 May 2022 15:20:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 90A671F43F1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654035601;
        bh=dqvPbD0+LyE8BrCyvcj4tkNdD3HuNjmZ6QAi2jlf4lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUux18MMXlb51shdebtxX+3nedmXE19+HQ65ny3FB5b7mvKStmQbMrQrhnRE6giNC
         /EMiebD2qDDTbz1uEfP9PCMOJXrSyMrTSIAEJT7i/paBPNcZRTtQxKlPl8G8FjsNAb
         ytuWmbomZTbqlPaqDBdFow89+M6nIrqE1cRPhnftfQ6jWYO7Ch9jue4Gu1P57Y9091
         8TLKZ6Ph4C3kZw/UDE2Sc/StNoAY+0oCu/YiiqK4BFgWZyvAX1ETJ8+YV9OBkksNFz
         kZx8duSUqP7ZGjSPdSrocuIGABHGsAwWktMdgZG7Pxyl+ElW8UKdsASUU6scbTxBxF
         gXyofvy9WtO6g==
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
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch drive-strength-adv for -microamp
Date:   Tue, 31 May 2022 18:19:53 -0400
Message-Id: <20220531221954.160036-2-nfraprado@collabora.com>
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

Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
drive-strength-microamp instead of mediatek,drive-strength-adv.

Since there aren't any users of mediatek,drive-strength-adv on mt8192
yet, remove this property and add drive-strength-microamp in its place,
which has a clearer meaning.

While at it, add a new 'if' block to validate that drive-strength and
drive-strength-microamp aren't used together, since they're mutually
exclusive.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>

---

Changes in v2:
- Added 'if' block to make drive-strength and drive-strength-microamp
  mutually exclusive
- Changed commit title to be more precise
- Dropped Fixes tag

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 35 ++++++-------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index c90a132fbc79..c8092b218f2f 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -80,31 +80,8 @@ patternProperties:
               dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
-          mediatek,drive-strength-adv:
-            description: |
-              Describe the specific driving setup property.
-              For I2C pins, the existing generic driving setup can only support
-              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
-              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
-              driving setup, the existing generic setup will be disabled.
-              The specific driving setup is controlled by E1E0EN.
-              When E1=0/E0=0, the strength is 0.125mA.
-              When E1=0/E0=1, the strength is 0.25mA.
-              When E1=1/E0=0, the strength is 0.5mA.
-              When E1=1/E0=1, the strength is 1mA.
-              EN is used to enable or disable the specific driving setup.
-              Valid arguments are described as below:
-              0: (E1, E0, EN) = (0, 0, 0)
-              1: (E1, E0, EN) = (0, 0, 1)
-              2: (E1, E0, EN) = (0, 1, 0)
-              3: (E1, E0, EN) = (0, 1, 1)
-              4: (E1, E0, EN) = (1, 0, 0)
-              5: (E1, E0, EN) = (1, 0, 1)
-              6: (E1, E0, EN) = (1, 1, 0)
-              7: (E1, E0, EN) = (1, 1, 1)
-              So the valid arguments are from 0 to 7.
-            $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3, 4, 5, 6, 7]
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
 
           mediatek,pull-up-adv:
             description: |
@@ -138,6 +115,14 @@ patternProperties:
         required:
           - pinmux
 
+        allOf:
+          - if:
+              required:
+                - drive-strength-microamp
+            then:
+              properties:
+                drive-strength: false
+
         additionalProperties: false
 
 allOf:
-- 
2.36.1

