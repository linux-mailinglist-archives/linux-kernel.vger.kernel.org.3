Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A5489E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiAJRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:39:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55187 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238488AbiAJRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:39:52 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20AHc0dQ028470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 12:38:01 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9E78715C00C8; Mon, 10 Jan 2022 12:38:00 -0500 (EST)
Date:   Mon, 10 Jan 2022 12:38:00 -0500
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
        Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <Ydxu+KS5UkQ6hU9R@mit.edu>
References: <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 03:38:08PM +0100, Jason A. Donenfeld wrote:
> 
> Yea, I'm not really compelled by it as something real that we'd
> actually want to have for something serious. Keep in mind: this thread
> isn't really about cryptography, but just about compliance nonsense.
> BUT, if it turns out that the path to these people getting their green
> compliance checkbox stamp isn't actually thousands of lines of new
> code, but rather some glue bridging the /dev/urandom / getrandom(2)
> API into the blah cryptoapi thing, that's... interesting news to me.
> I'm not even saying, at this stage anyhow, that I want to do this, but
> I do find it a very interesting data point.

The last time I had the displeasure of looking into the FIPS
certification, which granted, was over a decade ago when I was in
IBM's Linux Technology Center, what I learned was it all depends on
the FIPS certification lab.  NIST writes the documentation, but what
really matters is the FIPS certification lab that a hardware or
software vendor pays $$$$ to in order to get the magic certificate
which allows you to sell into *some* government contracts.  (When I
had to go through the all of the nonsense to get a TS/SCI clearance to
support the real-time kernel for all of the IBM servers for the
DDG/1000 Zumwalt Class destroyer, they didn't care about getting FIPS
certified.  I've also seen tighter security measures for computer
rooms at NYC financial companies than at a Top Secret machine root at
said defense contractor.  Go figure....)

The other thing I learned for those customers who *did* care, was that
the only thing that got certified was a specific binary image.  If you
replace the kernel or OpenSSL library with, say, a bugfixed version
that fixed an actively exploited zero day, *boom*, that would break
the certification and the system would no longer be FIPS certified.

Some FIPS labs would allow you to certify the "cryptographic core" of
the OpenSSL library, which the OpenSSL library would then dlopen, and
so as long as the bugfix was in, say, the ASN.1 parser, and you didn't
need to change the "cryptographic core" it was OK --- and you just
needed to hope that there weren't any bugs in the cryptographic core,
since then you wouldn't be allowed to fix it --- since FIPS compliance
was more important than, say, the *actual* security of the system in
question.

So yeah, as I said, it's all about TSA-style security theatre, and
when I worked for IBM and there was millions of dollars on the line, I
might have cared.  For upstream development, (and blessedly, this is
not something that my current employer has needed to worry about) I
care far less about it.

If we want to add a CONFIG_RANDOM_SECURITY_THEATRE build option which
diverts getrandom and /dev/urandom to use crypto/drbg, I'm going to
think it's a waste of time, and there are some things about
crypto/drbg that I'm not psyched about such as the fact that only
reseed after 2**20 calls to drbg_generate(), and the drbg statemachine
will initialize itself from get_random_bytes() in early boot, when the
CRNG is least likely to be securely initialized.  So **I** wouldn't
want to use it for my own personal security, but if it allows Ubuntu
to sell into the US govnerment market, my only hope is that this
wouldn't be inflicted on all of their customers, but only those US
Government customers who care (and as near as I can tell, this is
*not* all USG customers).

> > Specifically, I think that if you change your perspective from, "how can we
> > change the algorithms of the RNG to be FIPS" to "how can we bend FIPS within
> > its limits so that having what customers want would minimally impact the
> > quality of the RNG implementation or introduce undue maintenance burdens."
> 
> We're now starting to get some idea about how this FIPS stuff bends.

Well, if we optionally (if jitterentropy_rng is compiled in), we would
periodically pull from it as one additional entropy source into the
input_pool, it won't do any harm --- other than the CPU overhead
consumed by jitterentropy, of course.  Maybe that would make some
people happy, including some FIPS Labs?

I've also seen some FIPS certifications which didn't care about what
the kernel did, but only cared about what was in the OpenSSL library.
(Which is where the story about segregating out the cryptographic core
so that you could actually patch most zero-days without having to go
back to the FIPS certification lab, pay $$$, and wait months for the
updated binary to be certified.)

So I suspect that there will be a lot of anecdotal evidence, but the
only thing we can probably say with any amount of certainity is Your
Mileage May Vary.

Cheers,

						- Ted
