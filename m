Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21577599877
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbiHSJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347808AbiHSJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:14:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D6371BA;
        Fri, 19 Aug 2022 02:14:00 -0700 (PDT)
X-UUID: 93cc2e66cdcf48c99894302bf8956e15-20220819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m9Mn/Y5eqL1fhFPMyU3DqaJWhYp9JczK52OrynSvfJU=;
        b=QvZ3p99bZR3K9hr/XRwGnUqC/Ogg31S10Y2UjSGEYdVJu0RMsePxf8/ua5a7HgkZD97LcVP8LIk4ryI56lC1BOCsOZdqjpykeFyoskRdAUENTMwZkHopyFEJft5GnFkqiuv0vofyAwthd4hCagQecN5+01/J9XT1fLtDt0HalCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:c0468842-4be0-46cd-aedd-595d0f2bb2dc,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:c0468842-4be0-46cd-aedd-595d0f2bb2dc,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:5b78b667-a9d9-4672-a3c8-12721739a220,C
        OID:3367a85ff7ee,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 93cc2e66cdcf48c99894302bf8956e15-20220819
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 763835170; Fri, 19 Aug 2022 17:13:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Aug 2022 17:13:47 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Aug 2022 17:13:46 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 3/7] phy: phy-mtk-tphy: add property to set pre-emphasis
Date:   Fri, 19 Aug 2022 17:13:40 +0800
Message-ID: <20220819091344.2274-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property to set usb2 phy's pre-emphasis, it's disabled by default
on some SoCs.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 8ee7682b8e93..986fde0f63a0 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -72,6 +72,8 @@
 #define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
 
 #define U3P_USBPHYACR6		0x018
+#define PA6_RG_U2_PRE_EMP		GENMASK(31, 30)
+#define PA6_RG_U2_PRE_EMP_VAL(x)	((0x3 & (x)) << 30)
 #define PA6_RG_U2_BC11_SW_EN		BIT(23)
 #define PA6_RG_U2_OTG_VBUSCMP_EN	BIT(20)
 #define PA6_RG_U2_DISCTH		GENMASK(7, 4)
@@ -370,6 +372,7 @@ struct mtk_phy_instance {
 	int eye_term;
 	int intr;
 	int discth;
+	int pre_emphasis;
 	bool bc12_en;
 };
 
@@ -841,10 +844,13 @@ static void phy_parse_property(struct mtk_tphy *tphy,
 				 &instance->intr);
 	device_property_read_u32(dev, "mediatek,discth",
 				 &instance->discth);
+	device_property_read_u32(dev, "mediatek,pre-emphasis",
+				 &instance->pre_emphasis);
 	dev_dbg(dev, "bc12:%d, src:%d, vrt:%d, term:%d, intr:%d, disc:%d\n",
 		instance->bc12_en, instance->eye_src,
 		instance->eye_vrt, instance->eye_term,
 		instance->intr, instance->discth);
+	dev_dbg(dev, "pre-emp:%d\n", instance->pre_emphasis);
 }
 
 static void u2_phy_props_set(struct mtk_tphy *tphy,
@@ -875,6 +881,10 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 	if (instance->discth)
 		mtk_phy_update_bits(com + U3P_USBPHYACR6, PA6_RG_U2_DISCTH,
 				    PA6_RG_U2_DISCTH_VAL(instance->discth));
+
+	if (instance->pre_emphasis)
+		mtk_phy_update_bits(com + U3P_USBPHYACR6, PA6_RG_U2_PRE_EMP,
+				    PA6_RG_U2_PRE_EMP_VAL(instance->pre_emphasis));
 }
 
 /* type switch for usb3/pcie/sgmii/sata */
-- 
2.25.1

