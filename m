Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23497542B35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiFHJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiFHJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE871D82F4;
        Wed,  8 Jun 2022 01:36:10 -0700 (PDT)
X-UUID: b566a5b6eae447c9897858eace2fbdea-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:0d5b83aa-2477-46cd-b412-e843e534e382,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:0d5b83aa-2477-46cd-b412-e843e534e382,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:ac2415e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:ab9fe7398c47,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: b566a5b6eae447c9897858eace2fbdea-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 788356503; Wed, 08 Jun 2022 16:36:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 16:36:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 1/9] dt-binding: remoteproc: mediatek: Support dual-core SCP
Date:   Wed, 8 Jun 2022 16:35:45 +0800
Message-ID: <20220608083553.8697-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608083553.8697-1-tinghan.shen@mediatek.com>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 SCP co-processor is a dual-core RISC-V MCU.

Add a new property to reference the sibling core and to assign
core id to SCP nodes. Also add a new compatile for the driver of
SCP 2nd core.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../devicetree/bindings/remoteproc/mtk,scp.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index eec3b9c4c713..4576ff9b1f2d 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -20,6 +20,7 @@ properties:
       - mediatek,mt8186-scp
       - mediatek,mt8192-scp
       - mediatek,mt8195-scp
+      - mediatek,mt8195-scp-dual
 
   reg:
     description:
@@ -57,6 +58,17 @@ properties:
   memory-region:
     maxItems: 1
 
+  mediatek,scp-core:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      Reference to the sibling SCP core. This is required to
+      enable support for dual-core SCP.
+    items:
+      - items:
+          - description: Phandle of sibling SCP node.
+          - description: Core id of this SCP node
+            enum: [0, 1]
+
 required:
   - compatible
   - reg
@@ -115,6 +127,7 @@ examples:
         reg-names = "sram", "cfg", "l1tcm";
         clocks = <&infracfg CLK_INFRA_SCPSYS>;
         clock-names = "main";
+        mediatek,scp-core = <&scp_dual 0>;
 
         cros_ec {
             mediatek,rpmsg-name = "cros-ec-rpmsg";
-- 
2.18.0

