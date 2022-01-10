Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9448A0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiAJUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:05:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54680 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiAJUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:05:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29740B817D2;
        Mon, 10 Jan 2022 20:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0641C36AE9;
        Mon, 10 Jan 2022 20:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641845110;
        bh=5UEoJ7LADym/lTJ6UBzOx14TlXiB1WSHgVxNCt8uJaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHNydo81TYOGXNPN05R9ogZ/ri3VFhOQ9PvkHgeD0RJ5OsUOhlFUUFKjDoCso/KM2
         OGZoj+PMuGGC2MyuIGt3FSYfdHcBl5qBypGBtd476RyWiy+IL0CWQgNTlbg3mxZn6E
         3pm6IcgZMWqJa0y3eSnTFIeAEXs8MHbdn9dwW3QlUDL++/AfZLVoNVqWaplS6PJjf4
         fS9JL2KwJL0xKVa/Wu6W3uLYms9yIRr4guRlaOXRQX8f3r2XVyAcBjJ9sAyvOClqHg
         sp/PntthmERkaDv2fpLdYITPVA0v9Bd7Q+lXO/3QIzYDEbK7nouW+QwsJ2aAIftNar
         MGfEu99SsZkBA==
Date:   Mon, 10 Jan 2022 12:05:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Simo Sorce <simo@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YdyRdK5y+xfh3VJQ@sol.localdomain>
References: <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <cdfd8173b1b343413b054957dc2984c27587495c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfd8173b1b343413b054957dc2984c27587495c.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 02:41:33PM -0500, Simo Sorce wrote:
> On Mon, 2022-01-10 at 19:44 +0100, Jason A. Donenfeld wrote:
> > On Mon, Jan 10, 2022 at 4:08 PM Marcelo Henrique Cerri
> > <marcelo.cerri@canonical.com> wrote:
> > > > Just to confirm, this little patch here gives you FIPS certification?
> > > It does
> > 
> > On Mon, Jan 10, 2022 at 7:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > Now, the idea of certifying the whole kernel as a FIPS cryptographic module is
> > > stupid
> 
> Not that it is not the whole kernel, but a "module boundary" is drawn
> around the crypto API and vicinity.
> It would be really nice if this whole "boundary" could be built as a
> single binary module to be loaded in the kernel in fips mode. That way
> we could update the rest of the kernel w/o rebuilding the module, but
> we are not there.

FWIW, the "FIPS module as a loadable kernel module" approach was implemented in
the Android kernel; grep for "fips140" in branch "android13-5.10" of
https://android.googlesource.com/kernel/common.  It's a lot of work for nothing
IMO, but the FIPS certification lab being used is happy with the approach.
Note that random.c is outside of the FIPS module with this approach.

- Eric
