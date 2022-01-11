Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E987F48A61A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiAKDMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:12:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53939 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229523AbiAKDMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:12:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20B3AFvn012506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 22:10:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 22C2415C00C8; Mon, 10 Jan 2022 22:10:15 -0500 (EST)
Date:   Mon, 10 Jan 2022 22:10:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <Ydz1F/AqB1oO/qHF@mit.edu>
References: <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu>
 <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:44:03PM -0800, Andy Lutomirski wrote:
> 
> So let’s solve it for real.  Have a driver (in a module) that
> exposes a /dev/urandom compatible interface to the CryptoAPI DRBG.
> We can do a really nice job of it, and maybe it’ll be 100 lines of
> code.  People can do whatever they like with it in their container
> manager or boot scripts. And if it has a problem (where it’s *less*
> secure than the real urandom), we can say “I told you so”.
> 
> We can go one step farther: add an LSM hook to getrandom().  Then
> someone can hack up a fips_t policy for SELinux that turns off
> getrandom.

These are both dangerous.  The first means creating a new device node
which effectively is /dev/drbg-random which could be bind mounted or
mknod'ed to be /dev/urandom.  But if the user boots a kernel that
doesn't support this new device node, it will mean opening
/dev/urandom will get ENODEV.

Similarly, getrandom(2) never fails.  By allowing a SELinux policy to
force it to fail with ENOSYS, or some other error, it means exposing
userspace code to a failure path that may not be as well tested.
Sure, *sane* code might fall back to opening /dev/urandom; but the
whole point of getrandom(2) was that it was a dumb, stupid interface
interface that could be safely used by application programmers.  Not
paranoid OS crypto engineers that carefully check the error returns of
all system calls, with appropriate fallbacks and making sure that code
always "fails safe".

Right now, the enterprise distros are doing their own thing, and quite
frankly, I don't see a problem with that.  If it turns out DRBG is
less secure (and there are some things that fill me with disquiet),
then let them take the economic consequences, since they are the ones
who are doing this for the economic advantages of trying to claim FIPS
compliance.

If we must support this in the upstream kernel, then configure it via
CONFIG_RANDOM_SECURITY_THEATRE which redirects getrandom(2) and
/dev/[u]random to DRBG.  I'd prefer that it be possible for someone to
put "random_security_theatre=0" on the boot command line which would
disable redirecting the interfaces to DRBG so if it turns out that
DRBG *is* less secure, we can give advice on how to turn it off
without requiring a patched kernel.  :-)

						- Ted
