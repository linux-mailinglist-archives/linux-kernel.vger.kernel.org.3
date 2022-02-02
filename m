Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABCB4A6BE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiBBGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbiBBGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047EC061772;
        Tue,  1 Feb 2022 22:38:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 260032F3;
        Wed,  2 Feb 2022 07:37:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643783879;
        bh=r7oPY8EgqItgv6YCn6zBalF5PLzzR/lsj6VuIS++Yos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLOCGme6aMq06je0Lu1485Xqfm7daGDbIMPkjYd6z2/1J38MsLOKvWawioFIFgMhN
         DxkYmPPDtx8NiDxJRBYB5+7Z6dVAIqn+OwMRmZg/ualZvvPOG4QKZwwU9p6hIMLScy
         yhqIUNDQ4ewYg1lhLkXzT4ypXKUrMotK3DV1XZJc=
Date:   Wed, 2 Feb 2022 08:37:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [PATCH RESEND] media: uvcvideo: Add support for Apple
 T2-attached FaceTime HD Camera
Message-ID: <Yfomr83ol/1iGRSv@pendragon.ideasonboard.com>
References: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

Thank you for the patch, and sorry for the late reply.

On Wed, Jan 26, 2022 at 10:37:13AM +0000, Aditya Garg wrote:
> From: Paul Pawlowski <paul@mrarm.io>
> 
> Adds the requisite device id to support detection of the Apple FaceTime
> HD webcam exposed over the T2 BCE VHCI interface.
> 
> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 7c007426e..88dc9e7aa 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2848,6 +2848,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
>  					| UVC_QUIRK_BUILTIN_ISIGHT) },
> +	/* Apple FaceTime HD Camera (Built-In) */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x05ac,
> +	  .idProduct		= 0x8514,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_def },

Have you tested that the device doesn't work without this quirk ?

>  	/* Apple Built-In iSight via iBridge */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
Regards,

Laurent Pinchart
