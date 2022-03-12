Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335AC4D6DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 10:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiCLJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 04:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCLJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 04:06:05 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE71CB1A;
        Sat, 12 Mar 2022 01:04:55 -0800 (PST)
X-UUID: d3079cd252624080918f1cf081f23ddd-20220312
X-UUID: d3079cd252624080918f1cf081f23ddd-20220312
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1592565272; Sat, 12 Mar 2022 17:04:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Mar 2022 17:04:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Mar 2022 17:04:44 +0800
Message-ID: <bbb93172627649a7f8f3ddaa58f0d6a7ed24a733.camel@mediatek.com>
Subject: Re: [PATCH v2, 04/10] media: mtk-vcodec: Enable venc dual core usage
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>
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
Date:   Sat, 12 Mar 2022 17:03:40 +0800
In-Reply-To: <d92c6083-9d87-8eca-c760-f5a6f05f13b2@collabora.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
         <20220117120615.21687-5-irui.wang@mediatek.com>
         <3eaa4c05-f8f2-9e18-e6d9-a627fe5e1e40@collabora.com>
         <0b7f30b6eabb54fa894dcffea5827023ffdd58ee.camel@mediatek.com>
         <d92c6083-9d87-8eca-c760-f5a6f05f13b2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Angelo,

thanks for your review comments. I will update my new device tree,
example inline:

