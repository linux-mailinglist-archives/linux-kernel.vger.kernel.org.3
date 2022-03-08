Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9944D10E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbiCHHZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiCHHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:25:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0123DA40;
        Mon,  7 Mar 2022 23:24:46 -0800 (PST)
X-UUID: 8e0b449563f9494f8ff25ddbc85a45fb-20220308
X-UUID: 8e0b449563f9494f8ff25ddbc85a45fb-20220308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 121888610; Tue, 08 Mar 2022 15:24:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 8 Mar 2022 15:24:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 15:24:39 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Subject: [PATCH 0/5] ASoC: mediatek: Add support for MT8195 sound card with max98390 and rt5682
Date:   Tue, 8 Mar 2022 15:24:30 +0800
Message-ID: <20220308072435.22460-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for mt8195 board with mt6359, max98390
and rt5682.

Reset controller is included because mt8195 etdm is used to play sound via
max98390 before kernel boot.

In addition, the common part of machine driver is extracted for 
simplification.

Patches are based on broonie tree "for-next" branch.

Trevor Wu (5):
  ASoC: mediatek: mt8195: add reset controller
  dt-bindings: mediatek: mt8195: add reset property
  ASoC: mediatek: mt8195: common code for mt8195 machine driver
  ASoC: mediatek: mt8195: add machine driver with mt6359, max98390 and
    rt5682
  dt-bindings: mediatek: mt8195: add mt8195-mt6359-max98390-rt5682
    document

 .../bindings/sound/mt8195-afe-pcm.yaml        |   10 +
 .../sound/mt8195-mt6359-max98390-rt5682.yaml  |   61 +
 sound/soc/mediatek/Kconfig                    |   16 +
 sound/soc/mediatek/mt8195/Makefile            |   17 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |   16 +
 .../mediatek/mt8195/mt8195-mt6359-common.c    |  398 +++++++
 .../mediatek/mt8195/mt8195-mt6359-common.h    |   30 +
 .../mt8195/mt8195-mt6359-max98390-rt5682.c    | 1058 +++++++++++++++++
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      |  406 +------
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      |  409 +------
 10 files changed, 1618 insertions(+), 803 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-rt5682.yaml
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-common.c
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-common.h
 create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-max98390-rt5682.c

-- 
2.18.0

