Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A394A4BA457
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiBQP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:28:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBQP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:28:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EE294113;
        Thu, 17 Feb 2022 07:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62E2CB822A7;
        Thu, 17 Feb 2022 15:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA9C340EC;
        Thu, 17 Feb 2022 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645111666;
        bh=pWWgaapU1fBanlEMHlYmDceVAVnGZr1QDYRYjbDvijM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3TXdFhg97fUomG6QZ4Qe6J0DmsKAjKUAws6QYzVPuRRrhthjSGPlmadJTpMarxbd
         A1BgbWyhzEUk/TDYQGxYQ0ugKqd2xYkhA52DC/J7gcd17wIMz7O2wjeDF8fbgiu6l8
         6P5r8Xghn6kjNRnpYlBngIl2PgXTiz1wltUNpTC8=
Date:   Thu, 17 Feb 2022 16:27:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, bilbao@vt.edu, corbet@lwn.net,
        laurent.pinchart@ideasonboard.com, mchehab+huawei@kernel.org,
        pawell@cadence.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH v2] usb: gadget: uvc: add framebased stream support
Message-ID: <Yg5pb1A9QlgoKYnm@kroah.com>
References: <20220216081651.9089-1-3090101217@zju.edu.cn>
 <20220217104450.14372-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217104450.14372-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:44:50PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> Currently the uvc gadget can't support H264/HEVC transport, After
