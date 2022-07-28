Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D17583F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiG1MxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiG1MxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:53:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A053D59C;
        Thu, 28 Jul 2022 05:53:09 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F27356D;
        Thu, 28 Jul 2022 14:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659012788;
        bh=5LdV1rsx9QDBeHDyTBeBmy8DwsxHqzMNWJXEq1skaY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Prq3PmTcwGEH28JNMP5bHmGzORHfZh3XJ+Ts7xrJsJAb/YpajJDPOrZgGJK3IolPi
         ELtrHwAQVlydWL187wc76XUPrEJ6TB+HBhS/WQ02YtiWWPN/dv1hBBUsVE5SDoPKT0
         kCGQj0yYPTR/wbKiHeXkDlkswxacR3CUzK8JxhrI=
Date:   Thu, 28 Jul 2022 21:52:59 +0900
From:   paul.elder@ideasonboard.com
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: rkisp1: Add UYVY as an output format
Message-ID: <20220728125259.GL3984498@pyrite.rasen.tech>
References: <20220714112603.1117335-1-paul.elder@ideasonboard.com>
 <20220714112603.1117335-3-paul.elder@ideasonboard.com>
 <YtcwZSbXlSaaMjcd@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtcwZSbXlSaaMjcd@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Jul 20, 2022 at 01:29:57AM +0300, Laurent Pinchart wrote:
> Hi Paul,
> 
> Thank you for the patch.
> 
> On Thu, Jul 14, 2022 at 08:26:03PM +0900, Paul Elder wrote:
> > Add support for UYVY as an output format. The uv_swap bit in the
> > MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
> > work for packed YUV formats. Thus, UYVY support is implemented via
> > byte-swapping. This method clearly does not work for implementing
> > support for YVYU and VYUY.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > 
> > ---
> > UYVY for the self path has not been tested because no device supports
> > it. The rk3399 has a self path, but does not have the
> > MI_OUTPUT_ALIGN_FORMAT register and thus does not support UYVY. The
> > i.MX8MP does support UYVY, but does not have a self path.
> 
> I'm tempted to drop it then, as the code below isn't correct given that
> you use the same register for both MP and SP. Let's address MP only for
> now.

The same register is used for both MP and SP. They just have different
bits. Which is why we'd need the read-write cycle, assuming that there
exists a device that has both an SP and the MI_OUTPUT_ALIGN_FORMAT
register.


Paul

> 
> > ---
> >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > index 85fd85fe208c..77496ccef7ec 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > @@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
> >  		.uv_swap = 0,
> >  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> >  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_UYVY,
> > +		.uv_swap = 0,
> > +		.yc_swap = 1,
> > +		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> > +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> >  	}, {
> >  		.fourcc = V4L2_PIX_FMT_YUV422P,
> >  		.uv_swap = 0,
> > @@ -231,6 +237,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
> >  		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
> >  		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> >  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> > +	}, {
> > +		.fourcc = V4L2_PIX_FMT_UYVY,
> > +		.uv_swap = 0,
> > +		.yc_swap = 1,
> > +		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
> > +		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> > +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> >  	}, {
> >  		.fourcc = V4L2_PIX_FMT_YUV422P,
> >  		.uv_swap = 0,
> > @@ -464,6 +477,20 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
> >  		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
> >  	}
> >  
> > +	/*
> > +	 * uv swapping with the MI_XTD_FORMAT_CTRL register only works for
> 
> s@uv@U/V@
> 
> > +	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
> > +	 * YVYU and VYUY cannot be supported with this method.
> > +	 */
> > +	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> > +		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> > +		if (cap->pix.cfg->yc_swap)
> > +			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> > +		else
> > +			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> > +		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
> 
> As the register is not initialized anywhere, it would be better to write
> it fully here instead of a read-modify-write cycle. Same comments below.
> 
> > +	}
> > +
> >  	rkisp1_mi_config_ctrl(cap);
> >  
> >  	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> > @@ -505,6 +532,19 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
> >  		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
> >  	}
> >  
> > +	/*
> > +	 * uv swapping with the MI_XTD_FORMAT_CTRL register only works for
> > +	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
> > +	 * YVYU and VYUY cannot be supported with this method.
> > +	 */
> > +	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> > +		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> > +		if (cap->pix.cfg->yc_swap)
> > +			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
> > +		else
> > +			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
> > +		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
> > +	}
> 
> Missing blank line.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  	rkisp1_mi_config_ctrl(cap);
> >  
> >  	mi_ctrl = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
