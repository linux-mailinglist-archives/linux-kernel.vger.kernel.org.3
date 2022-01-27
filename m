Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3DF49E93F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiA0Rof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0Rod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:44:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5665C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:44:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so8205265pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IJPOuq6Vgz8OIBABNphso8njxsclBVNFuxy1S2ImKg=;
        b=hz4LA4/R1PHtVCGpkKbnhGNw4Nqv8KMtBczQ8H+o+pRWgPWJeKAvA5NHPiurEcUAwz
         fqOGDa9CBknJ6qeBMf1ognZpMfu2wCxmBRfm2PC4Zp7+JI6LMQTCZgwewH1cW883q+U1
         iiOtwbsQeO8RUCU9GC+vr40wGP71vcjb57WaQN95ZDBqJ78+KiYqVxfh7YFJxC8Tusid
         veshXEQRWgjUj+ADGoyBoarqO6FAMtVLU68RDqaIWufSqgwmBvDh5rNnraWaWSB6B2X+
         LyVvA/ib7ZcJkMoz2/1DEfhggw669dlJZNq2wcpGbcKAAzmO1DTMG/AMasb37aC8uJQL
         PUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IJPOuq6Vgz8OIBABNphso8njxsclBVNFuxy1S2ImKg=;
        b=KWWHabeJATQ1GtoOYEeukXQoDOFsLcfiWHd4F+MO+AS/3dQEVsRMJ8INjPopcgUXoU
         52jcicgyGzvoMHTReZyWuPp+vJMb3NEsgT8SIgl+o4Nm0r8YOflLta+u2BWRgcDqJY3i
         pYEpEyNDC7aGFozft7QvBZ2vuoPBdkFa+wWJuYS/7sNIoILzkEh0mJaT2AM2qfTpUoNq
         4zpciIVno48ZgZdaHKpRN07cGbvIMF1fg2Ph7Dx661iNL2sfcwZ5JwisvxmYlpGEvpFC
         AikdqcZF14jL7GtWvTpCvkeNarvlOxLLgIdkaZdv5mptfu72ZxHlLsHdx9/RE8FJ/86o
         oB6w==
X-Gm-Message-State: AOAM5319mhtaiC2T9ySwFXKOQgS5VbZCk+HbjnreYUDztrZORY+Yu7Uh
        eJpcxSWqDP5QJ8BePHkqA5wc48LsdV7zuWwIvBkN/iRMxns=
X-Google-Smtp-Source: ABdhPJw62i1nym9TtnDJAxQgputqo8B1Nf/SxH+SQg2KrwAObS2XwJFvBgZ1+SqIZZlXf8sJBsXlp8wLrGQ43eJKctM=
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr15090165pjb.228.1643305473139;
 Thu, 27 Jan 2022 09:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20220123183925.1052919-1-yury.norov@gmail.com> <d7dfe129-157f-f7ae-0fdb-f5eafef1f627@fi.rohmeurope.com>
In-Reply-To: <d7dfe129-157f-f7ae-0fdb-f5eafef1f627@fi.rohmeurope.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 27 Jan 2022 09:44:21 -0800
Message-ID: <CAAH8bW_N0y6ABdLykLk5YqAA27M_0SkrV0s1KTc9aLZkyoobiA@mail.gmail.com>
Subject: Re: [PATCH v3 00/54] lib/bitmap: optimize bitmap_weight() usage
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:30 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> On 1/23/22 20:38, Yury Norov wrote:
> > In many cases people use bitmap_weight()-based functions to compare
> > the result against a number of expression:
> >
> >       if (cpumask_weight(mask) > 1)
> >               do_something();
> >
> > This may take considerable amount of time on many-cpus machines because
> > cpumask_weight() will traverse every word of underlying cpumask
> > unconditionally.
> >
> > We can significantly improve on it for many real cases if stop traversing
> > the mask as soon as we count cpus to any number greater than 1:
> >
> >       if (cpumask_weight_gt(mask, 1))
> >               do_something();
>
> I guess I am part of the recipient list because I did the original
> suggestion of adding the single_bit_set()?

Yes, because of single_bit_set()

> If this is the case - well, I do like this series. Overall it looks good
> to me - but I for sure did not go through all the changes in detail ;)
> If there is some other reason to loop me in (Eg, if someone expects me
> to take a more specific look on something) - please give me a nudge.

The key patch of the series is #27: "lib/bitmap: add bitmap_weight_{cmp, eq,
gt, ge, lt, le} functions"

Feel free to add suggested/reviewed (or whatever you find appropriate) tags
if you want.

Thanks,
Yury
