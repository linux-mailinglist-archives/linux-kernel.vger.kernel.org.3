Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC949D572
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiAZWb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiAZWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:31:26 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E8C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:31:26 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t9so1562243lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUNsPVRrEXPHkK3Ji0dMkXwmQEV06f5oI4lUQbtCdgQ=;
        b=jsJO4FMtL8QAqx4i9W8ApcDSN018jF12jT11t89X6PIzcFwM+6MvrudbuneGoKTYy6
         bMyGjTuyfSohV83FvpbWydz17UuLWxH06z+zrYwsSqBzMjHWRaRWPXbeeLq1iHwqsmCa
         IRMV2RkoWS7LnxRTFdAnh3tdIhWpyfC6LGIsRw47kZWotavzQalJXy9y0Gf+P4ltBQdb
         Ysy4pdK6GCw6vqRMbCaPOsIjZfGxdW1FDYtOf4kKpyaevfoQHBvYth3psXvLinnfsyrP
         yOM67lejYlPg6pK4DGfaymiGN3lzM1pEsOOIZOb92cmaxExKyUpAEIMO5putF6xBP+qg
         bMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUNsPVRrEXPHkK3Ji0dMkXwmQEV06f5oI4lUQbtCdgQ=;
        b=E5Vt0B8aI3v/GO5X9Y/Pd66JJtSyCQR2K15KPxeb0GkhvWkImVfehT36jMCNq07+x8
         B9MUPlic3dEWvEitKZ0FitrdSn/OnjtomTW1+B1VlCCVyDt+KnhYT9A21PecoOKLALHP
         WERiNflaumdKsPyEGOoqLcDDZGzXwyiIO7i6yof/5Dt5Czj2FT9WdbT7SWCLUwAe65bc
         h7bAEJCbN9djQbGW0FjOEVnPaTqV4prsIc6YqTrEM3ZXQTAzPLsPHd7kL9JrEVmMsuew
         vYSJakIQYt1wUXVDlRHJ9NxOaXPbdK1W3y9lwZ+G0Yo1HxLjTy9dA+MxRKC8euVt28p0
         JtWw==
X-Gm-Message-State: AOAM531AZjYb/ThcWn80mfhpN1wf5RaiEr5stmglOz0HmPcbmUVvuGHx
        B+1CJG+Wf0ktij7nC7TjHw3CG4k32aBlHhGGscRwig==
X-Google-Smtp-Source: ABdhPJwzpRK0L6JLh/zhHu1oHlv48GAHDSWcWIP3UKt97ZrojP5cByrEDAD3wG15sVXiJ6zgDtb/fIaf+T/9p/IQZ4k=
X-Received: by 2002:a05:651c:984:: with SMTP id b4mr831849ljq.235.1643236281260;
 Wed, 26 Jan 2022 14:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20220126205214.2149936-1-jannh@google.com> <CA+fCnZe_p+JwUWwumgGm185vWSdAK_z-UFDp7-HWKANB4YjA=g@mail.gmail.com>
In-Reply-To: <CA+fCnZe_p+JwUWwumgGm185vWSdAK_z-UFDp7-HWKANB4YjA=g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Jan 2022 23:30:54 +0100
Message-ID: <CAG48ez0pke5fqEuWGecMAKLpsdVoW3JM3M-SkajHcq_dsrQ_4A@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: fix handling of dual-direction-capable endpoints
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:12 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> On Wed, Jan 26, 2022 at 9:52 PM Jann Horn <jannh@google.com> wrote:
> >
> > Under dummy_hcd, every available endpoint is *either* IN or OUT capable.
> > But with some real hardware, there are endpoints that support both IN and
> > OUT. In particular, the PLX 2380 has four available endpoints that each
> > support both IN and OUT.
> >
> > raw-gadget currently gets confused and thinks that any endpoint that is
> > usable as an IN endpoint can never be used as an OUT endpoint.
> >
> > Fix it by looking at the direction in the configured endpoint descriptor
> > instead of looking at the hardware capabilities.
> >
> > With this change, I can use the PLX 2380 with raw-gadget.
> >
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index c5a2c734234a..d86c3a36441e 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -1004,7 +1004,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
> >                 ret = -EBUSY;
> >                 goto out_unlock;
> >         }
> > -       if ((in && !ep->ep->caps.dir_in) || (!in && ep->ep->caps.dir_in)) {
> > +       if (in != usb_endpoint_dir_in(ep->ep->desc)) {
> >                 dev_dbg(&dev->gadget->dev, "fail, wrong direction\n");
> >                 ret = -EINVAL;
> >                 goto out_unlock;
> >
> > base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> > --
> > 2.35.0.rc0.227.g00780c9af4-goog
> >
>
> Awesome! Thanks for finding this!
>
> What do you think about using
>
> if ((in && !ep->ep->caps.dir_in) || (!in && !ep->ep->caps.dir_out))
>
> instead?
>
> It looks less cryptic: if (in and no in caps) or (out and no out caps) => fail.

That's also semantically different, right?
As I understand it, what we should be checking here is whether the
direction of the request matches the direction previously specified in
USB_RAW_IOCTL_EP_ENABLE, not whether the hardware would be capable of
using the endpoint in the requested direction if it had been
configured for that direction?
But I might also be misunderstanding what's going on - it's not like
I've looked at a spec for this or anything like that, I'm just kinda
guessing...
