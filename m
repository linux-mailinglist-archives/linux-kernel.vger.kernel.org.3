Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0B46F8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhLJBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:47:36 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59850
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhLJBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:47:35 -0500
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14DA240037
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639100640;
        bh=ZIXrtDOhYU1b9fjx6AyyMn6oiPeFZR5lKunpXwPMkgI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=p/fWojZ5VRoVamDgFCbzqnqUQGGBfRK+G3vwxejSGHklZlKvhByFbOYVIzap4JJ+q
         dnd+HjpppvtwiM4ywOG4yf9INmZNCXwfFumJkXXX/+YAFI6CpQtUroY+IoODoPUTNC
         Yh0JLr+NkcFH7CD9HsDCKH80+LimLOq8vDizP6+p28dODveOtsD8CJQ4bO/YCsOFdo
         ReldcOa+Ob3KJq40le7j9cvw1PlSpQ/yJJRr5KMHbyWI9oLTDvSvkz5yJhpXjP4EQv
         h8xN9JOeFdkTE2YH4hLl/P7CDdev43asEgZKJxT0VCwyUotTcBqaGEPUX/cWOxTSXL
         59Bk4PD1cTchg==
Received: by mail-ua1-f72.google.com with SMTP id g9-20020ab04e09000000b002e8ebb5df39so5712567uah.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIXrtDOhYU1b9fjx6AyyMn6oiPeFZR5lKunpXwPMkgI=;
        b=k3gyxmZkZ6LqjnEcXLYDx1nG1nQg30xjnTle4+U1JqIURBwTGYayNi7OqvW3cRLesO
         5zqnLoTW8HamENjFUYYr7FxTtlSrk30EAaxB5b9Qxs7X58RFgSVUGq5WBWNIrl6t33wO
         Z/899CxIRkOSKSVC177bU5LAot8P3MnlwOFO9/SoL/wKSh5gl8pbUQrtdnmSSmQYqOLq
         nWBh/iJruQACkKewahDpb4/yMpLfJ/TVUYdymJlmifbbzTTkuNuJl6po8+aPhKXfqEzp
         FynNQ1a0odHjT/aQlAclk8uDiH4adWRPsOM2bK8u6Mac04L6KIG1JEx9MVymbWSdfRCi
         /Ajw==
X-Gm-Message-State: AOAM533iDxjMarqXwqchfI0aO/wbFWJtU4dvFC9QRwtGnSgTh2vYgMrK
        3+sYl6SVk1lphcETOhyCqU4BeJKjfAgdpSH0RbnNQWdZGlnGbysVPSx+O+ry963EGiqRcmvZgoX
        FF0aLSbuDnm8SnIZU7NJNqKlYOI1CJPJPJ9hvmxUb
X-Received: by 2002:a05:6122:50e:: with SMTP id x14mr15820885vko.7.1639100628005;
        Thu, 09 Dec 2021 17:43:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUv/BrMDsPwYgaX0VKdnt6UdhIQI8FrDbG0uOiawhq3qrga49+obfrgZrIxyNo1TP/ZjADlQ==
X-Received: by 2002:a05:6122:50e:: with SMTP id x14mr15820827vko.7.1639100627706;
        Thu, 09 Dec 2021 17:43:47 -0800 (PST)
Received: from valinor (201-1-104-75.dsl.telesp.net.br. [201.1.104.75])
        by smtp.gmail.com with ESMTPSA id r2sm975467vsk.28.2021.12.09.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 17:43:46 -0800 (PST)
Date:   Thu, 9 Dec 2021 22:43:37 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20211210014337.xmin2lu5rhhe3b3t@valinor>
References: <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="la2bihmaswtec7aj"
Content-Disposition: inline
In-Reply-To: <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--la2bihmaswtec7aj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 11:02:38AM -0500, Jason A. Donenfeld wrote:
> Hi Simo,
>=20
> I think various folks have said this during the various discussions on th=
is
> topic over the years, in addition to myself, but I suppose I'll reiterate=
 my
> general views on FIPS in this context.
>=20
> FIPS is about compliance and certification. From a cryptographic point of
> view, there might be some good ideas, some dated ideas, some superfluous =
but
> harmless ideas, and so forth. But the reason that you want it for your
> customers is because you think your product will become more valuable or
> useful to customers if it checks that green compliance checkbox. I don't =
think
> we disagree about this being the motivation.
>=20
> Now typically the kernel interoperates with lots of things and implements=
 many
> different specifications. It supports scores of network protocols, IPsec
> cipher suites, USB quirks, SCSI hacks, you name it. The implementation of
> these drivers is always up to the author and hopefully kernel developers =
at
> large do the best job they can with the implementation, but the hardware =
or
> protocol they're interfacing with is not up to the author, by virtue of it
> being external to the kernel. It's not like instantiating IPsec with sing=
le
> DES and MD4, or SM3 and SM4, etc. is so great, and it's not like the
> compendium of brilliant hacks in drivers/usb/host/pci-quirks.c is so great
> either. But these things all exist to talk to something *outside* of the
> kernel, and so we grit our teeth, and as I said, do the best we can to
> implement it well.
>=20
> But the RNG isn't like that. In fact, the RNG is logically *required* to =
be
> not anything like that: it returns random bytes, and they must not have a=
ny
> distinguishing quality with other random bytes; otherwise we have a serio=
us
> problem that needs fixing. And so, we carry things out according to the u=
sual
> kernel developer mindset: we implement it as best as we can, using the be=
st
> algorithms we can find, in a way most suitable for the kernel.
>=20
> Then FIPS comes along and starts dictating things about *how* we implemen=
t it,
> and those things it dictates might not be exactly the same as what we wou=
ld
> would be doing when doing best that we can, using the best algorithms we =
can
> find, and in the most suitable way for the kernel. And so it would seem t=
hat
> the goal of implementing the RNG as best as we can might potentially be at
> odds with the goal of getting that green compliance checkbox, because that
> checkbox oversteps its bounds a bit.
>=20
> That's not to say, of course, that we shouldn't accept input on how we
> implement our algorithms from elsewhere. On the contrary, I think random.=
c has
> a *lot* to gain from incorporating newer ideas, and that the formalism and
> guidance from academic cryptographers is less "academic" than it once was=
 and
