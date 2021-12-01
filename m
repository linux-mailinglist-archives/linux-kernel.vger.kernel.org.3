Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631164653CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351844AbhLARXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:23:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351795AbhLARW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638379177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiZDyXKdIjoC0F4y1/21wnzR7Rkw3wQsneZ+xHv3bB8=;
        b=R9UYrYscQG+0/NMeeUbxJui0vpQC237hEwSa+P9V/mN69iOrmee+AdDyhqT4MLfg1gDnAj
        JMPImlTk50jOnCHYivfggyhMuGvmpEI0GDHKp+E5F4OMtBYIQu4RItio0EZHgZquIQ1iT9
        zZPbNZ3zxiTT2zVeLwsOsNLawCUMVZM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Y2QyVT9ePw29dZ-pQzYdXg-1; Wed, 01 Dec 2021 12:19:36 -0500
X-MC-Unique: Y2QyVT9ePw29dZ-pQzYdXg-1
Received: by mail-qt1-f198.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso33023821qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jiZDyXKdIjoC0F4y1/21wnzR7Rkw3wQsneZ+xHv3bB8=;
        b=j0RbeeoYZ6cn5sl6C9d2eQj+Eq0roaU8v0J1qC7IzG9kM0I3wimvEboXALbgULjBh2
         u0yvQHN/IbiEpMSlZT6j8Un6bmFNxONGjPVIZ/+49/OiWaSRIU1dV/mV7y24lMi+3N6N
         nv+WYyLMZFUDfXiwupl4KaHhPG2VjqBjvgamOOCq3YljnAO63pIaoX1x1p+pHuDxOzhF
         wQuy7zM6FEilSDkuBXst4xozkdzeMx4HSDKwL/8pHF+5UpgrZpmKckdS0T3khkxdKkAW
         SBT7a0CQkIA0PzJV2nZTABFh4y2QPxltfcT1Xx5/op4ZiO8yVLCZAt7g0QL+NIaeGCAR
         bVsg==
X-Gm-Message-State: AOAM533KMNu41Fb45DVH8kXp7pBDhZSjNKMeCQJSRIDVcqG7HA2HaHim
        Zeb9ly/q3OEaHO5JnNvFwuTXtwRFdPghX23SUvTsc0iV23aGvg+jyzWfc3KejXFACJgp1g+JcSl
        ILbHURsIq3imbsx+KEhVI6Lsa
X-Received: by 2002:a37:4554:: with SMTP id s81mr7371886qka.762.1638379175786;
        Wed, 01 Dec 2021 09:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWqbuKAE1JfEcn1281HvxQmQCWVq237w2PgHxATmpqKqtM2LHfLb7RFBY3h4huYaJu+j2h5A==
X-Received: by 2002:a37:4554:: with SMTP id s81mr7371851qka.762.1638379175509;
        Wed, 01 Dec 2021 09:19:35 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id p10sm198805qtw.97.2021.12.01.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 09:19:34 -0800 (PST)
Message-ID: <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Date:   Wed, 01 Dec 2021 12:19:33 -0500
In-Reply-To: <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
         <22137816.pfsBpAd9cS@tauon.chronox.de> <YaEJtv4A6SoDFYjc@kroah.com>
         <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
         <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
         <YaYvYdnSaAvS8MAk@kroah.com>
         <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
         <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
         <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
         <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
         <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,
thanks for your reply, I appreciate when there is a clear exchange of
ideas.

Comment inline.

On Wed, 2021-12-01 at 11:02 -0500, Jason A. Donenfeld wrote:
> Hi Simo,
> 
> I think various folks have said this during the various discussions on this
> topic over the years, in addition to myself, but I suppose I'll reiterate my
> general views on FIPS in this context.
> 
> FIPS is about compliance and certification. From a cryptographic point of
> view, there might be some good ideas, some dated ideas, some superfluous but
> harmless ideas, and so forth. But the reason that you want it for your
> customers is because you think your product will become more valuable or
> useful to customers if it checks that green compliance checkbox. I don't think
> we disagree about this being the motivation.

I have to say that although there is clearly a great deal of "because
we need the certification" I do not fully agree that FIPS is just a
checkbox to be ticked for me. Of course for customers that do not care
that much it is, and it is a required one. However having worked a lot
on this I can tell you there is actually real cryptographic value in
the requirements FIPS introduced over the years. If anything my
complaint is that the list of accepted constructs is restrictive, but
other than that most of the requirements have real world sense, and the
certification process do uncover issue that otherwise would linger as
the testing is rather thorough.

