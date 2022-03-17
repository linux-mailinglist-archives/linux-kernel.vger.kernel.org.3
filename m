Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEE4DC0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiCQIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiCQIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:23:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DAC1C64A3;
        Thu, 17 Mar 2022 01:22:41 -0700 (PDT)
X-UUID: d7b9917ac22e40a6933a7fed8d9c3227-20220317
X-UUID: d7b9917ac22e40a6933a7fed8d9c3227-20220317
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1592486316; Thu, 17 Mar 2022 16:22:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 16:22:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:22:32 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3, 00/10] Enable two H264 encoder core on MT8195
Date:   Thu, 17 Mar 2022 16:22:20 +0800
Message-ID: <20220317082230.23622-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 has two H264 encoder cores, they have their own power-domains,
clocks, interrupts, register base. The two H264 encoder cores can work
together to achieve higher performance, it's a core mode called
frame-racing, one core has 4K@30fps performance, two cores can achieve
4K@60fps.
The two encoder core encoding process looks like this:

    VENC Core0: frm#0....frm#2....frm#4....
    VENC Core1: ..frm#1....frm#3....frm#5....

This series of patches are used to enable the two H264 encoder cores,
encoding process will be changed:
As-Is: Synchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder IRQ -->
encoding done with result --> job_finish
V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder IRQ -->
encoding done with result --> job_finish
...

To-Be: Asynchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
(venc core0 may encode done here, done the encoding result to client)
V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.

There is no "wait encoder IRQ" synchronous call during frame-racing mode
encoding process, it can full use the two encoder cores to achieve higher
performance.

---
This series patches dependent on:
media_stage tree:
[1]
https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4

mt8192 decoder:
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=616991

patch3 new venc dt-bindings included files
[3] MM IOMMU binding:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/

[4] MT8195 power domain:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579

changes compared with v2:
- update venc core dt-bindings, add two new properties for current usage.
- parse venc multi_core mode from device tree.
- rebase to the newer linux media stage.

changes compared with v1:
- of_platform_populate was used in place of the component framework.
- new yaml file for venc cores.
- some modifications for patch v1's review comments.
---

Irui Wang (10):
  media: mtk-vcodec: Use core type to indicate h264 and vp8 enc
  media: mtk-vcodec: export encoder functions
  dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for
    mt8195
  media: mtk-vcodec: Enable venc dual core usage
  media: mtk-vcodec: mtk-vcodec: Rewrite venc power manage interface
  media: mtk-vcodec: Add venc power on/off interface
  media: mtk-vcodec: Rewrite venc clock interface
  media: mtk-vcodec: Add more extra processing for venc_multi_core mode
  media: mtk-vcodec: Add venc_multi_core mode encode process
  media: mtk-vcodec: Done encode result to client

 .../media/mediatek,vcodec-encoder-core.yaml   | 181 +++++++++++++++
 .../media/mediatek,vcodec-encoder.yaml        |   1 -
 drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  36 ++-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 113 +++++++---
 .../platform/mtk-vcodec/mtk_vcodec_enc.h      |   7 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 169 ++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 107 +++++----
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 183 +++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.h   |  11 +-
 .../platform/mtk-vcodec/mtk_vcodec_util.c     |  19 ++
 .../platform/mtk-vcodec/mtk_vcodec_util.h     |   5 +
 .../platform/mtk-vcodec/venc/venc_h264_if.c   | 212 +++++++++++++++---
 .../platform/mtk-vcodec/venc/venc_vp8_if.c    |   3 +-
 .../media/platform/mtk-vcodec/venc_drv_if.c   |  79 +++++--
 .../media/platform/mtk-vcodec/venc_drv_if.h   |   7 +
 .../media/platform/mtk-vcodec/venc_vpu_if.c   |  11 +-
 .../media/platform/mtk-vcodec/venc_vpu_if.h   |   3 +-
 19 files changed, 1026 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h

-- 
2.18.0

