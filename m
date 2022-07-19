Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052E57A9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiGSWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiGSWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:24:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BFB5FAF9;
        Tue, 19 Jul 2022 15:24:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C85CD6DB;
        Wed, 20 Jul 2022 00:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658269447;
        bh=XnUcNSBSkdkmpcW8sYsoDRMcQ6OtfsNPSlCrDwuDGUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtROVuKbZFS05aqr63BImFVKVJxfdcNhv4rbcHoK8N9dwD9cRhc+Fg6iAYdPiWh2r
         P21zs+CAjAWbRfaQJuorL2Xa7m+yuooWj/jQbT0dck04fqV3/fgjDd1zfaUP7Fy7wg
         41zCnAfYcKOZ8ypGzcT0Dwkidv/7aT7f2RuCeifE=
Date:   Wed, 20 Jul 2022 01:23:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: rkisp1: Add YC swap capability
Message-ID: <Ytcu5UqMfOPfkHEu@pendragon.ideasonboard.com>
References: <20220714112603.1117335-1-paul.elder@ideasonboard.com>
 <20220714112603.1117335-2-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714112603.1117335-2-paul.elder@ideasonboard.com>
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

On Thu, Jul 14, 2022 at 08:26:02PM +0900, Paul Elder wrote:
> The ISP version in the i.MX8MP has an MI_OUTPUT_ALIGN_FORMAT register
> that the rk3399 does not have. This register allows swapping bytes,
> which can be used to implement UYVY from YUYV.
> 
> Add a feature flag to signify the presence of this feature, and add it
> to the i.MX8MP match data. Also add it as a flag to the format info in
> the list of supported formats by the capture v4l2 devices, and update
> enum_fmt and s_fmt to take it into account.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 27 ++++++++++++++-----
>  .../platform/rockchip/rkisp1/rkisp1-common.h  |  1 +
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  3 ++-
>  3 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index c494afbc21b4..85fd85fe208c 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -47,13 +47,15 @@ enum rkisp1_plane {
>   * @fourcc: pixel format
>   * @fmt_type: helper filed for pixel format
>   * @uv_swap: if cb cr swapped, for yuv
> + * @yc_swap: if y and cb/cr swapped, for yuv
>   * @write_format: defines how YCbCr self picture data is written to memory
>   * @output_format: defines sp output format
>   * @mbus: the mbus code on the src resizer pad that matches the pixel format
>   */
>  struct rkisp1_capture_fmt_cfg {
>  	u32 fourcc;
> -	u8 uv_swap;
> +	u32 uv_swap : 1;
> +	u32 yc_swap : 1;
>  	u32 write_format;
>  	u32 output_format;
>  	u32 mbus;
> @@ -1150,9 +1152,13 @@ static const struct rkisp1_capture_fmt_cfg *
>  rkisp1_find_fmt_cfg(const struct rkisp1_capture *cap, const u32 pixelfmt)
>  {
>  	unsigned int i;
> +	bool yc_swap_support =
> +		cap->rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN;

Could you move this before the previous line ?

I'm tempted to write a patch at some point that will simplify this with
a rkisp1_has_feature() that will... scratch that,
https://lore.kernel.org/linux-media/20220719221751.4159-1-laurent.pinchart@ideasonboard.com
:-) Could you rebase for v2 ?

>  
>  	for (i = 0; i < cap->config->fmt_size; i++) {
> -		if (cap->config->fmts[i].fourcc == pixelfmt)
> +		const struct rkisp1_capture_fmt_cfg *fmt = &cap->config->fmts[i];

Missing blank line. I thought checkpatch.pl would warn about this.

> +		if (fmt->fourcc == pixelfmt &&
> +		    (!fmt->yc_swap || yc_swap_support))
>  			return &cap->config->fmts[i];
>  	}
>  	return NULL;
> @@ -1223,22 +1229,29 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
>  	struct rkisp1_capture *cap = video_drvdata(file);
>  	const struct rkisp1_capture_fmt_cfg *fmt = NULL;
>  	unsigned int i, n = 0;
> +	bool yc_swap_support =
> +		cap->rkisp1->info->features & RKISP1_FEATURE_MI_OUTPUT_ALIGN;
>  
> -	if (!f->mbus_code) {
> -		if (f->index >= cap->config->fmt_size)
> -			return -EINVAL;
> +	if (f->index >= cap->config->fmt_size)
> +		return -EINVAL;
>  
> +	if (!f->mbus_code && yc_swap_support) {
>  		fmt = &cap->config->fmts[f->index];
>  		f->pixelformat = fmt->fourcc;
>  		return 0;
>  	}

I'm tempted to drop this optimization, as it makes the code more complex
and only brings a small improvement to an ioctl that shouldn't be in a
hot path, but that's up to you.

>  
>  	for (i = 0; i < cap->config->fmt_size; i++) {
> -		if (cap->config->fmts[i].mbus != f->mbus_code)
> +		fmt = &cap->config->fmts[i];
> +
> +		if (!!f->mbus_code && fmt->mbus != f->mbus_code)

You can s/!!//

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			continue;
> +
> +		if (!yc_swap_support && fmt->yc_swap)
>  			continue;
>  
>  		if (n++ == f->index) {
> -			f->pixelformat = cap->config->fmts[i].fourcc;
> +			f->pixelformat = fmt->fourcc;
>  			return 0;
>  		}
>  	}
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 38be565341d6..b0f9221a1922 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -119,6 +119,7 @@ enum rkisp1_feature {
>  	RKISP1_FEATURE_MAIN_STRIDE = BIT(3),
>  	RKISP1_FEATURE_DMA_34BIT = BIT(4),
>  	RKISP1_FEATURE_SELF_PATH = BIT(5),
> +	RKISP1_FEATURE_MI_OUTPUT_ALIGN = BIT(6),
>  };
>  
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 3b549c07a9bb..a475933820fd 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -520,7 +520,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
>  	.isp_ver = IMX8MP_V10,
>  	.features = RKISP1_FEATURE_RSZ_CROP
>  		  | RKISP1_FEATURE_MAIN_STRIDE
> -		  | RKISP1_FEATURE_DMA_34BIT,
> +		  | RKISP1_FEATURE_DMA_34BIT
> +		  | RKISP1_FEATURE_MI_OUTPUT_ALIGN,
>  };
>  
>  static const struct of_device_id rkisp1_of_match[] = {

-- 
Regards,

Laurent Pinchart