> much more real world, implementable, and suitable for our uses. But, agai=
n,
> incorporating new ideas and accepting input on how to improve our code is=
 very
> much not the same thing as following the FIPS laundry list for that green
> compliance checkbox. Maybe some parts do overlap -- and I'd love patches =
that
> improve the code alongside compelling cryptographic arguments -- but, aga=
in,
> we're talking about compliance here, and not a more welcome, "hey check o=
ut
> this document I found with a bunch of great ideas we should implement."
>=20
> I would like the kernel to have an excellent CSPRNG, from a cryptographic
> point of view, from a performance point of view, from an API point of vie=
w. I
> think these motivations are consistent with how the kernel is generally
> developed. And I think front loading the motivations with an external
> compliance goal greatly deviates and even detracts from the way the kerne=
l is
> generally developed.
>=20
> Now the above is somewhat negative on FIPS, but the question can still be
> posed: does FIPS have a path forward in the RNG in the kernel? It's obvio=
usly
> not a resounding "yes", but I don't think it's a totally certain "no" eit=
her.
> It might be possible to find some wiggle room. I'm not saying that it is
> certainly possible to do that, but it might be.
>=20
> Specifically, I think that if you change your perspective from, "how can =
we
> change the algorithms of the RNG to be FIPS" to "how can we bend FIPS wit=
hin
> its limits so that having what customers want would minimally impact the
> quality of the RNG implementation or introduce undue maintenance burdens."
> This means: not refactoring the RNG into some large abstraction layer tha=
t's
> pluggable and supports multiple different implementations, not rewriting =
the
> world in a massive patchset, not adding clutter. Instead, perhaps there's=
 a
> very, very minimal set of things that can be done that would be considera=
bly
> less controversial. That will probably require from you and other FIPS
> enthusiasts some study and discussion at what the truly most minimal set =
of
> things required are to get you that green compliance checkbox. And hey --
> maybe it's still way too much and it doesn't work out here. But maybe it'=
s not
> that much, or, as Greg suggested, maybe it winds up that your needs are
> actually satisfied just fine by something in userspace or userspace-adjac=
ent.
>=20
> So I don't know whether the FIPS has a path forward here, but if it does,=
 I
> think the above is the general shape it would take. And in the mean time,=
 I'm
> of course open to reviewing patches that improve the RNG in a cryptograph=
ic or
> algorithmic sense, rather than a purely compliance one.

Hi, Jason. How do you think we could approach that then?

Are you willing to discuss the FIPS 140-3 requirements that random.c
doesn't currently meet so we can dive deeper on how we could implement
them in a way that would improve the kernel other then simply
providing compliance to FIPS?

I believe that several requirements would be beneficial to random.c
(ie, health test, oversampling, entropy data collection). But so far
we lack proper direction on how to proceed and it would be better for
us to have a clear notion of what could be accepted before putting
more effort on yet another patch set.

I believe all the distros are interested in making progress on that,
but without a general guidance it makes very hard for us to
collaborate and we end up in the current situation in which each
distro is carrying its own "hack", as Simo mentioned before. Canonical
is in the same situation as the other distros and we are carrying an
workaround to wire up the crypto DRBG to random.c in order to archive
compliance.

We could also concentrate all the discussion in the linux-crypto
mailing list to facilitate this process, since right now I believe the
MAINTAINERS file doesn't have a specific mailing list associate to
random.c

>=20
> Hopefully that helps you understand more about where we're coming from.
>=20
> Regards,
> Jason

--=20
Regards,
Marcelo


--la2bihmaswtec7aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAmGysMkACgkQ6e82Loes
sAmfqgv/b3XReppZ/jZp4KBaaW+pGPhNK6MiZFt4oHXDaM8TLmp3aD7kF4EVxOHY
9G4hRLgTvum5VdRZnKBLHj2MslQzShp7m3BQcu1rzF6isLEWhnJGr6CdbMWBsYN0
t4d62lRtKuC9qmZDptxU2N3F8Zic6GzXhRznR3BW19D7y9+LuS7+XpHQrdF81cyl
E0AG659067HSwpUS7BFgwkCADL6eRYvAs/fdwIXUI76d+I7cRdu47zngbfQJzPxn
mbj8EiHX0mSWTO39Q6JeljDe3WGC+Ze5E7rA1BHLn9l4PGuPlGn6UHh9OBvr+Peq
soWmXqSQgsA+uTl9qBn2lagSIsjd3cFjoYBTwA6INSUJUs3o4bkXLNpDNYGmWwFd
gFlNJ+ed50KKrUKCxHnJeSm+LahnDfkz/kN6mQggyBGXWVg/37xXwpln+fEPmUpu
Hm5gFqwImSfSL7BCmdPtyGpoC+/QZ5t6pzqbfYrATN7vhgmqyCOv/AVYLfhAtcbD
/XsovBXs
=3QkD
-----END PGP SIGNATURE-----

--la2bihmaswtec7aj--
