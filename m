Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5E54F8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382483AbiFQOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiFQOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:02:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A64BFDA;
        Fri, 17 Jun 2022 07:02:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35A3F2A5;
        Fri, 17 Jun 2022 16:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655474526;
        bh=LpsKvZstMvv2i4Y3Vj1GtPMEWG5JQzfy/QFV7UCQRhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVG9acKpqwDROhKFcYN9pjseM/lF+hqMy2lsy2W9zIZd/PqKAPfw19IrdUMUfkaEp
         QowBODcmX6V7cblBjdejC4ZA9k9jA7RhRd/Bg5ODgqjYCIqeSN+vrQkvgUxja+BH6/
         Fw5PJ0zIn3mJgSy7O0RlcCtCO4+2kXTK5RyetfZ8=
Date:   Fri, 17 Jun 2022 17:01:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Subject: Re: [PATCH v7 4/8] media: uvcvideo: Limit power line control for
 Quanta UVC Webcam
Message-ID: <YqyJUikNtzvgujob@pendragon.ideasonboard.com>
References: <20220617103645.71560-1-ribalda@chromium.org>
 <20220617103645.71560-5-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617103645.71560-5-ribalda@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Fri, Jun 17, 2022 at 12:36:41PM +0200, Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.
> 
> Bus 001 Device 003: ID 0408:3090 Quanta Computer, Inc. USB2.0 HD UVC WebCam
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x0408 Quanta Computer, Inc.
>   idProduct          0x3090
>   bcdDevice            0.04
>   iManufacturer           3 Quanta
>   iProduct                1 USB2.0 HD UVC WebCam
>   iSerial                 2 0x0001
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 35 ++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 6c86faecbea2..4fb07084f1c0 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2643,6 +2643,32 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>  
> +static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> +	{ 0, "Invalid" },
> +	{ 1, "50 Hz" },
> +	{ 2, "60 Hz" },
> +};

It's not nice to have to include the first item in the array, but we
can't fix that without modifying uvc_menu_info, which we can't do as
it's part of the UAPI. Let's keep it as-is, but I would then expose the
uvc_menu_info array from uvc_ctrl.c instead of duplicating it here.

> +
> +static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls_limited,
> +	.menu_min	= 1,
> +	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> +};
> +
> +static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> +	.mappings = (const struct uvc_control_mapping *[]) {
> +		&uvc_ctrl_power_line_mapping_limited,
> +		NULL, /* Sentinel */
> +	},
> +};
> +
>  static const struct uvc_device_info uvc_quirk_probe_minmax = {
>  	.quirks = UVC_QUIRK_PROBE_MINMAX,
>  };
> @@ -2673,6 +2699,15 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
>   * though they are compliant.
>   */
>  static const struct usb_device_id uvc_ids[] = {
> +	/* Quanta USB2.0 HD UVC Webcam */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x0408,
> +	  .idProduct		= 0x3090,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>  	/* LogiLink Wireless Webcam */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
Regards,

Laurent Pinchart
