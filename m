Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D554598F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiFJB2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiFJB2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:28:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489EF3A1A5;
        Thu,  9 Jun 2022 18:27:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so50636668ejj.10;
        Thu, 09 Jun 2022 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzngdOuc+eP5DPOwAieaNtUEJhlqA6slW8XA9oYN7qo=;
        b=KyQOB2XAFGaun8DWOS/tb6rz+mun/ModYr9ZAdBr2ZUo1imTU9PTsiBm+xx5UDfua5
         Jd6/7uCTtr+E5Y3M2piZtxpVYEFnlNgVlR9riJMc3nUpghEjHGsbH1jB4yePs7A8lOTc
         feuS9w/wfbpp8WGmSdzSELRIVppuJRZQoQstgyJjoC6Vg9OBHsJy6aCPPuNi9HcHy9Q2
         lwpQTCLvCStRcALwIMp09OpSABJ1vqzhTYKZ/T2tOUdoVBp9K7s7SBinY14wZ3YJyjre
         xXIZZYKnYaiLPjeAFPYp8lyBM7FsJgLbJHGHdltzgYoEmO1cOYZInrypOzJ6lEgvTFBw
         166Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzngdOuc+eP5DPOwAieaNtUEJhlqA6slW8XA9oYN7qo=;
        b=JBlf29jWhwg9+PIAcd8S8qTfjF/J2/qMGDdDHZvxFIYp56SoOL560r8A2rUzxpZ2Ye
         pOZMMCKA2dBOHFb14CTJE1np8YjNFU2si9L2MgFSSyeTmcyZQgT2h2MBloY8rbtSuoDQ
         E3WM2xA9TdcX545f66O95zl57wYVRRVRBmqW+STz/tj/p9kLarujk3MFpPU5LRmoTkY1
         wCkeqBoxsgb/PpNhb4CRb3IMb88WiBE8ny7FTBL9hCVOM7vJUeH6EQMeNlXv2B5S7eW1
         kcDLjqXGh+99D+CPL2Ny+5rdZDQqTzhH9XwSCnuJHy1bseZUxszCXWZ5AbqwF3xRT/+K
         2OJQ==
X-Gm-Message-State: AOAM533nWXBM5ARvqM1CxWFg94O1eqVszYaEowy5nje/2RE8KWoI2Izx
        wwQmyAsfC4XbWlDhpNe4opLDV6auoP8i8iM0uY4=
X-Google-Smtp-Source: ABdhPJxprE64uswT/J+aAD9S3F15hbY6GcvxE1pi5IWJKz2WY17MxaOpqPV/O7TE8EyZ8zGHBHHxLjjwIVP55eHU8eM=
X-Received: by 2002:a17:907:3f9f:b0:6fe:f9e2:9c6a with SMTP id
 hr31-20020a1709073f9f00b006fef9e29c6amr39916405ejc.479.1654824473738; Thu, 09
 Jun 2022 18:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220602055027.849014-1-dzm91@hust.edu.cn> <YphciEToNtxIUrzU@hovoldconsulting.com>
 <CAD-N9QUfeN7qQ-S20x9mU=-rd38nPFeont2dYT2+-phTxdqMvA@mail.gmail.com> <YqH86qB4wfYctyYP@hovoldconsulting.com>
In-Reply-To: <YqH86qB4wfYctyYP@hovoldconsulting.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 10 Jun 2022 09:27:27 +0800
Message-ID: <CAD-N9QVQpm87wpCnLj08db3kAr=b191op3=ESOMm1yh7UWu4jw@mail.gmail.com>
Subject: Re: [PATCH] media: flexcop-usb: fix sanity check of bNumEndpoints
To:     Johan Hovold <johan@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        gushengxian <gushengxian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 10:00 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 09, 2022 at 09:42:15AM +0800, Dongliang Mu wrote:
> > On Thu, Jun 2, 2022 at 2:45 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, Jun 02, 2022 at 01:50:24PM +0800, Dongliang Mu wrote:
> > > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >
> > > > Commit d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type
> > > > ") adds a sanity check for endpoint[1], but fails to modify the sanity
> > > > check of bNumEndpoints.
> > > >
> > > > Fix this by modifying the sanity check of bNumEndpoints to 2.
> > >
> > > Are you sure that d725d20e81c2 ("media: flexcop-usb: sanity checking of
> > > endpoint type) was correct?
> >
> > I am not sure if fc_usb->uintf->cur_altsetting->endpoint[1] is right or not.
> >
> > But the sanity check of bNumEndpoints does not match the following dereference.
>
> I should know better than try to be subtle on the internet: Your fix is
> wrong.
>
> You need to try to understand the code you're changing. Not just do
> pattern matching.

I see. Yeah, I have such an incorrect assumption - previous commits
should be somehow correct since maintainers already review them.

Next time, I will dig more about the code logic and try to post a more
comprehensive patch.

>
> > > > Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > > >  drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
> > > > index 7835bb0f32fc..eb54bfdda01f 100644
> > > > --- a/drivers/media/usb/b2c2/flexcop-usb.c
> > > > +++ b/drivers/media/usb/b2c2/flexcop-usb.c
> > > > @@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
> > > >               return ret;
> > > >       }
> > > >
> > > > -     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
> > > > +     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
> > > >               return -ENODEV;
> > > >       if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
> > > >               return -ENODEV;
> > >
> > > It looks like it should have verified the type of endpoint[0] here
> > > instead.
> >
> > This sanity check originally makes sure the
> > fc_usb->uintf->cur_altsetting->endpoint[0] in
> > flexcop_usb_transfer_init.
>
> Yes, and that is the only endpoint that this driver uses.

This needs an understanding of the working mechanism of this hardware.

>
> I've posted a fix here:
>
>         https://lore.kernel.org/r/20220609135341.19941-1-johan@kernel.org
>
> Johan
