Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72C463C84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbhK3RKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:10:37 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47508 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231492AbhK3RKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:10:33 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1AUH5GU3001767;
        Tue, 30 Nov 2021 18:05:16 +0100
Date:   Tue, 30 Nov 2021 18:05:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simo Sorce <simo@redhat.com>, Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
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
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <20211130170516.GA1439@1wt.eu>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZHKHjomEivul6U@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:45:44PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 30, 2021 at 09:31:09AM -0500, Simo Sorce wrote:
> > On Tue, 2021-11-30 at 15:04 +0100, Greg Kroah-Hartman wrote:
> > > Odds are, you REALLY do not want the in-kernel calls to be pulling from
> > > the "random-government-crippled-specification" implementation, right?
> > 
> > You really *do* want that.
> > When our customers are mandated to use FIPS certified cryptography,
> > they want to use it for kernel cryptography as well, and in general
> > they want to use a certified randomness source as well.
> 
> There are huge numbers of internal kernel calls that use random data for
> non-crypto things.

I think the confusion comes from the use of cryptography to hide the
internal state and provide non-predictable sequences, and not from the
use of this source to perform cryptography elsewhere. But crypto here,
when used, is not a goal but a means. We could call this a "reduction"
function or a "whitening" function. Its importance solely depends on
how much we want to protect the internal state from being guessed, which
first comes back to how long the knowledge of this internal state is
useful. If we'd mix completely independent and unpredictable sources
like cosmic microwave background noise and sea-level beta radiations,
these are constantly renewed, their knowledge doesn't bring anything
and there's no need for crypto to protect them. That's not necessarily
what we're using and we have to deal with more durable source whose
disclosure could have more impact for some time frame, thus would need
some protection.

As such there is probably a broad spectrum between "we must use strong
cryptography on this source hence abide with authorities' decisions" and
"we just need this short-lived state not to be trivially guessable till
the next call". In this case do we *really* care about what crypto
functions are used to hide the internal state ? I guess not really, and
that could possibly be configurable at run time. After all, in practice
the jitter entropy and other sources might add sufficient uncertainty
to complicate analysis of even a weak algorithm and render the internal
state hardly guessable.

> > Your plan requires an active maintainer that guides these changes and
> > interact with the people proposing them to negotiate the best outcome.
> > But that is not happening so that road seem blocked at the moment.
> 
> We need working patches that fit with the kernel development model first
> before people can start blaming maintainers :)
> 
> I see almost 300 changes accepted for this tiny random.c file over the
> years we have had git (17 years).  I think that's a very large number of
> changes for a 2300 line file that is relied upon by everyone.

I'm also having some concerns about this. It seems to me that it's always
difficult to *simplify* what we have and that each time we try to replace
something in that area we end up with multiple versions. Look at the recent
prandom32 stuff for example. We got a new algo used for IP IDs, in a rush,
hoping to generalize it to replace the existing Tausworthe one. I had a look
a few months ago to try to finish the job... hundreds of callers that make
use of the internal state for unit tests :-(  Basically unfeasible without
breaking lots of driver I have no idea how to test. So by trying to replace
something we just ended up with two implementations (and if I remember well
there were already a few more, mostly variants of the former).

A replacement ought to be an observation, a conclusion of a work well done,
not a goal. If the changes manage to move everyone in the right direction
and at the end everything is seamlessly replaced for good, that's awesome.
But changing for changing is hard. And if we end up with build time options
to decide between one solution and the other, we fragment the testability :-/

Just my two cents,
Willy