> Now typically the kernel interoperates with lots of things and implements many
> different specifications. It supports scores of network protocols, IPsec
> cipher suites, USB quirks, SCSI hacks, you name it. The implementation of
> these drivers is always up to the author and hopefully kernel developers at
> large do the best job they can with the implementation, but the hardware or
> protocol they're interfacing with is not up to the author, by virtue of it
> being external to the kernel. It's not like instantiating IPsec with single
> DES and MD4, or SM3 and SM4, etc. is so great, and it's not like the
> compendium of brilliant hacks in drivers/usb/host/pci-quirks.c is so great
> either. But these things all exist to talk to something *outside* of the
> kernel, and so we grit our teeth, and as I said, do the best we can to
> implement it well.
> 
> But the RNG isn't like that. In fact, the RNG is logically *required* to be
> not anything like that: it returns random bytes, and they must not have any
> distinguishing quality with other random bytes; otherwise we have a serious
> problem that needs fixing. And so, we carry things out according to the usual
> kernel developer mindset: we implement it as best as we can, using the best
> algorithms we can find, in a way most suitable for the kernel.
> 
> Then FIPS comes along and starts dictating things about *how* we implement it,
> and those things it dictates might not be exactly the same as what we would
> would be doing when doing best that we can, using the best algorithms we can
> find, and in the most suitable way for the kernel. And so it would seem that
> the goal of implementing the RNG as best as we can might potentially be at
> odds with the goal of getting that green compliance checkbox, because that
> checkbox oversteps its bounds a bit.

Well I think most of the requirements are sane practices, hopefully
controversial stuff will be minimal. I fully believe we can work to
have the best we can as well as having it FIPS compliant, because the
intent of FIPS requirements here is exactly to have the best guarantees
for randomness.

> That's not to say, of course, that we shouldn't accept input on how we
> implement our algorithms from elsewhere. On the contrary, I think random.c has
> a *lot* to gain from incorporating newer ideas, and that the formalism and
> guidance from academic cryptographers is less "academic" than it once was and
> much more real world, implementable, and suitable for our uses. But, again,
> incorporating new ideas and accepting input on how to improve our code is very
> much not the same thing as following the FIPS laundry list for that green
> compliance checkbox. Maybe some parts do overlap -- and I'd love patches that
> improve the code alongside compelling cryptographic arguments -- but, again,
> we're talking about compliance here, and not a more welcome, "hey check out
> this document I found with a bunch of great ideas we should implement."

I happen to think quite a few of the requirements are actually good
ideas to implement to improve the guarantees of randomness, but there
may definitely be contentious ideas of what is "good" and what is an 
"arbitrary request".

> I would like the kernel to have an excellent CSPRNG, from a cryptographic
> point of view, from a performance point of view, from an API point of view. I
> think these motivations are consistent with how the kernel is generally
> developed. And I think front loading the motivations with an external
> compliance goal greatly deviates and even detracts from the way the kernel is
> generally developed.

I would agree is compliance meant arbitrary/capricious requirements.
Hopefully most of the requirements are reasonable and we can find a
reasonable way to fulfill them.

> Now the above is somewhat negative on FIPS, but the question can still be
> posed: does FIPS have a path forward in the RNG in the kernel? It's obviously
> not a resounding "yes", but I don't think it's a totally certain "no" either.
> It might be possible to find some wiggle room. I'm not saying that it is
> certainly possible to do that, but it might be.
> 
> Specifically, I think that if you change your perspective from, "how can we
> change the algorithms of the RNG to be FIPS" to "how can we bend FIPS within
> its limits so that having what customers want would minimally impact the
> quality of the RNG implementation or introduce undue maintenance burdens."

We always operate with this mindset to be quite frank. The kernel is
just one of many crypto modules we certify, and we always try to find
the least invasive options in all the crypto modules we certify. We
also normally try to get all changes upstream because we think they are
a benefit to everyone.

> This means: not refactoring the RNG into some large abstraction layer that's
> pluggable and supports multiple different implementations, not rewriting the
> world in a massive patchset, not adding clutter.

I think the reason to propose this is to deal with cases where the
kernel community and the FIPS requirement diverge. A pluggable system
allows to provide a downstream module and in general will provide clear
entry-points where to apply downstream patches that minimally deviate
from the general structure.

Unfortunately, regardless of what the kernel community find of its
liking we have a business need to provide FIPS certifications to our
customers. So for us it is also a matter of pragmatically reducing to
the maximum extent possible any necessary deviation from upstream
kernels.

>  Instead, perhaps there's a
> very, very minimal set of things that can be done that would be considerably
> less controversial. That will probably require from you and other FIPS
> enthusiasts some study and discussion at what the truly most minimal set of
> things required are to get you that green compliance checkbox.

As long as there is actual feedback and a willingness to reach a
compromise on both sides when a change does not materially cause
issues, I think this is certainly reasonable.

>  And hey --
> maybe it's still way too much and it doesn't work out here. But maybe it's not
> that much, or, as Greg suggested, maybe it winds up that your needs are
> actually satisfied just fine by something in userspace or userspace-adjacent.

Unfortunately userspace is not an option for kernel's own cryptography.

> So I don't know whether the FIPS has a path forward here, but if it does, I
> think the above is the general shape it would take. And in the mean time, I'm
> of course open to reviewing patches that improve the RNG in a cryptographic or
> algorithmic sense, rather than a purely compliance one.

Hopefully we can take both into account.

> Hopefully that helps you understand more about where we're coming from.

It does,
thanks.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




