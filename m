Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3A5AB72C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiIBRH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiIBRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:07:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6640C110D85
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:07:50 -0700 (PDT)
Received: (qmail 278413 invoked by uid 1000); 2 Sep 2022 13:07:49 -0400
Date:   Fri, 2 Sep 2022 13:07:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mathias.nyman@linux.intel.com,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] usb: core: stop USB enumeration if too many retries
Message-ID: <YxI4ZViLkZOjN/Bh@rowland.harvard.edu>
References: <20220902091535.3572333-1-raychi@google.com>
 <YxIX+jqWFfwAWYot@rowland.harvard.edu>
 <CAPBYUsApTYex027qBe-=EyUxDHb8MMQscX+2jqZ98zXxN-0tHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsApTYex027qBe-=EyUxDHb8MMQscX+2jqZ98zXxN-0tHA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 12:08:04AM +0800, Ray Chi wrote:
> On Fri, Sep 2, 2022 at 10:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Sep 02, 2022 at 05:15:35PM +0800, Ray Chi wrote:
> > > If a broken accessory connected to a USB host, usbcore might
> > > keep doing enumeration retries and it will take a long time to
> > > cause system unstable.
> > >
> > > This patch provides a quirk to specific USB ports of the hub to
> > > stop USB enumeration if needed.
> >
> > This seems very awkward.  Why not have a quirk that prevents USB
> > enumeration completely, instead of after some number of retries?  After
> > all, if the port is connected to a broken accessory, there's no reason
> > to try enumerating it even once.
> >
> > For that matter, have you tried using the existing "disabled" port
> > attribute instead of adding a new quirk?  Does it already solve your
> > problem?
> >
> 
> Since we don't know if the connected accessory is normal or broken, doing port
> initialization is necessary.

I don't understand.  If you don't know whether the accessory is broken, 
how do you know whether to set the quirk?

On the other hand, if you always set the quirk even before you know 
whether the accessory is broken, why make it a quirk at all?  Why not 
make it the normal behavior of the driver?

> > > +              * Some USB hosts can't take a long time to keep doing enumeration
> > > +              * retry. After doing half of the retries, we would turn off the port
> > > +              * power to stop enumeration if the quirk is set.
> >
> > What made you decide that half of the retries was the right place to
> > stop?  Why not do all the retries?
> 
> Since some normal devices will be timeout in the first attempt, I set
> the condition to half
> of the retries. All the retries will take 12*timeout seconds. It is
> too long so that a watchdog
> timeout problem may happen.

Why not set CONFIG_USB_FEW_INIT_RETRIES instead?

> > If the quirk prevented enumeration completely then this function
> > wouldn't be needed.
> 
> The enumeration is still needed as above.
> 
> >
> > > +
> > >  /* Check if a port is power on */
> > >  int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
> > >  {
> > > @@ -4855,6 +4879,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> > >                                       buf->bMaxPacketSize0;
> > >                       kfree(buf);
> > >
> > > +                     if (r < 0 && (port_dev->quirks & USB_PORT_QUIRK_STOP_ENUM)) {
> >
> > How come this line tests the quirk but doesn't call
> > hub_port_stop_enumerate()?
> 
> Since the quirk is used to stop enumeration and reduce the total time.
> If the port has the quirk, I think the port doesn't need to do
> set_address after the port gets
> failures in the new scheme. It will add 2 attempts * timeout (defined
> in hc_driver) seconds.

I still can't tell what you're trying to accomplish.  You need to do a 
much better job of explaining the point of this.  For instance, you 
might describe in detail a situation where the quirk is needed, 
explaining what sort of behavior of the system would lead you to set the 
quirk, and why.

Alan Stern
