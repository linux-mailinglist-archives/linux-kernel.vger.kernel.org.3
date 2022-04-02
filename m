Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A734EFEE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353794AbiDBFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiDBFUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:20:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7CE1AC72E;
        Fri,  1 Apr 2022 22:18:04 -0700 (PDT)
X-UUID: 08833e10c2624593a6c5ee6a6193b403-20220402
X-UUID: 08833e10c2624593a6c5ee6a6193b403-20220402
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1983533025; Sat, 02 Apr 2022 13:17:58 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 2 Apr 2022 13:17:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 2 Apr
 2022 13:17:56 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 2 Apr 2022 13:17:56 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <tzungbi@google.com>
CC:     <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v8 0/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Date:   Sat, 2 Apr 2022 13:17:50 +0800
Message-ID: <20220402051754.17513-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series reuses mt8192-mt6359-rt10150rt5682.c for supporting machine
driver with rt1015p speaker amplifier and rt5682s headset codec.

Changes from v7:
  - "mediatek,hdmi-codec" is an optional property, the code and the
    binding document should match.

Changes from v6:
  - "speaker-codec" changes to "speaker-codecs" due to there may be two
    speaker codec.

Changes from v5:
  - "mediatek,headset-codec" and "mediatek,speaker-codec" drop prefix
    and move to properties from patternProperties.

Changes form v4:
  - split a large patch into three small patches for easy reviewing
  - correct coding style

Changes from v3:
  - fix build error: too many arguments for format
    [-Werror-format-extra-args]

Changes from v2:
  - fix build warnings such as "data argument not used by format string"

Changes from v1:
  - uses the snd_soc_of_get_dai_link_codecs to complete the
  configuration of dai_link's codecs
  - uses definitions to simplifies card name and compatible name

Jiaxin Yu (4):
  ASoC: dt-bindings: mt8192-mt6359: add new compatible and new
    properties
  ASoC: mediatek: mt8192: refactor for I2S3 DAI link of speaker
  ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI links of headset
  ASoC: mediatek: mt8192: support rt1015p_rt5682s

 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    |  32 +++
 sound/soc/mediatek/Kconfig                    |   1 +
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 199 +++++++++++-------
 3 files changed, 153 insertions(+), 79 deletions(-)

-- 
2.18.0

