Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3A577829
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGQUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGQUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:14:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F4411A1B;
        Sun, 17 Jul 2022 13:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1220B80DFF;
        Sun, 17 Jul 2022 20:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FF9C3411E;
        Sun, 17 Jul 2022 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658088886;
        bh=uk08sAzkVMY+XZxQEzLyrIPyICsHFAdaxskNvnRcQDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgpE/A8k8vJX0M0cBGOTf+pmR+w+H6NFZYcvPtv++HUDOAU+O15bX4tSEcEv3BAAJ
         ss579Xvy/RCOFDBNhmt942Z6OK+72sHHaxr9rGX1Du27zrTNgz9oKecUhMDrPsgFju
         d4/52pSKO1WHjjGEAy/hEqa+KSG1BtkjatwQA4d0=
Date:   Sun, 17 Jul 2022 22:14:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Reinhard Speyerer <rspmn@arcor.de>
Cc:     sdlyyxy <sdlyyxy@bupt.edu.cn>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Message-ID: <YtRtswctFMLxeglu@kroah.com>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtKrbucYNulPEKUp@arcor.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 02:13:34PM +0200, Reinhard Speyerer wrote:
> On Fri, Jul 15, 2022 at 10:59:13PM +0800, sdlyyxy wrote:
> > 
> > > On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > The Oppo R11 diagnostic USB connection needs to be bound to the
> > > usb-serial-simple driver as it just wants to use a dumb pipe to
> > > communicate to the host.
> > > 
> > > usb-devices output:
> > > T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> > > D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> > > P: Vendor=22d9 ProdID=276c Rev=04.04
> > > S: Manufacturer=OPPO
> > > S: Product=SDM660-MTP _SN:09C6BCA7
> > > S: SerialNumber=beb2c403
> > > C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> > > I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> > > 
> > > Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> > > Cc: Johan Hovold <johan@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > drivers/usb/serial/usb-serial-simple.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> > > index 4c6747889a19..eb832b94aa3a 100644
> > > --- a/drivers/usb/serial/usb-serial-simple.c
> > > +++ b/drivers/usb/serial/usb-serial-simple.c
> > > @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> > > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> > > 					USB_CLASS_VENDOR_SPEC,	\
> > > 					0x50,			\
> > > -					0x01) }
> > > +					0x01) },		\
> > > +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> > > +					0xff, 0xff, 0x30) }
> > > DEVICE(google, GOOGLE_IDS);
> > > 
> > > /* Libtransistor USB console */
> > > -- 
> > > 2.37.1
> > Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> 
> While this may work sufficiently well for real low-volume diag traffic I'd
> expect a significant percentage of diag messages to be lost in practice
> with the usb-serial-simple driver.
> 
> According to the usb-devices output this looks like the Qualcomm USB gadget
> in the DIAG + ADB composition to me.
> 
> Since the option driver uses the usb-wwan framework my suggestion would be
> for the original patch to be applied instead similar to what has been done
> e.g. for the Quectel RM500Q diag port.

But this is not using the option chip, nor using the option flow control
protocol at all, so it should not be showing up as a device controlled
by the option driver.  It just will not work properly, the simple driver
should be doing the exact same thing here.

thank,

greg k-h
