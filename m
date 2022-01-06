Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19584866D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiAFPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiAFPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:40:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DACC061245;
        Thu,  6 Jan 2022 07:40:17 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id w184so8498806ybg.5;
        Thu, 06 Jan 2022 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YKFqbxqRhSrpS10gEKkdq6zgQ77RwI60JI4NhfOBth8=;
        b=GQlTSEtVjB8pz+9yfl1zRN8k9cSW8tlJTk/60O1OSAab9wXsSzSR2AfP1SyTPghggm
         R3H2jCiuw2uo1+suvE7iAHJMv+YMN0zp9rL/KgzE39VhtRYzEyMA3rW/aJTelzXrz1hW
         a6B854t6NyMsVWD3a1Zh7KlIzkkHjArhxStrPgL9EdYhzLQYb0XfetkARgtPdTvHLQvw
         6ET7InaKrLehHVlH+DS/MXyncL6EQm+6uVLRwee59/MiII3cUpHa3tZIPw09g7+kCwQ3
         1N1ZIa5l6ULYQcgkPCVqiiYMjuVgbg/D3cqfAoQmmUUlJejodPr4JWcjjQmBLFWz7Q4F
         0VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YKFqbxqRhSrpS10gEKkdq6zgQ77RwI60JI4NhfOBth8=;
        b=Lpb8S52npMzYFZKBK7rWfWt3BhWGEei7FyjqBarUSnc1ts/2uaEnnX/NGG0BJZ+igg
         Z4M8pGt4CAxx/Irlx+ZvWsuScLav4i78opaCvgC9WqAgtN/yd8luqbv0kywx+x+pP6b0
         KXxZU2ONoUqO/58W1DyCrc6wKgWCV8J1rNv70BiKbjLnTcnyuu+X4mBbxaQ9N+Ab5wt1
         8ljXxaXesKPPz3Hgg7i+oZrbuhnkgg4uEQHe2oRuykG7UZMxTOa000HZrUJd9LuJFzWD
         jiHUEehP+G6yRMAW3wbXjQJTFW54CR9RnZil8wJXwDjSAuhPKQrmAejBPbDN49u7SKQ3
         rkFg==
X-Gm-Message-State: AOAM532BOWud52NJK8jo/6T3N871/Ixw+lG4ZtkFQ3bI6e910hxxlZqL
        Ln+oHvoDQjDHv91p9CTO6wngdLtvf9zd53MOrZk=
X-Google-Smtp-Source: ABdhPJzIA3AtEQTXGqxbgw11u0GELqS4RKSp/Z6gEhPYVGeQrt+BzeRO1+w3fxGgvXIigvfwxF0XzUN+inh/Ab9jfQM=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr75641857ybo.613.1641483616417;
 Thu, 06 Jan 2022 07:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YdXt2mDjZ0zikbt6@oden.dyn.berto.se> <CA+V-a8sGh0bCiDu_Eiz3EFgaDPmr-qyz95=dExwf+UvuyA21Cg@mail.gmail.com>
 <YdcK5WWnEtEQk0Fp@oden.dyn.berto.se>
In-Reply-To: <YdcK5WWnEtEQk0Fp@oden.dyn.berto.se>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Jan 2022 15:39:50 +0000
Message-ID: <CA+V-a8v1ijFVVh91eHTD2uSGcinD46Hs9LDV125+_dfmvj6vYw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Thu, Jan 6, 2022 at 3:29 PM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Lad,
>
> On 2022-01-05 19:25:25 +0000, Lad, Prabhakar wrote:
> > Hi Niklas,
> >
> > Thank you for the review.
> >
> > On Wed, Jan 5, 2022 at 7:13 PM Niklas S=C3=B6derlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > >
> > > Hi Lad,
> > >
> > > Thanks for your work.
> > >
> > > On 2022-01-04 14:52:11 +0000, Lad Prabhakar wrote:
> > > > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > > > allocation of IRQ resources in DT core code, this causes an issue
> > > > when using hierarchical interrupt domains using "interrupts" proper=
ty
> > > > in the node as this bypasses the hierarchical setup and messes up t=
he
> > > > irq chaining.
> > > >
> > > > In preparation for removal of static setup of IRQ resource from DT =
core
> > > > code use platform_get_irq_optional().
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v2-v3:
> > > > * Fixed review comment pointed by Andy
> > > >
> > > > v1->v2
> > > > * Simplified checking error code
> > > > * Break loop earlier if no interrupts are seen
> > > >
> > > > v1: https://lkml.org/lkml/2021/12/18/163
> > > > ---
> > > >  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
> > > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_=
thermal.c
> > > > index b49f04daaf47..e480f7290ccf 100644
> > > > --- a/drivers/thermal/rcar_thermal.c
> > > > +++ b/drivers/thermal/rcar_thermal.c
> > > > @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_d=
evice *pdev)
> > > >       struct rcar_thermal_common *common;
> > > >       struct rcar_thermal_priv *priv;
> > > >       struct device *dev =3D &pdev->dev;
> > > > -     struct resource *res, *irq;
> > > > +     struct resource *res;
> > > >       const struct rcar_thermal_chip *chip =3D of_device_get_match_=
data(dev);
> > > >       int mres =3D 0;
> > > >       int i;
> > > > @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_=
device *pdev)
> > > >       pm_runtime_get_sync(dev);
> > > >
> > > >       for (i =3D 0; i < chip->nirqs; i++) {
> > > > -             irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, i=
);
> > > > -             if (!irq)
> > > > -                     continue;
> > > > +             int irq;
> > > > +
> > > > +             irq =3D platform_get_irq_optional(pdev, i);
> > > > +             if (irq < 0 && irq !=3D -ENXIO) {
> > > > +                     ret =3D irq;
> > > > +                     goto error_unregister;
> > > > +             }
> > > > +             if (!irq || irq =3D=3D -ENXIO)
> > > > +                     break;
> > >
> > > This do not look correct and differs form v1.
> > >
> > > In the old code if we can't get an IRQ the loop is continued. This is
> > > used to detect if interrupts are supported or not on the platform.  T=
his
> > > change will fail on all systems that don't describes interrupts in DT
> > > while the driver can function without interrupts.
> > >
> > There are no non-DT users for this driver. Do you see this driver
> > being used in a non-DT environment in near future?
>
> No, maybe I was unclear sorry about that. What I intended to say was
> that this change will break platforms that that make use of this driver
> but do not describe interrupts in its DT description. As with this
> change not describing interrupts is consider an error.
>
> For example checkout thermal@ffc48000 in arch/arm/boot/dts/r8a7779.dtsi.
>
If the interrupts are missing in DT (for example in [1])
platform_get_irq_optional() will return -ENXIO with this patch this
error code is handled gracefully i.e. it doesn't return error and
breaks instead keeping the orignal behavior of the driver.

[1] arch/arm/boot/dts/r8a7779.dtsi

Cheers,
Prabhakar
