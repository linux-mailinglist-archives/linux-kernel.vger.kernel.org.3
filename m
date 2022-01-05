Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99DC48504D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiAEJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbiAEJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:43:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72704C061761;
        Wed,  5 Jan 2022 01:43:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u25so38205428edf.1;
        Wed, 05 Jan 2022 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRnc55tj1n+sPsEdp+WydV/2BKtzEcvrsCdVOsyMvCY=;
        b=V4Uv8OTwrK12FN5pqgjMBFW02myUtTtOFjbcZ2DJv63kZ08yeTlmcY0q2LiHANMB3o
         8gxEpCLzaQ5v6AhGNf4A3zlpu74oRyxVIoLyyfQGMALQmwk5LSiK/vgYKwljud5cAo83
         ZBvfTx2AF3L4ampONPW1a4nJgSp+RfydCqKUXvkctv4O6ViWr0u2urqyWY+dmsPzmYSC
         aJBgoAD3aahK6Mj/5e22bJeI17nW9klvQodLx+ZS2QnxUdUz7CYQluyOMec/wNDx77HS
         2wA64IRL8KCmH4SiC9q5EGoyAfMUnWBWtbNiBlwmISZdfwEy1Oc9dMvXspdN2f4z8Q50
         KtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRnc55tj1n+sPsEdp+WydV/2BKtzEcvrsCdVOsyMvCY=;
        b=a2IFaR0SMo8J5O8ujnvfpObUxI/TzMPDIUZ0Tn+KcMgC3ZoeATnW3KMXts0HGgzIdm
         3lQSzhWR3AT2Scd/eNZyGZ7hfa8ha6MYEq1b8cW7lzMUv7KdT2e4YmMX1S55t89ahRo5
         U0Mf1wKwq3sucAFOEnTIgdxCQuhAeimCAMrKJ520WCr+890a1YJEFouqGhCUqUnoYZ5E
         ezn+YxwF1EEm43J+j5beJkP+BMzeH71mqXLCFui/GgOhUGyjfXrcySu02Cw87iRr6Mrc
         oQehEAcWMiyCU+iDRp/iJk1AbtZcBp3RTJCvKSyvvC24Y6c4bGUcix9Oifo2+am6nK3T
         7EJw==
X-Gm-Message-State: AOAM533vPAAW0fBabVbCweNA5ziwOUwYrrN7GZuuZB/OoDHfOskpAj3C
        EFU54K26CEz1OHAG8KWSvL67LSHZfovbKvC6ME7EGHJh46E=
X-Google-Smtp-Source: ABdhPJw+yXBWPZdlcIIEHa1kJ4MswCCkaOb0VlpzkZxV6oeFtzhRWMnYYFFahSiDE3WKkGq1LjHROuVd9hAiP8kEgZg=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr49326091edd.29.1641375799944;
 Wed, 05 Jan 2022 01:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com> <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
In-Reply-To: <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:42:43 +0200
Message-ID: <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

On Tue, Jan 4, 2022 at 7:23 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

...

> > > +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > > +       res_irq->start = irq;
> > > +       res_irq->end = irq;
> > > +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
> >
> > If you convert DEFINE_RES_NAMED() to return a compound literal, then
> > you may use it here like
> >
> > res_irq = DEFINE_RES_NAMED(...);
> >
> > or even do like this
> >
> > if (dev_of_node(...))
> >   res_irq = DEFINE_RES_IRQ_NAMED(...)
> > else
> >   res_irq = DEFINE_RES_IRQ(...);
> > res_irq->flags |= irq_get_trigger_type(irq);
> >
> There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_IRQ()
> changing this macos just for this single user tree wide doesn't make
> sense. Let me know if you think otherwise.

Converting them to produce compound literal is straightforward and
does not require changes in the users. But on the other hand it allows
you to use it and convert existing users to use that form directly.
You may conduct research on how macros in the property.h were morphing
towards that.

> > I'm not sure why you can't simply use the NAMED variant in both cases
> > (yes, I see that of_node_full_name() will return something, not NULL).

-- 
With Best Regards,
Andy Shevchenko
