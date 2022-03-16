Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8C4DB28A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356523AbiCPOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356488AbiCPORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:17:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042462A17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:16:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l8so4086878pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cmuQfEF3b9+t30Lb35qeI0BNHVNJA8vB+B2MwaFEGI=;
        b=NaxFaqn+iGOtxJvtFb34lGog6Dhl7WHEoiaIG+tcuA+bpCX3qirC46X65CrwQqjvIN
         Mb5wSv1CPbPQCvVa72JJYhIqXi+1LuPLA6dPLw2U11C+CndMAalWOySxjBTnEDWjHn3T
         /ukFaLPnlryEz5n2hRSqFHZqmYAbkbQlwBUJI1sZ23+3l5uIa1KRKRzJynUTc7CKKUco
         059G3kOJTCuLKBxbNif9dpkuht2RXrlKo4VNoBEk1vtnEfJ8p3qH7c4j002q2Q5JHkKW
         K38zmORRiIQfyxtnRMlsJKy+PMypk3loztywS8xG6rIy7dVXMYa8SundZpxiuUnyxDYb
         buiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cmuQfEF3b9+t30Lb35qeI0BNHVNJA8vB+B2MwaFEGI=;
        b=DFYjO3k+qnkpE6QGniEucfSVBsw7V8rAMglsWKQzklv+4vgNzk57Eitdkar7MY0aQW
         ifBkBZtS52Lfb8UaGl8s/6FLNdeqNUu2fuh7AUHhsNdIEES3j4PuVAYnwWSHLe9RqmJV
         emRDWn5Z4M9DvD+++YMPehZ9AY5qnnMf3JomlOCf6ZWgUc4eZs89gMEfVvKD1/PtViJX
         J6kpAdLVu00WpvRuFPz2dToCCUTo4v2fx9AgigK3Z5JUryUAz15Bor83v4Jqi9P3glfe
         OXfAlxc/WzCSmag6gwLBKp4CQgUmZYVOAEa6UExfuwvJHj0LcCur9BGnRabeOMnpTZiC
         sZvg==
X-Gm-Message-State: AOAM532FdUg7MNnTef1F15lUZwjxfOumTUFloaBs11fUP4PGdsoiua3u
        y3HtueHgqA7jI52q0e5TIpc5DeA+0hHWPoPGMXs=
X-Google-Smtp-Source: ABdhPJxfDfBnWUfeGOWWkZSZ+3cUxB5mx09xaD6sFvA1c9zRjFOFHkj+tVCU1tzSwLzkIXOWefDJzSpQb8l4X/2hqqo=
X-Received: by 2002:a63:d44c:0:b0:380:8c48:e040 with SMTP id
 i12-20020a63d44c000000b003808c48e040mr29111126pgj.14.1647440162819; Wed, 16
 Mar 2022 07:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com> <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
 <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
 <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com> <CAFUsyfLUQLj5py1AQ+4NptM6htWxV5i0qxkeXDUdFPfAnqRY2w@mail.gmail.com>
 <CAFUsyfKrGhTHoC+MXiA3zFY-dT0wqPRxoJwMY=+uPbj0p0dDAg@mail.gmail.com>
 <CAFUsyfJQq5n12L-fCsagk5LOqLYXL+3BAORHDCXY-Ud1t2CVDg@mail.gmail.com> <CAFUsyf+4vgZsM9gdyN1=eP_MzDsuOXOdKitS=1Rj-jBpdFGg9Q@mail.gmail.com>
