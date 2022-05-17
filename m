Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB852A523
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbiEQOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbiEQOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E062E0BC;
        Tue, 17 May 2022 07:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213276160B;
        Tue, 17 May 2022 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC26C385B8;
        Tue, 17 May 2022 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652798697;
        bh=QZBvZjvpV6WIhybyhDD0L+yIYufi9SKnX03r87oDAZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpQTMtT+mo4FYSp2athdJqVRD3J0EQTdA1cFErWpD8FNo0IJxYJ1hvs8/HGk460FF
         DKd28BiJDqNaV7MyTj1OPzEq8YkXUJq7F4mGnEihXbrL0YptinMkRKqN8f9yq/ClXx
         pv84FxxB8uOmckDQU1Zv2++iHxbYd0ycR4adzM/U7ghzyc5SS0iVYAx8OlrCwHFDUj
         44/zpOOGKvRHsEX2Mc8MKanCODMpCHzmu2ziV1XCknf3EkdNl0+JzalvcsknwQO86V
         qvL2uNYAqwHwlZ42BHRbQxXLqPXrz0za4kful4RSX819iJAe7NLjLTOnQRQ9TqLr5H
         KXwRVqyzLbG3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nqyRV-00013D-Fu; Tue, 17 May 2022 16:44:57 +0200
Date:   Tue, 17 May 2022 16:44:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Carl =?utf-8?B?WWluKOaut+W8oOaIkCk=?= <carl.yin@quectel.com>
Cc:     Reinhard Speyerer <rspmn@arcor.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Quectel BG95 modem
Message-ID: <YoO06aI15sGRimRo@hovoldconsulting.com>
References: <TYZPR06MB4270471E08BF0BCDBF24722186CE9@TYZPR06MB4270.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB4270471E08BF0BCDBF24722186CE9@TYZPR06MB4270.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:14:34AM +0000, Carl Yin(殷张成) wrote:
> Hi Reinhard:
>     Although BG95 supports at+qcfgext="usbnet", "rmnet", but lots of QMI message do not support, 
>     E.g WDS_START_NETWORK_INTERFACE, so "rmnet" is basically useless.

Sounds like a good idea to reserve interface 3 as Reinhard suggested
anyway for completeness.

You can mention that the configuration is incomplete, but please include
usb-devices output for also for rmnet so we have all the configurations
in the commit message.

> On Tuesday, May 17, 2022 at 05:13 AM +0000, Reinhard Speyerer wrote:
> 
> > On Mon, May 16, 2022 at 06:10:17AM +0000, Carl Yin(殷张成) wrote:
> > > The BG95 modem has 2 USB configurations that are configurable via the
> > > AT command AT+QCFGEXT="usbnet",["ecm"|"modem"] which make the
> > modem
> > > enumerate with the following interfaces, respectively:
> > >
> > > "modem": Diag + GNSS + Modem + Modem
> > > "ecm"  : DIAG + GNSS + Modem + ECM
> > 
> > Hi Carl,
> > 
> > what about the AT+QCFGEXT="usbnet","rmnet" configuration available on
> > several firmware versions which makes the BG95 enumerate as Diag + GNSS +
> > Modem + QMI:
> > 
> > T:  Bus=02 Lev=02 Prnt=06 Port=01 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
> > D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > P:  Vendor=2c7c ProdID=0700 Rev= 0.00
> > S:  Manufacturer=Quectel, Incorporated
> > S:  Product=Quectel LPWA Module
> > S:  SerialNumber=xxxxxxxx
> > C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> > I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> > E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > 
> > >
> > > A detailed description of the USB configuration for each mode follows:
> > >
> > > +QCFGEXT: "usbnet","modem"
> > > -------------------------
> > > T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> > > D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > > P:  Vendor=2c7c ProdID=0700 Rev= 0.00
> > > S:  Manufacturer=Quectel, Incorporated
> > > S:  Product=Quectel LPWA Module
> > > S:  SerialNumber=884328a2
> > > C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> > > I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > > E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> > > E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > > E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > >
> > > +QCFGEXT: "usbnet","ecm"
> > > -----------------------
> > > T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> > > D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> > > P:  Vendor=2c7c ProdID=0700 Rev= 0.00
> > > S:  Manufacturer=Quectel, Incorporated
> > > S:  Product=Quectel LPWA Module
> > > S:  SerialNumber=884328a2
> > > C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> > > A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> > > I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> > > E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > > E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00
> > > Driver=cdc_ether
> > > E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> > > I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00
> > > Driver=cdc_ether
> > > I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00
> > > Driver=cdc_ether
> > > E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > > E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> > >
> > > Signed-off-by: Carl Yin <carl.yin@quectel.com>
> > > ---
> > >  drivers/usb/serial/option.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> > > index 152ad8826..f91b2a67d 100644
> > > --- a/drivers/usb/serial/option.c
> > > +++ b/drivers/usb/serial/option.c
> > > @@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
> > >  #define QUECTEL_PRODUCT_RM500Q			0x0800
> > >  #define QUECTEL_PRODUCT_EC200S_CN		0x6002
> > >  #define QUECTEL_PRODUCT_EC200T			0x6026
> > > +#define QUECTEL_PRODUCT_BG95			0x0700

Please keep the defines sorted by PID.

> > >  #define CMOTECH_VENDOR_ID			0x16d8
> > >  #define CMOTECH_PRODUCT_6001			0x6001
> > > @@ -1143,6 +1144,10 @@ static const struct usb_device_id option_ids[] = {
> > >  	  .driver_info = ZLP },
> > >  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> > QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
> > >  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> > > QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> > > +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> > QUECTEL_PRODUCT_BG95, 0xff, 0xff, 0xff),
> > > +	  .driver_info = ZLP },
> > 
> > Could you please add a RSVD(3) flag to the driver_info here to avoid that the
> > option driver incorrectly binds to the QMI interface?

> > > +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> > QUECTEL_PRODUCT_BG95, 0xff, 0xfe, 0xff),
> > > +	  .driver_info = ZLP },

Wouldn't a single entry using USB_DEVICE_INTERFACE_CLASS() be enough to
cover all three configurations?

> > >
> > >  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
> > >  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
> > > --
> > > 2.17.1
> > >

Johan