On Fri, 2022-03-04 at 10:07 +0100, AngeloGioacchino Del Regno wrote:
> Il 04/03/22 03:12, Irui Wang ha scritto:
> > Hello, Angelo,
> > 
> > Many thanks for your review.
> > 
> > On Thu, 2022-03-03 at 15:27 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 17/01/22 13:06, Irui Wang ha scritto:
> > > > Adds new venc core mode to indicate different venc hardware
> > > > mode:
> > > > VENC_SINGLE_CORE_MODE means only one core, the device has its
> > > > own
> > > > power/clk/irq, init_clk/request_irq helper can be used.
> > > > 
> > > > VENC_DUAL_CORE_MODE means more than one core inside, the core
> > > > device
> > > > can use the init_clk/request_irq helper to initialize their own
> > > > power/clk/irq. And the main device doesn't need use these
> > > > helper
> > > > anymore.
> > > > 
> > > > MT8195 has two H264 venc cores, enable dual_core_mode for it.
> > > > 
> > > > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > > > ---
> > > >    drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
> > > >    .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  22 +++
> > > >    .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 153
> > > > ++++++++++++++++++
> > > >    .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++++
> > > >    .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  88 +++++---
> > > > --
> > > >    5 files changed, 266 insertions(+), 37 deletions(-)
> > > >    create mode 100644 drivers/media/platform/mtk-
> > > > vcodec/mtk_vcodec_enc_core.c
> > > >    create mode 100644 drivers/media/platform/mtk-
> > > > vcodec/mtk_vcodec_enc_core.h
> > > > 
> > > > diff --git a/drivers/media/platform/mtk-vcodec/Makefile
> > > > b/drivers/media/platform/mtk-vcodec/Makefile
> > > > index 93e7a343b5b0..c472b221bd6b 100644
> > > > --- a/drivers/media/platform/mtk-vcodec/Makefile
> > > > +++ b/drivers/media/platform/mtk-vcodec/Makefile
> > > > @@ -3,7 +3,8 @@
> > > >    obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
> > > >    				       mtk-vcodec-enc.o \
> > > >    				       mtk-vcodec-common.o \
> > > > -				       mtk-vcodec-dec-hw.o
> > > > +				       mtk-vcodec-dec-hw.o \
> > > > +				       mtk-vcodec-enc-core.o
> > > >    
> > > >    mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
> > > >    		vdec/vdec_vp8_if.o \
> > > > @@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
> > > >    		venc_drv_if.o \
> > > >    		venc_vpu_if.o \
> > > >    
> > > > +mtk-vcodec-enc-core-y := mtk_vcodec_enc_core.o
> > > >    
> > > >    mtk-vcodec-common-y := mtk_vcodec_intr.o \
> > > >    		mtk_vcodec_util.o \
> > > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > > index f78463ff4551..9e4e4290a69a 100644
> > > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > > @@ -117,6 +117,23 @@ enum mtk_vdec_hw_count {
> > > >    	MTK_VDEC_MAX_HW_COUNT,
> > > >    };
> > > >    
> > > > +/*
> > > > + * enum mtk_venc_core_id -- encoder core id
> > > > + */
> > > > +enum mtk_venc_core_id {
> > > > +	MTK_VENC_CORE0 = 0,
> > > > +	MTK_VENC_CORE1 = 1,
> > > 
> > > You don't have to say "= 1" for core1, just...
> > > 
> > > 	MTK_VENC_CORE0 = 0,
> > > 	MTK_VENC_CORE1,
> > > 
> > > ...is fine, and better.
> > 
> > I will fix it.
> > 
> > > 
> > > > +	MTK_VENC_CORE_MAX,
> > > > +};
> > > > +
> > > > +/**
> > > > + * enmu mtk_venc_core_mode - Used to indicate different encode
> > > > mode
> > > > + */
> > > > +enum mtk_venc_core_mode {
> > > > +	VENC_SINGLE_CORE_MODE = 0,
> > > > +	VENC_DUAL_CORE_MODE = 1,
> > > > +};
> > > > +
> > > >    /*
> > > >     * struct mtk_video_fmt - Structure used to store
> > > > information
> > > > about pixelformats
> > > >     */
> > > > @@ -420,6 +437,7 @@ struct mtk_vcodec_dec_pdata {
> > > >     * @output_formats: array of supported output formats
> > > >     * @num_output_formats: number of entries in output_formats
> > > >     * @core_type: stand for h264 or vp8 encode
> > > > + * @core_mode: indicate encode core mode
> > > >     */
> > > >    struct mtk_vcodec_enc_pdata {
> > > >    	bool uses_ext;
> > > > @@ -430,6 +448,7 @@ struct mtk_vcodec_enc_pdata {
> > > >    	const struct mtk_video_fmt *output_formats;
> > > >    	size_t num_output_formats;
> > > >    	int core_type;
> > > > +	enum mtk_venc_core_mode core_mode;
> > > >    };
> > > >    
> > > >    #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata-
> > > > > uses_ext)
> > > > 
> > > > @@ -479,6 +498,7 @@ struct mtk_vcodec_enc_pdata {
> > > >     * @subdev_dev: subdev hardware device
> > > >     * @subdev_prob_done: check whether all used hw device is
> > > > prob
> > > > done
> > > >     * @subdev_bitmap: used to record hardware is ready or not
> > > > + * @enc_core_dev: used to store venc core device
> > > >     */
> > > >    struct mtk_vcodec_dev {
> > > >    	struct v4l2_device v4l2_dev;
> > > > @@ -524,6 +544,8 @@ struct mtk_vcodec_dev {
> > > >    	void *subdev_dev[MTK_VDEC_HW_MAX];
> > > >    	int (*subdev_prob_done)(struct mtk_vcodec_dev
> > > > *vdec_dev);
> > > >    	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
> > > > +
> > > > +	void *enc_core_dev[MTK_VENC_CORE_MAX];
> > > >    };
> > > >    
> > > >    static inline struct mtk_vcodec_ctx *fh_to_ctx(struct
> > > > v4l2_fh
> > > > *fh)
> > > > diff --git a/drivers/media/platform/mtk-
> > > > vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-
> > > > vcodec/mtk_vcodec_enc_core.c
> > > > new file mode 100644
> > > > index 000000000000..d84914f615a5
> > > > --- /dev/null
> > > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
> > > > @@ -0,0 +1,153 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2021 MediaTek Inc.
> > > > + */
> > > > +
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +#include "mtk_vcodec_drv.h"
> > > > +#include "mtk_vcodec_enc.h"
> > > > +#include "mtk_vcodec_enc_core.h"
> > > > +
> > > > +static const struct of_device_id mtk_venc_core_ids[] = {
> > > > +	{
> > > > +		.compatible = "mediatek,mtk-venc-core0",
> > > > +		.data = (void *)MTK_VENC_CORE0,
> > > > +	},
> > > > +	{
> > > > +		.compatible = "mediatek,mtk-venc-core1",
> > > > +		.data = (void *)MTK_VENC_CORE1,
> > > > +	},
> > > > +	{},
> > > > +};
> > > 
> > > Hello Irui,
> > > 
> > > You don't need a different compatible for the different cores, as
> > > in
> > > the
> > > declaration, there's nothing special that differentiates them
> > > that
> > > much.
> > > 
> > > I understand that there may be a need to differentiate the core
> > > number, as
> > > in, CORE0 always has to be the leader, while CORE1 would be the
> > > follower,
> > > but this is not a good reason to give them a different compatible
> > > string.
> > > 
> > > I want to make you aware that Kyrie Wu did the same thing as you
> > > did
> > > here
> > > and in my review on his patch I was able to give an extensive
> > > example
> > > of
> > > how this should look; the exactly same logic would apply to this
> > > patch.
> > > 
> > > Please have a look here:
> > > https://patchwork.kernel.org/comment/24726607/
> > > 
> > > P.S.: In short, you should have only one "mediatek,mtk-venc-hw"
> > > compatible
> > >         used for probing both cores.
> > 
> > thanks for your suggestions, with your example, venc can be
> > rewritten
> > like this:
> > venc {
> >      compatible = "mediatek,mt8195-vcodec-enc";
> >      ..... other properties .....
> > 
> >      venc_core0 {
> >          compatible = "mediatek,mtk-venc-hw";
> >          mediatek,hw-leader;//mediatek,venc-core0;
> >          ..... other properties .....
> >      };
> > 
> >      venc_core1 {
> >          compatible = "mediatek,mtk-venc-hw";
> >          //mediatek,venc-core1;
> >          ..... other properties .....
> >      };
> > };
> > I will rewrite this code if it matches your suggestions.
> 
> Yes, exactly. Just one nit, please don't use underscores.
> 
> venc_core0: venc-hw@(addr)
> this is fine ^
> 
> venc_core0: venc_hw@(addr)
> this is NOT ok ^^
> 
> By the way, one (or more than one) of the commits in this series
> is not working correctly, giving a kernel panic on dma mem alloc.
> 
> Looking forward to see the new version!
> 
> Regards,
> Angelo

We add a new property "mediatek,core-id" to indicite current encoder
core id. 

if we enable the two encoder cores, it will need more dma mem buffers
for encoding, in patch-08 add a new venc-vsi to store these encoding
working buffers, both kernel and user side need update the venc-vsi,
otherwise, we will get a panic on mem alloc.

There are still some encoding issues after apply the device tree, we
still working on it, and we will send a new version patches once wesolve them. 

Thanks
Best Regards

example dtsi
soc {
    #address-cells = <2>;
    #size-cells = <2>;

    venc {
        compatible = "mediatek,mt8195-vcodec-enc";
        mediatek,scp = <&scp>;
        iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>;
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;
        dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;

        venc-core@1a020000 {
             compatible = "mediatek,mtk-venc-core";
             reg = <0 0x1a020000 0 0x10000>;
             mediatek,core-id = <0>;
             iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
                     <&iommu_vdo M4U_PORT_L19_VENC_REC>,
                     <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
                     <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
                     <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
                     <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
                     <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
             interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
             clocks = <&vencsys CLK_VENC_VENC>;
             clock-names = "clk_venc";
             assigned-clocks = <&topckgen CLK_TOP_VENC>;
             assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
             power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
        };

        venc-core@1b020000 {
             compatible = "mediatek,mtk-venc-core";
             reg = <0 0x1b020000 0 0x10000>;
             mediatek,core-id = <1>;
             iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
                      <&iommu_vpp M4U_PORT_L20_VENC_REC>,
                      <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
                      <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
                      <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
                      <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
                      <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
                      <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
                      <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
             interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
             clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
             clock-names = "clk_venc_core1";
             assigned-clocks = <&topckgen CLK_TOP_VENC>;
             assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
             power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
        };
    };
};

