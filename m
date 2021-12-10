Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3B46FAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhLJGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbhLJGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:50:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76780C061746;
        Thu,  9 Dec 2021 22:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 283FAB82779;
        Fri, 10 Dec 2021 06:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2908C00446;
        Fri, 10 Dec 2021 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639118791;
        bh=OtcYWcrE7+fgmYrrmv9WrsJEdx2OzJXkqwY8azLwKO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZsVpqRut1pFnfNfNJrw053jZzC2+bdbamEVFwA2g7V5ZauxQqr8+LjihlsmOpNXA
         jWeUiDSBiSOVKK1e+1G0w66MH+JyJ9RSZvcgQ7tlGSOqvqPSkVL5l1FodT6xL205lL
         IqjkfwHsC9D+6hMaTAIkwlpaB/eqxDsZsIaicyeQ=
Date:   Fri, 10 Dec 2021 07:46:24 +0100
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
Message-ID: <YbL3wNBFi2vjyvPj@kroah.com>
References: <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210014337.xmin2lu5rhhe3b3t@valinor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:43:37PM -0300, Marcelo Henrique Cerri wrote:
> Hi, Jason. How do you think we could approach that then?
> 
> Are you willing to discuss the FIPS 140-3 requirements that random.c
> doesn't currently meet so we can dive deeper on how we could implement
> them in a way that would improve the kernel other then simply
> providing compliance to FIPS?

Discussing things doesn't usually work well.  Let's see some working
patches first, that solve problems that you have with the current random
code, and we can go from there.

Again, like any other kernel patch submission, nothing new here at all.

> I believe all the distros are interested in making progress on that,
> but without a general guidance it makes very hard for us to
> collaborate and we end up in the current situation in which each
> distro is carrying its own "hack", as Simo mentioned before. Canonical
> is in the same situation as the other distros and we are carrying an
> workaround to wire up the crypto DRBG to random.c in order to archive
> compliance.

If everyone seems to think their patches are hacks, and are not worthy
of being submitted, then why do they think that somehow they are viable
for their users that are actually using them?

{sigh}

greg k-h
