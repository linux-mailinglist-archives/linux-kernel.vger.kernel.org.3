Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B147149F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhLKQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:05:32 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:48675 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhLKQFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:05:31 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BBG4Pcm006075;
        Sat, 11 Dec 2021 17:04:25 +0100
Date:   Sat, 11 Dec 2021 17:04:25 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Tso Ted <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 00/15] /dev/random - a new approach
Message-ID: <20211211160425.GA6023@1wt.eu>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <f59e7a25-ea0b-b36e-791e-8ab49bc7102c@schoebel-theuer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59e7a25-ea0b-b36e-791e-8ab49bc7102c@schoebel-theuer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 04:45:55PM +0100, Thomas Schoebel-Theuer wrote:
> 4) Collection of entropy vs consumption of entropy: the old /dev/random has
> an important feature for me: any _mass_ usage by whatever class of users
> (whether tenthousands of UIDs per server and/or HTTP/second, or maybe even
> some privileged orchestration scripts) would _consume_ masses of entropy.
> When suchalike consumption would exceed the production rate, the old
> /dev/random would become so slow that our internal monitoring processes
> would certainly alert, and consequently would hint our responsibles (located
> at other teams) at the problem.

I'm sorry but I cannot agree with you on this. You are claiming that your
monitoring processes are so limited that the only situation they can
discover is when the machine is basically dead. There are plenty of
users who end up replacing /dev/random with /dev/urandom in production
to make sure a terrible service outage never happens again, and one
important feature of an RNG is its performance, particularly when it's
shared between processes and users. The fact that your monitoring only
triggers when the system becomes unusable is a proof that it must be
fixed, and certainly not an indication that any possible kernel
limitation you're benefitting from does not deserve to be addressed.

Willy
