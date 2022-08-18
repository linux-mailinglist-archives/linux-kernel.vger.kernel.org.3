Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643EA5986CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiHRPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbiHRPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:04:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFA3CBC8;
        Thu, 18 Aug 2022 08:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1687DCE20C3;
        Thu, 18 Aug 2022 15:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA1C433B5;
        Thu, 18 Aug 2022 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660835056;
        bh=vBhKqDvpAfhoNzcM9gcsVCR1KKZq7v+wp1Li/loUVDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvGMZKAhoCDn2oqCGr++nUr+qzxOYRcBRb6wIfhTu8WZ9gxneHoW4E0e3oJ5MdJRb
         ESq4tKFiAtwzj7HEzhPKNKkdYZ2bpiWxc9UGtlwLk4kndv5D+5VinOQwRJZ89nfzZ6
         Khy5GIWLX2HCKmXo58wSG+1RsXjSxwjSVuushzzo=
Date:   Thu, 18 Aug 2022 17:04:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.guibert@free.fr
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
Message-ID: <Yv5U7Xw5gHSY5EH0@kroah.com>
References: <20220817102440.117640-1-thierry.guibert@croix-rouge.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817102440.117640-1-thierry.guibert@croix-rouge.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:24:40PM +0200, Thierry GUIBERT wrote:
> Supports for ICOM F3400 and ICOM F4400 PMR radios in CDC-ACM driver
> enabling the AT serial port.
> The Vendor Id is 0x0C26
> The Product ID is 0x0020
> 
> Output of lsusb :
> Bus 001 Device 009: ID 0c26:0020 Prolific Technology Inc. ICOM Radio
> Couldn't open device, some information will be missing
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            2 Communications
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0c26 Prolific Technology Inc.
>   idProduct          0x0020
>   bcdDevice            0.00
>   iManufacturer           1 ICOM Inc.
>   iProduct                2 ICOM Radio
>   iSerial                 3 *obfuscated*
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0030
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         2 Communications
>       bInterfaceSubClass      2 Abstract (modem)
>       bInterfaceProtocol      1 AT-commands (v.25ter)
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval              12
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass        10 CDC Data
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
> 
> Signed-off-by: Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
> ---
>  drivers/usb/class/cdc-acm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 9b9aea24d58c..7735c6edce73 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1813,6 +1813,9 @@ static const struct usb_device_id acm_ids[] = {
>  	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
>  	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
>  	},
> +	{ USB_DEVICE(0x0c26, 0x0020), /* Icom ICF3400 Serie */
> +	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
> +	},

These were all in sorted order, until your entry :(

Can you fix this up to be in the correct order and resend a v2?

thanks,

greg k-h
