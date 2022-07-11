Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909B563181
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiGAKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiGAKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE157969E;
        Fri,  1 Jul 2022 03:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B61062339;
        Fri,  1 Jul 2022 10:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C4C341C6;
        Fri,  1 Jul 2022 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656671720;
        bh=5hX8oRoPZn4b5fAaXxxYWDQveykgB7sgy/RluBH/fJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWsq++M5k0Wo3efjXd1fLAQzurXJaA8GNRq0b6drz75gynuFHQa39dFdvKWiH04u3
         u89Q2AoTV2EoGcNYW3oH4iH1+CvKo0EWKBfUMEyz0xZlzarTk2K6bJkFVql7L82ddO
         LuY+yThHSOoxvhtr0vmohQ3P7cO/ZS7ygZl7sY6A=
Date:   Fri, 1 Jul 2022 12:35:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Albert Wang <albertccwang@google.com>
Subject: Re: [PATCH] USB: hub: add module parameters to usbcore for port init
 retries
Message-ID: <Yr7N5ZjKLpeQflxd@kroah.com>
References: <20220617102256.3253019-1-raychi@google.com>
 <YrFxLYibDtyuxSO6@kroah.com>
 <CAPBYUsBbP7ssGXSRyWN46u1-Qaa712QLm748FhJ-M3pANZUsng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsBbP7ssGXSRyWN46u1-Qaa712QLm748FhJ-M3pANZUsng@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:46:42PM +0800, Ray Chi wrote:
> On Tue, Jun 21, 2022 at 3:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jun 17, 2022 at 06:22:56PM +0800, Ray Chi wrote:
> > > Currently, there is a Kconfig (CONFIG_USB_FEW_INIT_RETRIES) to
> > > reduce retries when the port initialization is failed. The retry
> > > times are fixed and assigned in compile time. To improve the
> > > flexibility, this patch add four module parameters:
> > > port_reset_tries, set_address_tries, get_descriptor_tries,
> > > and get_maxpacket0_tries, to replace the original default values.
> > >
> > > The default value of module parameters is the same as before
> > > to preserve the existing behavior.
> > >
> > > Signed-off-by: Ray Chi <raychi@google.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         | 16 ++++++++++
> > >  drivers/usb/core/hub.c                        | 31 ++++++++++++++++---
> > >  2 files changed, 42 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 8090130b544b..c467b2778128 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -6277,6 +6277,22 @@
> > >                       USB_REQ_GET_DESCRIPTOR request in milliseconds
> > >                       (default 5000 = 5.0 seconds).
> > >
> > > +     usbcore.port_reset_tries=
> > > +                     [USB] Set the retry time of port reset for each
> > > +                     port initialization (default PORT_RESET_TRIES = 5).
> > > +
> > > +     usbcore.set_address_tries=
> > > +                     [USB] set the retry time of set address for each
> > > +                     port initialization (default SET_ADDRESS_TRIES = 2).
> > > +
> > > +     usbcore.get_descriptor_tries=
> > > +                     [USB] set the retry time of set address for each
> > > +                     port initialization (default GET_DESCRIPTOR_TRIES = 2).
> > > +
> > > +     usbcore.get_maxpacket0_tries=
> > > +                     [USB] set the retry time of get maxpacket0 for each
> > > +                     port initialization (default GET_MAXPACKET0_TRIES = 3).
> > > +
> > >       usbcore.nousb   [USB] Disable the USB subsystem
> > >
> > >       usbcore.quirks=
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index b7f66dcd1fe0..c5c695886424 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -2788,6 +2788,27 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
> > >  #define HUB_LONG_RESET_TIME  200
> > >  #define HUB_RESET_TIMEOUT    800
> > >
> > > +/* define retry time for port reset */
> > > +static int port_reset_tries = PORT_RESET_TRIES;
> > > +module_param(port_reset_tries, int, S_IRUGO|S_IWUSR);
> > > +MODULE_PARM_DESC(port_reset_tries, "retry times of port reset for each port initialization");
> >
> > Please no.  Module parameters are from the 1990's, let us never add new
> > ones if at all possible.
> >
> > These are global options, for all devices in the system.  Instead, use
> > per-device settings if you really need to change these values.
> 
> Sorry for the late reply.
> Since the driver is using define macro to decide the retry time
> currently, we can't
> modify the value directly. Do you mean setting by device tree for
> per-device settings? or other methods?

Yes, anything other than a module parameter as you just modified the
value of ALL devices in the system, which I do not think you really
want, right?  Odds are you just want to be able to work around a broken
internal USB hub, and do not want this option changed for anything that
a user plugs into the system, right?

> > But I would even push back on that and ask why these values need to be
> > changed at all.  What hardware is broken so badly that our timeout
> > settings do not work properly?  Can we modify them gracefully to "just
> > work" without any need for tweaking or requiring any modification by a
> > user at all?  That would be the better solution instead of requiring
> > users to do this on their own when confronted by misbehaving hardware.
> 
> I got some reports from end users, but I couldn't see the hardware
> information due to
> enumeration not being complete. There are too many hardwares owned by end users.
> It is hard to make work for all of them. In addition, some users just
> tried to reboot the Host device
> when they found their connected hardware not working. It would cause
> the device reset or hang
> due to the retry mechanism. This is why I want to modify the retry times.

So this is for external devices?  Then just change the kernel build
option for those systems?  In all the 20+ years, we haven't seen a real
need for this yet, what just changed to require it?

thanks,

greg k-h
