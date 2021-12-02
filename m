Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2865A465E84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355774AbhLBHQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:16:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55392 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhLBHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:16:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27F54B8214D;
        Thu,  2 Dec 2021 07:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C6C00446;
        Thu,  2 Dec 2021 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638429158;
        bh=oHg2l/U0p0wGsRrlI/rTNcspthN6DFWCqLaMurRqCV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrICSyWhFF8ObziEH7FC1N9oXzGT+j/k6V1QWJ8MApkea3l7TKqmUA1QfAdQe6dV1
         fxzTFJdm0AX98cxcqciEupwZJjf+QBj5vnkoRXoPnPEeTgGxqEWzeoZnKkbeIfabB/
         YeM53VJy2npy2Z7lV2eLIXoNd+Cj6Ban/XW3qCOI=
Date:   Thu, 2 Dec 2021 08:12:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simo Sorce <simo@redhat.com>,
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
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
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
Message-ID: <Yahx41BRXW5E7yWQ@kroah.com>
References: <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
 <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
 <CAH8yC8k1WMwjoUXY_2nWjLMLVLPQsno3asyDEYVRJ4pg=OpLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8k1WMwjoUXY_2nWjLMLVLPQsno3asyDEYVRJ4pg=OpLQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:24:43PM -0500, Jeffrey Walton wrote:
> On Wed, Dec 1, 2021 at 1:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 12:19 PM Simo Sorce <simo@redhat.com> wrote:
> > > that much it is, and it is a required one. However having worked a lot
> > > on this I can tell you there is actually real cryptographic value in
> > > the requirements FIPS introduced over the years
> > > Well I think most of the requirements are sane practices, hopefully
> > > controversial stuff will be minimal.
> > > I happen to think quite a few of the requirements are actually good
> > > ideas to implement to improve the guarantees of randomness
> >
> > If you think there are good ways to improve the RNG, of course send
> > patches for this, justifying why, taking into account recent research
> > into the topic you wish to patch, etc. Don't write, "because FIPS";
> > instead argue rationale for each patch. And if you _do_ feel the need
> > to appeal to authority, perhaps links to the various eprint papers you
> > consulted would be worthwhile. Preferably you're able to do this in a
> > small, incremental way, with small standalone patchsets, instead of
> > gigantic series.
> 
> I may be parsing things incorrectly, but you seem to be rejecting the
> NIST requirements, and then positioning your personal opinion as
> superior. It sounds like one authority is being replaced by another.
> Perhaps I am missing something.
> 
> I am also guessing you've never read the relevant NIST documents. The
> documents state the security goals and provide the steps to achieve
> them in an implementation.

Ok, I think this thread has gone on long enough without any real
patches.

Please, if you want to support NIST, or any other type of thing, submit
patches that implement what you think will help achieve this.  Absent of
that, we have no idea what NIST or any other random document aims to
require or wish.

thanks,

greg k-h
