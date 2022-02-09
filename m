Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539E44AF033
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiBILzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBILzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010BE036C06;
        Wed,  9 Feb 2022 02:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA29AB81FDF;
        Wed,  9 Feb 2022 10:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B6CC340F0;
        Wed,  9 Feb 2022 10:45:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e/Pf7Ive"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644403530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnV7UrhgQr21PthLX8Pn4FBnaM1gdWwfkrGLWJxwOk8=;
        b=e/Pf7IveD0TcWViwwV6va+EUgF16LNdycAHWCqKseMhDXVn4URn9RZGvL6n7T8xgB9Ao80
        cQeLvSsFaNQ2aqZLdFGLpkwv3r23F5dk1dtsdp77ph0VHG/+zmjbV0V+x8VpKSzLn5Nf2m
        t3HtH0OZvJvOHO5gpxn77+h9FUJ0chQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a106e8c0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 10:45:30 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id v47so4667782ybi.4;
        Wed, 09 Feb 2022 02:45:30 -0800 (PST)
X-Gm-Message-State: AOAM530h9koEOSpNGaLzRorYs6ySJqOeP+khhRSxpnu8XG3/UgpAFy2Q
        25kIDPn9KpyBB4teOdFupJCiBWbMq8/IaMPuw1I=
X-Google-Smtp-Source: ABdhPJyFIHbgEiHJaxfexbZoIL2JTJqU4IXZN6GR5vdFmMhJfpC+2SqDzSxGldox0imKQ8bFRw7girU0y7NkaYEx4I8=
X-Received: by 2002:a25:c006:: with SMTP id c6mr1366885ybf.457.1644403528916;
 Wed, 09 Feb 2022 02:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20220209011919.493762-1-Jason@zx2c4.com> <20220209011919.493762-7-Jason@zx2c4.com>
 <YgN7TvD5rs/5i1dQ@owl.dominikbrodowski.net>
In-Reply-To: <YgN7TvD5rs/5i1dQ@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 11:45:18 +0100
X-Gmail-Original-Message-ID: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
Message-ID: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] random: absorb fast pool into input pool after
 fast load
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 9:31 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Wed, Feb 09, 2022 at 02:19:16AM +0100 schrieb Jason A. Donenfeld:
> > During crng_init == 0, we never credit entropy in add_interrupt_
> > randomness(), but instead dump it directly into the base_crng. That's
> > fine, except for the fact that we then wind up throwing away that
> > entropy later when we switch to extracting from the input pool and
> > overwriting the base_crng key. The two other early init sites --
> > add_hwgenerator_randomness()'s use crng_fast_load() and add_device_
> > randomness()'s use of crng_slow_load() -- always additionally give their
> > inputs to the input pool. But not add_interrupt_randomness().
>
> Hm, up to this patch there is no base_crng key. So maybe change the ordering
> of the patches?

I'll fix the commit message, actually. Eric wrote in his review of v1
that he thinks this problem needs to be fixed before we move to
overwriting keys in the subsequent patch and I agreed. Hence, this
patch comes first.

> > +
> > +                     /* Technically this call means that we're using a spinlock_t
> > +                      * in the IRQ handler, which isn't terrific for PREEMPT_RT.
> > +                      * However, this only happens during very early boot, and then
>
> Whether it's only during "very early" boot depends on how fast we progress
> to crng_init = 2. So maybe just "during boot"?

Will do.

Jason
