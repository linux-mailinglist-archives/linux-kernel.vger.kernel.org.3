Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977E47125E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhLKHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:08:06 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:48615 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKHID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:08:03 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BB76AHD002532;
        Sat, 11 Dec 2021 08:06:10 +0100
Date:   Sat, 11 Dec 2021 08:06:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Simo Sorce <simo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
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
Message-ID: <20211211070610.GA2153@1wt.eu>
References: <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <YbL3wNBFi2vjyvPj@kroah.com>
 <20211210093003.lp6fexzrga3nijxn@valinor>
 <YbMiXOCibTRXYYCo@kroah.com>
 <b806a2a1a42b66f0fa5569b79862fe57277feda4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b806a2a1a42b66f0fa5569b79862fe57277feda4.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:02:35PM -0500, Simo Sorce wrote:
> On Fri, 2021-12-10 at 10:48 +0100, Greg Kroah-Hartman wrote:
> > Given that there are no patches here to review by anyone, why is this
> > email thread still persisting?
> 
> There is a will and a need to "improve" things, but given past absence
> of feedback, people are trying to understand if there is any point in
> trying to submit patches. Patches are work, and people like to know
> they are not wasting their time completely before committing many more
> hours.

It is obviously natural to think this way, but you can also understand
that reviewing patches is extremely time consuming. And it's extremely
difficult to review a patch series which says "replace all that
infrastructure with a new one", especially when the motivations are
"comply with this or that standard" without the benefits being obvious
at all for those having to review those patches. And keep in mind that
those who you expect to review the code will have to maintain it, so if
the benefit is not obvious, why would they take the risk of breaking
something that's been working well enough or that has been easy enough
to improve or fix over time ?

My feeling from the beginning is that nobody felt brave enough to go
through these series because of this.

The normal way to propose changes is to say "some of our customers ask
for FIPS, we've looked at *what is missing* to accomplish that, first
it suggests/requires/mandates properties X, Y and Z which are currently
not supported, so these patches improve the current code by adding such
properties". And you don't patch "for FIPS", you patch to make the
existing code evolve to support such missing properties or features,
till the point you figure that nothing is missing anymore, and you can
tell your customers "now we comply with FIPS". And if it takes several
versions to reach that point, no problem, because each version continues
to work like before, possibly better, possibly not.

It's not different from supporting a new hardware. You don't bring in
a big patch series implementing all of the machine's device drivers in
an isolated area specific to that device. Instead you bring the various
parts this machine relies on (serial, pcie, usb, network etc), possibly
by improving existing drivers that are already very close or share some
common parts, and at the end you figure you have everything you need
and then you can proudly say "now we fully support this device".

This way of proceeding incrementally allows submitters not to waste
time coding for nothing, and those reviewing changes to make sure
they're not breaking everything, or to ask for some changes to stay
safe.

But this does mean that a list of incremental changes/additions has to
be established on the submitter's side, not a list of replacements.
Sometimes it is required to replace a part, but the justification has
to be technical, not "this part doesn't meet standard X or Y, let's
reinvent it". And such replacements need to be minimal so that it's
obvious they continue to provide exactly the same services and it's
almost impossible that a bisect lands on such a patch when something
stops working (i.e. if it happens it's just a coding bug and not a
design mistake).

> > Again, the only way forward is to submit changes that meet our
> > well-documented development process.  There's nothing "special" about
> > this very tiny .c file that is any different than the other 30 million
> > lines of kernel code we support that warrants a different process at
> > all.
> 
> This very thread shows that there is an issue, people are not asking
> for exceptions to the process, they are only asking for direction from
> the maintainer so they can work productively and get some result, that
> is all the "special" there is here.

At least it's visible in this very thread's subject that it's addressed
in a special way: "/dev/random - a new approach", i.e. "trash all what
we have and restart from scratch". This is exactly what is causing the
problem from the beginning in my opinion. But at this point I think
that Jason, Greg and others have already been saying it, so I'll stop.

Hoping this helps,

Willy
