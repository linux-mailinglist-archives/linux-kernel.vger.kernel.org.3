Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF25A2F88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiHZTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiHZTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:02:58 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 65FAEA3D09
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:02:56 -0700 (PDT)
Received: (qmail 47706 invoked by uid 1000); 26 Aug 2022 15:02:55 -0400
Date:   Fri, 26 Aug 2022 15:02:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>
Subject: Re: [PATCH] usb: core: stop USB enumeration if too many retries
Message-ID: <YwkY30tkIp6OmCNh@rowland.harvard.edu>
References: <20220826075839.292615-1-raychi@google.com>
 <Ywje7UCqXridmRpw@rowland.harvard.edu>
 <CAPBYUsBBGTdLcBoRRup14hZDQYNbpRqu8Az7ZCVxP7WmctySBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsBBGTdLcBoRRup14hZDQYNbpRqu8Az7ZCVxP7WmctySBg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 01:53:45AM +0800, Ray Chi wrote:
> On Fri, Aug 26, 2022 at 10:55 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Aug 26, 2022 at 03:58:39PM +0800, Ray Chi wrote:
> > > If a broken accessory connected to a USB host, usbcore might
> > > keep doing enumeration retries and it will take a long time to
> > > cause system unstable.
> > >
> > > This patch provides a quirk to specific USB ports of the hub to
> > > stop USB enumeration if needed.
> >
> > Why only to specific ports?
> 
> The specific port means it is connected to a broken accessory.

Then this patch should be about connections to broken accessories, not 
too many retries.  The quirk should make the hub driver permanently 
ignore the port; whether the power is on or off doesn't matter.

Also, you might want to check whether the port connection is fixed 
rather than hot-unpluggable.  If the broken accessory can be unplugged 
from the port then you don't want to disable the port.

> > > Signed-off-by: Ray Chi <raychi@google.com>
> > > ---
> > >  drivers/usb/core/hub.c | 33 +++++++++++++++++++++++++++++++++
> > >  include/linux/usb.h    |  3 +++
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index 2633acde7ac1..0f4097440ffb 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -3081,6 +3081,28 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
> > >       return status;
> > >  }
> > >
> > > +/* Stop enumerate if the port met errors and quirk is set */
> > > +static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
> > > +{
> > > +     struct usb_port *port_dev = hub->ports[port1 - 1];
> > > +     struct usb_device *hdev = hub->hdev;
> > > +
> > > +     if (retries < (PORT_INIT_TRIES - 1) / 2)
> > > +             return false;
> > > +
> > > +     /*
> > > +      * Some USB hosts can't take a long time to keep doing enumeration
> > > +      * retry. After doing half of the retries, we would turn off the port
> > > +      * power to stop enumeration if the quirk is set.
> > > +      */
> > > +     if (port_dev->quirks & USB_PORT_QUIRK_STOP_ENUM) {
> > > +             usb_hub_set_port_power(hdev, hub, port1, false);
> >
> > Why turn the port power off?  Aren't there better ways to stop the
> > enumeration attempts?  When will the power ever get turned back on?
> >
> 
> Because the broken accessory is still connected to the port. Even if we stop
> the enumeration attempts, the port change event will issue a new port
> initialization.

If you know the accessory is broken then there's no reason to pay 
attention to the port change events in the first place.  You can simply 
make port_event() avoid calling hub_port_connect_change() if the quirk 
is set.

Alan Stern

> The implementation is used for dual-role devices, the port power could
> be turned on
> when the host mode restarts again.
> 
> > Why not use the initial_descriptor_timeout module parameter for this
> > purpose?  That's the sort of thing it was meant for.
> >
> 
> As I mentioned above, the usbcore driver will keep doing enumeration attempts if
> the broken accessory is still connected. It never stops. This is why I
> want to turn
> off the port to stop enumeration.
> 
> > Alan Stern
> 
> Thanks,
> Ray
