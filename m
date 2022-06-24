Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF955967D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiFXJY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiFXJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:24:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C26E788;
        Fri, 24 Jun 2022 02:24:10 -0700 (PDT)
X-UUID: f0a9b11c11b7421fbd23c714414def81-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:38bda913-4304-435b-8427-734c15509ba3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:7f3df42d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: f0a9b11c11b7421fbd23c714414def81-20220624
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1305827405; Fri, 24 Jun 2022 17:24:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 24 Jun 2022 17:24:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 24 Jun 2022 17:24:00 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
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
        <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Subject: [PATCH v19 0/4] media: mediatek: support mdp3 on mt8183 platform
Date:   Fri, 24 Jun 2022 17:23:55 +0800
Message-ID: <20220624092359.11908-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v18:
- Rebase on linux-next.
- Adjust copyright date of MDP3 driver.
- Functions renaming as follows:
  [1] is_output_disable() => is_output_disabled()
  [2] mdp_component_init() => mdp_comp_config()
  [3] mdp_component_deinit() => mdp_comp_destroy()
  [4] mdp_comp_ctx_init() => mdp_comp_ctx_config()
  [5] mdp_sub_comps_create() => mdp_comp_sub_create()
- Document MDP3 10-bit format descriptions in "mtk-mdp3-regs.c".
- Add error control for functions mdp_comp_clocks_on and mdp_comp_clock_on.
- Moved function "mtk_mutex_put" from function
  "mdp_comp_destroy"(renamed from mdp_component_deinit) to avoid semantic ambiguity.
- For some allocated parameters, assign a value of NULL after freeing
  to avoid the possibility of repeated use.
- Removed unnecessary timestamp pass flow.
- About parameters passed by the user in function "mdp_try_fmt_mplane", add relevant checks to
  clamp them in a reasonable range to avoid the possibility of overflow

Change since v17:
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=649104
- In response to future CMDQ api changes listed below:
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220608144055.27562-1-chunkuang.hu@kernel.org/
  adjust CMDQ flush and callback flow in MDP3.

Change since v16:
- Rebased on v5.19-rc1
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=646131
- In response to MUTEX changes, adjust API naming and parameters when
  used in function "mdp_path_subfrm_require".
- Remove unnecessary MDP3 phandle in 8183 dts.

Change since v15:
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=640926
- Split the bindings under ./soc/mediatek into a separate patch.
- Fix data abort in "mdp_auto_release_work"
- Adjust the steps in the function "mdp_cmdq_send" to make the error handling
  more reasonable

Change since v14:
- Rebase on v5.18-rc6
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=640926
- In response to CMDQ API change, replace the function "cmdq_pkt_flush_async"
  with the standard APIs of mbox
- Fix the description of "mediatek,gce-client-reg" property in MDP3-related
  bindings

Change since v13:
- Rebase on v5.18-rc4
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=636041
- Remove advanced functionality about ISP settings for direct link cases.
- Remove the software designation in the mt8183 dts and
  revise corresponding bindings.

Change since v12:
- Rebase on linux-next
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=630948
- Remove messages related to routing information in MDP3, and leave the related
  settings in MMSYS.
- Remove unnecessary phandle and redundant property in RDMA dt-binding and
  adjust the corresponding driver.
- Revise MDP3 node name in dts. 
- Removed unnecessary functions, mutex and work queue in MDP3 driver
- Fixed format mapping error for V4L2_PIX_FMT_RGB565X

Change since v11:
- Rebase on linux-next tag:next-20220316
- Depend on:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=624281
- Remove redundant hardware index in data-binding suggested by Rob Herring.
- Referring to Rob Herring's suggestion to improve some descriptions in the
  RDMA dt-binding
- Move MDP3 file folder from "./drive/media/platform/mtk-mdp3" to
  "./driver/media/platform/mediatek/mdp3"
- Fixed the V4L2 and MDP color format mapping error in RGB565 which
  checked by Benjamin Gaignard

Change since v10:
- The routing table needs to be discarded, and the calculation result
  on the SCP side is used to write a suitable mux setting for
  1 input port and 2 output ports.
- Adjust dts parsing flow to remove redundant HW IDs.
- Fix memory leak caused by no free path information in function "mdp_cmdq_send".

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
- fix compliance test fail item (m2m cmd with -f) due to there is two problem in
  runing all format(-f) cmd:
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

Hi,

This patch is used to present Media Data Path 3 (MDP3)
which provided scaling and color format conversion.
support using GCE to write register in critical time limitation.
support V4L2 m2m device control.

Moudy Ho (4):
  dt-binding: mediatek: add bindings for MediaTek MDP3 components
  dt-binding: mediatek: add bindings for MediaTek CCORR and WDMA
  arm64: dts: mt8183: add Mediatek MDP3 nodes
  media: platform: mtk-mdp3: add Mediatek MDP3 driver

 .../bindings/media/mediatek,mdp3-rdma.yaml    |  85 ++
 .../bindings/media/mediatek,mdp3-rsz.yaml     |  65 ++
 .../bindings/media/mediatek,mdp3-wrot.yaml    |  70 ++
 .../bindings/soc/mediatek/mediatek,ccorr.yaml |  58 +
 .../bindings/soc/mediatek/mediatek,wdma.yaml  |  71 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  79 +-
 drivers/media/platform/mediatek/Kconfig       |   1 +
 drivers/media/platform/mediatek/Makefile      |   1 +
 drivers/media/platform/mediatek/mdp3/Kconfig  |  20 +
 drivers/media/platform/mediatek/mdp3/Makefile |   6 +
 .../platform/mediatek/mdp3/mdp_reg_ccorr.h    |  19 +
 .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  65 ++
 .../platform/mediatek/mdp3/mdp_reg_rsz.h      |  39 +
 .../platform/mediatek/mdp3/mdp_reg_wdma.h     |  47 +
 .../platform/mediatek/mdp3/mdp_reg_wrot.h     |  55 +
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 290 +++++
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 527 ++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |  43 +
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 994 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    | 185 ++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 384 +++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  95 ++
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     | 769 ++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |  48 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 742 +++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    | 370 +++++++
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     | 312 ++++++
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |  78 ++
 28 files changed, 5517 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
 create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
 create mode 100644 drivers/media/platform/mediatek/mdp3/Makefile
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h

-- 
2.18.0

