Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A449F21F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbiA1DzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:55:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40692 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345889AbiA1Dy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:54:57 -0500
X-UUID: 88e879716cbf42399dbd58bcfe02dd7c-20220128
X-UUID: 88e879716cbf42399dbd58bcfe02dd7c-20220128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1917609676; Fri, 28 Jan 2022 11:54:45 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 11:54:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 11:54:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 11:54:41 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 0/7] support mt8195 decoder
Date:   Fri, 28 Jan 2022 11:54:33 +0800
Message-ID: <20220128035440.24533-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, add mt8195 soc lat hardware and compatible, then add documents.
For vp8 only support MM21 mode, H264/vp9 support MT21C, need to separate
them. Lastly, enable H264 inner racing mode to reduce hardware latency.

Patch 1~4 add mt8195 soc lat hardware and compatible, then add documents.
Patch 5 using different format for different codecs.
Patch 6 prevent kernel crash when scp reboot.
Patch 7 enable H264 inner racing mode to reduce hardware latency.
---
This patch depends on "support mt8186 decoder"[1]

[1]  https://patchwork.kernel.org/project/linux-mediatek/cover/20220122075606.19373-1-yunfei.dong@mediatek.com
---
changed with v1:
- separate "Init VP9 stateless decode params" patch and remove it to another one.
- add reviewed-by in patch v3/v4/v6
---
Tinghan Shen (1):
  media: mtk-vcodec: prevent kernel crash when scp ipi timeout

Yunfei Dong (6):
  dt-bindings: media: mtk-vcodec: Adds decoder dt-bindings for lat soc
  media: mtk-vcodec: Add to support lat soc hardware
  dt-bindings: media: mtk-vcodec: Adds decoder dt-bindings for mt8195
  media: mtk-vcodec: Adds compatible for mt8195
  media: mtk-vcodec: Different codec using different capture format
  media: mtk-vcodec: Add to support H264 inner racing mode

 .../media/mediatek,vcodec-subdev-decoder.yaml | 50 +++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 41 +++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  8 +++
 .../platform/mtk-vcodec/mtk_vcodec_dec_hw.c   | 12 +++--
 .../platform/mtk-vcodec/mtk_vcodec_dec_hw.h   |  2 +
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 50 +++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 11 ++++
 .../mtk-vcodec/vdec/vdec_h264_req_multi_if.c  | 23 +++++++--
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   |  5 ++
 9 files changed, 194 insertions(+), 8 deletions(-)

-- 
2.25.1

