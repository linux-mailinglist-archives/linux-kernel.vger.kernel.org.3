Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16550D5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiDXWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbiDXWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:21:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D275604;
        Sun, 24 Apr 2022 15:18:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D658822;
        Mon, 25 Apr 2022 00:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650838693;
        bh=kKdIECQ7HGq/14pdy4CNiFSgaiDt1Eljj4XvUzaDoDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGWFaZmXYV8/tn1dWeP4xejhtVqJnk4oGXQqDOhzwYAY16jdmodhP2fGcjwHTC+U1
         GRPrMKCpB5ChenOIsmsNshVXBFSCofT9u0dXJV8wfrDUKRTk6PXRR59SzCnhTVHB14
         qCkniTScodlOVhzteOEILVzixxPeFZRNzEpknIq4=
Date:   Mon, 25 Apr 2022 01:18:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: uvc: simplify uvc_enpoint_max_bpi
Message-ID: <YmXMpQOb3bb4l6IF@pendragon.ideasonboard.com>
References: <20220401172437.625645-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401172437.625645-1-ribalda@chromium.org>
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

I think you meant uvc_endpoint_max_bpi() in the subject line.

On Fri, Apr 01, 2022 at 07:24:36PM +0200, Ricardo Ribalda wrote:
> The case USB_SPEED_WIRELESS and the default one were doing the same.
> 
> Also, make always use of usb_endpoint_maxp_mult, as it should have a
> sane value, even for LOW speed and WIRELESS.

I always fear regressions with this kind of patch, but I have no reason
to think there's a specific issue, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 1b4cc934109e..a2dcfeaaac1b 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1760,21 +1760,14 @@ static unsigned int uvc_endpoint_max_bpi(struct usb_device *dev,
>  					 struct usb_host_endpoint *ep)
>  {
>  	u16 psize;
> -	u16 mult;
>  
>  	switch (dev->speed) {
>  	case USB_SPEED_SUPER:
>  	case USB_SPEED_SUPER_PLUS:
>  		return le16_to_cpu(ep->ss_ep_comp.wBytesPerInterval);
> -	case USB_SPEED_HIGH:
> -		psize = usb_endpoint_maxp(&ep->desc);
> -		mult = usb_endpoint_maxp_mult(&ep->desc);
> -		return psize * mult;
> -	case USB_SPEED_WIRELESS:
> -		psize = usb_endpoint_maxp(&ep->desc);
> -		return psize;
>  	default:
>  		psize = usb_endpoint_maxp(&ep->desc);
> +		psize *= usb_endpoint_maxp_mult(&ep->desc);
>  		return psize;
>  	}
>  }

-- 
Regards,

Laurent Pinchart
