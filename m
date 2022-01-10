Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E480848A073
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiAJTvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:51:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49309 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239531AbiAJTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:51:15 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20AJnORK019332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 14:49:25 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D0A2A15C00C8; Mon, 10 Jan 2022 14:49:24 -0500 (EST)
Date:   Mon, 10 Jan 2022 14:49:24 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YdyNxJzdBmSSEtDC@mit.edu>
References: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 07:44:23PM +0100, Jason A. Donenfeld wrote:
> b) Userspace to use some other RNG.
> 
> (b) can be accomplished in userspace by just (i) disabling getrandom()
> (making it return ENOSYS), and then (ii) replacing the /dev/urandom
> path with a CUSE device or similar.

I don't think you even need to do this.  In general, you need FIPS
certification for some specific use cases / application.  For example,
if you're going for PCI compliance, then you might only need FIPS
compliance for your OpenSSL library.  What the FIPS certification lab
might consider acceptable for its entropy for its DRBG is an
interesting question.  For some, simply having the OpenSSL library use
RDSEED or RDRAND might be sufficient.  Or it could talk to an actual
physical RNG device.

So disabling getrandom() is probably not necessary, just so long as
you can demonstrate that the FIPS cryptographic module --- i.e., the
OpenSSL library --- is getting its entropy from an acceptable source.

I suspect what's actually going on is that some enterprise customers
have FIPS complaince on a check-off list, and they aren't actually
getting a formal FIPS certification.  Or they only need something to
wave under the noses of their PCI certification company, and so the
question is what makes them happy.

Going into the details of whether ChaCha20 is blessed by FIPS is
probably more into technical weeds than most of the people who *say*
they want FIPS certification actually will go.  After all, the
in-kernel DRBG is using as its "entropy source" the timing
instructions from a bunch of x86 assembly instructions which is
**soooo** complicated that people are willing to drink from the snake
oil and claim that it is secure.  Is it really?  Has FIPS said that
it's OK?  Not any more than they've said anything about ChaCha20!

And this is why some FIPS certification have gotten by just *fine*
with a pure userspace OpenSSL library as their FIPS cryptographic
module.  Where you draw the line between a "blessed" entropy source
and one that's just hand-waving is really at the discretion of the
certification lab.

Personally, if I was doing something that I really, *really* wanted to
be secure, I'd be mixing in several hardware RNG's.  Given that most
server and client platforms have a TPM, or some other hardened
security module, using that is probably the best bet of I was
architecting some that *really* needed to be secure.  But of course,
we're not talking about real security in this thread; we're talking
about whatever security theater will make the FIPS certification labs,
and the people who say they want FIPS on their check-off list, happy.  :-)

    	       	       	    	      	       - Ted
