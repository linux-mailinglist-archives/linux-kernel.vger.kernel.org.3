Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351E94AF409
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiBIO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBIO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:27:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A6C0613CA;
        Wed,  9 Feb 2022 06:27:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 676F5B821B8;
        Wed,  9 Feb 2022 14:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256FCC340E7;
        Wed,  9 Feb 2022 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644416840;
        bh=Vt0kDCJ7W3GqI9yfxaVBf6yVn5/OTpKCqAm7HSVGpfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAjXtgAGOFJpUDLYNwJ608xaYKFOIX6vyidjx5noGP15WnlNEaio23Efw6jDxMck/
         qJM7Jo55r6j+Dt5mpTM5Hjd4XZmyS7W+yEgaGzX9FavyvAFQHm3kHXJmxI97/5GT4V
         8RTNy6TKwj/AYcPmPtgqasdLOjSq4/Y4yGds22jL04sm8Ulf6sFzc9qhGFC8IqRv/f
         zh8AZFfp37RF2y0l95F+KWX0re3Ysrjzy9xO67z5z5uaHmWXNxiwFiaK61a2QgMUgJ
         TvdKGk6E8t+VRLYq8Q6v7ELbk9xb5tmh8wexGzba3Omwrlz99xHy6u4pum1AKTL5rg
         clW5YeQxn9Zvw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nHnvx-0002LS-LT; Wed, 09 Feb 2022 15:27:01 +0100
Date:   Wed, 9 Feb 2022 15:27:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for DW5829e
Message-ID: <YgPPNVzyg7Gypzv9@hovoldconsulting.com>
References: <20220209031535.9668-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209031535.9668-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:15:35AM +0800, Slark Xiao wrote:
> Dell DW5829e same as DW5821e except CAT level.
> DW5821e supports CAT16 but DW5829e supports CAT9.
> There are 2 types product of DW5829e: normal and eSIM.
> So we will add 2 PID for DW5829e.
> And for each PID, it support MBIM or RMNET.
> Let's see test evidence as below:
> 
> DW5829e MBIM mode:
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  2
> P:  Vendor=413c ProdID=81e6 Rev=03.18
> S:  Manufacturer=Dell Inc.
> S:  Product=DW5829e Snapdragon X20 LTE
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 7 Cfg#= 2 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> I:  If#=0x6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> 
> DW5829e RMNET mode:
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=413c ProdID=81e6 Rev=03.18
> S:  Manufacturer=Dell Inc.
> S:  Product=DW5829e Snapdragon X20 LTE
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> I:  If#=0x1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> 
> DW5829e-eSIM MBIM mode:
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=5000 MxCh= 0
> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  2
> P:  Vendor=413c ProdID=81e4 Rev=03.18
> S:  Manufacturer=Dell Inc.
> S:  Product=DW5829e-eSIM Snapdragon X20 LTE
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 7 Cfg#= 2 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> I:  If#=0x6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> 
> DW5829e-eSIM RMNET mode:
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=5000 MxCh= 0
> D:  Ver= 3.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=413c ProdID=81e4 Rev=03.18
> S:  Manufacturer=Dell Inc.
> S:  Product=DW5829e-eSIM Snapdragon X20 LTE
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> I:  If#=0x1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> 
> BTW, the interface 0x6 of MBIM mode is GNSS port, which not same as NMEA
> port. So it's banned from serial option driver.
> The remaining interfaces 0x2-0x5 are: MODEM, MODEM, NMEA, DIAG.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Thanks for providing all the necessary details.

> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 962e9943fc20..b47bad810eec 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -198,6 +198,8 @@ static void option_instat_callback(struct urb *urb);
>  
>  #define DELL_PRODUCT_5821E			0x81d7
>  #define DELL_PRODUCT_5821E_ESIM			0x81e0
> +#define DELL_PRODUCT_5829E			0x81e6
> +#define DELL_PRODUCT_5829E_ESIM			0x81e4

Please keep the defines sorted by PID.

>  #define KYOCERA_VENDOR_ID			0x0c88
>  #define KYOCERA_PRODUCT_KPC650			0x17da
> @@ -1063,6 +1065,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
>  	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5821E_ESIM),
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E, 0xff),
> +	  .driver_info = RSVD(6) },
> +	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM, 0xff),
> +	  .driver_info = RSVD(6) },

It looks like these entries will cause the driver to bind also to the
QMI port however.

>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },

Johan
