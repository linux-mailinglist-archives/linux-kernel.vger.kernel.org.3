Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADAD4BF166
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiBVF3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:29:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBVF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:28:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181983DDF9;
        Mon, 21 Feb 2022 21:28:20 -0800 (PST)
X-UUID: 082f280e525446169deb59a2fe6a9060-20220222
X-UUID: 082f280e525446169deb59a2fe6a9060-20220222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 637108411; Tue, 22 Feb 2022 13:28:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Feb 2022 13:28:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Feb 2022 13:28:13 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jassisinghbrar@gmail.com>, <fparent@baylibre.com>,
        <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v4,0/5] add display support for MediaTek SoC MT8186
Date:   Tue, 22 Feb 2022 13:27:58 +0800
Message-ID: <20220222052803.3570-1-rex-bc.chen@mediatek.com>
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

v4:
1. Remove binding of dsi and dpi.
2. Revise aal binding.
3. Fix indention in [4/5].

v3:
1. Modify display binding based on mtk display binding patch. ([1])
2. Remove patch: drm/mediatek: separate postmask component from mtk_disp_drv.c
3. Remove compatible of 8186 ovl because we can re-use compatible of 8192 for 8186.
4. Fix issue of space before tab on mutex patch.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-drm-next&id=4ed545e7d10049b5492afc184e61a67e478a2cfd

v2:
1. Add binding documentation for mmsys, mutex and mtk_display.
2. Remove duplicated definition of postmask registers on mtk_drm_drv.
3. Add disp_ovl support for MT8186.
4. Add detailed commit messages.

Rex-BC Chen (2):
  dt-bindings: arm: mediatek: mmsys: add support for MT8186
  dt-bindings: display: mediatek: add MT8186 SoC binding

Yongqiang Niu (3):
  soc: mediatek: mmsys: add mt8186 mmsys routing table
  soc: mediatek: add MTK mutex support for MT8186
  drm/mediatek: add display support for MT8186

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,aal.yaml        |   7 ++
 .../display/mediatek/mediatek,ccorr.yaml      |   5 +
 .../display/mediatek/mediatek,color.yaml      |   1 +
 .../display/mediatek/mediatek,dither.yaml     |   1 +
 .../display/mediatek/mediatek,gamma.yaml      |   1 +
 .../display/mediatek/mediatek,mutex.yaml      |   2 +
 .../display/mediatek/mediatek,ovl-2l.yaml     |   5 +
 .../display/mediatek/mediatek,ovl.yaml        |   5 +
 .../display/mediatek/mediatek,postmask.yaml   |   5 +
 .../display/mediatek/mediatek,rdma.yaml       |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  33 +++++
 drivers/soc/mediatek/mt8186-mmsys.h           | 113 ++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  11 ++
 drivers/soc/mediatek/mtk-mutex.c              |  45 +++++++
 15 files changed, 236 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8186-mmsys.h

-- 
2.18.0

