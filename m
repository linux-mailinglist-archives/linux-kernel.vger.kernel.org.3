Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26E54A933
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiFNGFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiFNGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:05:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B22ED40;
        Mon, 13 Jun 2022 23:05:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41CDE825;
        Tue, 14 Jun 2022 08:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655186710;
        bh=QYptlfnk0VxCl07UM6skKbaz0LAnWtEY0VKHc61nOD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKBij5WMadmOImZ/7LBa13X/J95QzOHIJpvLDtBRy3EHHydbUemAuTsfczfrkJxrL
         zI3exFbwP7tBYBko4QxP29t6wWcQ23IdkFwo+XNX6I1EosPnacZyqMYDtTdCxEMHbo
         Uy5oFvlscgKF9ShDnQconUg31tay0SPo59TwKaUw=
Date:   Tue, 14 Jun 2022 09:05:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        arnd@arndb.de, ribalda@chromium.org, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media: v4l: Use memset_after() helper
Message-ID: <YqglDSzN7bx+mMkx@pendragon.ideasonboard.com>
References: <20220613130845.89220-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613130845.89220-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu,

Thank you for the patch.

On Mon, Jun 13, 2022 at 09:08:45PM +0800, Xiu Jianfeng wrote:
> The CLEAR_AFTER_FIELD defined here is functionally the same as
> memset_after() helper, so replace it with memset_after() to simplify the
> code, no functional change in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 84 +++++++++++++---------------
>  1 file changed, 39 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 21470de62d72..417e939a2b2f 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -31,12 +31,6 @@
>  
>  #include <trace/events/v4l2.h>
>  
> -/* Zero out the end of the struct pointed to by p.  Everything after, but
> - * not including, the specified field is cleared. */
> -#define CLEAR_AFTER_FIELD(p, field) \
> -	memset((u8 *)(p) + offsetof(typeof(*(p)), field) + sizeof((p)->field), \
> -	0, sizeof(*(p)) - offsetof(typeof(*(p)), field) - sizeof((p)->field))
> -
>  #define is_valid_ioctl(vfd, cmd) test_bit(_IOC_NR(cmd), (vfd)->valid_ioctls)
>  
>  struct std_descr {
> @@ -1481,7 +1475,7 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>  		p->mbus_code = 0;
>  
>  	mbus_code = p->mbus_code;
> -	CLEAR_AFTER_FIELD(p, type);
> +	memset_after(p, 0, type);
>  	p->mbus_code = mbus_code;
>  
>  	switch (p->type) {
> @@ -1656,7 +1650,7 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> +		memset_after(p, 0, fmt.pix);
>  		ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
>  		/* just in case the driver zeroed it again */
>  		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> @@ -1666,30 +1660,30 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_cap_mplane))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +		memset_after(p, 0, fmt.pix_mp.xfer_func);
>  		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> +			memset_after(&p->fmt.pix_mp.plane_fmt[i],
> +				     0, bytesperline);
>  		return ops->vidioc_s_fmt_vid_cap_mplane(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_overlay))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.win);
> +		memset_after(p, 0, fmt.win);
>  		return ops->vidioc_s_fmt_vid_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_CAPTURE:
>  		if (unlikely(!ops->vidioc_s_fmt_vbi_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.vbi.flags);
> +		memset_after(p, 0, fmt.vbi.flags);
>  		return ops->vidioc_s_fmt_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
>  		if (unlikely(!ops->vidioc_s_fmt_sliced_vbi_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
> +		memset_after(p, 0, fmt.sliced.io_size);
>  		return ops->vidioc_s_fmt_sliced_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> +		memset_after(p, 0, fmt.pix);
>  		ret = ops->vidioc_s_fmt_vid_out(file, fh, arg);
>  		/* just in case the driver zeroed it again */
>  		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> @@ -1697,45 +1691,45 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_out_mplane))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +		memset_after(p, 0, fmt.pix_mp.xfer_func);
>  		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> +			memset_after(&p->fmt.pix_mp.plane_fmt[i],
> +				     0, bytesperline);
>  		return ops->vidioc_s_fmt_vid_out_mplane(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_out_overlay))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.win);
> +		memset_after(p, 0, fmt.win);
>  		return ops->vidioc_s_fmt_vid_out_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_OUTPUT:
>  		if (unlikely(!ops->vidioc_s_fmt_vbi_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.vbi.flags);
> +		memset_after(p, 0, fmt.vbi.flags);
>  		return ops->vidioc_s_fmt_vbi_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
>  		if (unlikely(!ops->vidioc_s_fmt_sliced_vbi_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
> +		memset_after(p, 0, fmt.sliced.io_size);
>  		return ops->vidioc_s_fmt_sliced_vbi_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_SDR_CAPTURE:
>  		if (unlikely(!ops->vidioc_s_fmt_sdr_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sdr.buffersize);
> +		memset_after(p, 0, fmt.sdr.buffersize);
>  		return ops->vidioc_s_fmt_sdr_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_SDR_OUTPUT:
>  		if (unlikely(!ops->vidioc_s_fmt_sdr_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sdr.buffersize);
> +		memset_after(p, 0, fmt.sdr.buffersize);
>  		return ops->vidioc_s_fmt_sdr_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_META_CAPTURE:
>  		if (unlikely(!ops->vidioc_s_fmt_meta_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.meta);
> +		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_s_fmt_meta_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_META_OUTPUT:
>  		if (unlikely(!ops->vidioc_s_fmt_meta_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.meta);
> +		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_s_fmt_meta_out(file, fh, arg);
>  	}
>  	return -EINVAL;
> @@ -1758,7 +1752,7 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> +		memset_after(p, 0, fmt.pix);
>  		ret = ops->vidioc_try_fmt_vid_cap(file, fh, arg);
>  		/* just in case the driver zeroed it again */
>  		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> @@ -1768,30 +1762,30 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_cap_mplane))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +		memset_after(p, 0, fmt.pix_mp.xfer_func);
>  		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> +			memset_after(&p->fmt.pix_mp.plane_fmt[i],
> +				     0, bytesperline);
>  		return ops->vidioc_try_fmt_vid_cap_mplane(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_overlay))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.win);
> +		memset_after(p, 0, fmt.win);
>  		return ops->vidioc_try_fmt_vid_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_CAPTURE:
>  		if (unlikely(!ops->vidioc_try_fmt_vbi_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.vbi.flags);
> +		memset_after(p, 0, fmt.vbi.flags);
>  		return ops->vidioc_try_fmt_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
>  		if (unlikely(!ops->vidioc_try_fmt_sliced_vbi_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
> +		memset_after(p, 0, fmt.sliced.io_size);
>  		return ops->vidioc_try_fmt_sliced_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> +		memset_after(p, 0, fmt.pix);
>  		ret = ops->vidioc_try_fmt_vid_out(file, fh, arg);
>  		/* just in case the driver zeroed it again */
>  		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> @@ -1799,45 +1793,45 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_out_mplane))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +		memset_after(p, 0, fmt.pix_mp.xfer_func);
>  		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> +			memset_after(&p->fmt.pix_mp.plane_fmt[i],
> +				     0, bytesperline);
>  		return ops->vidioc_try_fmt_vid_out_mplane(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_out_overlay))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.win);
> +		memset_after(p, 0, fmt.win);
>  		return ops->vidioc_try_fmt_vid_out_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_OUTPUT:
>  		if (unlikely(!ops->vidioc_try_fmt_vbi_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.vbi.flags);
> +		memset_after(p, 0, fmt.vbi.flags);
>  		return ops->vidioc_try_fmt_vbi_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
>  		if (unlikely(!ops->vidioc_try_fmt_sliced_vbi_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
> +		memset_after(p, 0, fmt.sliced.io_size);
>  		return ops->vidioc_try_fmt_sliced_vbi_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_SDR_CAPTURE:
>  		if (unlikely(!ops->vidioc_try_fmt_sdr_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sdr.buffersize);
> +		memset_after(p, 0, fmt.sdr.buffersize);
>  		return ops->vidioc_try_fmt_sdr_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_SDR_OUTPUT:
>  		if (unlikely(!ops->vidioc_try_fmt_sdr_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.sdr.buffersize);
> +		memset_after(p, 0, fmt.sdr.buffersize);
>  		return ops->vidioc_try_fmt_sdr_out(file, fh, arg);
>  	case V4L2_BUF_TYPE_META_CAPTURE:
>  		if (unlikely(!ops->vidioc_try_fmt_meta_cap))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.meta);
> +		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_try_fmt_meta_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_META_OUTPUT:
>  		if (unlikely(!ops->vidioc_try_fmt_meta_out))
>  			break;
> -		CLEAR_AFTER_FIELD(p, fmt.meta);
> +		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_try_fmt_meta_out(file, fh, arg);
>  	}
>  	return -EINVAL;
> @@ -2036,7 +2030,7 @@ static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
>  	if (ret)
>  		return ret;
>  
> -	CLEAR_AFTER_FIELD(p, flags);
> +	memset_after(p, 0, flags);
>  
>  	return ops->vidioc_reqbufs(file, fh, p);
>  }
> @@ -2077,7 +2071,7 @@ static int v4l_create_bufs(const struct v4l2_ioctl_ops *ops,
>  	if (ret)
>  		return ret;
>  
> -	CLEAR_AFTER_FIELD(create, flags);
> +	memset_after(create, 0, flags);
>  
>  	v4l_sanitize_format(&create->format);
>  

-- 
Regards,

Laurent Pinchart
