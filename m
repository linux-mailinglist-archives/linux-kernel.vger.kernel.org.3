Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287504888F3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiAILno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiAILnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:43:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A750C06173F;
        Sun,  9 Jan 2022 03:43:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so42227641edc.0;
        Sun, 09 Jan 2022 03:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TFIzk+YWuBPnFiZs9zbXgKZUSa8lbE6A2L93JvJOAI=;
        b=m8FVlzEACozZV7ZCKpB5fPIjBehAKE569w7eh9lIulCATbt+Qy1r0NOCyomiVnv5Mx
         U8KiJWT9NhkDxsjZum67cpKm3IhBSeLuvWa/5WE8WW7y4XstOxCJlwrX1Fv5w3Wa5xns
         x9sbuC98nOF3iHOrOgGEbPY3CQFeXaKQHvxe/I/mlxCkgIQZBDLo3PKwNzSKf84B8EId
         2zbSUmaRGjO+vDXZS2RbQYeTtbe3h8c+ZfZCj+QtTEWhyjssiLADDjGqNDFgtzeUu5kf
         QSNxTw5QxYArSoFWxaEt4bhfZoxU12BpCLRjcG7QIKBgCDIu8s+rPb+K9ALQa0oLXxZe
         ZSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TFIzk+YWuBPnFiZs9zbXgKZUSa8lbE6A2L93JvJOAI=;
        b=eUoi0RqK+Bw359DVGh9V1/6mZqAwksoWhBaStnApwvNc+phJQF3GnCQVwG/Finu6A3
         GIX2gffp7F4pxoZc9vDxh7FppolOqWJSTrWqbKPFO7b9utRIZw0tldmI/siwFkfDd9e+
         QKxEKuBXHMV2E8xp84VGXfuGofDBQ7DM+Zghv3k8aDakO7kzTzZW8EruYvAgzq2xhOFL
         zMlvbDQlJLtS4bBnofrsZellMiyyzSuqSWR31/FIt2U8upH/JU5d0xndhC8DRc9tm0Hk
         MO5PJ9p8df+/+k4AUNpI8M385sFkh/NQfNFsv7JPSCzsRLChi7rCMot9PNdy5PHdFPPb
         IZtw==
X-Gm-Message-State: AOAM533eIB3gwYu+uFfFWBj6BUbqpZexHwajFyrVoWZNOuyv18HLbqCw
        66OJannpLT4XXFdNFQ8X3qT30Zkhm4Gjkr5+xaeyUBZ3oXQnsg==
X-Google-Smtp-Source: ABdhPJy0oaDrKZza1wFSyb1sYllgA9khXqRnVJR6Jtj44+rHVwhWSD+PHOx5ip7NXKtHAJMijxvqtqj3BRxKkmAoShE=
X-Received: by 2002:a17:907:a0c7:: with SMTP id hw7mr2925514ejc.579.1641728619015;
 Sun, 09 Jan 2022 03:43:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VeEvT-_47gKFAYdz-BR9y=KLEw2uMbRxYKo1rLQSQEfyg@mail.gmail.com>
 <Ydorm5HirY2i/RCg@errol.ini.cmu.edu>
In-Reply-To: <Ydorm5HirY2i/RCg@errol.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 13:43:02 +0200
Message-ID: <CAHp75Vdm-2DqDhVe2s-OF-5kiJV01fUp1u1iWFDT2fGSzrqXvg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 2:26 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Sat, Jan 08, 2022 at 07:43:19PM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 8, 2022 at 6:11 PM Gabriel Somlo <gsomlo@gmail.com> wrote:

...

> > > +       u32 div;
> > > +
> > > +       div = freq ? host->ref_clk / freq : 256U;
> >
> > > +       div = roundup_pow_of_two(div);
> > > +       div = clamp(div, 2U, 256U);
> >
> > Not sure why it becomes two lines again.
>
> Per my previous email, I have:
>
>         div = clamp((u32)roundup_pow_of_two(div), 2U, 256U);
>
> ... lined up for v10 (pending also Geert's OK on the (u32) cast
> to shut up compiler warnings) :)

Yeah, I have read that and I think we may survive without comment and
being in two lines.

That roundup_pow_of_two may return int, unsigned long, and who knows
what depending on the per arch implementations.

What a mess...

...

>     /* wrapper for use with devm_add_action_or_reset(), below */

No need for this comment.

>     static void litex_mmc_free_host_wrapper(void *ptr)
>     {

>         mmc_free_host((struct mmc_host *)ptr);

Casting is not needed, just name the variable as mmc

        mmc_free_host(mmc);

>     }

...

> I'll wait till sometime tomorrow for additional feedback on clamp()
> casting and voltage range hard-coding vs. regulators, before I send
> out v10 so we can continue from there.

Thanks!


-- 
With Best Regards,
Andy Shevchenko
