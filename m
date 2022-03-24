Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7E4E5E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347897AbiCXFki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiCXFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:40:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA9D1706D;
        Wed, 23 Mar 2022 22:39:01 -0700 (PDT)
X-UUID: ba22f226372e49a3ac08b383e9f021dc-20220324
X-UUID: ba22f226372e49a3ac08b383e9f021dc-20220324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 392250870; Thu, 24 Mar 2022 13:38:56 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 13:38:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 13:38:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 13:38:54 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <tzungbi@google.com>, <miles.chen@mediatek.com>,
        <yc.hung@mediatek.com>
Subject: [PATCH v4 0/6] ASoC: mediatek: Add support for MT8195 sound card with max98390 and rt5682
Date:   Thu, 24 Mar 2022 13:38:45 +0800
Message-ID: <20220324053851.27350-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This series of patches adds support for mt8195 board with mt6359, max98390
and rt5682.

To prevent from copy-paste components, mt8195 machine drivers and 
dt-bindings are merged in the patch.

Patches are based on broonie tree "for-next" branch.

Changes since v3:
  - apply some suggested changes from reviewers

Changes since v2:
  - split "merge machine driver" into two parts for better understanding

Changes since v1:
  - remove merged patches about reset controller
  - propose a common machine driver instead of machine driver common code
  - propose a common dt-bindings for mt8195 sound card

Trevor Wu (6):
  ASoC: mediatek: mt8195: revise mt8195-mt6359-rt1019-rt5682.c
  ASoC: mediatek: mt8195: merge machine driver
  ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
  ASoC: mediatek: mt8195: rename card controls
  ASoC: mediatek: mt8195: add machine support for max98390 and rt5682
  ASoC: dt-bindings: mediatek: mt8195: support
    mt8195-mt6359-max98390-rt5682

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   51 -
 ...-rt1019-rt5682.yaml => mt8195-mt6359.yaml} |    9 +-
 sound/soc/mediatek/Kconfig                    |   26 +-
 sound/soc/mediatek/mt8195/Makefile            |    3 +-
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1198 -----------------
 ...mt6359-rt1019-rt5682.c => mt8195-mt6359.c} |  862 +++++++-----
 6 files changed, 566 insertions(+), 1583 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 rename Documentation/devicetree/bindings/sound/{mt8195-mt6359-rt1019-rt5682.yaml => mt8195-mt6359.yaml} (84%)
 delete mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
 rename sound/soc/mediatek/mt8195/{mt8195-mt6359-rt1019-rt5682.c => mt8195-mt6359.c} (78%)

-- 
2.18.0

