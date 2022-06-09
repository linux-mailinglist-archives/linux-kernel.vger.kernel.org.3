Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF35445F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiFIIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbiFIIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:32:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EE1915E0;
        Thu,  9 Jun 2022 01:31:10 -0700 (PDT)
X-UUID: c8726196ce67469aad6658bd5000352d-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4cf4e1a2-70ed-47ad-a760-5f8fc3fe987c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:7b2ac67e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: c8726196ce67469aad6658bd5000352d-20220609
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 430775798; Thu, 09 Jun 2022 16:31:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 9 Jun 2022 16:31:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 9 Jun 2022 16:31:05 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Mark Brown" <broonie@kernel.org>, YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 2/3] firmware: mediatek: Use meaningful names for mbox
Date:   Thu, 9 Jun 2022 16:31:00 +0800
Message-ID: <20220609083101.24195-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220609083101.24195-1-tinghan.shen@mediatek.com>
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mbox according to action instead of 'mbox0' and 'mbox1'

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/firmware/mtk-adsp-ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index cb255a99170c..3de94765d659 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -83,7 +83,11 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
-		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
+		if (i < MTK_ADSP_MBOX_NUM / 2)
+			chan_name = kasprintf(GFP_KERNEL, "rep");
+		else
+			chan_name = kasprintf(GFP_KERNEL, "req");
+
 		if (!chan_name) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.18.0

