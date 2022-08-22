Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F859C004
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiHVNDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHVNC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:02:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAA356D1;
        Mon, 22 Aug 2022 06:02:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40B082B3;
        Mon, 22 Aug 2022 15:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661173377;
        bh=3KUAM+O8TZK6k0R26rf5Rv/fs3CP6Usaeb49tMIg+sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Td0g3pwLBnD4ckmy1hbXDW04i7ernfNgHGZCUdSMCtSjlY3Pn1sNUuAGLtBC48rgG
         FTTZrBGWXPZp5syugBjLfT+n7fp8i1q1BeoXTtDvEUdtHXhb0aXT+mUzYbtYJ7Nhwu
         /f9Qm6RMTvMXBTYpXVx1XaeYw5BwFMnZT+C6TWvs=
Date:   Mon, 22 Aug 2022 16:02:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix InterfaceProtocol for Quanta camera
Message-ID: <YwN+fU5ez0L5pi1j@pendragon.ideasonboard.com>
References: <20220808134106.70100-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808134106.70100-1-ribalda@chromium.org>
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

On Mon, Aug 08, 2022 at 03:41:06PM +0200, Ricardo Ribalda wrote:
> The device is using a different InterfaceProtocol than the one set in
> the original quirk.
> 
> Fixes: 95f03d973478 ("media: uvcvideo: Limit power line control for Quanta cameras")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> 
> This was fixed on the last version of the patchset. Unfortunately I did
> checked that it was the version merged :(.

Oops :-(

> It is too late to land it in this version?

I think it can be considered as a v6.0 fix, yes.

>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..6556158a8888 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2740,7 +2740,7 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .idProduct		= 0x4034,
>  	  .bInterfaceClass	= USB_CLASS_VIDEO,
>  	  .bInterfaceSubClass	= 1,
> -	  .bInterfaceProtocol	= 0,
> +	  .bInterfaceProtocol	= 1,

Should we use UVC_PC_PROTOCOL_15 here ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>  	/* LogiLink Wireless Webcam */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE

-- 
Regards,

Laurent Pinchart
