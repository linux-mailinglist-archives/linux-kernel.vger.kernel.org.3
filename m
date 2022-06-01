Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4253A3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352614AbiFALWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350625AbiFALWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD950443CF;
        Wed,  1 Jun 2022 04:22:14 -0700 (PDT)
X-UUID: ac5e663d48a34bb789d11d8ef291f551-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:109751f4-9156-42c6-b2ae-b41d6137d2a7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:b990268a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ac5e663d48a34bb789d11d8ef291f551-20220601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 736326214; Wed, 01 Jun 2022 19:22:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:04 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 01/15] dt-binding: remoteproc: mediatek: Support dual-core SCP
Date:   Wed, 1 Jun 2022 19:21:47 +0800
Message-ID: <20220601112201.15510-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
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

The SCP co-processor is a dual-core RISC-V MCU on MT8195.

Add a new property to identify each core and helps to find drivers
through device tree API to cooperate with each other, e.g. boot flow and
watchdog timeout flow.

Add a new compatile for the driver of SCP 2nd core.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index eec3b9c4c713..b181786d9575 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -20,6 +20,7 @@ properties:
       - mediatek,mt8186-scp
       - mediatek,mt8192-scp
       - mediatek,mt8195-scp
+      - mediatek,mt8195-scp-dual
 
   reg:
     description:
@@ -57,6 +58,16 @@ properties:
   memory-region:
     maxItems: 1
 
+  mediatek,scp-core:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      The property value is a list with 2 items, a core id and a phandle
+      to the sibling SCP node. The core id represents the id of the dts node contains
+      this property. The valid values of core id are 0 and 1 for dual-core SCP.
+      The phandle of sibling SCP node is used to find the register settings,
+      trigger core dependent callback, and invoke rproc API.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -115,6 +126,7 @@ examples:
         reg-names = "sram", "cfg", "l1tcm";
         clocks = <&infracfg CLK_INFRA_SCPSYS>;
         clock-names = "main";
+        mediatek,scp-core = <0 &scp_dual>;
 
         cros_ec {
             mediatek,rpmsg-name = "cros-ec-rpmsg";
-- 
2.18.0

