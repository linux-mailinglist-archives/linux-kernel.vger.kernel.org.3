Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817E584A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiG2Dvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiG2Dvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:51:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D07CB5B;
        Thu, 28 Jul 2022 20:51:39 -0700 (PDT)
X-UUID: 7b8fb5f6b6054ae9b4b432e5ec5e4d5b-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a50d1b30-8045-4e09-b1df-05fae615385b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:d1a6a5d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7b8fb5f6b6054ae9b4b432e5ec5e4d5b-20220729
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 924437438; Fri, 29 Jul 2022 11:51:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 11:51:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 11:51:30 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <nicolas.dufresne@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5, 0/8] Support H264 multi-core encoder on MT8195
Date:   Fri, 29 Jul 2022 11:51:21 +0800
Message-ID: <20220729035129.3634-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 has two H264 encoder hardware, named core0 and core1, this two
cores can encode two input frames separately at the same time to achieve
higher performance.

This series of patches are used to enable the two H264 encoder cores,
the difference between encoding process before and after enable two
cores is just like as below:
As-Is: Synchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder IRQ
-->
encoding done with result --> job_finish
V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder IRQ
-->
encoding done with result --> job_finish
...
To-Be: Asynchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
(venc core0 may encode done here, done the encoding result to client)
V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.

---
changes compared with v4:
- reabse to the newer linux media stage tree.
- remove "mediatek,venc-multi-core" property since sub-device can
  be probed by of_platform_populate api directly.
- some modifications for patch v4's review comments.

changes compared with v3:
- rebase to the newer linux media stage.
- add a capability to indicate scp firmware support multi-core.
- probe core0 as main device, core1 as sub-device.

changes compared with v2:
- update venc core dt-bindings, add two new properties for current
  usage.
- parse venc multi_core mode from device tree.
- rebase to the newer linux media stage.

changes compared with v1:
- of_platform_populate was used in place of the component framework.
- new yaml file for venc cores.
- some modifications for patch v1's review comments.
---

Irui Wang (8):
  dt-bindings: media: mediatek: vcodec: Adds encoder cores dt-bindings
    for mt8195
  media: mediatek: vcodec: Enable venc dual core usage
  media: mediatek: vcodec: Refactor venc power manage function
  media: mediatek: vcodec: Add more extra processing for multi-core
    encoding
  media: mediatek: vcodec: Add venc power on/off function
  media: mediatek: vcodec: Refactor encoder clock on/off function
  media: mediatek: vcodec: Add multi-core encoding process
  media: mediatek: vcodec: Return encoding result in asynchronous mode

 .../media/mediatek,vcodec-encoder-core.yaml   | 218 ++++++++++++++++
 .../media/mediatek,vcodec-encoder.yaml        |   1 -
 .../media/platform/mediatek/vcodec/Makefile   |   4 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  28 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 113 ++++++--
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  11 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  44 +++-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 156 +++++++++++
 .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  34 +++
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 178 +++++++++++--
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  11 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  19 ++
 .../mediatek/vcodec/mtk_vcodec_util.h         |   3 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 243 ++++++++++++++----
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   3 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |  75 ++++--
 .../platform/mediatek/vcodec/venc_drv_if.h    |   6 +
 .../platform/mediatek/vcodec/venc_vpu_if.c    |   9 +-
 .../platform/mediatek/vcodec/venc_vpu_if.h    |   3 +-
 19 files changed, 1028 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h

-- 
2.18.0

