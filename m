Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35114876F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347300AbiAGLyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:54:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347295AbiAGLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:54:46 -0500
X-UUID: 6f7dfea76555490bbc652be58e2bdf24-20220107
X-UUID: 6f7dfea76555490bbc652be58e2bdf24-20220107
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1256696717; Fri, 07 Jan 2022 19:54:41 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 7 Jan 2022 19:54:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Jan
 2022 19:54:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 19:54:39 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v8 3/4] dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property
Date:   Fri, 7 Jan 2022 19:53:44 +0800
Message-ID: <20220107115345.9075-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20220107115345.9075-1-tinghan.shen@mediatek.com>
References: <20220107115345.9075-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend pin driving support for I2C pins on SoC mt8195.
This property is also documented in mediatek,mt8183-pinctrl.yaml.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 567f71cab7b4..5e27e01d6588 100644
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
@@ -265,4 +291,13 @@ examples:
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

