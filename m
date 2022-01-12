Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5BB48C0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiALJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:20:42 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57673 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbiALJUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:20:40 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 90BB61BF208;
        Wed, 12 Jan 2022 09:20:36 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:21:37 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 23/23] media: atmel: atmel-isc: change format
 propagation to subdev into only verification
Message-ID: <20220112092137.rzgmo436hjl2bdfv@uno.localdomain>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-24-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-24-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Mon, Dec 13, 2021 at 03:49:40PM +0200, Eugen Hristev wrote:
> As a top MC video driver, the atmel-isc should not propagate the format to the
> subdevice.
> It should rather check at streamon() time if the subdev is properly configured
> with a compatible format.
> Removed the whole format finding logic, and reworked the format verification
> at streamon time, such that the ISC will return an error if the subdevice
> is not properly configured.
> With this being done, the module parameter 'sensor_prefered' makes no sense
> anymore. The ISC should not decide which format the sensor is using. The
> ISC should only cope with the situation and inform userspace if the streaming
> is possible in the current configuration.

Sounds great!

>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v3:
> - clamp to maximum resolution once the frame size from the subdev is found
>
>  drivers/media/platform/atmel/atmel-isc-base.c | 271 ++++++++----------
>  drivers/media/platform/atmel/atmel-isc.h      |   1 +
>  2 files changed, 126 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index 31c8e3029eee..00c8c9588a78 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -36,11 +36,6 @@ static unsigned int debug;
>  module_param(debug, int, 0644);
>  MODULE_PARM_DESC(debug, "debug level (0-2)");
>
> -static unsigned int sensor_preferred = 1;
> -module_param(sensor_preferred, uint, 0644);
> -MODULE_PARM_DESC(sensor_preferred,
> -		 "Sensor is preferred to output the specified format (1-on 0-off), default 1");
> -
>  #define ISC_IS_FORMAT_RAW(mbus_code) \
>  	(((mbus_code) & 0xf000) == 0x3000)
>
> @@ -532,7 +527,7 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
>  	 * convert it to any of the formats that we usually can with a
>  	 * RAW sensor. Thus, do not advertise them.
>  	 */
> -	if (!isc->config.sd_format ||
> +	if (isc->config.sd_format &&

Is this change intentional ?

>  	    !ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
>  		return -EINVAL;
>
> @@ -621,20 +616,30 @@ static int isc_try_validate_formats(struct isc_device *isc)
>  		break;
>  	default:
>  	/* any other different formats are not supported */
> +		v4l2_err(&isc->v4l2_dev, "Requested unsupported format.\n");
>  		ret = -EINVAL;
>  	}
>  	v4l2_dbg(1, debug, &isc->v4l2_dev,
>  		 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
>  		 rgb, yuv, grey, bayer);

Would it make sense to move this before the switch so that the
error messages, if any, appear later ?

>
> -	/* we cannot output RAW if we do not receive RAW */
> -	if ((bayer) && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
> +	if ((bayer) &&
> +	    !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
> +		v4l2_err(&isc->v4l2_dev, "Cannot output RAW if we do not receive RAW.\n");
>  		return -EINVAL;
> +	}
>
> -	/* we cannot output GREY if we do not receive RAW/GREY */
>  	if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
> -	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code))
> +	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
> +		v4l2_err(&isc->v4l2_dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
>  		return -EINVAL;
> +	}
> +
> +	if ((rgb || bayer || yuv) &&
> +	    ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
> +		v4l2_err(&isc->v4l2_dev, "Cannot convert GREY to another format.\n");
> +		return -EINVAL;
> +	}
>
>  	return ret;
>  }
> @@ -862,7 +867,7 @@ static void isc_try_fse(struct isc_device *isc,
>  	 * If we do not know yet which format the subdev is using, we cannot
>  	 * do anything.
>  	 */
> -	if (!isc->try_config.sd_format)
> +	if (!isc->config.sd_format)
>  		return;
>
>  	fse.code = isc->try_config.sd_format->mbus_code;
> @@ -883,180 +888,141 @@ static void isc_try_fse(struct isc_device *isc,
>  	}
>  }
>
> -static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
> -			u32 *code)
> +static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f)
>  {
> -	int i;
> -	struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
>  	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
> -	struct v4l2_subdev_pad_config pad_cfg = {};
> -	struct v4l2_subdev_state pad_state = {
> -		.pads = &pad_cfg
> -		};
> -	struct v4l2_subdev_format format = {
> -		.which = V4L2_SUBDEV_FORMAT_TRY,
> -	};
> -	u32 mbus_code;
> -	int ret;
> -	bool rlp_dma_direct_dump = false;
> +	unsigned int i;
>
>  	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>  		return -EINVAL;
>
> -	/* Step 1: find a RAW format that is supported */
> -	for (i = 0; i < isc->num_user_formats; i++) {
> -		if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
> -			sd_fmt = isc->user_formats[i];
> +	isc->try_config.fourcc = isc->user_formats[0]->fourcc;
> +
> +	/* find if the format requested is supported */
> +	for (i = 0; i < isc->controller_formats_size; i++)
> +		if (isc->controller_formats[i].fourcc == pixfmt->pixelformat) {
> +			isc->try_config.fourcc = pixfmt->pixelformat;
>  			break;
>  		}
> -	}
> -	/* Step 2: We can continue with this RAW format, or we can look
> -	 * for better: maybe sensor supports directly what we need.
> -	 */
> -	direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
> -
> -	/* Step 3: We have both. We decide given the module parameter which
> -	 * one to use.
> -	 */
> -	if (direct_fmt && sd_fmt && sensor_preferred)
> -		sd_fmt = direct_fmt;
> -
> -	/* Step 4: we do not have RAW but we have a direct format. Use it. */
> -	if (direct_fmt && !sd_fmt)
> -		sd_fmt = direct_fmt;
> -
> -	/* Step 5: if we are using a direct format, we need to package
> -	 * everything as 8 bit data and just dump it
> -	 */
> -	if (sd_fmt == direct_fmt)
> -		rlp_dma_direct_dump = true;
> -
> -	/* Step 6: We have no format. This can happen if the userspace
> -	 * requests some weird/invalid format.
> -	 * In this case, default to whatever we have
> -	 */
> -	if (!sd_fmt && !direct_fmt) {
> -		sd_fmt = isc->user_formats[isc->num_user_formats - 1];
> -		v4l2_dbg(1, debug, &isc->v4l2_dev,
> -			 "Sensor not supporting %.4s, using %.4s\n",
> -			 (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
> -	}
> -
> -	if (!sd_fmt) {
> -		ret = -EINVAL;
> -		goto isc_try_fmt_err;
> -	}
> -
> -	/* Step 7: Print out what we decided for debugging */
> -	v4l2_dbg(1, debug, &isc->v4l2_dev,
> -		 "Preferring to have sensor using format %.4s\n",
> -		 (char *)&sd_fmt->fourcc);
> -
> -	/* Step 8: at this moment we decided which format the subdev will use */
> -	isc->try_config.sd_format = sd_fmt;
> -
> -	/* Limit to Atmel ISC hardware capabilities */
> -	if (pixfmt->width > isc->max_width)
> -		pixfmt->width = isc->max_width;
> -	if (pixfmt->height > isc->max_height)
> -		pixfmt->height = isc->max_height;
> -
> -	/*
> -	 * The mbus format is the one the subdev outputs.
> -	 * The pixels will be transferred in this format Sensor -> ISC
> -	 */
> -	mbus_code = sd_fmt->mbus_code;
> -
> -	/*
> -	 * Validate formats. If the required format is not OK, default to raw.
> -	 */
> -
> -	isc->try_config.fourcc = pixfmt->pixelformat;
> -
> -	if (isc_try_validate_formats(isc)) {
> -		pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
> -		/* Re-try to validate the new format */
> -		ret = isc_try_validate_formats(isc);
> -		if (ret)
> -			goto isc_try_fmt_err;
> -	}
> -
> -	ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
> -	if (ret)
> -		goto isc_try_fmt_err;
> -
> -	ret = isc_try_configure_pipeline(isc);
> -	if (ret)
> -		goto isc_try_fmt_err;
>
> -	/* Obtain frame sizes if possible to have crop requirements ready */
> -	isc_try_fse(isc, &pad_state);
> -
> -	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
> -	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
> -			       &pad_state, &format);
> -	if (ret < 0)
> -		goto isc_try_fmt_subdev_err;
> +	/* If we did not find the requested format, we will fallback here */
> +	pixfmt->pixelformat = isc->try_config.fourcc;
> +	pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
> +	pixfmt->field = V4L2_FIELD_NONE;
>
> -	v4l2_fill_pix_format(pixfmt, &format.format);
> +	isc_try_configure_rlp_dma(isc, false);
>
>  	/* Limit to Atmel ISC hardware capabilities */
> -	if (pixfmt->width > isc->max_width)
> -		pixfmt->width = isc->max_width;
> -	if (pixfmt->height > isc->max_height)
> -		pixfmt->height = isc->max_height;
> +	v4l_bound_align_image(&pixfmt->width, 16, isc->max_width, 0,
> +			      &pixfmt->height, 16, isc->max_height, 0, 0);
>
>  	pixfmt->field = V4L2_FIELD_NONE;
>  	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
>  	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
>  			     pixfmt->height;
>
> -	if (code)
> -		*code = mbus_code;
> +	isc->try_fmt = *f;
>
>  	return 0;
> +}
>
> -isc_try_fmt_err:
> -	v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
> -isc_try_fmt_subdev_err:
> -	memset(&isc->try_config, 0, sizeof(isc->try_config));
> +static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
> +{
> +	isc_try_fmt(isc, f);
>
> -	return ret;
> +	/* make the try configuration active */
> +	isc->config = isc->try_config;
> +	isc->fmt = isc->try_fmt;
> +
> +	v4l2_dbg(1, debug, &isc->v4l2_dev, "ISC set_fmt to %.4s @%dx%d\n",
> +		 (char *)&f->fmt.pix.pixelformat,
> +		 f->fmt.pix.width, f->fmt.pix.height);
> +
> +	return 0;
>  }
>
> -static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
> +static int isc_validate(struct isc_device *isc)
>  {
> +	int ret;
> +	int i;
> +	struct isc_format *sd_fmt = NULL;
> +	struct v4l2_pix_format *pixfmt = &isc->fmt.fmt.pix;
>  	struct v4l2_subdev_format format = {
>  		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
> +		.pad = isc->remote_pad,
> +	};
> +	struct v4l2_subdev_pad_config pad_cfg = {};
> +	struct v4l2_subdev_state pad_state = {
> +		.pads = &pad_cfg,
>  	};
> -	u32 mbus_code = 0;
> -	int ret;
>
> -	ret = isc_try_fmt(isc, f, &mbus_code);
> +	/* Get current format from subdev */
> +	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, get_fmt, NULL,
> +			       &format);

Ah! Haven't you just said we don't care anymore about the subdev
format ? :)

