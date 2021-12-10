Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA846FE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhLJJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:51:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42398 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhLJJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:51:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D60EECE29C8;
        Fri, 10 Dec 2021 09:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A60C00446;
        Fri, 10 Dec 2021 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639129695;
        bh=z0x32lqi2Vr4THaqQyDRu27So8dcBhOvF0p05aspnjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJlfgXIqZA4DCK99O8Af+ry8dkJ/NO1eGcXS243Yckwgsfn/wJQ06ao7/FUWeViBK
         TOh+xbOIufYmsun4+y4fprVYG+doZu/p5SeZBGfZl5rAmHSEetsyofUgumX5lqjoZs
         u/dIAJWkMYXeRfvqaNsJhiEQJwZ8AVu9u0Gj0D8A=
Date:   Fri, 10 Dec 2021 10:48:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simo Sorce <simo@redhat.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
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
Message-ID: <YbMiXOCibTRXYYCo@kroah.com>
References: <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <YbL3wNBFi2vjyvPj@kroah.com>
 <20211210093003.lp6fexzrga3nijxn@valinor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210093003.lp6fexzrga3nijxn@valinor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 06:30:03AM -0300, Marcelo Henrique Cerri wrote:
> On Fri, Dec 10, 2021 at 07:46:24AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 09, 2021 at 10:43:37PM -0300, Marcelo Henrique Cerri wrote:
> > > Hi, Jason. How do you think we could approach that then?
> > > 
> > > Are you willing to discuss the FIPS 140-3 requirements that random.c
> > > doesn't currently meet so we can dive deeper on how we could implement
> > > them in a way that would improve the kernel other then simply
> > > providing compliance to FIPS?
> > 
> > Discussing things doesn't usually work well.  Let's see some working
> > patches first, that solve problems that you have with the current random
> > code, and we can go from there.
> > 
> > Again, like any other kernel patch submission, nothing new here at all.
> 
> Hi, Greg. I understand your point but we had plenty of patch
> submissions already from Stephan, Nicolai and others and that didn't
> work. So I am expecting that anybody taking over as the random.c
> maintainer can at least provide some direction on that.

Then submit patches to be reviewed!  This patch series was commented on
why it is not acceptable, so it's done with for now.

We can't go back in time and dig up old patch series to be reviewed now
unless they are actually refreshed and resubmitted.

Why isn't anyone doing that?

> > > I believe all the distros are interested in making progress on that,
> > > but without a general guidance it makes very hard for us to
> > > collaborate and we end up in the current situation in which each
> > > distro is carrying its own "hack", as Simo mentioned before. Canonical
> > > is in the same situation as the other distros and we are carrying an
> > > workaround to wire up the crypto DRBG to random.c in order to archive
> > > compliance.
> > 
> > If everyone seems to think their patches are hacks, and are not worthy
> > of being submitted, then why do they think that somehow they are viable
> > for their users that are actually using them?
> 
> Because although some people dislike it, FIPS is still a requirement
> for many users. That's the reality and that will not change just
> because there are some resistance against it.
> 
> The patches that distros are carrying are hacks because they try to
> minimize risks while keeping the code as close as possible to
> upstream. But that has several drawbacks, such as performance, limited
> entropy sources an so on, that to me makes them not suitable for
> upstream.

In other words, "the hacks we made to the random code are so bad we do
not want to submit them upstream for everyone to review as our names
would be on them and we would have to justify them to the world"?  :)

Given that there are no patches here to review by anyone, why is this
email thread still persisting?

Again, the only way forward is to submit changes that meet our
well-documented development process.  There's nothing "special" about
this very tiny .c file that is any different than the other 30 million
lines of kernel code we support that warrants a different process at
all.

greg k-h
