Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2C4899C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiAJNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:24:11 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60780
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbiAJNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:24:09 -0500
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 698CE4001C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641821042;
        bh=y7w1Bq5sCTcZ/SYydrzzqz8DKtVMpeWBxO3/6q2Lkts=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=rMhqJ3wQezmg0DQgEF+fVwFGGryXZxAQvZoeGEx6o7pMPGX670tdtmbdqhyEikxB7
         P4KL+lBp915cKo4B7sm+O3Hgfx6t5ZTo2SVm1nXSrDdWdG1vD7ciK/+3QFsHHSgZJc
         VnFvsGeRtF5az6T/BJSlJnqOBfXVBdm2RVHal3zOpY0py/ZeEECrT0F4HDZs01LVbn
         WNfejn9V31sdUjKsLam2dwb0OkGiyBvDKpJnNdVe6nJAm6r4yuhbnlKIhv6En2JRac
         fWlzSrO2F/Z2nwwcML0LOvMlIh2oI4up/l1+nvZldiA1dkOWxWf9f8aCzQOIPUfuh4
         PK2dSvykqDqkA==
Received: by mail-ua1-f72.google.com with SMTP id e22-20020ab031d6000000b0030525c25702so3712670uan.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7w1Bq5sCTcZ/SYydrzzqz8DKtVMpeWBxO3/6q2Lkts=;
        b=MvFXiNBlFhYSxVRQI/P2PhtT/GlZZiKnRmNgd5gIoc5RB9akaDtHF3VErfpLMvKbRk
         0G7ptApaZFCVm6Em3WngDC0+3bHWV6li/fmbG5nwPsx1aMfRHpaZjyd0cxCxHX80SJLS
         Bg1tuZZaR0M29hjOhHb42fCyZ73U7WS31QdUvaadr3b++6/9FMyp785fUbRFh3UQq2dt
         4IeygLAELgu+LK5+UsaHCykl+U7zA0pVmEOZYVgB5bTrzfoWbSnz3fdp61nPuEjLN1oq
         aVequPWW/Uj3RQMEOOd94n07AH7roZSFkvgyK7HeG90As23j3x2cX0XpjJeEvWMsKttg
         L5EA==
X-Gm-Message-State: AOAM5315kZsnM92o3rFQzb0DXXMYVXyHQlowkNfMREiVrVyXic3MQ+p0
        cGkhNLqdJSwCJeAfMw9Nggx0Ou2vLwa5OICfAg9OG2I3oLH/iHZbhALkJjIbVQtP8ZI56tk94j+
        ceB/LQJK4s9Ct7Bfz3z1/bzWV8LdWmutFYJOECRuB
X-Received: by 2002:a67:fb11:: with SMTP id d17mr25482111vsr.2.1641821038923;
        Mon, 10 Jan 2022 05:23:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKetxYjzs4lgtvK7kEEaUeZW96bKa0kJkQB0GYytA4wBa2q3qQrmNkobu1bOexv+jX8I2gdA==
X-Received: by 2002:a67:fb11:: with SMTP id d17mr25482085vsr.2.1641821038593;
        Mon, 10 Jan 2022 05:23:58 -0800 (PST)
Received: from valinor ([177.95.23.3])
        by smtp.gmail.com with ESMTPSA id n15sm3262637vkf.35.2022.01.10.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 05:23:57 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:23:49 -0300
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
Message-ID: <20220110132349.siplwka7yhe2tmwc@valinor>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijuaecwzdmoqompe"
Content-Disposition: inline
In-Reply-To: <20211210014337.xmin2lu5rhhe3b3t@valinor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijuaecwzdmoqompe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 10:43:37PM -0300, Marcelo Henrique Cerri wrote:
> On Wed, Dec 01, 2021 at 11:02:38AM -0500, Jason A. Donenfeld wrote:
> > Hi Simo,
> >=20
> > I think various folks have said this during the various discussions on =
this
> > topic over the years, in addition to myself, but I suppose I'll reitera=
te my
> > general views on FIPS in this context.
> >=20
> > FIPS is about compliance and certification. From a cryptographic point =
of
> > view, there might be some good ideas, some dated ideas, some superfluou=
s but
> > harmless ideas, and so forth. But the reason that you want it for your
> > customers is because you think your product will become more valuable or
> > useful to customers if it checks that green compliance checkbox. I don'=
t think
> > we disagree about this being the motivation.
> >=20
> > Now typically the kernel interoperates with lots of things and implemen=
ts many
> > different specifications. It supports scores of network protocols, IPsec
> > cipher suites, USB quirks, SCSI hacks, you name it. The implementation =
of
> > these drivers is always up to the author and hopefully kernel developer=
s at
> > large do the best job they can with the implementation, but the hardwar=
e or
> > protocol they're interfacing with is not up to the author, by virtue of=
 it
