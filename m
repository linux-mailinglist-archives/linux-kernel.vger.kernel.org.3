Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B934A334C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353791AbiA3CcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:32:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56398 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353124AbiA3CcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:32:18 -0500
X-UUID: d65e3960d9974b58b41e8b7ed74682e9-20220130
X-UUID: d65e3960d9974b58b41e8b7ed74682e9-20220130
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1724985298; Sun, 30 Jan 2022 10:32:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Jan 2022 10:32:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 10:32:13 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Subject: [PATCH v10 2/3] dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property
Date:   Sun, 30 Jan 2022 10:32:08 +0800
Message-ID: <20220130023209.16275-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20220130023209.16275-1-tinghan.shen@mediatek.com>
References: <20220130023209.16275-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend driving support for I2C pins on SoC mt8195.
This property is already documented in mediatek,mt8183-pinctrl.yaml.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 328ea59c5466..4db4899af6b1 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -98,6 +98,32 @@ patternProperties:
           drive-strength:
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
           bias-pull-down:
             description: |
               For pull down type is normal, it don't need add RSEL & R1R0 define
@@ -268,4 +294,13 @@ examples:
           bias-pull-down;
         };
       };
+
+      i2c0-pins {
+        pins {
+          pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
+                   <PINMUX_GPIO9__FUNC_SCL0>;
+          bias-disable;
+          mediatek,drive-strength-adv = <7>;
+        };
+      };
     };
-- 
2.18.0

