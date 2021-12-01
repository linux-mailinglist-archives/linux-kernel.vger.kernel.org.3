Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E67465252
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351320AbhLAQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhLAQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:06:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E21C061574;
        Wed,  1 Dec 2021 08:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83D51CE1F9D;
        Wed,  1 Dec 2021 16:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E8C53FAD;
        Wed,  1 Dec 2021 16:02:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="caygapzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638374574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrQW1Ely4/h7sdqog63OvLrVR5CU4XIcDh4k7AzyitM=;
        b=caygapzKMF2crhxdniY8JBztPaOyeNdUyzPc2rQCK4nXv7FLhKxBD8sIgH6nwCwa3NfxwJ
        szjj2K93w52W64ylCKwMst8IyT5CHSZTH4STl/Uxs38MM0/XgQsc4WNP2oj3BCIX0u+bOf
        7jBFBxN28TmpEYfHfZCZwWn4w46vv58=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 556139f9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 1 Dec 2021 16:02:54 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id y68so64888748ybe.1;
        Wed, 01 Dec 2021 08:02:54 -0800 (PST)
X-Gm-Message-State: AOAM530S43CBu/bioC0WGfYbUR3jOFf9WQLRNDgkQciMEQRekSZ9wRsk
        KYJ8xcd6Rh+tiYZDEUnxcukrImPSZNPH2JIWoJw=
X-Google-Smtp-Source: ABdhPJwv0iqr6pRuHAQ9lWIf29SaadZRhdHa+fhNagQmLZwlE/EieNlFkp7LPf6JaQxZsAWYG37MceqIo/8VOMgxI6w=
X-Received: by 2002:a25:a427:: with SMTP id f36mr8389055ybi.245.1638374569471;
 Wed, 01 Dec 2021 08:02:49 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com> <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com> <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com> <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com> <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
In-Reply-To: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 1 Dec 2021 11:02:38 -0500
X-Gmail-Original-Message-ID: <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
Message-ID: <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Simo Sorce <simo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simo,

I think various folks have said this during the various discussions on this
topic over the years, in addition to myself, but I suppose I'll reiterate my
general views on FIPS in this context.

FIPS is about compliance and certification. From a cryptographic point of
view, there might be some good ideas, some dated ideas, some superfluous but
harmless ideas, and so forth. But the reason that you want it for your
customers is because you think your product will become more valuable or
useful to customers if it checks that green compliance checkbox. I don't think
we disagree about this being the motivation.

Now typically the kernel interoperates with lots of things and implements many
different specifications. It supports scores of network protocols, IPsec
cipher suites, USB quirks, SCSI hacks, you name it. The implementation of
these drivers is always up to the author and hopefully kernel developers at
large do the best job they can with the implementation, but the hardware or
protocol they're interfacing with is not up to the author, by virtue of it
being external to the kernel. It's not like instantiating IPsec with single
DES and MD4, or SM3 and SM4, etc. is so great, and it's not like the
compendium of brilliant hacks in drivers/usb/host/pci-quirks.c is so great
either. But these things all exist to talk to something *outside* of the
kernel, and so we grit our teeth, and as I said, do the best we can to
implement it well.

But the RNG isn't like that. In fact, the RNG is logically *required* to be
not anything like that: it returns random bytes, and they must not have any
distinguishing quality with other random bytes; otherwise we have a serious
problem that needs fixing. And so, we carry things out according to the usual
kernel developer mindset: we implement it as best as we can, using the best
algorithms we can find, in a way most suitable for the kernel.

Then FIPS comes along and starts dictating things about *how* we implement it,
and those things it dictates might not be exactly the same as what we would
would be doing when doing best that we can, using the best algorithms we can
find, and in the most suitable way for the kernel. And so it would seem that
the goal of implementing the RNG as best as we can might potentially be at
odds with the goal of getting that green compliance checkbox, because that
checkbox oversteps its bounds a bit.

That's not to say, of course, that we shouldn't accept input on how we
implement our algorithms from elsewhere. On the contrary, I think random.c has
a *lot* to gain from incorporating newer ideas, and that the formalism and
guidance from academic cryptographers is less "academic" than it once was and
much more real world, implementable, and suitable for our uses. But, again,
incorporating new ideas and accepting input on how to improve our code is very
much not the same thing as following the FIPS laundry list for that green
compliance checkbox. Maybe some parts do overlap -- and I'd love patches that
improve the code alongside compelling cryptographic arguments -- but, again,
we're talking about compliance here, and not a more welcome, "hey check out
this document I found with a bunch of great ideas we should implement."

I would like the kernel to have an excellent CSPRNG, from a cryptographic
point of view, from a performance point of view, from an API point of view. I
think these motivations are consistent with how the kernel is generally
developed. And I think front loading the motivations with an external
compliance goal greatly deviates and even detracts from the way the kernel is
generally developed.

Now the above is somewhat negative on FIPS, but the question can still be
posed: does FIPS have a path forward in the RNG in the kernel? It's obviously
not a resounding "yes", but I don't think it's a totally certain "no" either.
It might be possible to find some wiggle room. I'm not saying that it is
certainly possible to do that, but it might be.

Specifically, I think that if you change your perspective from, "how can we
change the algorithms of the RNG to be FIPS" to "how can we bend FIPS within
its limits so that having what customers want would minimally impact the
quality of the RNG implementation or introduce undue maintenance burdens."
This means: not refactoring the RNG into some large abstraction layer that's
pluggable and supports multiple different implementations, not rewriting the
world in a massive patchset, not adding clutter. Instead, perhaps there's a
very, very minimal set of things that can be done that would be considerably
less controversial. That will probably require from you and other FIPS
enthusiasts some study and discussion at what the truly most minimal set of
things required are to get you that green compliance checkbox. And hey --
maybe it's still way too much and it doesn't work out here. But maybe it's not
that much, or, as Greg suggested, maybe it winds up that your needs are
actually satisfied just fine by something in userspace or userspace-adjacent.

So I don't know whether the FIPS has a path forward here, but if it does, I
think the above is the general shape it would take. And in the mean time, I'm
of course open to reviewing patches that improve the RNG in a cryptographic or
algorithmic sense, rather than a purely compliance one.

Hopefully that helps you understand more about where we're coming from.

Regards,
Jason
