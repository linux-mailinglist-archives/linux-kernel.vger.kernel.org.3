Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EB581D33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiG0BeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiG0BeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:34:10 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDEF3B944
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:34:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 129so7721313vsq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/vmVKqoirO/ZnmWFWh7pPMm3cXVMOD/O70AH93NwoQ=;
        b=Jc6Ja1iL+PmFORd+ayfCdUAApsKwWJH3RfjPl/SQuZhrBaZzCXxdetQ7soy2EcQ6dE
         f/nj5SyVuHTBOA/KjFi5utIcWohXkfywgsRATmBnYC04gNbsmz83ocjbKaRp9g83rcuk
         DhMYOeaq/VteMEk0cRjq+hFoBQcrQ3fUYOHARFyICB9SNqsTFisArW8UEaQ90k5lEh8z
         anyJBKA7hPC0NEyC5JZ1wQ4BYi/YB9bCXWuo5pm0FVN4qHFWpH4yPs3QQIBJlhzOkclx
         2F7lKyyI/n+cS7QMfS0nNxChHpDhxlQvH7kvT3LDfZ0jZzvcM+4rXNAnke9WUeAjp7Y6
         Xtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/vmVKqoirO/ZnmWFWh7pPMm3cXVMOD/O70AH93NwoQ=;
        b=hPZx2PZ1y5k+wnsUGNS0AqJjjp+M2twIABMmH7uRYLQZcRBfnsVCRzjp4MvMnb0AjE
         bRhDPSbTjX/g0opVOEMI2kdjd2IKPmQCmXuVmLYkQzUvPbHyB06f1DFKyF0t+Rb6FSxo
         1EoYbAQCxRLC+qkp92opvAwDLhZ6BvefTqMwecOUnbzx7yZtcg0pJe3ab3F85rZPvRTd
         zTc3SbzFlRsazXSnmOmLSwCidLMlOlps0YwaIcp+bKcJe1T2xp2cvokYDCArmv51Hgnd
         69UuKGFM5nR/jms6jvKKsI79/Ppu9zkaqdgmt86hVy3xLRP3aj/zZHo6kso4fVNOOuIX
         i57Q==
X-Gm-Message-State: AJIora954Qew9fUMqBVS16fcdw/peHM5efLjc+HGn8SEFLKifHsZ3BCc
        Jcr+NCHrSkenuAESnmu7HYidb59HhbxdtF2eBYw=
X-Google-Smtp-Source: AGRyM1sFGyULinUFRT9jlmibW4PcLK23Ey/VconZdFQvR2s3dTBQrqddR20oAw/7ezMa0qJ0CAjintrL+9pmKUHhcRc=
X-Received: by 2002:a05:6102:2387:b0:34b:9f6d:10da with SMTP id
 v7-20020a056102238700b0034b9f6d10damr6233583vsr.28.1658885647112; Tue, 26 Jul
 2022 18:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora> <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop> <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk> <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
 <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
In-Reply-To: <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jul 2022 18:33:55 -0700
Message-ID: <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 5:15 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jul 26, 2022 at 01:20:23PM -0700, Linus Torvalds wrote:
> > On Tue, Jul 26, 2022 at 12:44 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Overall, I would say it's pretty similar (some generic perform
> > > marginally better, some native perform marginally better) with the
> > > exception of find_first_bit() being much better with the generic
> > > implementation, but find_next_zero_bit() being noticably worse.
> >
> > The generic _find_first_bit() code is actually sane and simple. It
> > loops over words until it finds a non-zero one, and then does trivial
> > calculations on that last word.
> >
> > That explains why the generic code does so much better than your byte-wise asm.
> >
> > In contrast, the generic _find_next_bit() I find almost offensively
> > silly - which in turn explains why your byte-wide asm does better.
> >
> > I think the generic _find_next_bit() should actually do what the m68k
> > find_next_bit code does: handle the first special word itself, and
> > then just call find_first_bit() on the rest of it.
> >
> > And it should *not* try to handle the dynamic "bswap and/or bit sense
> > invert" thing at all. That should be just four different (trivial)
> > cases for the first word.
>
> Here's the results for the native version converted to use word loads:
>
> [   37.319937]
>                Start testing find_bit() with random-filled bitmap
> [   37.330289] find_next_bit:                 2222703 ns, 163781 iterations
> [   37.339186] find_next_zero_bit:            2154375 ns, 163900 iterations
> [   37.348118] find_last_bit:                 2208104 ns, 163780 iterations
> [   37.372564] find_first_bit:               17722203 ns,  16370 iterations
> [   37.737415] find_first_and_bit:          358135191 ns,  32453 iterations
> [   37.745420] find_next_and_bit:             1280537 ns,  73644 iterations
> [   37.752143]
>                Start testing find_bit() with sparse bitmap
> [   37.759032] find_next_bit:                   41256 ns,    655 iterations
> [   37.769905] find_next_zero_bit:            4148410 ns, 327026 iterations
> [   37.776675] find_last_bit:                   48742 ns,    655 iterations
> [   37.790961] find_first_bit:                7562371 ns,    655 iterations
> [   37.797743] find_first_and_bit:              47366 ns,      1 iterations
> [   37.804527] find_next_and_bit:               59924 ns,      1 iterations
>
> which is generally faster than the generic version, with the exception
> of the sparse find_first_bit (generic was:
> [   25.657304] find_first_bit:                7328573 ns,    656 iterations)
>
> find_next_{,zero_}bit() in the sparse case are quite a bit faster than
> the generic code.

Look at find_{first,next}_and_bit results. Those two have no arch version
and in both cases use generic code. In theory they should be equally fast
before and after, but your testing says that generic case is slower even
for them, and the difference is comparable with real arch functions numbers.
It makes me feel like:
 - there's something unrelated, like governor/throttling that affect results;
 - the numbers are identical, taking the dispersion into account.

If the difference really concerns you, I'd suggest running the test
several times
to measure confidence intervals.

Thanks,
Yury
