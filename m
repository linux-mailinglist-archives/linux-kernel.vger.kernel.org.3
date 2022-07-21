Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF157C491
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiGUGkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiGUGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:39:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDB3B960;
        Wed, 20 Jul 2022 23:39:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F8CF496;
        Thu, 21 Jul 2022 08:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658385595;
        bh=HLCcuuyn09GD67jWlHbPI3K4ebYuAGYQAmHxs8T3XHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIP/1SDkbOlYWuSVDO/jKpVK0/mOc5eAMkyQGCOnEdDAm4EJmMTmjwwlnJeEz6E8c
         P5nfkDyKcTZjolO86ZUD9/OQpKXGlrOSUxNp5yLeVsfp4v5uFEOspqJdJefAWQFpHl
         u8T1UqkO12fAvJKJWlSJQ9TfO69NDFpglgnOJozk=
Date:   Thu, 21 Jul 2022 09:39:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: Implement ENUM_FRAMESIZES
Message-ID: <Ytj0uVpQJUaJuJvK@pendragon.ideasonboard.com>
References: <20220720172231.4019063-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220720172231.4019063-1-paul.elder@ideasonboard.com>
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

On Thu, Jul 21, 2022 at 02:22:31AM +0900, Paul Elder wrote:
> Implement VIDIOC_ENUM_FRAMESIZES for the rkisp1 capture devices.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index c494afbc21b4..74106a01ded7 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1245,6 +1245,31 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
>  	return -EINVAL;
>  }
>  
> +static int rkisp1_enum_framesizes(struct file *file, void *fh,
> +				  struct v4l2_frmsizeenum *fsize)
> +{
> +	struct rkisp1_capture *cap = video_drvdata(file);
> +	const unsigned int max_widths[] = { RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> +					    RKISP1_RSZ_SP_SRC_MAX_WIDTH };
> +	const unsigned int max_heights[] = { RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> +					     RKISP1_RSZ_SP_SRC_MAX_HEIGHT};

You can make these static const.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +	if (fsize->index != 0)
> +		return -EINVAL;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> +
> +	fsize->stepwise.min_width = RKISP1_RSZ_SRC_MIN_WIDTH;
> +	fsize->stepwise.max_width = max_widths[cap->id];
> +	fsize->stepwise.step_width = 2;
> +
> +	fsize->stepwise.min_height = RKISP1_RSZ_SRC_MIN_HEIGHT;
> +	fsize->stepwise.max_height = max_heights[cap->id];
> +	fsize->stepwise.step_height = 2;
> +
> +	return 0;
> +}
> +
>  static int rkisp1_s_fmt_vid_cap_mplane(struct file *file,
>  				       void *priv, struct v4l2_format *f)
>  {
> @@ -1294,6 +1319,7 @@ static const struct v4l2_ioctl_ops rkisp1_v4l2_ioctl_ops = {
>  	.vidioc_s_fmt_vid_cap_mplane = rkisp1_s_fmt_vid_cap_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane = rkisp1_g_fmt_vid_cap_mplane,
>  	.vidioc_enum_fmt_vid_cap = rkisp1_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_framesizes = rkisp1_enum_framesizes,
>  	.vidioc_querycap = rkisp1_querycap,
>  	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>  	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,

-- 
Regards,

Laurent Pinchart
