Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3AA48AE47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiAKNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:16:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59160 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiAKNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:16:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967DD61628;
        Tue, 11 Jan 2022 13:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7909C36AE3;
        Tue, 11 Jan 2022 13:16:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SqubP8RT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641907005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQeC7YctX/YVqYkAnzGKLgfZxfV+ytQelxLfYGqLnUc=;
        b=SqubP8RTPOzXlEBQMp36lDr1ayPnfc/jhXUCmamqFS8JbyvknBtF/KetrOsETNwW+dMc/+
        Xjai/hibANJ9trNSLSz1MOiFZmM2RuooRZ73xz2qeaaigDVBS2Im/1yS6/itPjyJqIXaCQ
        sP3bisQvgrEFDz2HlaNG6Vg4m+JKDSc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b5f64864 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 13:16:45 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id c6so45145410ybk.3;
        Tue, 11 Jan 2022 05:16:44 -0800 (PST)
X-Gm-Message-State: AOAM531fuK1Ew8eRhTyOsIGRMGBSstsaFldDKo7PDcViDbBwlSSM9/T9
        4fnJSr1P3Bm7FvqFiTlzQ4MzMJQLS2+7zH2y1aA=
X-Google-Smtp-Source: ABdhPJxBYHrKFKQwwlE52qAsHcsrMv7o0I8tu8BgRgRGkDchwQOZShIdmgvijLdWQcaOJmR2LudNbTFJfE0zYHl+z/w=
X-Received: by 2002:a25:ae8d:: with SMTP id b13mr6700286ybj.255.1641907001570;
 Tue, 11 Jan 2022 05:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20220110132349.siplwka7yhe2tmwc@valinor> <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu> <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu> <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com> <Ydz1F/AqB1oO/qHF@mit.edu>
In-Reply-To: <Ydz1F/AqB1oO/qHF@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 14:16:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9o8FFLC3vvTN0cNzdzoYvBFwJMUCTaxOhnXfTaEELbBeg@mail.gmail.com>
Message-ID: <CAHmME9o8FFLC3vvTN0cNzdzoYvBFwJMUCTaxOhnXfTaEELbBeg@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Tue, Jan 11, 2022 at 4:12 AM Theodore Ts'o <tytso@mit.edu> wrote:
> These are both dangerous.  The first means creating a new device node
> which effectively is /dev/drbg-random which could be bind mounted or
> mknod'ed to be /dev/urandom.  But if the user boots a kernel that
> doesn't support this new device node, it will mean opening
> /dev/urandom will get ENODEV.
>
> Similarly, getrandom(2) never fails.  By allowing a SELinux policy to
> force it to fail with ENOSYS, or some other error, it means exposing
> userspace code to a failure path that may not be as well tested.
> Sure, *sane* code might fall back to opening /dev/urandom; but the
> whole point of getrandom(2) was that it was a dumb, stupid interface
> interface that could be safely used by application programmers.  Not
> paranoid OS crypto engineers that carefully check the error returns of
> all system calls, with appropriate fallbacks and making sure that code
> always "fails safe".
>
> Right now, the enterprise distros are doing their own thing, and quite
> frankly, I don't see a problem with that.

I agree with you. I think enterprise distros ought to keep doing their
own thing here, and there's a clear solution that does this in
userspace, and also a pretty non-invasive patch from Marcelo to patch
the crap into the kernel need be.

I spent some time reading about FIPS certification, compliance, and
the requirements of various customers. One thing in particular leapt
out at me, which I think you've been saying over and over in this
thread but I didn't fully understand until this morning:

The goal is generally to have particular pieces of software or
particular solutions FIPS certified. And to do this, they start from
the top of the stack and move onward down. Most OSS software out there
today isn't really FIPS ready and oftentimes a full solution needs
modifications in one place or another. Other times, it's enough to
plug in the right userspace crypto libraries. And I noticed in looking
at things that are FIPS certified that random number generation tends
to go through a userspace abstraction layer. And, it looks like these
abstraction layers all have FIPS-able RNG hooks. You mentioned OpenSSL
earlier, and it looks like even libgcrypt and wolfSSL have an
abstraction layer for this.

In other words, it's not even so clear that people who need FIPS
compliance really need /dev/urandom and such to be FIPS compliant as
part of that. And the ones who think they do for whatever security
theater nonsense can happily load up that CUSE thing I made, apply a
deliberately-downstream patch, or whatever other clever solution.

So indeed it really doesn't seem like this is something the kernel
needs to be doing.

Jason
