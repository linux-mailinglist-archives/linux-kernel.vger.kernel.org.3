Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55D489F47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiAJS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:29:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44698 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbiAJS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:29:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B944B81748;
        Mon, 10 Jan 2022 18:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BECC36AE9;
        Mon, 10 Jan 2022 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839377;
        bh=WbSXURwPnRNeBJeseas+oMhyvAiFryXuTHBY47HJAto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQwPoSZcWxE5PSP4o5LRNm57bdcAY539P0GrHIrJmRKNAq7g/iU0Bwa+owTpTQoKY
         Keu/ps/NqHFJFFyGnxvSwNoQ9rsLVGLTJY1a+R5j0h1Fq/bggrXWuHBHiRQgRWo+2k
         KBqRJN4C6KAs5nkdkTk9EPg7Icm8QcQ6Czh4uEg1AWX6qShHN060MlgA/qjfVCI+kR
         RBF5KeKS60Yhg7//tB+f1gW7M7KPttgUHIo7jTjV/1XYp8G7RGS9WRiURvOfPKTW9u
         H1VclBy0Aa8r8eA6kRzRMFxfM9zih1BitKkvCitmdRF4kTsmMFdWw0XiZxJ3ZAKGa1
         v2DXhQSL9uyPA==
Date:   Mon, 10 Jan 2022 10:29:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
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
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <Ydx7D3H0PS0Zs9/B@sol.localdomain>
References: <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydxu+KS5UkQ6hU9R@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:38:00PM -0500, Theodore Ts'o wrote:
> If we want to add a CONFIG_RANDOM_SECURITY_THEATRE build option which
> diverts getrandom and /dev/urandom to use crypto/drbg, I'm going to
> think it's a waste of time, and there are some things about
> crypto/drbg that I'm not psyched about such as the fact that only
> reseed after 2**20 calls to drbg_generate(), and the drbg statemachine
> will initialize itself from get_random_bytes() in early boot, when the
> CRNG is least likely to be securely initialized.  So **I** wouldn't
> want to use it for my own personal security, but if it allows Ubuntu
> to sell into the US govnerment market, my only hope is that this
> wouldn't be inflicted on all of their customers, but only those US
> Government customers who care (and as near as I can tell, this is
> *not* all USG customers).
> 

So just a few thoughts:

Ubuntu, Red Hat, and Oracle all have patches which do this.  They differ
slightly; e.g., Ubuntu's patch only changes /dev/urandom while the others change
/dev/random and getrandom() too.  But the idea is the same: the userspace
interfaces to the RNG are changed to get output from a SP800-90A DRBG
(crypto/drbg.c) rather than the Linux RNG directly.  The SP800-90A DRBG in turn
is seeded from from two entropy sources combined: the Linux RNG
(get_random_bytes()) and jitterentropy (crypto/jitterentropy.c).

My understanding (and I could be totally wrong -- I am still trying to reverse
engineer all the requirements for this certification stuff) is that the reason
that these distros need this is they are certifying the whole kernel image as a
FIPS cryptographic module, and that implies that cryptographic random numbers
must conform to the SP800-90{A-C} documents.  The problem is that ChaCha20 isn't
considered an approved DRBG algorithm, nor do Linux's entropy sources have
SP800-90B continuous health-tests.  Therefore, get_random_bytes() is considered
to provide no entropy.  crypto/drbg.c works around this by using an approved
DRBG algorithm and by using jitterentropy which has SP800-90B tests.

I think the reason people are considering this to be a hack is because on paper
it ignores Linux's main RNG.  It's still *used* as an extra entropy input, but
on paper it's credited with no entropy.  That seems a bit odd.

However, even Stephan's patchset has the same issues, IIUC.  Stephan's patchset
still keeps get_random_bytes() using ChaCha20, and it provides an option to
layer crypto/drbg.c on top of it for userspace output.  So I'm not sure how much
of a hack it really is, if the supposed non-hack is basically the same.

Now, the idea of certifying the whole kernel as a FIPS cryptographic module is
stupid, given that it prevents the kernel from being updated to fix security
vulnerabilities.  However, I've been told that essentially the same RNG issues
also arise for NIAP certification of mobile devices
(https://www.niap-ccevs.org/MMO/PP/PP_MDF_V3.2.pdf), which looks at entropy
system-wide.  NIAP similarly doesn't consider ChaCha20 to be an allowed DRBG
algorithm, so they consider the entropy to be constantly depleting, and it "runs
out".  (There have been devices that passed NIAP despite this, but I've been
told that this was an oversight.)  Wiring up /dev/{u,}random and getrandom() to
crypto/drbg.c would avoid this issue too.

So again, I could be totally wrong, as I am trying to reverse engineer the
requirements here --- but to me it seems that a small patch to provide an option
to use crypto/drbg.c could solve both the FIPS and NIAP certification problems.

If Stephan could elaborate on what his patchset does that is better (as far as
certification is concerned, at least -- I know his patchset has some other
advantages such as eliminating non-cryptographic entropy processing), that would
be helpful to illuminate anything I may be missing.

- Eric