In-Reply-To: <CAFUsyf+4vgZsM9gdyN1=eP_MzDsuOXOdKitS=1Rj-jBpdFGg9Q@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 16 Mar 2022 09:15:52 -0500
Message-ID: <CAFUsyfKon+fuFtXaB5+rFjuv0Tm9mcCJnitAhnRLgRMh8YE0bA@mail.gmail.com>
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 3:08 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Tue, Jan 11, 2022 at 9:13 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Dec 10, 2021 at 12:35 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> > > On Fri, Nov 19, 2021 at 6:05 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 19, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > > > >
> > > > > From: Noah Goldstein
> > > > > > Sent: 17 November 2021 22:45
> > > > > >
> > > > > > On Wed, Nov 17, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > > > > > >
> > > > > > > From: Noah Goldstein
> > > > > > > > Sent: 17 November 2021 21:03
> > > > > > > >
> > > > > > > > Add check for "short distance movsb" for forwards FSRM usage and
> > > > > > > > entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> > > > > > > > modes" that are an order of magnitude slower than usual.
> > > > > > > >
> > > > > > > > 'rep movsb' has some noticeable VERY slow modes that the current
> > > > > > > > implementation is either 1) not checking for or 2) intentionally
> > > > > > > > using.
> > > > > > >
> > > > > > > How does this relate to the decision that glibc made a few years
> > > > > > > ago to use backwards 'rep movs' for non-overlapping copies?
> > > > > >
> > > > > > GLIBC doesn't use backwards `rep movs`.  Since the regions are
> > > > > > non-overlapping it just uses forward copy. Backwards `rep movs` is
> > > > > > from setting the direction flag (`std`) and is a very slow byte
> > > > > > copy. For overlapping regions where backwards copy is necessary GLIBC
> > > > > > uses 4x vec copy loop.
> > > > >
> > > > > Try to find this commit 6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> > > > >
> > > > > Or follow links from https://www.win.tue.nl/~aeb/linux/misc/gcc-semibug.html
> > > > > But I can't find the actual patch.
> > > > >
> > > > > The claims were a massive performance increase for the reverse copy.
> > > > >
> > > >
> > > > I don't think that's referring to optimizations around `rep movs`. It
> > > > appears to be referring to fallout from this patch:
> > > > https://sourceware.org/git/?p=glibc.git;a=commit;h=6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> > > >
> > > > which broken programs misusing `memcpy` with overlapping regions
> > > > resulting in this fix:
> > > > https://sourceware.org/git/?p=glibc.git;a=commit;h=0354e355014b7bfda32622e0255399d859862fcd
> > > >
> > > > AFAICT support for ERMS was only added around:
> > > > https://sourceware.org/git/?p=glibc.git;a=commit;h=13efa86ece61bf84daca50cab30db1b0902fe2db
> > > >
> > > > Either way GLIBC memcpy/memmove moment most certainly does not
> > > > use backwards `rep movs`:
> > > > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S;hb=HEAD#l655
> > > >
> > > > as it is very slow.
> > > >
> > > > > The pdf from www.agner.org/optimize may well indicate why some
> > > > > copies are unexpectedly slow due to cache access aliasing.
> > > >
> > > > Even in the `4k` aliasing case `rep movsb` seems to stay within a
> > > > factor of 2 of optimal whereas the `std` backwards `rep movs` loses
> > > > by a factor of 10.
> > > >
> > > > Either way, `4k` aliasing detection is mostly a concern of `memcpy` as
> > > > the direction of copy for `memmove` is a correctness question, not
> > > > an optimization.
> > > >
> > > >
> > > > >
> > > > > I'm pretty sure that Intel cpu (possibly from Ivy bridge onwards)
> > > > > can be persuaded to copy 8 bytes/clock for in-cache data with
> > > > > a fairly simple loop that contains 2 reads (maybe misaligned)
> > > > > and two writes (so 16 bytes per iteration).
> > > > > Extra unrolling just adds extra code top and bottom.
> > > > >
> > > > > You might want a loop like:
> > > > >         1:      mov     0(%rsi, %rcx),%rax
> > > > >                 mov     8(%rsi, %rcx),%rdx
> > > > >                 mov     %rax, 0(%rdi, %rcx)
> > > > >                 mov     %rdx, 8(%rdi, %rcx)
> > > > >                 add     $16, %rcx
> > > > >                 jnz     1b
> > > > >
> > > > >         David
> > > >
> > > > The backwards loop already has 4x unrolled `movq` loop.
> > > ping.
> > ping.
> ping3.

Hi,

Anything I'm missing to get this looked at?

> > > >
> > > > >
> > > > > -
> > > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > > > Registration No: 1397386 (Wales)
