Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3148A29E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbiAJWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiAJWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:20:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016E7C06173F;
        Mon, 10 Jan 2022 14:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E2C61241;
        Mon, 10 Jan 2022 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290BBC36AE3;
        Mon, 10 Jan 2022 22:20:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gl96fnML"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641853211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDSjYBiVjmfDGkZBblJE/jv/nN3aUC6CEZepPvepyqo=;
        b=Gl96fnMLJkvsRUxxAhNiZsqmY+H5vGFP7OsoD2J/0nd3pF3rK0h9fxSVnlz+z7sqaeKKqv
        XXS+Gf6vbBl2K7DQnULYUY+I3lE9Ah04blPwNJv2enx1i/t66LZGb2SF//d7v0fWSHPqrD
        UlgP0ppUDSCh5KW/N+RdOwV6SPNHNIY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 75df7dca (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jan 2022 22:20:11 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id j83so42169637ybg.2;
        Mon, 10 Jan 2022 14:20:10 -0800 (PST)
X-Gm-Message-State: AOAM530FuSms7SngkLMzrf62ONfghpbzaw29DEjFIidupsaP/hyqdtQb
        u+m2Lf38zfb0KfkEHIkfwGUo5KPaJNcpOs+vL2U=
X-Google-Smtp-Source: ABdhPJwB36MohLbdRs5j8ZD0Fdnts0YRJJQx7iRXUj3f6lm4yTmmuEgoVyjnzxAUg7QyB67JPX3Cn5jF4ymfqbTVT+8=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr2468547ybe.32.1641853207457;
 Mon, 10 Jan 2022 14:20:07 -0800 (PST)
MIME-Version: 1.0
References: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor> <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu> <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com> <YdyNxJzdBmSSEtDC@mit.edu>
In-Reply-To: <YdyNxJzdBmSSEtDC@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Jan 2022 23:19:56 +0100
X-Gmail-Original-Message-ID: <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
Message-ID: <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
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

On Mon, Jan 10, 2022 at 9:18 PM Theodore Ts'o <tytso@mit.edu> wrote:
> In general, you need FIPS
> certification for some specific use cases / application.  For example,
> if you're going for PCI compliance, then you might only need FIPS
> compliance for your OpenSSL library.  What the FIPS certification lab
> might consider acceptable for its entropy for its DRBG is an
> interesting question.  For some, simply having the OpenSSL library use
> RDSEED or RDRAND might be sufficient.  Or it could talk to an actual
> physical RNG device.
>
> So disabling getrandom() is probably not necessary, just so long as
> you can demonstrate that the FIPS cryptographic module --- i.e., the
> OpenSSL library --- is getting its entropy from an acceptable source.

I don't know exactly what these people think they want, but what you
say seems probably correct.

> I suspect what's actually going on is that some enterprise customers
> have FIPS complaince on a check-off list, and they aren't actually
> getting a formal FIPS certification.  Or they only need something to
> wave under the noses of their PCI certification company, and so the
> question is what makes them happy.

Right.

> And this is why some FIPS certification have gotten by just *fine*
> with a pure userspace OpenSSL library as their FIPS cryptographic
> module.  Where you draw the line between a "blessed" entropy source
> and one that's just hand-waving is really at the discretion of the
> certification lab.

Hah, probably correct.

So, seen this way, and combined with the solution provided at [1] (or
similar) for people who think they need something there, it seems like
the FIPS people can likely get what they need without really needing
to involve the kernel anyway.

Jason

[1] https://lore.kernel.org/lkml/YdynXjhhuQfbYuSb@zx2c4.com/
