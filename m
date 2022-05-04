Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6751A03D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiEDNJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbiEDNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:09:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39512F00B;
        Wed,  4 May 2022 06:05:50 -0700 (PDT)
X-UUID: 0cdd07134d494d70b6bbebba00ebe54a-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0c7d9dcb-5444-4062-9682-71b3d1575ba1,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:0c7d9dcb-5444-4062-9682-71b3d1575ba1,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:1db32c16-2e53-443e-b81a-655c13977218,C
        OID:5ccef16228e4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 0cdd07134d494d70b6bbebba00ebe54a-20220504
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1254656210; Wed, 04 May 2022 21:05:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 21:05:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 21:05:41 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v5 1/9] dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
Date:   Wed, 4 May 2022 21:05:32 +0800
Message-ID: <20220504130540.5902-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
References: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
for scaling clock frequency and adjust voltage.
The phandle could be linked between CPU and MediaTek CCI for some
MediaTek SoCs, like MT8183 and MT8186.

The reason we need the link status between cpufreq and MediaTek cci is
cpufreq and mediatek cci could share the same regulator in some MediaTek
SoCs. Therefore, to prevent the issue of high frequency and low voltage,
we need to use this to make sure mediatek cci is ready.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index b8233ec91d3d..e0a4ba599abc 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -20,6 +20,13 @@ Optional properties:
 	       Vsram to fit SoC specific needs. When absent, the voltage scaling
 	       flow is handled by hardware, hence no software "voltage tracking" is
 	       needed.
+- mediatek,cci:
+	Used to confirm the link status between cpufreq and mediatek cci. Because
+	cpufreq and mediatek cci could share the same regulator in some MediaTek SoCs.
+	To prevent the issue of high frequency and low voltage, we need to use this
+	property to make sure mediatek cci is ready.
+	For details of mediatek cci, please refer to
+	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
 - #cooling-cells:
 	For details, please refer to
 	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-- 
2.18.0