> > being external to the kernel. It's not like instantiating IPsec with si=
ngle
> > DES and MD4, or SM3 and SM4, etc. is so great, and it's not like the
> > compendium of brilliant hacks in drivers/usb/host/pci-quirks.c is so gr=
eat
> > either. But these things all exist to talk to something *outside* of the
> > kernel, and so we grit our teeth, and as I said, do the best we can to
> > implement it well.
> >=20
> > But the RNG isn't like that. In fact, the RNG is logically *required* t=
o be
> > not anything like that: it returns random bytes, and they must not have=
 any
> > distinguishing quality with other random bytes; otherwise we have a ser=
ious
> > problem that needs fixing. And so, we carry things out according to the=
 usual
> > kernel developer mindset: we implement it as best as we can, using the =
best
> > algorithms we can find, in a way most suitable for the kernel.
> >=20
> > Then FIPS comes along and starts dictating things about *how* we implem=
ent it,
> > and those things it dictates might not be exactly the same as what we w=
ould
> > would be doing when doing best that we can, using the best algorithms w=
e can
> > find, and in the most suitable way for the kernel. And so it would seem=
 that
> > the goal of implementing the RNG as best as we can might potentially be=
 at
> > odds with the goal of getting that green compliance checkbox, because t=
hat
> > checkbox oversteps its bounds a bit.
> >=20
> > That's not to say, of course, that we shouldn't accept input on how we
> > implement our algorithms from elsewhere. On the contrary, I think rando=
m.c has
> > a *lot* to gain from incorporating newer ideas, and that the formalism =
and
> > guidance from academic cryptographers is less "academic" than it once w=
as and
> > much more real world, implementable, and suitable for our uses. But, ag=
ain,
> > incorporating new ideas and accepting input on how to improve our code =
is very
> > much not the same thing as following the FIPS laundry list for that gre=
en
> > compliance checkbox. Maybe some parts do overlap -- and I'd love patche=
s that
> > improve the code alongside compelling cryptographic arguments -- but, a=
gain,
> > we're talking about compliance here, and not a more welcome, "hey check=
 out