> adding framebased stream support, the driver can support them.
> 
> Framebased stream is a little different from uncompressed stream.
> So we can support framebased stream on the basis of uncompressed stream.
> 
> Here are the differences:
> 
> 1. For the format, framebased format has an extra member (
> __u8 bVariableSize) than uncompressed format.
> 
> 2. For the frame, the layout of last three members of framebased frame
> is different from uncompressed frame.
> a. Last three members of uncompressed frame are:
>   u32	dw_max_video_frame_buffer_size;
>   u32	dw_default_frame_interval;
>   u8	b_frame_interval_type;
> b. Last three members of framebased frame are:
>   u32	dw_default_frame_interval;
>   u8	b_frame_interval_type;
>   u32	dw_bytes_perline;
> 
> Here is an example of configuring H264:
> 
> cd /sys/kernel/config/usb_gadget/g1
> ndir=functions/uvc.usb0/streaming/uncompressed/$NAME
> mkdir -p $ndir
> echo -n "H264" > $ndir/guidFormat  # H264 or HEVC
> echo 0 > $ndir/bBitsPerPixel
> echo 1 > $ndir/bVariableSize
> wdir=functions/uvc.usb0/streaming/uncompressed/$NAME/${HEIGHT}p
> mkdir -p $wdir
> echo 0 > $wdir/dwBytesPerLine
> echo $WIDTH  > $wdir/wWidth
> echo $HEIGHT > $wdir/wHeight
> echo 29491200 > $wdir/dwMinBitRate
> echo 29491200 > $wdir/dwMaxBitRate
> cat <<EOF > $wdir/dwFrameInterval
> $INTERVAL
> EOF
> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
> ChangeLog v1->v2:
> - Use another way to handle frames, previous implementation within
> - using union has a warning. (Reported-by: kernel test robot <lkp@intel.com>)
> ---
>  .../ABI/testing/configfs-usb-gadget-uvc       | 13 +++-
>  drivers/usb/gadget/function/uvc_configfs.c    | 67 +++++++++++++++++--
>  drivers/usb/gadget/function/uvc_v4l2.c        |  2 +
>  include/uapi/linux/usb/video.h                |  3 +
>  4 files changed, 75 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> index 889ed45be4ca..2bf515dad516 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> @@ -243,7 +243,7 @@ Description:	Uncompressed format descriptors
>  What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/uncompressed/name
>  Date:		Dec 2014
>  KernelVersion:	4.0
> -Description:	Specific uncompressed format descriptors
> +Description:	Specific uncompressed/framebased format descriptors
>  
>  		==================	=======================================
>  		bFormatIndex		unique id for this format descriptor;
> @@ -264,12 +264,15 @@ Description:	Specific uncompressed format descriptors
>  					frame
>  		guidFormat		globally unique id used to identify
>  					stream-encoding format
> +		bVariableSize		whether the data within the frame is of
> +					variable length from frame to frame (
> +					only for framebased format)
>  		==================	=======================================
>  
>  What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/uncompressed/name/name
>  Date:		Dec 2014
>  KernelVersion:	4.0
> -Description:	Specific uncompressed frame descriptors
> +Description:	Specific uncompressed/framebased frame descriptors
>  
>  		=========================  =====================================
>  		bFrameIndex		   unique id for this framedescriptor;
> @@ -283,7 +286,11 @@ Description:	Specific uncompressed frame descriptors
>  					   like to use as default
>  		dwMaxVideoFrameBufferSize  the maximum number of bytes the
>  					   compressor will produce for a video
> -					   frame or still image
> +					   frame or still image (only for
> +					   uncompressed frame)
> +		dwBytesPerLine		   the per-line bytes of the framebased
> +					   frame, e.g. H264 or HEVC (only for
> +					   framebased frame)
>  		dwMaxBitRate		   the maximum bit rate at the shortest
>  					   frame interval in bps
>  		dwMinBitRate		   the minimum bit rate at the longest
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index 77d64031aa9c..695f9b68290f 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/sort.h>
> +#include <linux/videodev2.h>
>  
>  #include "u_uvc.h"
>  #include "uvc_configfs.h"
> @@ -782,6 +783,8 @@ struct uvcg_format {
>  	__u8			bmaControls[UVCG_STREAMING_CONTROL_SIZE];
>  };
>  
> +static u8 uvcg_uncompressed_subtype(struct uvcg_format *fmt);
> +
>  static struct uvcg_format *to_uvcg_format(struct config_item *item)
>  {
>  	return container_of(to_config_group(item), struct uvcg_format, group);
> @@ -1072,9 +1075,23 @@ struct uvcg_frame {
>  		u16	w_height;
>  		u32	dw_min_bit_rate;
>  		u32	dw_max_bit_rate;
> +
> +		/*
> +		 * The layout of last three members of framebased frame
> +		 * is different from uncompressed frame.
> +		 *   Last three members of uncompressed frame are:
> +		 *     u32	dw_max_video_frame_buffer_size;
> +		 *     u32	dw_default_frame_interval;
> +		 *     u8	b_frame_interval_type;
> +		 *   Last three members of framebased frame are:
> +		 *     u32	dw_default_frame_interval;
> +		 *     u8	b_frame_interval_type;
> +		 *     u32	dw_bytes_perline;
> +		 */
>  		u32	dw_max_video_frame_buffer_size;
>  		u32	dw_default_frame_interval;
>  		u8	b_frame_interval_type;
> +		u32	dw_bytes_perline;

Why not use a union here as this is coming from the hardware, right?


>  	} __attribute__((packed)) frame;
>  	u32 *dw_frame_interval;
>  };
> @@ -1185,6 +1202,7 @@ UVCG_FRAME_ATTR(dw_min_bit_rate, dwMinBitRate, 32);
>  UVCG_FRAME_ATTR(dw_max_bit_rate, dwMaxBitRate, 32);
>  UVCG_FRAME_ATTR(dw_max_video_frame_buffer_size, dwMaxVideoFrameBufferSize, 32);
>  UVCG_FRAME_ATTR(dw_default_frame_interval, dwDefaultFrameInterval, 32);
> +UVCG_FRAME_ATTR(dw_bytes_perline, dwBytesPerLine, 32);
>  
>  #undef UVCG_FRAME_ATTR
>  
> @@ -1329,6 +1347,7 @@ static struct configfs_attribute *uvcg_frame_attrs[] = {
>  	&uvcg_frame_attr_dw_max_video_frame_buffer_size,
>  	&uvcg_frame_attr_dw_default_frame_interval,
>  	&uvcg_frame_attr_dw_frame_interval,
> +	&uvcg_frame_attr_dw_bytes_perline,
>  	NULL,
>  };
>  
> @@ -1358,6 +1377,7 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
>  	h->frame.dw_max_bit_rate		= 55296000;
>  	h->frame.dw_max_video_frame_buffer_size	= 460800;
>  	h->frame.dw_default_frame_interval	= 666666;
> +	h->frame.dw_bytes_perline		= 0;
>  
>  	opts_item = group->cg_item.ci_parent->ci_parent->ci_parent;
>  	opts = to_f_uvc_opts(opts_item);
> @@ -1365,7 +1385,10 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
>  	mutex_lock(&opts->lock);
>  	fmt = to_uvcg_format(&group->cg_item);
>  	if (fmt->type == UVCG_UNCOMPRESSED) {
> -		h->frame.b_descriptor_subtype = UVC_VS_FRAME_UNCOMPRESSED;
> +		if (uvcg_uncompressed_subtype(fmt) == UVC_VS_FORMAT_UNCOMPRESSED)
> +			h->frame.b_descriptor_subtype = UVC_VS_FRAME_UNCOMPRESSED;
> +		else
> +			h->frame.b_descriptor_subtype = UVC_VS_FRAME_FRAME_BASED;
>  		h->fmt_type = UVCG_UNCOMPRESSED;
>  	} else if (fmt->type == UVCG_MJPEG) {
>  		h->frame.b_descriptor_subtype = UVC_VS_FRAME_MJPEG;
> @@ -1425,6 +1448,14 @@ struct uvcg_uncompressed {
>  	struct uvc_format_uncompressed	desc;
>  };
>  
> +static u8 uvcg_uncompressed_subtype(struct uvcg_format *fmt)
> +{
> +	struct uvcg_uncompressed *ch = container_of(fmt,
> +					struct uvcg_uncompressed, fmt);
> +
> +	return ch->desc.bDescriptorSubType;
> +}
> +
>  static struct uvcg_uncompressed *to_uvcg_uncompressed(struct config_item *item)
>  {
>  	return container_of(
> @@ -1466,6 +1497,7 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
>  	struct f_uvc_opts *opts;
>  	struct config_item *opts_item;
>  	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
> +	u32 fcc;
>  	int ret;
>  
>  	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
> @@ -1481,7 +1513,17 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
>  
>  	memcpy(ch->desc.guidFormat, page,
>  	       min(sizeof(ch->desc.guidFormat), len));
> -	ret = sizeof(ch->desc.guidFormat);
> +	ret = len;
> +
> +	fcc = v4l2_fourcc(ch->desc.guidFormat[0], ch->desc.guidFormat[1],
> +		ch->desc.guidFormat[2], ch->desc.guidFormat[3]);
> +	if (fcc == V4L2_PIX_FMT_H264 || fcc == V4L2_PIX_FMT_HEVC) {
> +		ch->desc.bLength		= UVC_DT_FORMAT_FRAMEBASED_SIZE;
> +		ch->desc.bDescriptorSubType	= UVC_VS_FORMAT_FRAME_BASED;
> +	} else {
> +		ch->desc.bLength		= UVC_DT_FORMAT_UNCOMPRESSED_SIZE;
> +		ch->desc.bDescriptorSubType	= UVC_VS_FORMAT_UNCOMPRESSED;
> +	}
>  
>  end:
>  	mutex_unlock(&opts->lock);
> @@ -1581,6 +1623,7 @@ UVCG_UNCOMPRESSED_ATTR(b_default_frame_index, bDefaultFrameIndex, 8);
>  UVCG_UNCOMPRESSED_ATTR_RO(b_aspect_ratio_x, bAspectRatioX, 8);
>  UVCG_UNCOMPRESSED_ATTR_RO(b_aspect_ratio_y, bAspectRatioY, 8);
>  UVCG_UNCOMPRESSED_ATTR_RO(bm_interface_flags, bmInterfaceFlags, 8);
> +UVCG_UNCOMPRESSED_ATTR(b_variable_size, bVariableSize, 8);

Why is this writable, but the other variables are not?

>  
>  #undef UVCG_UNCOMPRESSED_ATTR
>  #undef UVCG_UNCOMPRESSED_ATTR_RO
> @@ -1611,6 +1654,7 @@ static struct configfs_attribute *uvcg_uncompressed_attrs[] = {
>  	&uvcg_uncompressed_attr_b_aspect_ratio_y,
>  	&uvcg_uncompressed_attr_bm_interface_flags,
>  	&uvcg_uncompressed_attr_bma_controls,
> +	&uvcg_uncompressed_attr_b_variable_size,
>  	NULL,
>  };
>  
> @@ -1644,6 +1688,7 @@ static struct config_group *uvcg_uncompressed_make(struct config_group *group,
>  	h->desc.bAspectRatioY		= 0;
>  	h->desc.bmInterfaceFlags	= 0;
>  	h->desc.bCopyProtect		= 0;
> +	h->desc.bVariableSize		= 0;
>  
>  	h->fmt.type = UVCG_UNCOMPRESSED;
>  	config_group_init_type_name(&h->fmt.group, name,
> @@ -2038,7 +2083,7 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
>  				container_of(fmt, struct uvcg_uncompressed,
>  					     fmt);
>  
> -			*size += sizeof(u->desc);
> +			*size += u->desc.bLength;
>  		} else if (fmt->type == UVCG_MJPEG) {
>  			struct uvcg_mjpeg *m =
>  				container_of(fmt, struct uvcg_mjpeg, fmt);
> @@ -2053,7 +2098,7 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
>  		struct uvcg_frame *frm = priv1;
>  		int sz = sizeof(frm->dw_frame_interval);
>  
> -		*size += sizeof(frm->frame);
> +		*size += sizeof(frm->frame) - 4;

Where did "4" come from?

>  		*size += frm->frame.b_frame_interval_type * sz;
>  	}
>  	break;
> @@ -2108,8 +2153,8 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
>  
>  			u->desc.bFormatIndex = n + 1;
>  			u->desc.bNumFrameDescriptors = fmt->num_frames;
> -			memcpy(*dest, &u->desc, sizeof(u->desc));
> -			*dest += sizeof(u->desc);
> +			memcpy(*dest, &u->desc, u->desc.bLength);
> +			*dest += u->desc.bLength;
>  		} else if (fmt->type == UVCG_MJPEG) {
>  			struct uvcg_mjpeg *m =
>  				container_of(fmt, struct uvcg_mjpeg, fmt);
> @@ -2127,8 +2172,16 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
>  		struct uvcg_frame *frm = priv1;
>  		struct uvc_descriptor_header *h = *dest;
>  
> -		sz = sizeof(frm->frame);
> +		sz = sizeof(frm->frame) - 4;
>  		memcpy(*dest, &frm->frame, sz);
> +		/*
> +		 * Framebased frame doesn't have dw_max_video_frame_buffer_size,
> +		 * and has dw_bytes_perline, so we should handle the last three
> +		 * members of frame descriptor.
> +		 */
> +		if (frm->frame.b_descriptor_subtype == UVC_VS_FRAME_FRAME_BASED)
> +			memcpy((u8 *)*dest + 17, (u8 *)&frm->frame + 21, 9);
> +
>  		*dest += sz;
>  		sz = frm->frame.b_frame_interval_type *
>  			sizeof(*frm->dw_frame_interval);
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index a2c78690c5c2..3d6217328c50 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -58,6 +58,8 @@ struct uvc_format {
>  static struct uvc_format uvc_formats[] = {
>  	{ 16, V4L2_PIX_FMT_YUYV  },
>  	{ 0,  V4L2_PIX_FMT_MJPEG },
> +	{ 0,  V4L2_PIX_FMT_H264 },
> +	{ 0,  V4L2_PIX_FMT_HEVC },
>  };
>  
>  static int
> diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
> index bfdae12cdacf..383980bc9618 100644
> --- a/include/uapi/linux/usb/video.h
> +++ b/include/uapi/linux/usb/video.h
> @@ -468,9 +468,12 @@ struct uvc_format_uncompressed {
>  	__u8  bAspectRatioY;
>  	__u8  bmInterfaceFlags;
>  	__u8  bCopyProtect;
> +	/* bVariableSize is only for framebased format. */
> +	__u8  bVariableSize;

This just changed a user visable structure size.  What broke when doing
this?  What tool uses this?

>  } __attribute__((__packed__));
>  
>  #define UVC_DT_FORMAT_UNCOMPRESSED_SIZE			27
> +#define UVC_DT_FORMAT_FRAMEBASED_SIZE			28
>  
>  /* Uncompressed Payload - 3.1.2. Uncompressed Video Frame Descriptor */
>  struct uvc_frame_uncompressed {
> -- 
> 2.17.1
> 
