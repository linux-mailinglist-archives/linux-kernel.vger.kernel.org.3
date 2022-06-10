Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC1545D70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbiFJHaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346881AbiFJH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCD559B;
        Fri, 10 Jun 2022 00:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8098E61FD6;
        Fri, 10 Jun 2022 07:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E06C34114;
        Fri, 10 Jun 2022 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654846178;
        bh=jNsd0kuZCZ1CNIJYpIFtvU1hgHvp2sYZQcvjXBIrM8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvKhmR6Q0fp41iNBJJAoTF9qMnXaKDFj27FquI70np8DEgKD73PxHaovUFUvYGwjU
         JhGdWcRljWRH7UofR4M8DPsJk42gZJ7e/2BwxzOYPS66UfBVx0yMFWxZyGDyneyHJx
         xGeEQO4Qx29VmHrYfTgtx7QaH2Q4CtIqqIUTVnfsFbgChcV3gBbHvjDexuCwmmjj6h
         FMBkfaOy2jr3lN3DmyGrnIkI+XPp9XeIBbayKzAecoj1xLQWSqflysgsE84ja6Y6qe
         l6zjMqyzSLbAOJMbBeh01Z6k4+mTa/Jw2XJY2NuFHWHVQhio7tTLEn/MxBDNIrBgb5
         yAKlJm+DCBQpg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzZ5J-0007FW-VV; Fri, 10 Jun 2022 09:29:34 +0200
Date:   Fri, 10 Jun 2022 09:29:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        gushengxian <gushengxian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: flexcop-usb: fix sanity check of bNumEndpoints
Message-ID: <YqLy3QpRxnSrj7ge@hovoldconsulting.com>
References: <20220602055027.849014-1-dzm91@hust.edu.cn>
 <YphciEToNtxIUrzU@hovoldconsulting.com>
 <CAD-N9QUfeN7qQ-S20x9mU=-rd38nPFeont2dYT2+-phTxdqMvA@mail.gmail.com>
 <YqH86qB4wfYctyYP@hovoldconsulting.com>
 <CAD-N9QVQpm87wpCnLj08db3kAr=b191op3=ESOMm1yh7UWu4jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVQpm87wpCnLj08db3kAr=b191op3=ESOMm1yh7UWu4jw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 09:27:27AM +0800, Dongliang Mu wrote:
> On Thu, Jun 9, 2022 at 10:00 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jun 09, 2022 at 09:42:15AM +0800, Dongliang Mu wrote:
> > > On Thu, Jun 2, 2022 at 2:45 PM Johan Hovold <johan@kernel.org> wrote:

> > > > Are you sure that d725d20e81c2 ("media: flexcop-usb: sanity checking of
> > > > endpoint type) was correct?
> > >
> > > I am not sure if fc_usb->uintf->cur_altsetting->endpoint[1] is right or not.
> > >
> > > But the sanity check of bNumEndpoints does not match the following dereference.
> >
> > I should know better than try to be subtle on the internet: Your fix is
> > wrong.
> >
> > You need to try to understand the code you're changing. Not just do
> > pattern matching.
> 
> I see. Yeah, I have such an incorrect assumption - previous commits
> should be somehow correct since maintainers already review them.

Everyone makes mistakes and our review process isn't perfect.

And if your assumption was correct we wouldn't have any bugs at all.

> Next time, I will dig more about the code logic and try to post a more
> comprehensive patch.

Sounds good.

> > > > > Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
> > > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > > ---
> > > > >  drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
> > > > > index 7835bb0f32fc..eb54bfdda01f 100644
> > > > > --- a/drivers/media/usb/b2c2/flexcop-usb.c
> > > > > +++ b/drivers/media/usb/b2c2/flexcop-usb.c
> > > > > @@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > -     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
> > > > > +     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
> > > > >               return -ENODEV;
> > > > >       if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
> > > > >               return -ENODEV;
> > > >
> > > > It looks like it should have verified the type of endpoint[0] here
> > > > instead.
> > >
> > > This sanity check originally makes sure the
> > > fc_usb->uintf->cur_altsetting->endpoint[0] in
> > > flexcop_usb_transfer_init.
> >
> > Yes, and that is the only endpoint that this driver uses.
> 
> This needs an understanding of the working mechanism of this hardware.

Not really, you only need to look at the driver in this case. But sure,
you need some familiarity with USB to understand what is going on.

Johan
