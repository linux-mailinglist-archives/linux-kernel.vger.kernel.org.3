Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033A54658E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhLAWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353484AbhLAWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:09:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554DBC0613E1;
        Wed,  1 Dec 2021 14:05:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4Cnx2BJ6z4xPv;
        Thu,  2 Dec 2021 09:05:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638396342;
        bh=3qyA6EPZ/k+73zUURyjTLztuFtvmpskxuyB/RgDSpXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ABVWzP1Bcs4FrSIc81Sv5dcAwTqfbT3oz64tf+VWZKVB/YpUseaawjSX4wA7qvdAT
         cHqICEMZoayXnqjba0/iaQ5L4dqE6O3jnj4a4j4KXTOMdCMNDZzOu1SEzXlDrKELma
         p753NqILH9p5JIOmvSsai8x4ezknC7u6rDyVyckOlxTrcP0QOKLLnQAeZrYKQfu5uO
         y3lNcYEOad+RPRopXjXNWJ9hBg/chNFT3SKWpeJmBx9Rrc/hgxe1o9nS1Bcn3fbmCp
         v9hrMRvfQ0dBT29mbXJT00qqW+irWHK6rwF+Jx+iIY+nEJ0ztx1aKUvwpUjORwSF6R
         rmrZTXkHln+Yg==
Date:   Thu, 2 Dec 2021 09:05:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20211202090540.1f22fa39@canb.auug.org.au>
In-Reply-To: <CAK8P3a078LiivyzUiH+D--iRsQGTcQ_hy=-h7crynrbQ6ZYn6A@mail.gmail.com>
References: <20211126145201.5aefa68c@canb.auug.org.au>
        <CAK8P3a078LiivyzUiH+D--iRsQGTcQ_hy=-h7crynrbQ6ZYn6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uaPmmuwOfy6QSXmSWCUZ8uw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uaPmmuwOfy6QSXmSWCUZ8uw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 26 Nov 2021 11:01:52 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 26, 2021 at 4:52 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > After merging the tip tree, today's linux-next build (sparc defconfig)
> > failed like this:
> >
> > In file included from arch/sparc/include/asm/futex_32.h:4:0,
> >                  from arch/sparc/include/asm/futex.h:7,
> >                  from kernel/futex/futex.h:12,
> >                  from kernel/futex/core.c:41:
> > kernel/futex/core.c: In function 'futex_cmpxchg_value_locked':
> > include/asm-generic/futex.h:17:2: error: implicit declaration of functi=
on 'futex_atomic_cmpxchg_inatomic_local_generic'; did you mean 'futex_atomi=
c_cmpxchg_inatomic_local'? [-Werror=3Dimplicit-function-declaration]
> >   futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newv=
al)
> >   ^
> > include/asm-generic/futex.h:17:2: note: in definition of macro 'futex_a=
tomic_cmpxchg_inatomic'
> >   futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newv=
al)
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ =20
>=20
> Thanks a lot for the report, I sent a fix now:
>=20
> https://lore.kernel.org/lkml/20211126095852.455492-1-arnd@kernel.org

I am still getting this failure (Arnd's fix has not been applied).

--=20
Cheers,
Stephen Rothwell

--Sig_/uaPmmuwOfy6QSXmSWCUZ8uw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGn8bQACgkQAVBC80lX
0Gzpnwf/TQuQ9cTH3hYjEeSGoPCK8aIZc4kiXWuyeI7FcrDXd7TUskdj+B30F1kH
aZj24qY4d1fogfThm47r4t24lMhpCoY4pvDIU9clYPFPxkuIUeW5ysZHvIRw2AAq
dcVGBkeQJ3uhlIzy6aUqCPDHwp8BPne5QVuq+/DXpmyQU/LUPte0xTjRuvjNtkVo
InO1dRMvfOT+pjwoEky1mW2N4oqKQOvM06FCzP1LnGvCmuqjELoRjOxCe2oEcAia
45CDQBN6rYRInwg7+pgX74IMw4V9cknRTTFZ9DTpuLF6RhC7TBQToKWPyZFJBGVa
ohvcZs9oBK15i2N7BPlG42FZVULmiA==
=2Y0+
-----END PGP SIGNATURE-----

--Sig_/uaPmmuwOfy6QSXmSWCUZ8uw--
