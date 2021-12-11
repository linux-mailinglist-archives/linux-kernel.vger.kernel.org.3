Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA147130C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhLKI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:58:15 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:48642 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKI6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:58:14 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BB8v4l7003183;
        Sat, 11 Dec 2021 09:57:04 +0100
Date:   Sat, 11 Dec 2021 09:57:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jeffrey Walton <noloader@gmail.com>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Nicolai Stange <nstange@suse.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <20211211085704.GB3083@1wt.eu>
References: <YaZHKHjomEivul6U@kroah.com>
 <b806a2a1a42b66f0fa5569b79862fe57277feda4.camel@redhat.com>
 <20211211070610.GA2153@1wt.eu>
 <25222015.1r3eYUQgxm@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25222015.1r3eYUQgxm@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Sat, Dec 11, 2021 at 09:09:55AM +0100, Stephan Müller wrote:
> > It is obviously natural to think this way, but you can also understand
> > that reviewing patches is extremely time consuming. And it's extremely
> > difficult to review a patch series which says "replace all that
> > infrastructure with a new one", especially when the motivations are
> > "comply with this or that standard" without the benefits being obvious
> > at all for those having to review those patches.
> 
> I am so surprised by such statements. Patch 00/15 lists in a bullet list the 
> significant benefits of the LRNG. But seemingly nobody reads the introduction 
> with its concise bullet list or the documentation. The FIPS bits are a tiny 
> aspect of the whole effort (which even can be completely compiled out based on 
> config options), the more significant aspects that have nothing to do with 
> FIPS and benefit all are testability, performance, use of contemporary 
> cryptography, and flexibility.

But this is where the problem is. You're not proposing to improve the
current one but to replace it. Who has enough energy to review some new
code that claims to be compatible with older one ? It requires to perform
a mental "diff" which is extremely complicated. There are possibly corner
cases in the current code that nobody knows about and that some code
currently relies on. Who wlil detect that you're not going to break them
with a fresh new implementation ?

Incremental changes allow to focus on the changes. You don't need to
know how everything else works, just that the modifications do not
break the part they are inserted into. This makes a huge difference,
and this is why everyone constantly insists on seeing small incremental
changes. Sometimes you'll notice that you can even see review from
different people for very close parts in the same file.

> > But this does mean that a list of incremental changes/additions has to
> > be established on the submitter's side, not a list of replacements.
> 
> Before I started the endeavor of the stand-alone patch of the LRNG, I 
> developed cleanup patches to random.c in 2014 and 2015. I got massively 
> discouraged to continue working on random.c as I did not get feedback from the 
> maintainer. Some patches were taken, some were not without a comment... 

We all know that this is extremely irritating. It happens everywhere and
in every project. Sometimes lack of time, lost messages, flipped priorities,
or lack of interest, or a combination of all of this. I do it myself from
time to time by accident and I really feel bad when this happens. That's
not much different than when you're reminding a coworker that you need
their help and they forget because of other priorities. And this must
never discourage one from pinging again and asking why there's no
response. But one thing is certain to me, it's that if a maintainer,
for any reason, doesn't respond to tiny patches to their code, there's
hardly any chance to see a response to a whole replacement.

Here Jason offered to invest time reviewing changes. If you have changes
to propose, why not try ? And even if it takes one year to get everything
done, who cares ? You seem to have been working on this for 7 years
already, it might be worth trying another approach.

Regards,
Willy
