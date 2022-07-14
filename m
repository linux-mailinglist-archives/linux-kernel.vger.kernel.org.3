Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949D574B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiGNK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiGNK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F434558F7;
        Thu, 14 Jul 2022 03:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E77360C28;
        Thu, 14 Jul 2022 10:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B312C341C6;
        Thu, 14 Jul 2022 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657796215;
        bh=hMgpzF1MZOHp2GdSoKsf4K2dDGd26pzxKVOJ1XdPQvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAbrxoNI/VBuV6WFZH3GbO6+Z40dT92RjKvB7pFNe1uMYQjwXJ4IaX/IhKU9QT87p
         VVLW2u+GGJdD6rjqSY9fhMNpoUz5NBhf95U0X6mogb+NtF3p1YmOkpDEOUpq371Xx0
         8857XNJ3SF9w9CKQKhGAawHAhE19A+7MmGAyDvGs=
Date:   Thu, 14 Jul 2022 12:56:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sdlyyxy <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: adding support for OPPO R11 diag
 port
Message-ID: <Ys/2dN9ktCirZsd9@kroah.com>
References: <20220714102037.4113889-1-sdlyyxy@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714102037.4113889-1-sdlyyxy@bupt.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:20:37PM +0800, sdlyyxy wrote:
> From: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> 
> This patch adds support for OPPO R11 USB diag serial port to option
> driver. This phone uses Qualcomm Snapdragon 660 SoC.
> 
> usb-devices output:
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=22d9 ProdID=276c Rev=04.04
> S:  Manufacturer=OPPO
> S:  Product=SDM660-MTP _SN:09C6BCA7
> S:  SerialNumber=beb2c403
> C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

I do not think this has an option usb-serial chip in the device, this is
a phone with a debug port instead.

> I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs

What userspace program is bound to this endpoint?

> 
> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> ---
>  drivers/usb/serial/option.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index de59fa919540..cf65cb84c3ca 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -573,6 +573,10 @@ static void option_instat_callback(struct urb *urb);
>  #define WETELECOM_PRODUCT_6802			0x6802
>  #define WETELECOM_PRODUCT_WMD300		0x6803
>  
> +/* OPPO products */
> +#define OPPO_VENDOR_ID				0x22d9
> +#define OPPO_PRODUCT_R11			0x276c
> +
>  
>  /* Device flags */
>  
> @@ -2155,6 +2159,7 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },

This does not look correct, sorry.  Try using the usbserial generic
driver instead to transmit and recieve?

thanks,

greg k-h
