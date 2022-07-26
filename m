Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD86581670
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiGZPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGZPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:31:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0EDB7C6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:31:36 -0700 (PDT)
X-UUID: 36940567af7140c897fa69c7a1f330d0-20220726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:6800985f-b994-48a6-860c-bc08bb50d045,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:6800985f-b994-48a6-860c-bc08bb50d045,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:609d14ee-db04-4499-9fdf-04ef44b9468c,C
        OID:e4b8c560132e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 36940567af7140c897fa69c7a1f330d0-20220726
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1986539326; Tue, 26 Jul 2022 23:31:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 26 Jul 2022 23:31:32 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 26 Jul 2022 23:31:32 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <dan.carpenter@oracle.com>
CC:     <aaronyu@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt8186: set the correct string to strncmp()
Date:   Tue, 26 Jul 2022 23:31:30 +0800
Message-ID: <20220726153130.27584-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Smatch static checker warning. strncmp() here only needs to compare
the first seven bytes, so in order to make the code more clear, only the
first seven bytes of the string used as the comparison are reserved.

Bug report: https://www.spinics.net/lists/alsa-devel/msg145608.html

sound/soc/mediatek/mt8186/mt8186-dai-adda.c:78 get_adda_priv_by_name()
warn: strncmp() with weird length: 17 vs 7

sound/soc/mediatek/mt8186/mt8186-dai-adda.c
    72 static struct mtk_afe_adda_priv *get_adda_priv_by_name(struct mtk_base_afe *afe,
    73                                                        const char *name)
    74 {
    75         struct mt8186_afe_private *afe_priv = afe->platform_priv;
    76         int dai_id;
    77
--> 78         if (strncmp(name, "aud_dac_hires_clk", 7) == 0 ||
    79             strncmp(name, "aud_adc_hires_clk", 7) == 0)

Fixes: b65c466220b3 ("ASoC: mediatek: mt8186: support adda in platform driver")
Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index db71b032770d..81976f7c444e 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -75,8 +75,7 @@ static struct mtk_afe_adda_priv *get_adda_priv_by_name(struct mtk_base_afe *afe,
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	int dai_id;
 
-	if (strncmp(name, "aud_dac_hires_clk", 7) == 0 ||
-	    strncmp(name, "aud_adc_hires_clk", 7) == 0)
+	if (strncmp(name, "aud_dac", 7) == 0 || strncmp(name, "aud_adc", 7) == 0)
 		dai_id = MT8186_DAI_ADDA;
 	else
 		return NULL;
-- 
2.25.1

