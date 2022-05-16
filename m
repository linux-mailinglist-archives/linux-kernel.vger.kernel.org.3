Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE75292C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiEPVUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiEPVU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:20:29 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 14:20:26 PDT
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB4BC5;
        Mon, 16 May 2022 14:20:26 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr6.vodafonemail.de (Postfix) with ESMTPS id 4L2Bmh2NDXz1y4G;
        Mon, 16 May 2022 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1652735588;
        bh=c2yAvcHcSj4dUkmFeZGNgbY/Zr4/FRmi0kowp9kl5As=;
        h=Date:From:To:Subject:Message-ID:References:Content-Type:
         In-Reply-To:From;
        b=XjS+kcBheCKHYm9fVkAS18q706TH9fEVqzg/BwdXJizn9c9+vNy51Ig6H5LggrEV4
         SHjDrdddt568nFg122oi6+gcXpHLNquJ+OpL3EY5+iGETlR/aKFh76hFGLe4t4i37H
         e9uw93udBg9Icqu1GFIoHbDjC51JX9KVJAHVNRJ8=
Received: from arcor.de (p3ee2cafe.dip0.t-ipconnect.de [62.226.202.254])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4L2BmR1dLvzHnJ7;
        Mon, 16 May 2022 21:12:51 +0000 (UTC)
Date:   Mon, 16 May 2022 23:12:44 +0200
From:   Reinhard Speyerer <rspmn@arcor.de>
To:     Carl =?utf-8?B?WWluKOaut+W8oOaIkCk=?= <carl.yin@quectel.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Quectel BG95 modem
Message-ID: <YoK+TH6MzR89SEdo@arcor.de>
References: <TYZPR06MB4270136AEC3FB06E20F6503486CF9@TYZPR06MB4270.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB4270136AEC3FB06E20F6503486CF9@TYZPR06MB4270.apcprd06.prod.outlook.com>
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 5677
X-purgate-ID: 155817::1652735587-000004C0-15F19267/0/0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:10:17AM +0000, Carl Yin(殷张成) wrote:
> The BG95 modem has 2 USB configurations that are configurable via the AT
> command AT+QCFGEXT="usbnet",["ecm"|"modem"] which make the modem enumerate
> with the following interfaces, respectively:
> 
> "modem": Diag + GNSS + Modem + Modem
> "ecm"  : DIAG + GNSS + Modem + ECM

Hi Carl,

what about the AT+QCFGEXT="usbnet","rmnet" configuration available on
several firmware versions which makes the BG95 enumerate as
Diag + GNSS + Modem + QMI:

T:  Bus=02 Lev=02 Prnt=06 Port=01 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0700 Rev= 0.00
S:  Manufacturer=Quectel, Incorporated
S:  Product=Quectel LPWA Module
S:  SerialNumber=xxxxxxxx
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

> 
> A detailed description of the USB configuration for each mode follows:
> 
> +QCFGEXT: "usbnet","modem"
> -------------------------
> T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0700 Rev= 0.00
> S:  Manufacturer=Quectel, Incorporated
> S:  Product=Quectel LPWA Module
> S:  SerialNumber=884328a2
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> +QCFGEXT: "usbnet","ecm"
> -----------------------
> T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0700 Rev= 0.00
> S:  Manufacturer=Quectel, Incorporated
> S:  Product=Quectel LPWA Module
> S:  SerialNumber=884328a2
> C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Carl Yin <carl.yin@quectel.com>
> ---
>  drivers/usb/serial/option.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 152ad8826..f91b2a67d 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
>  #define QUECTEL_PRODUCT_EC200S_CN		0x6002
>  #define QUECTEL_PRODUCT_EC200T			0x6026
> +#define QUECTEL_PRODUCT_BG95			0x0700
>  
>  #define CMOTECH_VENDOR_ID			0x16d8
>  #define CMOTECH_PRODUCT_6001			0x6001
> @@ -1143,6 +1144,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = ZLP },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG95, 0xff, 0xff, 0xff),
> +	  .driver_info = ZLP },

Could you please add a RSVD(3) flag to the driver_info here to avoid
that the option driver incorrectly binds to the QMI interface?

Regards,
Reinhard

> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG95, 0xff, 0xfe, 0xff),
> +	  .driver_info = ZLP },
>  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
> -- 
> 2.17.1
> 
