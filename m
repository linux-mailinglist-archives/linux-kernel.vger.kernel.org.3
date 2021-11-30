Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF29463A83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhK3PtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:49:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51036 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhK3PtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:49:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E33ACE1A4C;
        Tue, 30 Nov 2021 15:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AA7C53FCD;
        Tue, 30 Nov 2021 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638287146;
        bh=BpRnlKibHzxADBPNri9C9Lp78VhKvvEfah2vybWggZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1JOELQxz9NaaOfxZ7StF89uNIWB0664f6Z6pJ0wEU2q6n9Yqqj//g0utxYgL+eUF
         s4iiZxMSnreQIfRY2AHAUZ7upbBaIs4CkQpmU1LOC+MthWlgN627t9LqSBydlCoqbE
         42UP/cjU6pfGl4Cue1MiFKz/PSDvyGZVsa5wz9LE=
Date:   Tue, 30 Nov 2021 16:45:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simo Sorce <simo@redhat.com>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
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
Message-ID: <YaZHKHjomEivul6U@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:31:09AM -0500, Simo Sorce wrote:
> On Tue, 2021-11-30 at 15:04 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 30, 2021 at 07:24:15AM -0500, Jeffrey Walton wrote:
> > > On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > ...
> > > > Sometimes, yes, it is valid to have different implementations for things
> > > > that do different things in the same area (like filesystems), but for a
> > > > core function of the kernel, so far the existing random maintainer has
> > > > not wanted to have multiple implementations.  Same goes for other parts
> > > > of the kernel, it's not specific only to this one very tiny driver.
> > > > 
> > > > As a counterpoint, we do not allow duplicate drivers that control the
> > > > same hardware types in the tree.  We have tried that in the past and it
> > > > was a nightmare to support and maintain and just caused massive user
> > > > confusion as well.  One can argue that the random driver is in this same
> > > > category.
> > > 
> > > I think an argument could be made that they are different drivers
> > > since they have different requirements and security goals. I don't
> > > think it matters where the requirements came from, whether it was ad
> > > hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
> > > organization.
> > > 
> > > Maybe the problem is with the name of the driver? Perhaps the current
> > > driver should be named random-linux, Stephan's driver should be named
> > > random-nist, and the driver should be wired up based on a user's
> > > selection. That should sidestep the problems associated with the
> > > "duplicate drivers" policy.
> > 
> > The "problem" here is that the drivers/char/random.c file has three users,
> > the userspace /dev/random and syscall api, the in-kernel "here's some
> > entropy for the random core to use" api, and the in-kernel "give me some
> > random data" api.
> > 
> > Odds are, you REALLY do not want the in-kernel calls to be pulling from
> > the "random-government-crippled-specification" implementation, right?
> 
> You really *do* want that.
> When our customers are mandated to use FIPS certified cryptography,
> they want to use it for kernel cryptography as well, and in general
> they want to use a certified randomness source as well.

There are huge numbers of internal kernel calls that use random data for
non-crypto things.

> I do not get why you call the implementation crippled? The
> specification is quite thorough and provides well reasoned requirements
> as well as self-test that insure coding mistakes won't end up returning
> non-random values.

Which specification are you talking about exactly?  There are loads of
different ones it seems that people wish to follow, so it's hard to
claim that they all are sane :)

> I understand the mistrust vs gov agencies due to past mishaps like the
> Dual-DRBG thing, but we are not talking about something like that in
> this case. NIST is not mandating any specific algorithmic
> implementation, the requirement set forth allow to use a variety of
> different algorithms so that everyone can choose what they think is
> sane.
> 
> > Again, just try evolving the existing code to meet the needs that you
> > all have, stop trying to do wholesale reimplementations.  Those never
> > succeed, and it's pretty obvious that no one wants a "plugin a random
> > random driver" interface, right?
> 
> I think one of the issues is that the number of changes required
> against the current random driver amount essentially to a re-
> implementation. Sure, you can do it as a series of patches that
> transform the current code in something completely different.

That is how kernel development works, it is nothing new.

> And the main question here is, how can we get there, in any case, if
> the maintainer of the random device doesn't even participate in
> discussions, does not pick obvious bug fixes and is simply not engaging
> at all?

What obvious bug fixes have been dropped?

> Your plan requires an active maintainer that guides these changes and
> interact with the people proposing them to negotiate the best outcome.
> But that is not happening so that road seem blocked at the moment.

We need working patches that fit with the kernel development model first
before people can start blaming maintainers :)

I see almost 300 changes accepted for this tiny random.c file over the
years we have had git (17 years).  I think that's a very large number of
changes for a 2300 line file that is relied upon by everyone.


thanks,

greg k-h
