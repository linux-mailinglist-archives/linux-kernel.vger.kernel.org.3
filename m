Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D56544C38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiFIMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiFIMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765D1F626;
        Thu,  9 Jun 2022 05:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10FBD61A69;
        Thu,  9 Jun 2022 12:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EEDC34114;
        Thu,  9 Jun 2022 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654778168;
        bh=Dgg+l1uq53d7NWf3gWp4/VPMNeVbJoee/e+EUeptoPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkZ1GuZbO169V0cqtLzdXkDv4dwaS9vE+vk8VZ2TgM7wnvaoxc8ihMpPAHLkDQC3h
         TSCJ1w6QnngkvtvQJ3H3JtNjcQOQ7YrFK3pqtsPZaqfV3o/K1lz4sIaSMU0CYIGAht
         pGvi1C6Cu7P8xWOKr0ow1hgHxF8Sh6/xOKyWxPbNL3DWg6C++eXPE2CSus+7U89cmg
         ejBVjhIxbsHBOA8r0d1jzD8rllZ0MzwULav/6ODbDVEgTquguTkwVz6PKaHbyP9XYm
         BOqmfVEClkBP2CMn3rbghfOh97MBUNgANfzoMHDRCGOSvdKUWWvjNSOHeouk9e6ArJ
         QyDlmQKQQf0Pg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzHOO-0005MO-GS; Thu, 09 Jun 2022 14:36:04 +0200
Date:   Thu, 9 Jun 2022 14:36:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for Cinterion MV31 with
 new baseline
Message-ID: <YqHpNAaY/Oez8TrJ@hovoldconsulting.com>
References: <20220601034740.5438-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601034740.5438-1-slark_xiao@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:47:40AM +0800, Slark Xiao wrote:
> Adding support for Cinterion device MV31 with Qualcomm
> new baseline. Use different PIDs to separate it from
> previous base line products.
> All interfaces settings keep same as previous.
> 
> Below is test evidence:
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00b8 Rev=04.14
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00B8 USB Mobile Broadband
> S:  SerialNumber=90418e79
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00b9 Rev=04.14
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00B9 USB Mobile Broadband
> S:  SerialNumber=90418e79
> C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> For PID 00b8, interface 3 is GNSS port which don't use serial driver.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e60425bbf537..5e26e90db7d6 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -432,6 +432,8 @@ static void option_instat_callback(struct urb *urb);
>  #define CINTERION_PRODUCT_CLS8			0x00b0
>  #define CINTERION_PRODUCT_MV31_MBIM		0x00b3
>  #define CINTERION_PRODUCT_MV31_RMNET		0x00b7
> +#define CINTERION_PRODUCT_MV31_MBIM2		0x00b8
> +#define CINTERION_PRODUCT_MV31_RMNET2		0x00b9

Thanks for the patch. I've applied it now after renaming the defines to
make the variant an infix instead (e.g. CINTERION_PRODUCT_MV31_2_MBIM).

>  #define CINTERION_PRODUCT_MV32_WA		0x00f1
>  #define CINTERION_PRODUCT_MV32_WB		0x00f2
>  
> @@ -1979,6 +1981,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(3)},
>  	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
>  	  .driver_info = RSVD(0)},
> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_MBIM2, 0xff),
> +	  .driver_info = RSVD(3)},
> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET2, 0xff),
> +	  .driver_info = RSVD(0)},
>  	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA, 0xff),
>  	  .driver_info = RSVD(3)},
>  	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),

Johan
