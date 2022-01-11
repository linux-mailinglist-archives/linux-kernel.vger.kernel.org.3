Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1156348B1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349836AbiAKQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:10:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48653 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343495AbiAKQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:10:43 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20BG8jiU007374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 11:08:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 24DC415C00C8; Tue, 11 Jan 2022 11:08:45 -0500 (EST)
Date:   Tue, 11 Jan 2022 11:08:45 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <Yd2rjQhK71L2vwgb@mit.edu>
References: <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu>
 <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
 <Ydz1F/AqB1oO/qHF@mit.edu>
 <CAHmME9o8FFLC3vvTN0cNzdzoYvBFwJMUCTaxOhnXfTaEELbBeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9o8FFLC3vvTN0cNzdzoYvBFwJMUCTaxOhnXfTaEELbBeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:16:30PM +0100, Jason A. Donenfeld wrote:
> I spent some time reading about FIPS certification, compliance, and
> the requirements of various customers. One thing in particular leapt
> out at me, which I think you've been saying over and over in this
> thread but I didn't fully understand until this morning:
> 
> The goal is generally to have particular pieces of software or
> particular solutions FIPS certified. And to do this, they start from
> the top of the stack and move onward down. Most OSS software out there
> today isn't really FIPS ready and oftentimes a full solution needs
> modifications in one place or another. Other times, it's enough to
> plug in the right userspace crypto libraries. And I noticed in looking
> at things that are FIPS certified that random number generation tends
> to go through a userspace abstraction layer. And, it looks like these
> abstraction layers all have FIPS-able RNG hooks. You mentioned OpenSSL
> earlier, and it looks like even libgcrypt and wolfSSL have an
> abstraction layer for this.

I know this thread is about security theatre, not real security, but
there's an even more important reason why the FIPS cryptographic
module should be as high in the stack as possible (e.g., in
userspace).  Let's consider as, Albert Einstein would put it, the
following gedanken experiment:

Let's presume that in 2008, there was a FIPS-140 certified OS
designating the Linux kernel as the "cryptographic module", and so
/dev/urandom was hacked to be "FIPS certified".  Huzzah!  Now let's
assume that OS was using Ubuntu, which, being derived from Debian, was
subject to a distribution "value add" where in blind obedience to a
valgrind warning, there was a distro-level change which resulted in
OpenSSL on Debian and Debian derivitives generating extremely
predictable keys[1].  This caused fairly massive security problems for
any use of OpenSSL, including ssh, certificate generation, etc. ---
despite the FIPS 140 certification of the OS.  Oops!

[1] https://en.wikinews.org/wiki/Predictable_random_number_generator_discovered_in_the_Debian_version_of_OpenSSL

It might be *cheaper* to claim that your OS is FIPS 140 certified by
hacking /dev/urandom.  Otherwise, you might have to have a responsible
security engineer audit the various userspace cryptographic libraries,
and that would be way more expensive.  It's much easier for a product
manager to say, "my work here is done" after applying a patch to the
Linux kernel for /dev/urandom, and not bothering to get an engineer to
certify the rest of the cryptographic stack.

And, if enterprise customers just care that an enterprise distro can
claim "FIPS 140 compliance", and they can push that claim of FIPS
compliance to the PCI certification authorities, they're happy.  So
ultimately, this is really an economic requirement, not a security
requirement.  And given that enterprise distros are the ones getting
paid $$$ in order to claim FIPS 140 compliance, then from an upstream
perspective, if our gaols is to optimzie the speed of getrandom(2) and
/dev/urandom, and to encourage application programmers to do the right
thing --- and *not* security theare for the sake of economic goals, we
should make technical decisions accordingly.

Cheers,

					- Ted
