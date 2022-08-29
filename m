Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1575A449F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiH2IJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiH2IIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:08:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0B52FC0;
        Mon, 29 Aug 2022 01:08:44 -0700 (PDT)
X-UUID: 2f12ab7810944ec7ad6248d771e2378d-20220829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VAHJFqQzhRn88m6R3tZ7/zsDUdAQj7nWEaWhRpKIxCM=;
        b=eBt+rjTUl2qnYAJXI76Y04aHoqsZk2EvrZBojYPRdOpjMhTe2LieAGtLk47inWGaXRoaKYjJV7ZanewssW/XC4Qlrgit3k78UIRE4JIL42EGnfbG+P61ce4DrhT7hfDMBAgZ5TNJPWtkC2dVAOBxa3pbj3heqOspxRtAZS9+R28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:e5eddfcc-2499-4803-85a1-1922dba3fbb8,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:58866820-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2f12ab7810944ec7ad6248d771e2378d-20220829
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1576505806; Mon, 29 Aug 2022 16:08:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 29 Aug 2022 16:08:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Aug 2022 16:08:36 +0800
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 6/7] phy: phy-mtk-tphy: set utmi 0 register in init() ops
Date:   Mon, 29 Aug 2022 16:08:29 +0800
Message-ID: <20220829080830.5378-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
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

No need repeat to clear utmi 0 register in ->power_on() and
->power_off(), just do it in ->init()

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 79920c066e59..e0f227a0d3cc 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -522,8 +522,8 @@ static void u2_phy_instance_init(struct mtk_tphy *tphy,
 	/* switch to USB function, and enable usb pll */
 	mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_FORCE_UART_EN | P2C_FORCE_SUSPENDM);
 
-	mtk_phy_update_bits(com + U3P_U2PHYDTM0, P2C_RG_XCVRSEL | P2C_RG_DATAIN,
-			    P2C_RG_XCVRSEL_VAL(1) | P2C_RG_DATAIN_VAL(0));
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM0,
+			   P2C_RG_XCVRSEL | P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
 
 	mtk_phy_clear_bits(com + U3P_U2PHYDTM1, P2C_RG_UART_EN);
 
@@ -565,9 +565,6 @@ static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
 
-	mtk_phy_clear_bits(com + U3P_U2PHYDTM0,
-			   P2C_RG_XCVRSEL | P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
-
 	/* OTG Enable */
 	mtk_phy_set_bits(com + U3P_USBPHYACR6, PA6_RG_U2_OTG_VBUSCMP_EN);
 
@@ -590,8 +587,6 @@ static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
 
-	mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_RG_XCVRSEL | P2C_RG_DATAIN);
-
 	/* OTG Disable */
 	mtk_phy_clear_bits(com + U3P_USBPHYACR6, PA6_RG_U2_OTG_VBUSCMP_EN);
 
-- 
2.18.0

