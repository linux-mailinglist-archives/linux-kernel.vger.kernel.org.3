Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5B4BDCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352297AbiBUJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:54:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352300AbiBUJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:47:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76C31347;
        Mon, 21 Feb 2022 01:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 102C1CE0E8B;
        Mon, 21 Feb 2022 09:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D89AC340EB;
        Mon, 21 Feb 2022 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645435159;
        bh=y/fovhg2SrSjIop/da0hcjHxQGhI87uhw9/cjMwETww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaR6FWg439BUCjrohVcf6NonY4BanAy1Q1sRSfgYMaPO36QhYrbEQbVOm2HiYtiN4
         duihRIgXjMhSEuUScJD/frv2fyDQNkxlQw+6cSPZ5I/maZ1L1Fom6tx2YokHxu7CBS
         qFEpGnIfNk9lF+v/hZs8H+JFQkIhRvmgIjcCmYeWk+C72/zppUtkC8iiTW7qHd8KYP
         QhQnu5bzHB/TTBV7RZhoVEgX2C6vXuslM18N8b2k0YUvMMXx1Xf0wwfrriV2zxvjFM
         BSTJHRL7jH73PRkrYGdxWJhz4iGRPyIMVuVX8CLD1PA+qx4Csh/o5nwVBm4I8s+Y46
         mHyyply0pXwPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nM4qh-00061f-NU; Mon, 21 Feb 2022 10:19:16 +0100
Date:   Mon, 21 Feb 2022 10:19:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add support for DW5829e
Message-ID: <YhNZE4m66Qb7jdeZ@hovoldconsulting.com>
References: <20220214021401.6264-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214021401.6264-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:14:01AM +0800, Slark Xiao wrote:
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
> ---
> v2: (1). sorted by PID  (2). reduce the conflict possibility between
> QMI and serial driver.

Thanks for the update. 

> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 962e9943fc20..f612805222b6 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -198,6 +198,8 @@ static void option_instat_callback(struct urb *urb);
>  
>  #define DELL_PRODUCT_5821E			0x81d7
>  #define DELL_PRODUCT_5821E_ESIM			0x81e0
> +#define DELL_PRODUCT_5829E_ESIM			0x81e4
> +#define DELL_PRODUCT_5829E			0x81e6
>  
>  #define KYOCERA_VENDOR_ID			0x0c88
>  #define KYOCERA_PRODUCT_KPC650			0x17da
> @@ -1063,6 +1065,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
>  	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5821E_ESIM),
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> +	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E),
> +	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> +	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
> +	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },

I see now that the previous two entries also reserved interface 1 even
though it's unnecessary as that interface does not have vendor class in
any configuration.

I dropped the RSVD(1) from the new entries before applying.

>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
>  	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },

Johan
