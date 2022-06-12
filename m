Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8ED547A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiFLNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiFLNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:54:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B156C03;
        Sun, 12 Jun 2022 06:54:24 -0700 (PDT)
X-UUID: 2dbcb9b0d66348da8d7faeda3d675b52-20220612
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ea1d74f2-6594-4236-92cf-cd3c67adebc8,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:ea1d74f2-6594-4236-92cf-cd3c67adebc8,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:7ca67d50-276a-4a9a-a4c8-ea931023add4,C
        OID:3b1ffced7f6d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 2dbcb9b0d66348da8d7faeda3d675b52-20220612
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2112512311; Sun, 12 Jun 2022 21:54:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 12 Jun 2022 21:54:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 12 Jun 2022 21:54:16 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [RFC PATCH 0/2] Introduce MediaTek frequency hopping driver
Date:   Sun, 12 Jun 2022 21:54:12 +0800
Message-ID: <20220612135414.3003-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This serie aims to add support for MediaTek frequency hopping and
spread spectrum clocking (SSC) control on MT8186 SoC.

Johnson Wang (2):
  dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency
    hopping
  clk: mediatek: Add frequency hopping support

 .../bindings/arm/mediatek/mediatek,fhctl.yaml | 149 ++++++++
 drivers/clk/mediatek/Kconfig                  |   8 +
 drivers/clk/mediatek/Makefile                 |   2 +
 drivers/clk/mediatek/clk-fhctl-ap.c           | 347 ++++++++++++++++++
 drivers/clk/mediatek/clk-fhctl-pll.c          | 209 +++++++++++
 drivers/clk/mediatek/clk-fhctl-pll.h          |  74 ++++
 drivers/clk/mediatek/clk-fhctl-util.h         |  24 ++
 drivers/clk/mediatek/clk-fhctl.c              | 191 ++++++++++
 drivers/clk/mediatek/clk-fhctl.h              |  45 +++
 drivers/clk/mediatek/clk-pll.c                |   5 +-
 drivers/clk/mediatek/clk-pll.h                |   5 +
 11 files changed, 1058 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
 create mode 100644 drivers/clk/mediatek/clk-fhctl-ap.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.h
 create mode 100644 drivers/clk/mediatek/clk-fhctl-util.h
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h

-- 
2.18.0

