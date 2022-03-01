Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ECA4C88C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiCAKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiCAKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:03:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189E5B3EA;
        Tue,  1 Mar 2022 02:02:58 -0800 (PST)
X-UUID: 656291b22a2c4d1ea04af01387f6ec76-20220301
X-UUID: 656291b22a2c4d1ea04af01387f6ec76-20220301
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 724579130; Tue, 01 Mar 2022 18:02:50 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 18:02:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 18:02:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 18:02:48 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v12 0/4] Add mmsys and mutex support for MDP
Date:   Tue, 1 Mar 2022 18:02:42 +0800
Message-ID: <20220301100246.2153-1-moudy.ho@mediatek.com>
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

Change since V11:
- Rebase on v5.17-rc6.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=5f9b5b757e44de47ebdc116c14b90e3cc8bc7acb
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=831785f0e5b919c29e1bc5f9a74e9ebd38289e24
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=15f1768365aed810826a61fef4a744437aa5b426

Change since v10:
- For some ISP application scenarios, such as preview and recording
  at the same time.
  The routing table needs to be discarded, and the calculation result
  on the SCP side is used to write a suitable mux setting for
  1 input and 2 output.
- Adjust the GCE client register parsing method to avoid redundant warning logs.

Change since v9:
- Add API for MDP getting mutex mod.

Hi,

This patch splits mmsys and mutex settings from Media Data Path 3 (MDP3),
and original mailling list list below:
https://patchwork.kernel.org/project/linux-mediatek/cover/20211201095031.31606-1-moudy.ho@mediatek.com/
Corresponding settings and interfaces are added for MDP operation in the
mmsys and mutex drivers, which increases the independence of the modules

Moudy Ho (4):
  soc: mediatek: mmsys: add CMDQ write register function
  soc: mediatek: mmsys: add support for ISP control
  soc: mediatek: mutex: add support for MDP
  soc: mediatek: mutex: add functions that operate registers by CMDQ

 drivers/soc/mediatek/Kconfig           |   1 +
 drivers/soc/mediatek/mt8183-mmsys.h    |  26 +++++
 drivers/soc/mediatek/mtk-mmsys.c       | 145 +++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h       |   2 +
 drivers/soc/mediatek/mtk-mutex.c       | 140 +++++++++++++++++++++++-
 include/linux/soc/mediatek/mtk-mmsys.h |  80 ++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h |   9 ++
 7 files changed, 401 insertions(+), 2 deletions(-)

-- 
2.18.0

