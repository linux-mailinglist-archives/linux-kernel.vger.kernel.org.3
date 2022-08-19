Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD2599193
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbiHSAIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiHSAIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:08:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633521CFED;
        Thu, 18 Aug 2022 17:08:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CD2F93;
        Fri, 19 Aug 2022 02:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660867705;
        bh=t+5dEQOgAJNR+XcH2UZOOtmMxxODcmkn3Y398QVCFNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/v4prcVOOfdG8Gv/GWSQiD9DZN1a+AQhII60dw1QIDCgBSlp9MG1hpC094o0iFd5
         cADSAb53M7tX8k9Tu0MLUCZEj8sXaWeyajIeBKsDSMWaPAJU3wXmm02nIi7fdLvHqR
         1ZUd5QM259WMTlrX82EUg0gKuC+5y8DS/CDXeyao=
Date:   Fri, 19 Aug 2022 03:08:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     huanglei <huanglei@kylinos.cn>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: limit power line control for Sonix
 Technology
Message-ID: <Yv7Udve8bFXsBr0/@pendragon.ideasonboard.com>
References: <20220818022338.13374-1-huanglei@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220818022338.13374-1-huanglei@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huanglei,

Thank you for the patch.

On Thu, Aug 18, 2022 at 10:23:38AM +0800, huanglei wrote:
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

Would you be able to send me the full descriptors for that device ?

> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..218db3f1db5d 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3282,6 +3282,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Sonix Technology USB 2.0 Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x3277,
> +	  .idProduct		= 0x0072,
> +	  .bInterfaceClass	= USB_CLASS_VENDOR_SPEC,

Does the device really implement a vendor class ?

> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },

This should be moved up to keep the list sorted by VID:PID.

>  	/* Generic USB Video Class */
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

-- 
Regards,

Laurent Pinchart
