Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F7599BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbiHSMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiHSMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:07:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA010096A;
        Fri, 19 Aug 2022 05:06:57 -0700 (PDT)
X-UUID: 90fb09d8026b40bcb47f4d9907776688-20220819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=g/YPOMlZjMsEaO2WgP8P2ictRGCTTr097gbQCAoAdL0=;
        b=eqz286WlDwrBi5Va/N4fvbTOki8cK9cI0LmYNnDzFWCsjXmeTlOCqu/2Jhpv+NPutiJY0p2uWvvOT7i/eMstPdBc5XClUzx5QospF2u+Q5GA7GDkXqvSAqM/dEt3mcht86PcrlRQR0nOOLeDolrM8B495gkLY4dj1oohGoUmKJ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:b698d438-228e-4734-ac58-4b3edee145df,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:459c36c9-6b09-4f60-bf82-12f039f5d530,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 90fb09d8026b40bcb47f4d9907776688-20220819
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1512524538; Fri, 19 Aug 2022 20:06:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 19 Aug 2022 20:06:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 19 Aug 2022 20:06:50 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v3] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for pinctrl nodes
Date:   Fri, 19 Aug 2022 20:06:49 +0800
Message-ID: <20220819120649.21523-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
Co-developed-by: Guodong Liu <guodong.liu@mediatek.com>
Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Change in v2:
  * Remove changes of the formatting of addresses and add C-d-b tag for
    Guodong
Change in v1:
  * Capitalize First Letter of Sentences and rephrase the commit message
    [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
---
---
 .../bindings/pinctrl/pinctrl-mt8186.yaml           | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
index 1eeb885ce0c6..26573a793b57 100644
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
@@ -235,9 +235,9 @@ examples:
             <0x10002A00 0x0200>,
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

