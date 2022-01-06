Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F448674F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiAFQE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbiAFQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:04:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700DC061212;
        Thu,  6 Jan 2022 08:04:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z9so11169821edm.10;
        Thu, 06 Jan 2022 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ctx64qtfQaEmway8Kl0Z051R8wEi+pk+eWwHlBI63c=;
        b=fYbgLqcL4zaXh1ucZUfWK2WSspFcZ91K6O7qBCYLfWp2Mmme3TvyT3A5eZdBYm7NgF
         KocFWAxLxnHNShaXafq62qT7NPYw4R60fXkQPEKZXoNROxemo0K7z3P/76Cr8Bi6Z3K0
         JvgDXo7P11qKEN8hwehCiz+JohZSQ1JuggVxa/NDF4AwEd+mtGgyTVWVjKfoK0oLjUe7
         rN8G6s8oE/LFnjzSKsF1wZmGtHbdIIQLwxsxOqya6G/UwPw5nDDXS6rYhZf/kVJ1WOLY
         a0pN/DgecdhV+YUN7H6yEfCOUVYjEsURIOwDy7cpsPoNtcQkvvMAuM4uSU7pXEbcCb1D
         NHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ctx64qtfQaEmway8Kl0Z051R8wEi+pk+eWwHlBI63c=;
        b=n4mvWbkVshbeG09BfKLkBtb8djfKgGgW5gsdEMn8jRRC03HGnwh9Z27ZGLuX7XhgT9
         8Kb86ZvuQ/Q79YN9bI1dIm26afq/zxI+pC4pT+gmdwNLFQCuoD2bTTOOy/JpE93LpciA
         ahiMM1h/fpJb03E0cTFoXGbjevVtIE85A7ipY4NerYPiMlBb6esUJX1jsPqP6r1YtgtA
         9vzkymoY6AqLQwHdIcQiN7OWGRbXDwM1i+Yl9k0KcoATXqy6o4G25X0NtV3YjFPOhkXi
         5o+as6+2eNlD2upPS0ei/RyLAzNp1Pl3HEalxy4wUZHQOKzNuAjyFIKnW2dBv0kAaVvt
         UKBw==
X-Gm-Message-State: AOAM531RZjpsel2VAbb/uIeaUHu81d6R68VOqkXq2pVSxasQUcKKFIrM
        TKo+csVSufdRdZeBOen4hcqwdvHJxSBu+fynvy0=
X-Google-Smtp-Source: ABdhPJwTxvD406D0DGK0mYcdp8aZhArKmYPduzf+XvjE19FsKp9m1u+n1aKLdNehAPa2eWaqDZQYzxl3yfdpLymIT+E=
X-Received: by 2002:a17:906:2b07:: with SMTP id a7mr2711702ejg.77.1641485096313;
 Thu, 06 Jan 2022 08:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YdXt2mDjZ0zikbt6@oden.dyn.berto.se> <CA+V-a8sGh0bCiDu_Eiz3EFgaDPmr-qyz95=dExwf+UvuyA21Cg@mail.gmail.com>
 <YdcK5WWnEtEQk0Fp@oden.dyn.berto.se>
In-Reply-To: <YdcK5WWnEtEQk0Fp@oden.dyn.berto.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 18:04:19 +0200
Message-ID: <CAHp75VfoRs8b-jeoa3Q-cfjO3nKz7W1f-q72twH-isCQh6NeFw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 5:29 PM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2022-01-05 19:25:25 +0000, Lad, Prabhakar wrote:
> > On Wed, Jan 5, 2022 at 7:13 PM Niklas S=C3=B6derlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > > On 2022-01-04 14:52:11 +0000, Lad Prabhakar wrote:

...

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

> > > Is there a reason you wish to do this change in addition to the switc=
h
> > > to platform_get_irq_optional()? If so I think that should be done in =
a
> > > separate patch.
> > >
> > No other reason, It was suggested by Gerrt too to use a break instead
> > of continue in v1.
>
> I think we need to keep the original behavior.

I don't see how this can break those. Or are you stating that some of
them are using board files with 0 as a valid (v)IRQ?

--=20
With Best Regards,
Andy Shevchenko
