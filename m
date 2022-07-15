Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE857608D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiGOLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiGOLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:33:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CAB137;
        Fri, 15 Jul 2022 04:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36F66CE2ED7;
        Fri, 15 Jul 2022 11:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2339C34115;
        Fri, 15 Jul 2022 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657884797;
        bh=Q3UZOvOjetME4AllcFAqqcdkF5t8np5OBMziJQfM8sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsyIcrj8J9vIh7GCQ6Ie3EE3DO6oJ2/RQnsW/cvcwzQ0++VMiY5S8Fy6zNbS32d1r
         wOXGiwXHek/lXzNUNHmTxm5oyrOG8uEQoR0LPKs/4p3ulCu4yO27s8GogJFtDCe5Em
         PnOfFRCFiH5G6md7IYZs4kcXQ4L5V8fHxy2bVIYE=
Date:   Fri, 15 Jul 2022 13:33:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sdlyyxy <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: adding support for OPPO R11 diag
 port
Message-ID: <YtFQelwu0QbDBwBA@kroah.com>
References: <20220714102037.4113889-1-sdlyyxy@bupt.edu.cn>
 <Ys/2dN9ktCirZsd9@kroah.com>
 <5F187A64-2C88-4F7E-98AD-2A52B17B0DA4@bupt.edu.cn>
 <YtENDiIpq++2l6yD@kroah.com>
 <YtEO51uf0RQNZIRP@kroah.com>
 <893094CE-73FF-4874-8F5E-2F5ED267B623@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893094CE-73FF-4874-8F5E-2F5ED267B623@bupt.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:08:58PM +0800, sdlyyxy wrote:
> 
> > On Jul 15, 2022, at 14:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Fri, Jul 15, 2022 at 08:45:34AM +0200, Greg KH wrote:
> >> On Fri, Jul 15, 2022 at 02:39:06PM +0800, sdlyyxy wrote:
> >>> Hi Greg,
> >>> Thanks for your comments!
> >>> 
> >>>> On Jul 14, 2022, at 18:56, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>> 
> >>>> On Thu, Jul 14, 2022 at 06:20:37PM +0800, sdlyyxy wrote:
> >>>>> From: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> >>>>> 
> >>>>> This patch adds support for OPPO R11 USB diag serial port to option
> >>>>> driver. This phone uses Qualcomm Snapdragon 660 SoC.
> >>>>> 
> >>>>> usb-devices output:
> >>>>> T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> >>>>> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> >>>>> P: Vendor=22d9 ProdID=276c Rev=04.04
> >>>>> S: Manufacturer=OPPO
> >>>>> S: Product=SDM660-MTP _SN:09C6BCA7
> >>>>> S: SerialNumber=beb2c403
> >>>>> C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> >>>>> I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> >>>> 
> >>>> I do not think this has an option usb-serial chip in the device, this is
> >>>> a phone with a debug port instead.
> >>>> 
> >>> Yeah, this phone uses a Qualcomm chip, not an option usb-serial chip.
> >>> It has the functionality to enter into a special mode, which provides 
> >>> a QCDM-capable diag port as the same behaviour of USB modems. For
> >>> Qualcomm devices, there are several drivers: qcserial, qcaux, and 
> >>> option. According to qcserial.c, qcaux.c source code and mailing list
> >>> conversations [1], this device with diag+adb layout should be driven
> >>> by option.
> >> 
> >> No, this is not an option chip, and does not follow the option device
> >> protocols at all.  So this is not the driver to use here.
> >> 
> >> We should probably switch those other devices as well, they aren't
> >> really option devices either.
> >> 
> >>>>> I: If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> >>>> 
> >>>> What userspace program is bound to this endpoint?
> >>>> 
> >>> I think it is used by adb via libusb.
> >>>>> 
> >>>>> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> >>>>> ---
> >>>>> drivers/usb/serial/option.c | 5 +++++
> >>>>> 1 file changed, 5 insertions(+)
> >>>>> 
> >>>>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >>>>> index de59fa919540..cf65cb84c3ca 100644
> >>>>> --- a/drivers/usb/serial/option.c
> >>>>> +++ b/drivers/usb/serial/option.c
> >>>>> @@ -573,6 +573,10 @@ static void option_instat_callback(struct urb *urb);
> >>>>> #define WETELECOM_PRODUCT_6802			0x6802
> >>>>> #define WETELECOM_PRODUCT_WMD300		0x6803
> >>>>> 
> >>>>> +/* OPPO products */
> >>>>> +#define OPPO_VENDOR_ID				0x22d9
> >>>>> +#define OPPO_PRODUCT_R11			0x276c
> >>>>> +
> >>>>> 
> >>>>> /* Device flags */
> >>>>> 
> >>>>> @@ -2155,6 +2159,7 @@ static const struct usb_device_id option_ids[] = {
> >>>>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
> >>>>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
> >>>>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> >>>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
> >>>> 
> >>>> This does not look correct, sorry. Try using the usbserial generic
> >>>> driver instead to transmit and recieve?
> >>>> 
> >>> Yes I have tried using usbserial generic driver. As for the interface
> >>> #0x0 diag port, it seems working. However, in the same time the 
> >>> generic driver will also be attached to interface #0x1, which causes
> >>> nonfunction of adb. Using this patch, diag and adb can run 
> >>> simultaneously. So it's better than the generic driver?
> >> 
> >> Ah, we should just bind the simple usb-serial driver to this interface
> >> and not bind the generic usb-serial driver to this interface.
> >> 
> >> Let me make up a simple patch for this for you to test...
> > 
> > Can you try the patch here for this, it should work the same as your
> > patch:
> > 
> > 
> > diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> > index 4c6747889a19..eb832b94aa3a 100644
> > --- a/drivers/usb/serial/usb-serial-simple.c
> > +++ b/drivers/usb/serial/usb-serial-simple.c
> > @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> > 					USB_CLASS_VENDOR_SPEC,	\
> > 					0x50,			\
> > -					0x01) }
> > +					0x01) },		\
> > +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> > +					0xff, 0xff, 0x30) }
> > DEVICE(google, GOOGLE_IDS);
> > 
> > /* Libtransistor USB console */
> > 
> Great, this patch works as intended. The VendorID 0x22d9 does not
> belong to Google, shall I add a separate section for OPPO in 
> usb-serial-simple.c and create a new patch?

Nah, these are all just "Android" devices, there's no real need to
rename the structure, we can just use the existing one unless Johan
wants me to change it.  I'll resend this as a "real" patch in a little
bit, thanks so much for testing this!

greg k-h
