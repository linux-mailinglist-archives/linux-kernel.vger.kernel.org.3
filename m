Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC0544128
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiFIBmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFIBmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:42:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C833B8;
        Wed,  8 Jun 2022 18:42:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so44597303ejj.10;
        Wed, 08 Jun 2022 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0D6cN8jS/qYdBTypuq5K9ywfnqqlVZ8+NqAm1ZmKmc=;
        b=HiSay6sxsKO0+hO5tj9o5ilp1GDilE+uZ8igw4cYdaLJh8UiWbG8SAIRLrbhYExmB+
         XbPE7ThqXmPWdyk3J4ZRVCYk/dfZsTqmOPVydK+bbCoBQpe+1zD2OxIgtX25yxVIEN4/
         bIjGRjBEQnMRqXglRvw/0/JHkdjt9E4FwO4Oh1nWIAXoBML1ZmQpJK+a4PiL0S4PcyyG
         qqROQxVo1lqHo6pgMEKUNd6xzUV+FS8WNye6Ifsx3wD9KvnT0g19xp9v2qeRreQSqJ/q
         iB3qQd+wMI4kH3qjctBiOy3UwGj1gX1QBB22As79vDFGeLdSfQfx4otKQkunRkx3ZXsl
         RF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0D6cN8jS/qYdBTypuq5K9ywfnqqlVZ8+NqAm1ZmKmc=;
        b=acXp6uuGIxGrc3HVfwg/wk6T9KKBfw83PdtlU+rUC+xLbfBIcLT6FxCsn/srbpVpJb
         qQeJXqyUeCHc9x/qoOkMMuGG8vwcVUd7jQrquCSH4HeeYBMhVpu9U4g/pyH5A7CAxsJo
         5lXhlXXnzI/8glqGf7/B5DR6fL4phu6q2//gOdsYKr9y73UFf2XzQ3s4qCNT2G9KNCJV
         NymB2UgalLN4dBFTeSq8BPDaVEwJsOuwUnRa1iYlt2CJUyRgs4z7JhpCf2lj0nFA/pjZ
         KbvZl7ZEMXce5R9HSO4enfh7PEoBsVukFoUeqp+JMXViEHxw7gBHdAVDXhEnBQ48uvKo
         29CA==
X-Gm-Message-State: AOAM532OgCBbBN77t211MNIExj/ZIJS9wdBW2V0fpIrD17VVVFNlqV5q
        XdqMJqzpYyD+anWDd4Se8dmlhDJdfvWT3agTK7iu6sjSFHyHqQ==
X-Google-Smtp-Source: ABdhPJxjXyFe963JsF83KfFkzmpO8DbHh3Ti6uCH6u9+/RaMYvtQF/dkXbIyki90EC3TxC17/KzABdyNtshxtR3MALo=
X-Received: by 2002:a17:907:7245:b0:711:d1ff:2ca4 with SMTP id
 ds5-20020a170907724500b00711d1ff2ca4mr16570995ejc.753.1654738961248; Wed, 08
 Jun 2022 18:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220602055027.849014-1-dzm91@hust.edu.cn> <YphciEToNtxIUrzU@hovoldconsulting.com>
In-Reply-To: <YphciEToNtxIUrzU@hovoldconsulting.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 9 Jun 2022 09:42:15 +0800
Message-ID: <CAD-N9QUfeN7qQ-S20x9mU=-rd38nPFeont2dYT2+-phTxdqMvA@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 2:45 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 02, 2022 at 01:50:24PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Commit d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type
> > ") adds a sanity check for endpoint[1], but fails to modify the sanity
> > check of bNumEndpoints.
> >
> > Fix this by modifying the sanity check of bNumEndpoints to 2.
>
> Are you sure that d725d20e81c2 ("media: flexcop-usb: sanity checking of
> endpoint type) was correct?

I am not sure if fc_usb->uintf->cur_altsetting->endpoint[1] is right or not.

But the sanity check of bNumEndpoints does not match the following dereference.

>
> > Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
> > index 7835bb0f32fc..eb54bfdda01f 100644
> > --- a/drivers/media/usb/b2c2/flexcop-usb.c
> > +++ b/drivers/media/usb/b2c2/flexcop-usb.c
> > @@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
> >               return ret;
> >       }
> >
> > -     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
> > +     if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
> >               return -ENODEV;
> >       if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
> >               return -ENODEV;
>
> It looks like it should have verified the type of endpoint[0] here
> instead.

This sanity check originally makes sure the
fc_usb->uintf->cur_altsetting->endpoint[0] in
flexcop_usb_transfer_init.

>
> Oliver?
>
> Johan
