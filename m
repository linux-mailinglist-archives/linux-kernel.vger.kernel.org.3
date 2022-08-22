Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D959BFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiHVMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:50:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940342CE27;
        Mon, 22 Aug 2022 05:50:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37D6D2B3;
        Mon, 22 Aug 2022 14:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661172649;
        bh=wU4ONctRZSKCRxX625nmts14wxrRJ5eBmdXPz3iSBqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1912lHlGZYYAf46PBNc6FBKALHLz9Cz975vVlRCZAqqC06/907G0h8iP4QW5Vqaj
         V4l3sjGQBanU06xLcR4NfxVqYmp6KY6fitEnmiza9ynO7pN7BcYYw6ZFWxU+7WAlWe
         FdLaTJjBJfZJbZYqk0ZOOIgmNovwkZl7B4GYPMq0=
Date:   Mon, 22 Aug 2022 15:50:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     huanglei <huanglei814@163.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH v3] media: uvcvideo: limit power line control for Sonix
 Technology
Message-ID: <YwN7pSpORzIZaaSW@pendragon.ideasonboard.com>
References: <20220820005658.21456-1-huanglei814@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220820005658.21456-1-huanglei814@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Huang Lei,

Thank you for the patch.

On Sat, Aug 20, 2022 at 08:56:58AM +0800, huanglei wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.
> 
> Bus 003 Device 003: ID 3277:0072 Sonix Technology Co., Ltd. USB 2.0 Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x3277
>   idProduct          0x0072
>   bcdDevice            1.00
>   iManufacturer           2 Sonix Technology Co., Ltd.
>   iProduct                1 USB 2.0 Camera
>   iSerial                 3 REV0001
>   bNumConfigurations      1
> 
> Signed-off-by: huanglei <huanglei@kylinos.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..e8f823685139 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3264,6 +3264,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
> +	/* Sonix Technology USB 2.0 Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x3277,
> +	  .idProduct		= 0x0072,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>  	/* Acer EasyCamera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
Regards,

Laurent Pinchart