> > this document I found with a bunch of great ideas we should implement."
> >=20
> > I would like the kernel to have an excellent CSPRNG, from a cryptograph=
ic
> > point of view, from a performance point of view, from an API point of v=
iew. I
> > think these motivations are consistent with how the kernel is generally
> > developed. And I think front loading the motivations with an external
> > compliance goal greatly deviates and even detracts from the way the ker=
nel is
> > generally developed.
> >=20
> > Now the above is somewhat negative on FIPS, but the question can still =
be
> > posed: does FIPS have a path forward in the RNG in the kernel? It's obv=
iously
> > not a resounding "yes", but I don't think it's a totally certain "no" e=
ither.
> > It might be possible to find some wiggle room. I'm not saying that it is
> > certainly possible to do that, but it might be.
> >=20
> > Specifically, I think that if you change your perspective from, "how ca=
n we
> > change the algorithms of the RNG to be FIPS" to "how can we bend FIPS w=
ithin
> > its limits so that having what customers want would minimally impact the
> > quality of the RNG implementation or introduce undue maintenance burden=
s."
> > This means: not refactoring the RNG into some large abstraction layer t=
hat's
> > pluggable and supports multiple different implementations, not rewritin=
g the
> > world in a massive patchset, not adding clutter. Instead, perhaps there=
's a
> > very, very minimal set of things that can be done that would be conside=
rably
> > less controversial. That will probably require from you and other FIPS
> > enthusiasts some study and discussion at what the truly most minimal se=
t of
> > things required are to get you that green compliance checkbox. And hey =
--
> > maybe it's still way too much and it doesn't work out here. But maybe i=
t's not
> > that much, or, as Greg suggested, maybe it winds up that your needs are
> > actually satisfied just fine by something in userspace or userspace-adj=
acent.
> >=20
> > So I don't know whether the FIPS has a path forward here, but if it doe=
s, I
> > think the above is the general shape it would take. And in the mean tim=
e, I'm
> > of course open to reviewing patches that improve the RNG in a cryptogra=
phic or
> > algorithmic sense, rather than a purely compliance one.
>=20
> Hi, Jason. How do you think we could approach that then?
>=20
> Are you willing to discuss the FIPS 140-3 requirements that random.c
> doesn't currently meet so we can dive deeper on how we could implement
> them in a way that would improve the kernel other then simply
> providing compliance to FIPS?
>=20
> I believe that several requirements would be beneficial to random.c
> (ie, health test, oversampling, entropy data collection). But so far
> we lack proper direction on how to proceed and it would be better for
> us to have a clear notion of what could be accepted before putting
> more effort on yet another patch set.
>=20
> I believe all the distros are interested in making progress on that,
> but without a general guidance it makes very hard for us to
> collaborate and we end up in the current situation in which each
> distro is carrying its own "hack", as Simo mentioned before. Canonical
> is in the same situation as the other distros and we are carrying an
> workaround to wire up the crypto DRBG to random.c in order to archive
> compliance.
>

Hoping that might help with the discussion and to explain why I do
consider those solutions a "hack", that's the patch we've been using
so far to achieve SP 800-90B compliance:

https://kernel.ubuntu.com/~mhcerri/0001-UBUNTU-SAUCE-random-Use-Crypto-API-=
DRBG-for-urandom-.patch


> We could also concentrate all the discussion in the linux-crypto
> mailing list to facilitate this process, since right now I believe the
> MAINTAINERS file doesn't have a specific mailing list associate to
> random.c
>=20
> >=20
> > Hopefully that helps you understand more about where we're coming from.
> >=20
> > Regards,
> > Jason
>=20
> --=20
> Regards,
> Marcelo
>=20



--=20
Regards,
Marcelo


--ijuaecwzdmoqompe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAmHcM2UACgkQ6e82Loes
sAk33gv/fzqfdl9QneT2Xww4tzE2f/70KjJRsT7whiSU5yBSYAwOedxExVcEa5w2
B3tiTXQNtO5TF0pWPARauxGUQUUcyJOv+93B43e/wv39aay+MLK4Z+rz74Sq3a1g
sT8MPto7TCH8l6ZK+fUi7s3EEqUsheoGQnG5ElQ0AtkJxQeB8xZomwsPh4W45SME
4LaDiY2iFCwMNZy6Mfp8+l0eSuGR1m+WZUiKbR4PQCMmVgYT6vO8FS43fZJaj+Y8
LJ0hezFqu93/s6d+e9eE4m+xmUjpAdS6WC6N6ZfqB0b13220Z3nCO2EY3hWoSD+N
SsASLQucXSyUgsXriS60c0FcWy8xPFlQOtJA/IcyuQ42ns9uw9nQNcrVOT2hBRvM
aXOrIY9Mleq4C2KOCjCf7T5WneBS+ptsl7DskC8kAOj4T7AwA7U5GSlnk7Ihnalm
GBPWW8p9j9t281HwjdDQ6gY6hYKcatiPY/brq+EuZw20GBcDJy6+ilbJux8GmWkJ
zIJKMYRH
=b+oB
-----END PGP SIGNATURE-----

--ijuaecwzdmoqompe--
