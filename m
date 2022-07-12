Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D85571E77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiGLPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiGLPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:11:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF39CB47F;
        Tue, 12 Jul 2022 08:04:54 -0700 (PDT)
X-UUID: 2dd2c6e62d9d440680d7796eac713480-20220712
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:87bbe036-dda0-4fea-a66d-e41fb863bdde,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:87bbe036-dda0-4fea-a66d-e41fb863bdde,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:11ce1664-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:c2c42f8f366f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2dd2c6e62d9d440680d7796eac713480-20220712
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 3148393; Tue, 12 Jul 2022 23:04:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 12 Jul 2022 23:04:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jul 2022 23:04:43 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v9 0/8] ASoC: mediatek: Add support for MT8186 SoC
Date:   Tue, 12 Jul 2022 23:04:34 +0800
Message-ID: <20220712150442.32504-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for Mediatek AFE of MT8186 Soc.
Patches are based on broonie tree "for-next" branch.

Changes since v8:
  - Remove unnecessary comments and blank line.
  - Use devm_add_action_or_reset to ease error handling when dev probe.
  - Remove .remove callback in plaform driver.

Changes since v7:
  - Optimize the code logic, such as the return value and position of a
    function.
  - Use devm_pm_runtime_enable() instead of pm_runtime_enable().
  - Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync().

Changes since v6:
  - The Makefile and Kconfig updates are moved into the driver patches so that can
    keep independence of each patch.

Changes since v5:
  - fix build error about function snd_soc_card_jack_new that modified by:
    Link: https://lore.kernel.org/r/20220408041114.6024-1-akihiko.odaki@gmail.com
  - some have been accepted, details are in the link below:
    Link: https://lore.kernel.org/all/165459931885.399031.2621579592368573898.b4-ty@kernel.org/

Changes since v4:
  - [v5 07/20]
    - remove unsusd controls
  - [v5 09/20]
    - correct indent error
  - [v5 10/20]
  - [v5 13/20]
  - [v5 14/20]
    - fix the return value if the value is different from the previous
      value in mixer controls
  - [v5 17/20]
  - [v5 19/20]
    - correct the compatible name with '_' instead of '-'
  - [v5 18/20]
  - [v5 20/20]
    - correct the yaml after 'pip3 install dtschema --upgrade'

Changes since v3:
  - [v4 09/18]
    - remove DEBUG_COEFF debugging code
  - [v4 10/18]
    - simplify the logic of the code
  - [v4 13/18]
    - split out the MT6366 bits into mt8186-mt6366-commom.c
    - fix build error of "error: 'struct dev_pm_info' has no member named 'runtime_error'"
    - fix bug of adda dai driver
    - add route for pcm interface channel 2.
  - [v4 15/18]
  - [v4 17/18]
    - commonize the configuration of the codec
    - move MT6366 common bits into mt8186-mt6366-common.c

Changes since v2:
  - add a new compatible string "mediatek,mt6366-sound"
  - modify the log level for simplicity
  - use dev_err_probe(...) instead of dev_err(...) in dev probe()
  - optimized the logic of some code
  - use BIT() and GENMASK() macros to descript the registers

  Thanks for AngeloGioacchino's careful reviews.

Changes since v1:
  [v2 01/17]
    - add a new ID to the existing mt6358 codec driver
  [v2 03/17]
    - modify log level in DAPM events
    - use standard numeric control with name ending in Switch
    - return 1 when the value changed in mixer control's .get callback
  [v2 05/17]
    - ending in Switch to the standard on/off controls
    - change to "HW Gain 1 Volume" and "HW Gain 2 Volume"
  [v2 09/17]
    - return an error in the default case rather than just picking one of
      the behaviours when do .set_fmt
    - use the new defines that are _PROVIDER_MASK, _DAIFMT_CBP_CFP and
      _DAIFMT_CBC_CFC
  [v2 10/17]
  [v2 11/17]
    - the clock and gpio are aplit out into separate  patches

  The source file's GPL comment use c++ style, and the header fils's GPL
  comment use c style. We have added "Switch" after the names of all the
  controls that just are simple on/off.

Jiaxin Yu (8):
  dt-bindings: mediatek: mt6358: add new compatible for using mt6366
  ASoC: mediatek: mt8186: add platform driver
  ASoC: mediatek: mt8186: add mt8186-mt6366 common driver
  dt-bindings: mediatek: mt8186: add audio afe document
  ASoC: mediatek: mt8186: add machine driver with mt6366, da7219 and
    max98357
  dt-bindings: mediatek: mt8186: add mt8186-mt6366-da7219-max98357
    document
  ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and
    rt5682s
  dt-bindings: mediatek: mt8186: add mt8186-mt6366-rt1019-rt5682s
    document

 .../devicetree/bindings/sound/mt6358.txt      |    4 +-
 .../bindings/sound/mt8186-afe-pcm.yaml        |  175 +
 .../sound/mt8186-mt6366-da7219-max98357.yaml  |   75 +
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |   75 +
 sound/soc/mediatek/Kconfig                    |   44 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/mt8186/Makefile            |   22 +
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c    |    3 +-
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h    |    2 +-
 sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
 .../soc/mediatek/mt8186/mt8186-afe-control.c  |  255 ++
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3000 +++++++++++++++++
 .../mediatek/mt8186/mt8186-mt6366-common.c    |   57 +
 .../mediatek/mt8186/mt8186-mt6366-common.h    |   17 +
 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 1002 ++++++
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     |  978 ++++++
 16 files changed, 5942 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
 create mode 100644 sound/soc/mediatek/mt8186/Makefile
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c

-- 
2.18.0

