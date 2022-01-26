Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88A249D589
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiAZWhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAZWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:37:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17EC06161C;
        Wed, 26 Jan 2022 14:37:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p63so543538iod.11;
        Wed, 26 Jan 2022 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Gr+VjFFLhz7S6VXwMqEIihZJ584fho7AEDsoOCYiI0=;
        b=U0mnARbKSH7vnAwcMrBYC5RtAm7VrIUN42wZLa5SWUbXGUxMmCvRo6gD6AnRGzfEBe
         QeZdfBlSy/yMuqUtRS61e8VOHemccXUPCYOmzWdvjiqds17/YVDk8Gp1QvKblRe82Uwv
         4LSdHBGAe3t0k11Fkad+X56S/JyjSLFx/J3V7SBbPE10sULYee5gTZuMQZc0C8dbw3D+
         rIunNFJ1z39YoFcW28VDVebaefiKjOtsLFwRleXDXKBSn5SnEqmY2HVgh+XReZ0kvvwH
         w6P7ef94/Wf2X4SDaZfywEyLUs+qTyyUzGCwDM2XFIdSE3NLFvZz32Z9uGb9Ndc4HAhW
         DK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Gr+VjFFLhz7S6VXwMqEIihZJ584fho7AEDsoOCYiI0=;
        b=5feHn2gK6reOjB1Kaexj/65t6zevtUay58Js6kgkqu24qSaF7WzfkHUMI+06+paLvM
         NcPlx7aACrAtrVJQb7piLwko4Z7mq3M/tV9LW4RkJh1kkjU4l6r7uN8PlxHSWNHYeUnz
         W1JXGrkqAEQqcPJdOkyWpMABd+UsDZcYxaKiprKW9ngURUlubDuBDRFWETCt3hbHfaH+
         IBCc41/Vo/DEtCb8ZGATTt7EoteSch0KFGla9T0g5QFU7UJEvLNK4inS/4mEMXBM6e9j
         BWKvKVdBSCYrvUR3WHxURLcuLsPLbdDqiHVSaBIJ/J4XDPcaMv0NK0Gp/QsMUFO+G6mn
         GCMQ==
X-Gm-Message-State: AOAM532nzY86mfEG/8xwIKMQWrVbAxsh6YdZZRKiUbgGx4fTQKf4Iysk
        8TVux7o/Am8sKSbiroAYPJARVgWbsfUYy6Ef7e8=
X-Google-Smtp-Source: ABdhPJzGCPKmUKac8oqOoS6GtvYoUTDDesEjikIlkXwKxeU9U35wfUUCY0XJ6wfatw2r58N4ahfTV+u1SnMJno56n28=
X-Received: by 2002:a02:c496:: with SMTP id t22mr453240jam.117.1643236662760;
 Wed, 26 Jan 2022 14:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20220126205214.2149936-1-jannh@google.com> <CA+fCnZe_p+JwUWwumgGm185vWSdAK_z-UFDp7-HWKANB4YjA=g@mail.gmail.com>
 <CAG48ez0pke5fqEuWGecMAKLpsdVoW3JM3M-SkajHcq_dsrQ_4A@mail.gmail.com>
In-Reply-To: <CAG48ez0pke5fqEuWGecMAKLpsdVoW3JM3M-SkajHcq_dsrQ_4A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 26 Jan 2022 23:37:32 +0100
Message-ID: <CA+fCnZdXpBHFN3u5exkbLkUsPaFVsbFi=evsPd3uMMfV=tKAeg@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: fix handling of dual-direction-capable endpoints
To:     Jann Horn <jannh@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:31 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jan 26, 2022 at 11:12 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > On Wed, Jan 26, 2022 at 9:52 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > Under dummy_hcd, every available endpoint is *either* IN or OUT capable.
> > > But with some real hardware, there are endpoints that support both IN and
> > > OUT. In particular, the PLX 2380 has four available endpoints that each
> > > support both IN and OUT.
> > >
> > > raw-gadget currently gets confused and thinks that any endpoint that is
> > > usable as an IN endpoint can never be used as an OUT endpoint.
> > >
> > > Fix it by looking at the direction in the configured endpoint descriptor
> > > instead of looking at the hardware capabilities.
> > >
> > > With this change, I can use the PLX 2380 with raw-gadget.
> > >
> > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > >  drivers/usb/gadget/legacy/raw_gadget.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > > index c5a2c734234a..d86c3a36441e 100644
> > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > @@ -1004,7 +1004,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
> > >                 ret = -EBUSY;
> > >                 goto out_unlock;
> > >         }
> > > -       if ((in && !ep->ep->caps.dir_in) || (!in && ep->ep->caps.dir_in)) {
> > > +       if (in != usb_endpoint_dir_in(ep->ep->desc)) {
> > >                 dev_dbg(&dev->gadget->dev, "fail, wrong direction\n");
> > >                 ret = -EINVAL;
> > >                 goto out_unlock;
> > >
> > > base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> > > --
> > > 2.35.0.rc0.227.g00780c9af4-goog
> > >
> >
> > Awesome! Thanks for finding this!
> >
> > What do you think about using
> >
> > if ((in && !ep->ep->caps.dir_in) || (!in && !ep->ep->caps.dir_out))
> >
> > instead?
> >
> > It looks less cryptic: if (in and no in caps) or (out and no out caps) => fail.
>
> That's also semantically different, right?
> As I understand it, what we should be checking here is whether the
> direction of the request matches the direction previously specified in
> USB_RAW_IOCTL_EP_ENABLE, not whether the hardware would be capable of
> using the endpoint in the requested direction if it had been
> configured for that direction?
> But I might also be misunderstanding what's going on - it's not like
> I've looked at a spec for this or anything like that, I'm just kinda
> guessing...

Ah, yes, you are right. We already checked caps via
usb_gadget_ep_match_desc() in EP_ENABLE. So here it makes sense to
check that the request direction matches the one in the descriptor.

Your original patch makes sense.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
