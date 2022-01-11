Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB848A6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347532AbiAKENx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbiAKENw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:13:52 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:13:51 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 7C9DA424F9; Tue, 11 Jan 2022 04:13:49 +0000 (GMT)
Date:   Tue, 11 Jan 2022 04:13:49 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20220111041349.GA5542@srcf.ucam.org>
References: <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu>
 <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
 <Ydz1F/AqB1oO/qHF@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydz1F/AqB1oO/qHF@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:10:15PM -0500, Theodore Ts'o wrote:

> Right now, the enterprise distros are doing their own thing, and quite
> frankly, I don't see a problem with that.  If it turns out DRBG is
> less secure (and there are some things that fill me with disquiet),
> then let them take the economic consequences, since they are the ones
> who are doing this for the economic advantages of trying to claim FIPS
> compliance.

The goal is to identify a solution that avoids the enterprise kernels 
needing to do their own thing. They're in a position to globally 
LD_PRELOAD something to thunk getrandom() to improve compatibility if 
they want to, and they're also able to define the expected level of 
breakage if you enable FIPS mode. An approach that allows a single 
kernel to provide different policies in different contexts (eg, 
different namespaces could have different device nodes providing 
/dev/random) makes it easier to configure that based on customer 
requirements.

> If we must support this in the upstream kernel, then configure it via
> CONFIG_RANDOM_SECURITY_THEATRE which redirects getrandom(2) and
> /dev/[u]random to DRBG.  I'd prefer that it be possible for someone to
> put "random_security_theatre=0" on the boot command line which would
> disable redirecting the interfaces to DRBG so if it turns out that
> DRBG *is* less secure, we can give advice on how to turn it off
> without requiring a patched kernel.  :-)

The majority of enterprise customers don't need FIPS compliance, so all 
that would happen in that case is that the vendors would flip the sense 
of that config option and the docs for enterprise distros and mainline 
would be out of sync. I understand that this is a situation where a 
niche case is making life miserable for everyone else, and I understand 
that this is a hole that the enterprise world has dug for itself, but 
where there are people expressing a real tangible use case that exists 
for reasons outside their control, it really feels like we should try to 
find a solution that works for everyone.
