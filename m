Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A578596898
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiHQF0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiHQF0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:26:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8914E659D3;
        Tue, 16 Aug 2022 22:26:25 -0700 (PDT)
X-UUID: 3fc69181ffe845a7b463e6b087214610-20220817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+61FKuBZ2E54vbXTp6HuMJjGwe8HZxYw+DY8yWRPFeA=;
        b=qiEMjBEv7oJW73pwFPC49kgT3u8PGP8MyeQ7IIzFXm3m1Z72DqXVjLQDmbLTim4GQi2sHHoAu5vLDRTQ8Lkis16JGywDgV8agMG1P80HLanHi2BGzZ59LpV0VSZiUb8lKb9xawa2Je+rylnMpICzGayJCq6iOnzvedXMk0jN1pg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:99346184-ed82-42f4-a48e-5fd8eb63d97d,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:7857e69c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3fc69181ffe845a7b463e6b087214610-20220817
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 106568066; Wed, 17 Aug 2022 13:26:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 17 Aug 2022 13:26:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 17 Aug 2022 13:26:17 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v2] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for pinctrl nodes
Date:   Wed, 17 Aug 2022 13:26:15 +0800
Message-ID: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt8186 contains 8 GPIO physical address bases that correspond to
the 'reg-names' of the pinctrl driver. The 'reg-names' entries in
bindings are ordered incorrectly, though. The system crashes due of an
erroneous address when the regulator initializes.

We fix the 'reg-names' for the pinctrl nodes and the pinctrl-mt8186
example in bindings.

Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
---
Change in v1:
  * Capitalize First Letter of Sentences and rephrase the commit message
    [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
---
---
 .../bindings/pinctrl/pinctrl-mt8186.yaml         | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
index 1eeb885ce0c6..604445e390a7 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
@@ -41,12 +41,12 @@ properties:
       Gpio base register names.
     items:
       - const: iocfg0
-      - const: iocfg_bm
-      - const: iocfg_bl
-      - const: iocfg_br
+      - const: iocfg_lt
       - const: iocfg_lm
+      - const: iocfg_lb
+      - const: iocfg_bl
       - const: iocfg_rb
-      - const: iocfg_tl
+      - const: iocfg_rt
       - const: eint
 
   interrupt-controller: true
@@ -232,12 +232,12 @@ examples:
             <0x10002200 0x0200>,
             <0x10002400 0x0200>,
             <0x10002600 0x0200>,
-            <0x10002A00 0x0200>,
+            <0x10002a00 0x0200>,
             <0x10002c00 0x0200>,
             <0x1000b000 0x1000>;
-      reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
-                  "iocfg_br", "iocfg_lm", "iocfg_rb",
-                  "iocfg_tl", "eint";
+      reg-names = "iocfg0", "iocfg_lt", "iocfg_lm",
+                  "iocfg_lb", "iocfg_bl", "iocfg_rb",
+                  "iocfg_rt", "eint";
       gpio-controller;
       #gpio-cells = <2>;
       gpio-ranges = <&pio 0 0 185>;
-- 
2.18.0

