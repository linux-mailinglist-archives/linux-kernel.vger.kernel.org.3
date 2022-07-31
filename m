Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9A58617B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiGaUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:55:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129263A7;
        Sun, 31 Jul 2022 13:55:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7C36B415;
        Sun, 31 Jul 2022 22:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659300944;
        bh=z/icKT+ON5rGVjV3cQOF9rm7J26cV7YZ1upIXjkT4Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRKDl5CWFyiu/lIHNsnj8p6f8yxrCWisd92TkIo90hhjXHZ9cgcD74QomFA1mqjby
         QTdbqeR+0Fp2YQjuIfTWCH20A7n8rXjd5QqGrWcI5w89CC40djiJaNRUlaTPmtCXQo
         GTfISRFqByInYlhivZpTeheWzV13RAX9PD1PzFWQ=
Date:   Sun, 31 Jul 2022 23:55:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: rkisp1: Add UYVY as an output format
Message-ID: <YubsTAmY/B9F1Dhy@pendragon.ideasonboard.com>
References: <20220728130505.2077842-1-paul.elder@ideasonboard.com>
 <20220728130505.2077842-3-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220728130505.2077842-3-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Thu, Jul 28, 2022 at 10:05:05PM +0900, Paul Elder wrote:
> Add support for UYVY as an output format. The uv_swap bit in the
> MI_XTD_FORMAT_CTRL register that is used for the NV formats does not
> work for packed YUV formats. Thus, UYVY support is implemented via
> byte-swapping. This method clearly does not work for implementing
> support for YVYU and VYUY.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> 
> ---
> Changes in v2:
> - s@uv@U/V@
> - SP has been kept (so, uh, *not* changed in v2)
> 
> UYVY for the self path has not been tested because no device supports
> it. The rk3399 has a self path, but does not have the
> MI_OUTPUT_ALIGN_FORMAT register and thus does not support UYVY. The
> i.MX8MP does support UYVY, but does not have a self path.
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index 9fb4879e65fa..0d5e3373e1f5 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -97,6 +97,12 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
>  		.uv_swap = 0,
>  		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_UYVY,
> +		.uv_swap = 0,
> +		.yc_swap = 1,
> +		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUVINT,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV422P,
>  		.uv_swap = 0,
> @@ -231,6 +237,13 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
>  		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
>  		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>  		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_UYVY,
> +		.uv_swap = 0,
> +		.yc_swap = 1,
> +		.write_format = RKISP1_MI_CTRL_SP_WRITE_INT,
> +		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> +		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUV422P,
>  		.uv_swap = 0,
> @@ -464,6 +477,20 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
>  		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
>  	}
>  
> +	/*
> +	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
> +	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
> +	 * YVYU and VYUY cannot be supported with this method.
> +	 */
> +	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> +		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> +		if (cap->pix.cfg->yc_swap)
> +			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> +		else
> +			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES;
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
> +	}

I dislike read-modify-write sequences when the register isn't fully
initialized to a known value somewhere. This issue applies to other
registers too, so we could fix it globally on top.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  	rkisp1_mi_config_ctrl(cap);
>  
>  	reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);
> @@ -505,6 +532,20 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
>  		rkisp1_write(rkisp1, RKISP1_CIF_MI_XTD_FORMAT_CTRL, reg);
>  	}
>  
> +	/*
> +	 * U/V swapping with the MI_XTD_FORMAT_CTRL register only works for
> +	 * NV12/NV21 and NV16/NV61, so instead use byte swap to support UYVY.
> +	 * YVYU and VYUY cannot be supported with this method.
> +	 */
> +	if (rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN) {
> +		reg = rkisp1_read(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT);
> +		if (cap->pix.cfg->yc_swap)
> +			reg |= RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
> +		else
> +			reg &= ~RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES;
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT, reg);
> +	}
> +
>  	rkisp1_mi_config_ctrl(cap);
>  
>  	mi_ctrl = rkisp1_read(rkisp1, RKISP1_CIF_MI_CTRL);

-- 
Regards,

Laurent Pinchart
