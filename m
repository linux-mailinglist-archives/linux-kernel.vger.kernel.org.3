Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC454C0C67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiBWGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiBWGGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:06:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6645B3CE;
        Tue, 22 Feb 2022 22:06:22 -0800 (PST)
X-UUID: 0387d5c6fb8544c8b313e2d5a2f8024f-20220223
X-UUID: 0387d5c6fb8544c8b313e2d5a2f8024f-20220223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1005719897; Wed, 23 Feb 2022 14:06:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Feb 2022 14:06:15 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 14:06:13 +0800
Message-ID: <bc7d9d90aae903ac95e952d74a15105f51f03542.camel@mediatek.com>
Subject: Re: [PATCH v2, 00/10] Enable two H264 encoder cores on MT8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 23 Feb 2022 14:06:13 +0800
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all maintainers,

Gently ping.

Could you help to review this series of patches? 
I would be very grateful for any of your comments.

Thanks
Best Regards
On Mon, 2022-01-17 at 20:06 +0800, Irui Wang wrote:
> MT8195 has two H264 encoder cores, they have their own power-domains,
> clocks, interrupts, register base. The two H264 encoder cores can
> work
> together to achieve higher performance, it's a core mode called
> frame-racing, one core has 4K@30fps performance, two cores can
> achieve
> 4K@60fps.
> The two encoder core encoding process looks like this:
> 
>     VENC Core0: frm#0....frm#2....frm#4....
>     VENC Core1: ..frm#1....frm#3....frm#5....
> 
> This series of patches are used to enable the two H264 encoder cores,
> encoding process will be changed:
> As-Is: Synchronous
> V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder
> IRQ -->
> encoding done with result --> job_finish
> V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder
> IRQ -->
> encoding done with result --> job_finish
> ...
> 
> To-Be: Asynchronous
> V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
> ..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
> (venc core0 may encode done here, done the encoding result to client)
> V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.
> 
> There is no "wait encoder IRQ" synchronous call during frame-racing
> mode
> encoding process, it can full use the two encoder cores to achieve
> higher
> performance.
> 
> ---
> This series patches dependent on:
> [1]: the latest linux stage tree: 
> https://git.linuxtv.org/media_stage.git
> 
> mtk decoder patches
> [2]: 
> https://patchwork.linuxtv.org/project/linux-media/list/?series=7105
> [3]: 
> https://patchwork.linuxtv.org/project/linux-media/list/?series=7131
> 
> new yaml included files
> [4]:
> 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=551641
> [5]:
> 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579
> 
> ---
> ---
> changes compared with v1:
> - of_platform_populate was used in place of the component framework.
> - new yaml file for venc cores.
> - some modifications for patch v1's review comments.
> ---
> 
> Irui Wang (10):
>   media: mtk-vcodec: Use core type to indicate h264 and vp8 enc
>   media: mtk-vcodec: export encoder functions
>   dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for
>     mt8195
>   media: mtk-vcodec: Enable venc dual core usage
>   media: mtk-vcodec: mtk-vcodec: Rewrite venc power manage interface
>   media: mtk-vcodec: Add venc power on/off interface
>   media: mtk-vcodec: Rewrite venc clock interface
>   media: mtk-vcodec: Add more extra processing for dual-core mode
>   media: mtk-vcodec: Add dual core mode encode process
>   media: mtk-vcodec: Done encode result to client
> 
>  .../media/mediatek,vcodec-encoder-core.yaml   | 214
> +++++++++++++++++
>  drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  44 +++-
>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 109 ++++++---
>  .../platform/mtk-vcodec/mtk_vcodec_enc.h      |   7 +-
>  .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 187 +++++++++++++++
>  .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++
>  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 118 ++++++----
>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 187 +++++++++++++--
>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.h   |  11 +-
>  .../platform/mtk-vcodec/mtk_vcodec_util.c     |  19 ++
>  .../platform/mtk-vcodec/mtk_vcodec_util.h     |   5 +
>  .../platform/mtk-vcodec/venc/venc_h264_if.c   | 216 +++++++++++++++-
> --
>  .../platform/mtk-vcodec/venc/venc_vp8_if.c    |   3 +-
>  .../media/platform/mtk-vcodec/venc_drv_if.c   |  79 +++++--
>  .../media/platform/mtk-vcodec/venc_drv_if.h   |   7 +
>  .../media/platform/mtk-vcodec/venc_vpu_if.c   |  10 +-
>  .../media/platform/mtk-vcodec/venc_vpu_if.h   |   3 +-
>  18 files changed, 1097 insertions(+), 162 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> core.yaml
>  create mode 100644 drivers/media/platform/mtk-
> vcodec/mtk_vcodec_enc_core.c
>  create mode 100644 drivers/media/platform/mtk-
> vcodec/mtk_vcodec_enc_core.h
> 

