Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420944DA487
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351950AbiCOVWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351938AbiCOVWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:22:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF15BD13;
        Tue, 15 Mar 2022 14:20:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 880151F42BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647379249;
        bh=3ckuvqWLQ1qmzoI6HPHe+BcexrvaTRmXFylbDp1AC3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiIGSmRYBQRNzj3mgKPV/UTBh7RiXSNivNo34MoxKqEfCQDberhKZkx5V3hpbATJ3
         hX2IB1KUOeNwc/jmKawertc+hsCDJhhTWmNvTwM6yHM2umYnoOUqjCcpevWSxUegjK
         sJydYSemDm5kuiyd7mqxabk6lpX943D6a/l2YoFUMpRJvn+46Oz6CE36MxuGzkWQjS
         S/ZbGXyvLMNBCwfcFcl0haRTEU1JgebWwVluVARlQu9Ps72xPRUTjy6SECtEK0FUfy
         vez6cjtUaOU/VEsiVD8JUv3hOOZRItzn+FXUjHBSlPzTTYypNBZ4lt4pWnNeUZBvOg
         IjUrPQllOg00w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 2/4] dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property
Date:   Tue, 15 Mar 2022 17:19:34 -0400
Message-Id: <20220315211936.442708-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315211936.442708-1-nfraprado@collabora.com>
References: <20220315211936.442708-1-nfraprado@collabora.com>
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

Add the mediatek,drive-strength-adv property to the pinctrl-mt8192
dt-binding to allow further drive current adjustments for I2C nodes on
MT8192. It is the same as in mt8183-pinctrl.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index d63e23d9ed16..b52d8d0eb2d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -78,6 +78,32 @@ patternProperties:
               dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
+          mediatek,drive-strength-adv:
+            description: |
+              Describe the specific driving setup property.
+              For I2C pins, the existing generic driving setup can only support
+              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
+              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
+              driving setup, the existing generic setup will be disabled.
+              The specific driving setup is controlled by E1E0EN.
+              When E1=0/E0=0, the strength is 0.125mA.
+              When E1=0/E0=1, the strength is 0.25mA.
+              When E1=1/E0=0, the strength is 0.5mA.
+              When E1=1/E0=1, the strength is 1mA.
+              EN is used to enable or disable the specific driving setup.
+              Valid arguments are described as below:
+              0: (E1, E0, EN) = (0, 0, 0)
+              1: (E1, E0, EN) = (0, 0, 1)
+              2: (E1, E0, EN) = (0, 1, 0)
+              3: (E1, E0, EN) = (0, 1, 1)
+              4: (E1, E0, EN) = (1, 0, 0)
+              5: (E1, E0, EN) = (1, 0, 1)
+              6: (E1, E0, EN) = (1, 1, 0)
+              7: (E1, E0, EN) = (1, 1, 1)
+              So the valid arguments are from 0 to 7.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
           bias-pull-down: true
 
           bias-pull-up: true
-- 
2.35.1

