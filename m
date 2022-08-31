Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE035A8430
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiHaRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:22:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A41543D7;
        Wed, 31 Aug 2022 10:22:00 -0700 (PDT)
X-UUID: b1f2346a39f2423694b120268e9cf49c-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tyL8cPvebaCtbUtbRJCGD1Ux/d2Hi5szlibwPANQZ1E=;
        b=Zz77KI36j49AOdps07TRvLAao4aItIEb7BmMKh3x5MZs3/ksimttw/QyXTA+1Vk0SbUnPckPC1TALnonYxlKvcIRirD8n5m1wyb+w4r4G8oR06b4519AtguWzBEtHTbJzSsvh9F1aZsAZa7F0u9QfIOYNnkQJDnSbV9QSYZhjwg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:9c06a793-f46c-4615-b9ca-5d42ca478572,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:9c06a793-f46c-4615-b9ca-5d42ca478572,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:26562c56-e800-47dc-8adf-0c936acf4f1b,C
        OID:655b26123161,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b1f2346a39f2423694b120268e9cf49c-20220901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 669347512; Thu, 01 Sep 2022 01:21:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 1 Sep 2022 01:21:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Sep 2022 01:21:53 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 0/2] Add mt8186 mutex support for mdp3
Date:   Thu, 1 Sep 2022 01:21:49 +0800
Message-ID: <20220831172151.10215-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on matthias.bgg/linux.git, for-next and provide
mt8186 mutex support for Media Data Path 3 (MDP3).

As discussed, we add data field (mt8186_mdp_mutex_driver_data) for 
mt8186 mdp3 mutex support instead of adding mutex_table_mod into mt8186
disp mutex data.

changes since v2:
 - rebase to matthias.bgg/linux.git
 - add C-d-b, R-b and A-b tags

changes since v1:
 - add mt8186_mdp_mutex_table_mod
 - add mt8186_mdp_mutex_driver_data for mt8186-mdp3-mutex

Allen-KH Cheng (2):
  dt-bindings: soc: mediatek: Add mdp3 mutex support for mt8186
  soc: mediatek: mutex: Add mt8186 mutex mod settings for mdp3

 .../bindings/soc/mediatek/mediatek,mutex.yaml |  1 +
 drivers/soc/mediatek/mtk-mutex.c              | 28 +++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h        |  2 ++
 3 files changed, 31 insertions(+)

-- 
2.18.0

