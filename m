Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0554D265
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiFOUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFOUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:16:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3E4B86D;
        Wed, 15 Jun 2022 13:16:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 940A75A9;
        Wed, 15 Jun 2022 22:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655324178;
        bh=v1jkPA/EFojabfAV7CqrNhRRtf1nu53ymbo3OjQaZ+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAYDj2ecF7Wh3k/aBm0G8psU0EIBwv4jaVsp1cZ4ba8hgolUoANUU95Wur/tNquvL
         BcYLNq81dNw2GbgsDDtGcDCQwcl5Ks2g3SM5oOYeBfo58qVrDiw8VSp3XjJLnQjM/M
         UWVqDCnd+FDZKd4fbr0oCPP3TEWoGpeVQTA3eA/Q=
Date:   Wed, 15 Jun 2022 23:16:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, drinkcat@chromium.org, acourbot@chromium.org,
        pihsun@chromium.org, menghui.lin@mediatek.com,
        sj.huang@mediatek.com, ben.lok@mediatek.com, randy.wu@mediatek.com,
        srv_heupstream@mediatek.com, Rex-BC Chen <Rex-BC.Chen@mediatek.com>
Subject: Re: [V1] media: mtk-mdp3: Add Mediatek MDP3 Driver
Message-ID: <Yqo+CPSNDeqFLPGB@pendragon.ideasonboard.com>
References: <20210623091457.18002-1-moudy.ho@mediatek.com>
 <2735b66aef88ef5dc623702d27efc3a931d2fdd3.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2735b66aef88ef5dc623702d27efc3a931d2fdd3.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:55:14PM -0400, Nicolas Dufresne wrote:
> Le mercredi 23 juin 2021 à 17:14 +0800, Moudy Ho a écrit :
> > From: mtk18742 <moudy.ho@mediatek.com>
> > 
> > Add MDP3 driver for MT8183
> > 
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >  drivers/media/platform/Kconfig                |   17 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/mtk-mdp3/Makefile      |    9 +
> >  drivers/media/platform/mtk-mdp3/isp_reg.h     |   37 +
> >  .../media/platform/mtk-mdp3/mdp-platform.h    |   58 +
> >  .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   75 +
> >  .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |  206 +++
> >  drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |  109 ++
> >  .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |  125 ++
> >  .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |  115 ++
> >  .../media/platform/mtk-mdp3/mmsys_config.h    |  188 +++
> >  drivers/media/platform/mtk-mdp3/mmsys_mutex.h |   35 +
> >  .../media/platform/mtk-mdp3/mmsys_reg_base.h  |   38 +
> >  drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  282 ++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  538 ++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   53 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1437 +++++++++++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  157 ++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  266 +++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   86 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-debug.c  |  973 +++++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-debug.h  |   39 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  803 +++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   42 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  748 +++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  373 +++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  313 ++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   79 +
> >  28 files changed, 7203 insertions(+)
> >  create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
> >  create mode 100644 drivers/media/platform/mtk-mdp3/isp_reg.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp-platform.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_config.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_mutex.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_reg_base.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h

[snip]

> > diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
> > new file mode 100644
> > index 000000000000..0c4c942b5f9c
> > --- /dev/null
> > +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
> > @@ -0,0 +1,748 @@

[snip]

> > +static void mdp_prepare_buffer(struct img_image_buffer *b,
> > +			       struct mdp_frame *frame, struct vb2_buffer *vb)
> > +{
> > +	struct v4l2_pix_format_mplane *pix_mp = &frame->format.fmt.pix_mp;
> > +	unsigned int i;
> > +
> > +	b->format.colorformat = frame->mdp_fmt->mdp_color;
> > +	b->format.ycbcr_prof = frame->ycbcr_prof;
> > +	for (i = 0; i < pix_mp->num_planes; ++i) {
> > +		u32 stride = mdp_fmt_get_stride(frame->mdp_fmt,
> > +			pix_mp->plane_fmt[i].bytesperline, i);
> > +
> > +		b->format.plane_fmt[i].stride = stride;
> > +		/*
> > +		 * TODO(crbug.com/901264): The way to pass an offset within a
> > +		 * DMA-buf is not defined in V4L2 specification, so we abuse
> > +		 * data_offset for now. Fix it when we have the right interface,
> > +		 * including any necessary validation and potential alignment
> > +		 * issues.
> > +		 */
> > +		b->format.plane_fmt[i].size =
> > +			mdp_fmt_get_plane_size(frame->mdp_fmt, stride,
> > +					       pix_mp->height, i) -
> > +					       vb->planes[i].data_offset;
> > +		b->iova[i] = vb2_dma_contig_plane_dma_addr(vb, i) +
> > +			     vb->planes[i].data_offset;
> 
> As the comment says, data_offset is not valdiated at all for capture devices and
> is only validated so that (length - data_offset > 0) for OUTPUT devices. So this
> is going out of spec and leave the door open for buffer overflow triggered by
> users.

And as documented by the TODO comment, it's clearly an API abuse. This
can't go in as-is, we need to revive the v4l2_buffer extended API that
Boris used to work on.

> > +	}
> > +	for (; i < MDP_COLOR_GET_PLANE_COUNT(b->format.colorformat); ++i) {
> > +		u32 stride = mdp_fmt_get_stride_contig(frame->mdp_fmt,
> > +			b->format.plane_fmt[0].stride, i);
> > +
> > +		b->format.plane_fmt[i].stride = stride;
> > +		b->format.plane_fmt[i].size =
> > +			mdp_fmt_get_plane_size(frame->mdp_fmt, stride,
> > +					       pix_mp->height, i);
> > +		b->iova[i] = b->iova[i - 1] + b->format.plane_fmt[i - 1].size;
> > +	}
> > +	b->usage = frame->usage;
> > +}

-- 
Regards,

Laurent Pinchart
