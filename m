Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B49465E32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbhLBGbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:31:04 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52970 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231690AbhLBGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:31:01 -0500
X-UUID: c1d45c09562a45fa825fe8e733dc11f8-20211202
X-UUID: c1d45c09562a45fa825fe8e733dc11f8-20211202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 706566197; Thu, 02 Dec 2021 14:27:35 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Dec 2021 14:27:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Dec
 2021 14:27:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 14:27:34 +0800
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
        <srv_heupstream@mediatek.com>
Subject: [PATCH v10 0/3] media: mediatek: support mdp3 on mt8183 platform
Date:   Thu, 2 Dec 2021 14:27:30 +0800
Message-ID: <20211202062733.20338-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v9:
- Keep only the MDP3 driver patches and split the remaining mmsys and
  mutex patches into another mail.
- Move mutex mod settings to corresponding driver and make relevant adjustments
  for this in MDP3 driver.
- Fix compile warning reported by kernel test robot.

Change since v8:
- Rebase on v5.16-rc2.
- Refer to Angelo's suggestion, adjust the register writing format to increase
  readability and significance.
- Refer to Angelo's suggestion, adjust or reduce inappropriate debugging
  messages.
- Refer to Rob Herring's suggestion to correct the the binding file
  to make it with the specification.
- Fix compile warning reported by kernel test robot.

Change since v7:
- Rebase on v5.15-rc6.
- Revise several V4L2 M2M settings to pass v4l2-compliance test.
- Integrate those same component dt-binding documents of DRM and MDP, and
  move them under the MMSYS domain.
- Split MMSYS and MUTEX into two different files according to
  their functional properties.

Changes since v6:
- Refactor GCE event to corresponding node.
- Fix dt_binding_check fail.
- Fix compilation errors.

Changes since v5:
- Rebase on v5.14-rc6.
- Move MMSYS/Mutex settings to corresponding driver.
- Revise the software license description and copyright.
- Remove unnecessary enum. or definitions.
- Optimize platform/chip definition conditions.
- Use general printing functions instead of MDP3 private ones.
- Fix compile warning.

Changes since v4:
- Rebase on v5.13-rc1.
- Remove the CMDQ flush flow to match the CMDQ API change.
- Integrate four of MDP's direct-link subcomponents into MDP controller node
  from syscon node to avoid illegal clock usage.
- Rewrite dt-binding in a JSON compatible subset of YAML
- Fix a bit of macro argument precedence.

Changes since v3:
- Rebase on v5.9-rc1.
- modify code for review comment from Rob Herring, cancel multiple nodes using
  same register base situation.
- control IOMMU port through pm runtime get/put to DMA components' device.
- SCP(VPU) driver revision.
- stop queuing jobs(remove flush_workqueue()) after mdp_m2m_release().
- add computation of plane address with data_offset.
- fix scale ratio check issue.
- add default v4l2_format setting.

Changes since v2:
- modify code for review comment from Tomasz Figa & Alexandre Courbot
- review comment from Rob Herring will offer code revision in v4, due to
  it's related to device node modification, will need to modify code
  architecture

Changes since v1:
- modify code for CMDQ v3 API support
- EC ipi cmd migration
- fix compliance test fail item (m2m cmd with -f) due to there is two problem in runing all format(-f) cmd:
1. out of memory before test complete
        Due to capture buffer mmap (refcount + 1) after reqbuf but seems
        no corresponding munmap called before device close.
        There are total 12XX items(formats) in format test and each format
        alloc 8 capture/output buffers.
2. unceasingly captureBufs() (randomly)
        Seems the break statement didn't catch the count == 0 situation:
        In v4l2-test-buffers.cpp, function: captureBufs()
                        ...
                        count--;
                        if (!node->is_m2m && !count)
                                break;
        Log is as attachment

I will paste the test result with problem part in another e-mail

Hi,

This is the first version of RFC patch for Media Data Path 3 (MDP3),
MDP3 is used for scaling and color format conversion.
support using GCE to write register in critical time limitation.
support V4L2 m2m device control.

Moudy Ho (3):
  dt-binding: mt8183: add Mediatek MDP3 dt-bindings
  dts: arm64: mt8183: add Mediatek MDP3 nodes
  media: platform: mtk-mdp3: add Mediatek MDP3 driver

 .../bindings/media/mediatek,mdp3-rsz.yaml     |   65 +
 .../bindings/media/mediatek,mdp3-wrot.yaml    |   67 +
 .../bindings/soc/mediatek/mediatek,ccorr.yaml |   57 +
 .../bindings/soc/mediatek/mediatek,rdma.yaml  |  216 +++
 .../bindings/soc/mediatek/mediatek,wdma.yaml  |   68 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  115 +-
 drivers/media/platform/Kconfig                |   19 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/mtk-mdp3/Makefile      |    6 +
 .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   19 +
 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h |   27 +
 .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   65 +
 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |   39 +
 .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |   47 +
 .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   55 +
 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  280 ++++
 .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  505 +++++++
 .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   46 +
 .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1264 +++++++++++++++++
 .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  147 ++
 .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  338 +++++
 .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   76 +
 .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  789 ++++++++++
 .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   49 +
 .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  737 ++++++++++
 .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  372 +++++
 .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  312 ++++
 .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   78 +
 28 files changed, 5859 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
 create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
 create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h

-- 
2.18.0

