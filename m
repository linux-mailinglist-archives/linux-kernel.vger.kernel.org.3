Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C764FB4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiDKH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbiDKH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:26:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8FE01C;
        Mon, 11 Apr 2022 00:24:15 -0700 (PDT)
X-UUID: 9542053b5d214051b767888afdabda70-20220411
X-UUID: 9542053b5d214051b767888afdabda70-20220411
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 93216145; Mon, 11 Apr 2022 15:24:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 15:24:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 15:24:05 +0800
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v14 0/6] Add mutex support for MDP
Date:   Mon, 11 Apr 2022 15:23:57 +0800
Message-ID: <20220411072403.24016-1-moudy.ho@mediatek.com>
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

Change since V14:
- Rebase on linux-next.
- Add new SOF and MOD table for general interface to integrate the requirement
  of different modules.
- Remove unnecessary MOD structure.
- By Rob Herring's suggestion, revise the description of
  "mediatek,gce-client-reg" in MUTEX dt-bindings.
- Delete the redundant definition of MTK_MUTEX_ENABLE and modify corresponding
  function.

Change since V13:
- Rebase on linux-next tag:next-20220316
- Adjust the MUTEX MOD table structure and corresponding functions.
- Adjust the definition style about 8183 MDP MOD.
- Remove redundant definitions and enumerations.
- Adjust the CMDQ operation in MUTEX to be backward compatible

Change since V12:
- Rebase on linux-next
- Remove ISP related settings in MMSYS
- Removed CMDQ operations previously used by MDP in MMSYS
- Move mediatek MUTEX dt-binding path
- Add additional property in MUTEX for CMDQ operations

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

Moudy Ho (6):
  soc: mediatek: mutex: add common interface to accommodate multiple
    modules operationg MUTEX
  soc: mediatek: mutex: add 8183 MUTEX MOD settings for MDP
  dt-bindings: soc: mediatek: move out common module from display folder
  dt-bindings: soc: mediatek: add gce-client-reg for MUTEX
  dts: arm64: mt8183: add GCE client property for Mediatek MUTEX
  soc: mediatek: mutex: add functions that operate registers by CMDQ

 .../mediatek/mediatek,mutex.yaml              |  14 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   1 +
 drivers/soc/mediatek/mtk-mutex.c              | 164 +++++++++++++++++-
 include/linux/soc/mediatek/mtk-mutex.h        |  23 +++
 4 files changed, 200 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,mutex.yaml (82%)

-- 
2.18.0