Kidding, I might got a bit lost in the logic, but if I look at your
above isc_try_validate_formats() it seems like an ideal candidate for
.link_validate() media_entity operation.

Just to make sure we're on the same page, here's how it should ideally
look like:
- set format does care about subdev format. It only checks that the
  format required from the user is one of the ISC supported one. Ie.
  no v4l2_subdev_call()

- as s_stream time your top driver calls media_pipeline_start()

- media_pipeline_start() walks all the entities in the pipeline and
  validates the format of connected pads. To validate formats the
  __media_pipeline_start() functions calls link_validate() on each
  entity. You should in your driver set

        static const struct media_entity_operations your_media_entity_ops = {
                .link_validate = v4l2_subdev_link_validate,
        };

  if you want to use the default link validation procedure, or set the
  callback to your custom validation function, which can behave more
  or less like isc_try_validate_formats()

Does it match your understanding too ?

Thanks
   j



>  	if (ret)
>  		return ret;
>
> -	v4l2_fill_mbus_format(&format.format, &f->fmt.pix, mbus_code);
> -	ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
> -			       set_fmt, NULL, &format);
> -	if (ret < 0)
> -		return ret;
> +	/* Identify the subdev's format configuration */
> +	for (i = 0; i < isc->num_user_formats; i++)
> +		if (isc->user_formats[i]->mbus_code == format.format.code) {
> +			sd_fmt = isc->user_formats[i];
> +			break;
> +		}
> +
> +	/* Check if the format is not supported */
> +	if (!sd_fmt) {
> +		v4l2_err(&isc->v4l2_dev,
> +			 "Current subdevice is streaming a media bus code that is not supported 0x%x\n",
> +			 format.format.code);
> +		return -EPIPE;
> +	}
> +
> +	/* At this moment we know which format the subdev will use */
> +	isc->try_config.sd_format = sd_fmt;
> +
> +	/* If the sensor is not RAW, we can only do a direct dump */
> +	if (!ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
> +		isc_try_configure_rlp_dma(isc, true);
>
>  	/* Limit to Atmel ISC hardware capabilities */
> -	if (f->fmt.pix.width > isc->max_width)
> -		f->fmt.pix.width = isc->max_width;
> -	if (f->fmt.pix.height > isc->max_height)
> -		f->fmt.pix.height = isc->max_height;
> +	v4l_bound_align_image(&format.format.width, 16, isc->max_width, 0,
> +			      &format.format.height, 16, isc->max_height, 0, 0);
>
> -	isc->fmt = *f;
> +	/* Check if the frame size is the same. Otherwise we may overflow */
> +	if (pixfmt->height != format.format.height ||
> +	    pixfmt->width != format.format.width) {
> +		v4l2_err(&isc->v4l2_dev,
> +			 "ISC not configured with the proper frame size: %dx%d\n",
> +			 format.format.width, format.format.height);
> +		return -EPIPE;
> +	}
>
> +	v4l2_dbg(1, debug, &isc->v4l2_dev,
> +		 "Identified subdev using format %.4s with %dx%d %d bpp\n",
> +		 (char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
> +		 isc->try_config.bpp);
> +
> +	/* Reset and restart AWB if the subdevice changed the format */
>  	if (isc->try_config.sd_format && isc->config.sd_format &&
>  	    isc->try_config.sd_format != isc->config.sd_format) {
>  		isc->ctrls.hist_stat = HIST_INIT;
>  		isc_reset_awb_ctrls(isc);
>  		isc_update_v4l2_ctrls(isc);
>  	}
> -	/* make the try configuration active */
> +
> +	/* Validate formats */
> +	ret = isc_try_validate_formats(isc);
> +	if (ret)
> +		return ret;
> +
> +	/* Obtain frame sizes if possible to have crop requirements ready */
> +	isc_try_fse(isc, &pad_state);
> +
> +	/* Configure ISC pipeline for the config */
> +	ret = isc_try_configure_pipeline(isc);
> +	if (ret)
> +		return ret;
> +
>  	isc->config = isc->try_config;
>
>  	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
> @@ -1064,6 +1030,19 @@ static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
>  	return 0;
>  }
>
> +static int isc_streamon(struct file *file, void *priv, enum v4l2_buf_type bt)
> +{
> +	struct isc_device *isc = video_drvdata(file);
> +	int ret;
> +
> +	ret = isc_validate(isc);
> +
> +	if (ret)
> +		return ret;
> +
> +	return vb2_ioctl_streamon(file, priv, bt);
> +}
> +
>  static int isc_s_fmt_vid_cap(struct file *file, void *priv,
>  			      struct v4l2_format *f)
>  {
> @@ -1080,7 +1059,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct isc_device *isc = video_drvdata(file);
>
> -	return isc_try_fmt(isc, f, NULL);
> +	return isc_try_fmt(isc, f);
>  }
>
>  static int isc_enum_input(struct file *file, void *priv,
> @@ -1176,7 +1155,7 @@ static const struct v4l2_ioctl_ops isc_ioctl_ops = {
>  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
>  	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
>  	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
> -	.vidioc_streamon		= vb2_ioctl_streamon,
> +	.vidioc_streamon		= isc_streamon,
>  	.vidioc_streamoff		= vb2_ioctl_streamoff,
>
>  	.vidioc_g_parm			= isc_g_parm,
> @@ -1879,7 +1858,7 @@ static int isc_set_default_fmt(struct isc_device *isc)
>  	};
>  	int ret;
>
> -	ret = isc_try_fmt(isc, &f, NULL);
> +	ret = isc_try_fmt(isc, &f);
>  	if (ret)
>  		return ret;
>
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index c2cb805faff3..7081698adddd 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -297,6 +297,7 @@ struct isc_device {
>  	struct completion	comp;
>
>  	struct v4l2_format	fmt;
> +	struct v4l2_format	try_fmt;
>  	struct isc_format	**user_formats;
>  	unsigned int		num_user_formats;
>
> --
> 2.25.1
>
