Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C799546C346
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhLGTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhLGTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:04:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F27C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 11:01:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so560465lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SupVShNTJXevij1EjwBsA50LSidShtjCg/jXRot9bjo=;
        b=r3DyYrLKfSQMsfPXa31vjOKwQh2BCyUHk/ALY7BiaifwGaT4UGUmiNmjvztyRKLNWr
         S+yen2gW1+z5FuFYaeXS8KFz/bg2gq1LFLuNWj22DKJHEUebD+oPYu3OOK3CNn5JpDj+
         d9sN4Zx32FnSjBrQVAnSSx93kLiX+Rm/o5XnK606mauTydScUqvPkpOFJv/OLNOEL/kc
         mQvvvSS7oU58jh7wVNHRG5yHZyIFWiezcZosFLUBV9NVe+2FsR+x43qbYNLAVjH5ps59
         ZnR340Wofoz25vQQ10zcZqRTURu1XwrKOcbdtv/vKfa7suRPRMfHPL5Mv1sBi9wMOyiW
         M2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SupVShNTJXevij1EjwBsA50LSidShtjCg/jXRot9bjo=;
        b=OzSmEltnHZED4sf5t9pa+4CSv75/iAEf+1KlgtH5heEMn3ptSAxbeIF5ZqRBNFG96m
         C0VG7a/OEo7zybXzC0fK5W3FHJA9+EMGPFbA7a3fDPe6rpmtNXeflP+oq6tyRe0qrkuv
         F6S42hfDgzHKgRf70AFVYPPYh/XYFru00rNJr/YykQkyRe8NZJEVGEH3fL8iLaMjQHHt
         Zs0qBuJl6CP/QmN3Ufr52ou/DxhGl5Ah5+oCteB5PsFZC5ZYP4OR9DdzQtO7Qjkme0Ml
         b7xZAkEtV41jSQwvT+w3PkRa4iCoZYlOycMYHsmcgROh+LDWZXiWxZztg7LSBqG3IMPY
         K/lw==
X-Gm-Message-State: AOAM532qkDg1nHiouARSQP6ZnnMzj90wrBY839BOZ7E/BcfBi/VtxDbR
        SiwGhAzw9hmiuFHO5GaEMcmT0047cuvhfxR7qK8muw==
X-Google-Smtp-Source: ABdhPJws1M5JeOEGcy41V2RcswPp254QO96BxAPTUKc20NHWJL5bam2X9XT3xWRLxCoy1rPVWr5hd+t+GrwApmkBD1g=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr43740531lfe.489.1638903661109;
 Tue, 07 Dec 2021 11:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20211204220249.591482-1-arnd@kernel.org> <CAKwvOdnZSyfZaa1crQ15DGNNj8JBspnM0xxOF3D2mTt96Ftfgw@mail.gmail.com>
In-Reply-To: <CAKwvOdnZSyfZaa1crQ15DGNNj8JBspnM0xxOF3D2mTt96Ftfgw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Dec 2021 11:00:49 -0800
Message-ID: <CAKwvOdnH9tV3PK4k+XEnjo_Le88o+Jqt-H-_C2VnsKiiBUAW9g@mail.gmail.com>
Subject: Re: [PATCH] power: reset: ltc2952: fix float conversion error
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Moll?= <Rene.Moll@xsens.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 10:41 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Dec 4, 2021 at 2:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang-14 does not like the way this driver converts a 'long double'
> > to an integer when the target architecture disables floating point
> > support:
> >
> > drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux' does not support it
> >         data->wde_interval = 300L * 1E6L;
> >                                   ^
> >
> > Turn this into pure integer math and make it more readable at the
> > same time using the NSEC_PER_MSEC macro instead.
> >
> > Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the patch! The change in clang-14 (ToT) that triggered this
> has had another patch on top reverting these diagnostics.
> https://reviews.llvm.org/D114162
>
> That said, this change is still worthwhile for the improved semantics, IMO.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Ah, a fix has already been picked up:
https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=644106cdb89844be2496b21175b7c0c2e0fab381

>
> > ---
> >  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
> > index fbb344353fe4..9fc88a9f244c 100644
> > --- a/drivers/power/reset/ltc2952-poweroff.c
> > +++ b/drivers/power/reset/ltc2952-poweroff.c
> > @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
> >
> >  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
> >  {
> > -       data->wde_interval = 300L * 1E6L;
> > -       data->trigger_delay = ktime_set(2, 500L*1E6L);
> > +       data->wde_interval = 300 * NSEC_PER_MSEC;
> > +       data->trigger_delay = ktime_set(2, 500 * NSEC_PER_MSEC);
> >
> >         hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >         data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
> > --
> > 2.29.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
