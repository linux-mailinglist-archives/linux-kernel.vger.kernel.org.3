Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68955489BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiAJPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:08:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37688
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbiAJPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:08:16 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B8A63FFDD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641827294;
        bh=k4Z0FKYBFvD8zuWLkEANuqJoDxX4Vy32CJrotfBvkeA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=RkvZhz+5jNJqAPZ+RdQQETRwsnr9Cxjy1yYx6hQLKlcXRGROjccJUmumxaYSDEzmZ
         f0tGnk6tZnA7wQRtek1x4z0UerhBA383nn9axWCI0+nRWnPjLlLFe6bG5LFhDdow31
         YXEFZ2kQPsIKRwFBJ1RUzPVL+8SehQ2oCJihK/I7ytRPshX9gEbUAUPjSFjbVyn5Eq
         a9AdOOMUsZfc+RZOJdtIdyM+9Nji6Rh+eF2l/N8CvG/L8Qa/dvEeYDQzKzx5fyyK66
         y+T8e+f2iaMuAlcuVh40x63ah9r3beyIOi47qV6St74Z4azBYDahSzj17McfvcviAj
         svvsVYZ8JRiFQ==
Received: by mail-oi1-f197.google.com with SMTP id s18-20020acaa912000000b002c86172672dso3081294oie.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4Z0FKYBFvD8zuWLkEANuqJoDxX4Vy32CJrotfBvkeA=;
        b=126NeOsHyOoSeQgEgMdc9cLWTDK5Kh4qUx06nYEkbhuxKb6imC7oPhNHSKNwYQOrGa
         9JjS/XYQq83AvBKcs/V2b8cYMl5lYKIn+q+AVdeyeiak43+R6LEFQy7BDh6IAyxIeQKI
         KkeYg4+AGgJsuGhd91VWyr4uqfd8mZa6nzuh6qZSI1UquCPab9DyG1/I/4wlSIcy27xv
         akurdxqYZyV9ZiKEEoUi+PZ+GByQHW6PKDIsUk0rXcZYCOtUJ+vtaLGVMAsLBJ8/VxAr
         jk75BtlsmtJqv2eLa/6uCWtY0OPExdoPIxUpzf9XrJbNhX0GQ6SSdWNxinf3XRT19Tf9
         biag==
X-Gm-Message-State: AOAM533R/BMLEIEvhpMoW4mmMiI8RSmzmq0Ey/OkrsENJ0pI/azQ7bIY
        VHIS8j0QwW/UrJwbN8dmA1jQICz9vxV32Fea5hgwHfuOgWhxwNz/imARUKThsSr14arzJzjfOvw
        HxJZQG35VVs0/pRylptl+00/ZISdlRhU1bAaJk9Ep
X-Received: by 2002:a9f:326d:: with SMTP id y42mr38699uad.119.1641827281683;
        Mon, 10 Jan 2022 07:08:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOgt+M2vPY7qOIlhOxsc6l4UH7vrRQWGTR8qeSBbJzHUyEKU35JdlMBarGftYfPnIu7W2XPQ==
X-Received: by 2002:a9f:326d:: with SMTP id y42mr38661uad.119.1641827281380;
        Mon, 10 Jan 2022 07:08:01 -0800 (PST)
Received: from valinor ([177.95.23.3])
        by smtp.gmail.com with ESMTPSA id w62sm3859726vkd.47.2022.01.10.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:08:00 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:07:51 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simo Sorce <simo@redhat.com>,
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
Message-ID: <20220110150751.eyragx5tk7scd5p4@valinor>
References: <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com>
 <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrkvaum5odjlkfrt"
Content-Disposition: inline
In-Reply-To: <YdxCsI3atPILABYe@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrkvaum5odjlkfrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 10, 2022 at 09:29:04AM -0500, Theodore Ts'o wrote:
> On Mon, Jan 10, 2022 at 03:11:46PM +0100, Jason A. Donenfeld wrote:
> > On Mon, Jan 10, 2022 at 2:24 PM Marcelo Henrique Cerri
> > <marcelo.cerri@canonical.com> wrote:
> > > Hoping that might help with the discussion and to explain why I do
> > > consider those solutions a "hack", that's the patch we've been using
> > > so far to achieve SP 800-90B compliance:
> > >
> > > https://kernel.ubuntu.com/~mhcerri/0001-UBUNTU-SAUCE-random-Use-Crypt=
o-API-DRBG-for-urandom-.patch
> >=20
> > Thanks for sending this in response to my request for it in our private=
 thread.

No problem. And sorry for the delay.

> >=20
> > Just to confirm, this little patch here gives you FIPS certification?

It does because it basically replaces everything in random.c (for
urandom in this case) with the Crypto API DRBG, which is
compliant. Although it might be wiser to replace both urandom and
random in this case.

>=20
> There might be some FIPS certification labs that might be willing to
> be taken in by the jitterentropy story, but when I've had private
> communications from people who are familiar with the Intel
> microarchitecture saying that jitterentropy is mostly "security by
> obscurity", I'd be strongly opposed to replacing the current scheme
> with something which is purely jitteretropy.
>=20
> Perhaps an build-time option where one of the seeds into the CRNG is
> "jitterentropy", but we keep everything else.  That way, jitterentropy
> can still be TSA-style "security theatre", but we're not utterly
> dependant on the "the CPU microarchitecture is SOOOOOOO complicated,
> it *must* be unpredictable".
>

Hi, Theodore.

I might be missing something, but the Crypto API DRBG is seeded by
jitterentropy_rng and by get_random_bytes(), their outputs are both
concatenated and used as the seed. So I don't think that should be a
concern, right?


> 						- Ted

--=20
Regards,
Marcelo


--yrkvaum5odjlkfrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEExJjLjAfVL0XbfEr56e82LoessAkFAmHcS8cACgkQ6e82Loes
sAkzfQv/YFKX+P7lMLHqRDZj2C8ENBjvbx6HOZyNGL9QEucfEHEAlRjjErgxFObs
H0SfkUmIEgg1JGJPCTFrD4Wge4LsU2ZY4seQvl1GM1zpC90icUY//Y1mc+rjpW/A
svYUwA7o7J0+nsZqreMyAgqF3inu6GujSywYHzP71Fjaq61Mu5+5jY//07LpYU4x
uPo2uKiG1d3GjFKWD7QHzgudF+X0/SaVA5NGEDDR0z6G7QS5R2HvDoj8sulCcyr1
nLSkiYQNUAivYPzlgwF/x/ezLdPHvrRWpGJnWkDrPlGfz1cdamdr7z2CgmbX8xZN
q8XUIOrH2d08S4HYh3Z6j3u3E8OQMxQ4vBZKdKs980h65h4AI5gunacKPBBELzED
CCuYycmZlL8BmYW6w1e1Ewnlkfb1xkFW/dElps6RJuJJGbipKCHx9kOgyc6kc6OC
rfuLDaIIb1LJvCuGPsBNGuSMu7wl94f/ueUMTxcFumaQb7GIwzG3/tmKVm2PeAOG
uXF8c05f
=Jjuy
-----END PGP SIGNATURE-----

--yrkvaum5odjlkfrt--
