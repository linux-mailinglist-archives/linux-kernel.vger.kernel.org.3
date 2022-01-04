Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC614846EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiADRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiADRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:23:19 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D1C061761;
        Tue,  4 Jan 2022 09:23:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e202so67309876ybf.4;
        Tue, 04 Jan 2022 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0fxJwxcEgSkj2eOcXcyDIdZlfD4jD3cTZQSlVi3VC4=;
        b=g7lv72VwhePNwXMdQ/rFPweyWzUbE+AghjJN/3wfZVt2co0OW9JMC5Ev76qVJTjMBl
         rPyqbW32YyH33Iy3nd79Jcb4DhmwAXCqP7heBhKL+L/0bqoib6tDBh49g9EUqzDtOccb
         8RsudYJeMqrBxyyB4GhHIjV3AQeA4ifFk59hhOfVjSCJa2Ep2E+bhVg+9HdN1m7f+o4Q
         BhS92lWreXqeGmSqUSGtCY+Xpm8YUC2s6yJm7Jb/xFhnmGiaW0q4XBR2M0iGggtQHMLN
         05/yVW2US5XjPJF6LWQuYoGBIfyqDLjuYH6EDjG4R/MHzJK7tO23GHId8kOTajcLJTNy
         06LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0fxJwxcEgSkj2eOcXcyDIdZlfD4jD3cTZQSlVi3VC4=;
        b=YSvuYRDOQGeeXF6tLUIeGJBBSWMPbb8NdxYBR7Fu+nvhT95Op1dLYO+QwDrPQWqHwy
         mhFjxFigCiBepEItB1KC7Knf1vXkhR08Z3mNyvhKjTUI2jcXAeCLvRBjrrZxDk7e9xwD
         jCtOFZkG/UrTQ928vXEZnly6hZH2OyNWv5G6LudV7FL4AurwYpzSjxEdyOPqOXSA1yTE
         uYXwRtoshGXHZK82EKCrU9fZz29gHtrJpjiY84OEH1lzU/2pmKJMVs2UwpLZq0by7wCY
         lZKZ3Z+WJwu/Duh+MDf4warSVZSgafYFsqTiIw71Ydfu5SOWWN5Hun7x5d9gCj/DDRMX
         hAgw==
X-Gm-Message-State: AOAM5310JPA95uaiClCVE+4B0nvq/d/7avrYD1Lku7mqn1lxOqi32HB0
        UZoH2vohaX6HHiy2Ms++Uzj9/eCX+1akkohxpZg=
X-Google-Smtp-Source: ABdhPJzX8CvCO/xMMrYlbfQT3Al/CwKUdR85sCz+78pZQWHGLSP6nhp+UgQPf8uvwEeRWSqlSYbFS43MSBFm8BhQtnE=
X-Received: by 2002:a25:44c:: with SMTP id 73mr47947529ybe.186.1641316998829;
 Tue, 04 Jan 2022 09:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
In-Reply-To: <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jan 2022 17:22:52 +0000
Message-ID: <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > Also this patch propagates error code in case devm_request_irq()
> > fails instead of returing -EINVAL.
>
> returning
>
> ...
>
> > +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > +       res_irq->start = irq;
> > +       res_irq->end = irq;
> > +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
>
> If you convert DEFINE_RES_NAMED() to return a compound literal, then
> you may use it here like
>
> res_irq = DEFINE_RES_NAMED(...);
>
> or even do like this
>
> if (dev_of_node(...))
>   res_irq = DEFINE_RES_IRQ_NAMED(...)
> else
>   res_irq = DEFINE_RES_IRQ(...);
> res_irq->flags |= irq_get_trigger_type(irq);
>
There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_IRQ()
changing this macos just for this single user tree wide doesn't make
sense. Let me know if you think otherwise.

> I'm not sure why you can't simply use the NAMED variant in both cases
> (yes, I see that of_node_full_name() will return something, not NULL).
>
> ...
>
> > +       while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
> > +               if (err < 0)
> > +                       goto vpif_unregister;
>
> Needs a better error checking, i.e. consider 0 as no-IRQ (equivalent
> to -ENXIO (note, OF code never returns 0 as valid vIRQ).
>
Will fix that.

> >                 res_idx++;
> >         }
>
> ...
>
> > +       while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
> > +               if (err < 0)
> > +                       goto vpif_unregister;
>
> Ditto.
>
Will fix that.

Cheers,
Prabhakar
