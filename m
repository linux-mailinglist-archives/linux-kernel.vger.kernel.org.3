Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BC590BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiHLGAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiHLF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4BA573F;
        Thu, 11 Aug 2022 22:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5526130A;
        Fri, 12 Aug 2022 05:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364D5C433D6;
        Fri, 12 Aug 2022 05:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660283967;
        bh=G4iQ0XGJX3p+R2kdOIEn5fZJufsQFy2I5LfUJ+ohZzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYxsraJoB7bHM8KItK9772vVNv9mjuNUjNnY9mBVY+niU8VTeB6yZVsqN7YgA7jXg
         HRfsbljZ8AkrT84LCjNZunzqEGZ26cFvva0CuOMnftXoHfojT8tWVzhVM6NT5sWE62
         qexXxCN6TEQYC8onujfysVXo+s+fxu7Al1UWK56s=
Date:   Fri, 12 Aug 2022 07:59:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] USB: trancevibrator: simplify tv_probe
Message-ID: <YvXsPQjC83N9iNVI@kroah.com>
References: <20220811090213.35899-1-dzm91@hust.edu.cn>
 <20220811090213.35899-2-dzm91@hust.edu.cn>
 <YvTGlV/RIN1QCce8@kroah.com>
 <CAD-N9QWJt5_XyfdjWyN8q9HjBNnm=nzb2t+C+RS-mxEXTyZo2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QWJt5_XyfdjWyN8q9HjBNnm=nzb2t+C+RS-mxEXTyZo2g@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 08:21:00AM +0800, Dongliang Mu wrote:
> On Thu, Aug 11, 2022 at 5:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 11, 2022 at 05:02:09PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > The function tv_probe does not need to invoke kfree when the
> > > allocation fails. So let's simplify the code of tv_probe.
> > >
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/usb/misc/trancevibrator.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
> > > index 55cb63652eda..30d4d774d448 100644
> > > --- a/drivers/usb/misc/trancevibrator.c
> > > +++ b/drivers/usb/misc/trancevibrator.c
> > > @@ -84,22 +84,15 @@ static int tv_probe(struct usb_interface *interface,
> > >  {
> > >       struct usb_device *udev = interface_to_usbdev(interface);
> > >       struct trancevibrator *dev;
> > > -     int retval;
> > >
> > >       dev = kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
> > > -     if (!dev) {
> > > -             retval = -ENOMEM;
> > > -             goto error;
> > > -     }
> > > +     if (!dev)
> > > +             return -ENOMEM;
> > >
> > >       dev->udev = usb_get_dev(udev);
> > >       usb_set_intfdata(interface, dev);
> > >
> > >       return 0;
> > > -
> > > -error:
> > > -     kfree(dev);
> > > -     return retval;
> > >  }
> > >
> > >  static void tv_disconnect(struct usb_interface *interface)
> > > --
> > > 2.35.1
> > >
> >
> >
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for what needs to be done
> >   here to properly describe this.
> 
> Sorry, Greg. I forget to add the changes:
> 
> v1->v2: fix the truncated subject of PATCH 2/2.
> 
> Shall I resend another v2 patch with change information or send a v3
> patch with this information?

v3 please.
