Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71C50D5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiDXWeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiDXWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:34:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1124BF1;
        Sun, 24 Apr 2022 15:31:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 929EF822;
        Mon, 25 Apr 2022 00:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650839472;
        bh=/FPZPEyJUc/9ZV4EvGCRcui3f6Vt3drlaFma6mUvFBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maY3jAAzvXiN9jo4BvVzINUNAR3vuA6LKTu3vC/qR7woSl7BOMo2N8aX5B0uqhFUE
         tVF0nHyX6IwIcmMmqoky7s1aYPRCkW0a7eVysLkil674Ed9QkrtxWL7aMvBYQW1uOJ
         27fkkr8QqeaZuY3rcZMFtHwWMHaF+c7gZtx/qm88=
Date:   Mon, 25 Apr 2022 01:31:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: uvc: Undup use uvv-endpoint_max_bpi code
Message-ID: <YmXPsPY+Ef4/U525@pendragon.ideasonboard.com>
References: <20220401172437.625645-1-ribalda@chromium.org>
 <20220401172437.625645-2-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401172437.625645-2-ribalda@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

And here the subject line should mention uvc_endpoint_max_bpi() :-)
While at it, I'll replace "uvc" with "uvcvideo".

On Fri, Apr 01, 2022 at 07:24:37PM +0200, Ricardo Ribalda wrote:
> Replace manual decoding of psize in uvc_parse_streaming(), with the code
> from uvc_endpoint_max_bpi(). It also handles usb3 devices.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 4 +---
>  drivers/media/usb/uvc/uvc_video.c  | 3 +--
>  drivers/media/usb/uvc/uvcvideo.h   | 1 +
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index dda0f0aa78b8..977566aa2c89 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1009,9 +1009,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
>  				streaming->header.bEndpointAddress);
>  		if (ep == NULL)
>  			continue;
> -
> -		psize = le16_to_cpu(ep->desc.wMaxPacketSize);
> -		psize = (psize & 0x07ff) * (1 + ((psize >> 11) & 3));
> +		psize = uvc_endpoint_max_bpi(dev->udev, ep);
>  		if (psize > streaming->maxpsize)
>  			streaming->maxpsize = psize;
>  	}
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index a2dcfeaaac1b..9dc0a5dba158 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1756,8 +1756,7 @@ static void uvc_video_stop_transfer(struct uvc_streaming *stream,
>  /*
>   * Compute the maximum number of bytes per interval for an endpoint.
>   */
> -static unsigned int uvc_endpoint_max_bpi(struct usb_device *dev,
> -					 struct usb_host_endpoint *ep)
> +u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep)
>  {
>  	u16 psize;
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 143230b3275b..28eb337a6cfb 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -911,6 +911,7 @@ void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
>  u32 uvc_fraction_to_interval(u32 numerator, u32 denominator);
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>  					    u8 epaddr);
> +u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep);
>  
>  /* Quirks support */
>  void uvc_video_decode_isight(struct uvc_urb *uvc_urb,

-- 
Regards,

Laurent Pinchart
