Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7186E49714A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiAWLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAWLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:24:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EA9C06173B;
        Sun, 23 Jan 2022 03:24:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JhW3S1Ss8z4xNq;
        Sun, 23 Jan 2022 22:24:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642937060;
        bh=AXqTBcO/JQOfYg0JjB8y47Tymg3zAnj4rj1Hr3uw2sQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kDf0RgzN5aMBMcChu8mUaXYqGZEySy/H1izEgPl1BiDkrbARh6RQR+Deo3Y6YWst/
         EIhFXnoJwelNXE8EhcjQcaVke5fX3iKXaRgoiAcEz1+i+RUtXDhG96PeYVUsYrwcIB
         NCCVfkGawevaMTrYTvjgdfaCXNnqfuk8dvlmzpH1GYAfEO1XxNcRC4dXGAkJg/3xsY
         lSRZJ23/fSuG73wxKer7mFPXkz4RRY7c/UoGVswKki/fT62WHBkI7Mo6ywZvebhOIJ
         rNpGjey6lu6CCJDY6ZKvY3f1l82674nIWLphgCOg0HMN/SEdrwfXkwc4dgB2HirNpZ
         srW1cEk6UrTIw==
Date:   Sun, 23 Jan 2022 22:24:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH 1/1] sysctl: Fix 'one_thousand' defined but not used
 warning
Message-ID: <20220123222419.1f948e8a@canb.auug.org.au>
In-Reply-To: <Ye0bUGBJWRp+abEF@xhacker>
References: <20220117012317.21168-1-surenb@google.com>
        <Ye0bUGBJWRp+abEF@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QPlZWTPGr0k1gtB4pQ6ulNl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QPlZWTPGr0k1gtB4pQ6ulNl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Sun, 23 Jan 2022 17:09:36 +0800 Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Sun, Jan 16, 2022 at 05:23:17PM -0800, Suren Baghdasaryan wrote:
> > Fix the following warning issued when CONFIG_PERF_EVENTS is not
> > defined:
> >=20
> > kernel/sysctl.c:125:12: warning: 'one_thousand' defined but not used [-=
Wunused-variable]
> >=20
> > Fixes: 39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_fact=
or max limit to 30%")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/sysctl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index ef77be575d87..81a6f2d47f77 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -122,7 +122,9 @@ static unsigned long one_ul =3D 1;
> >  static unsigned long long_max =3D LONG_MAX;
> >  static int one_hundred =3D 100;
> >  static int two_hundred =3D 200;
> > +#ifdef CONFIG_PERF_EVENTS
> >  static int one_thousand =3D 1000; =20
>=20
> what about moving one_thousand definition below to group it with
> six_hundred_forty_kb var together, so that we can avoid one
> #ifdef CONFIG_PERF_EVENTS ... #endif
>=20
> > +#endif
> >  static int three_thousand =3D 3000;
> >  #ifdef CONFIG_PRINTK
> >  static int ten_thousand =3D 10000;
> > --=20
> > 2.34.1.703.g22d0c6ccf7-goog
> >  =20

This has been fixed in Linus' current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/QPlZWTPGr0k1gtB4pQ6ulNl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHtOuMACgkQAVBC80lX
0GyK/Qf/RxIoUc6kNwRGfkw1R+LbpkZEI6NDetkWhkFFyxCsaoKdwFadKGFPtGkD
Uw+V73WlNlMGknsMV5t5TdZqflsVsmt+9lbL4wTBSm9Hdd8We6zR6rBdIbg6fJm+
vLx908fdT7n7NGGSmocNl4+JcvkXhjpjlULTEtISJjuG3VdrIleq2EZ/uCeDCeF9
NnpvzCzDH6u1Nv2tlGltGBCIhvu6IhYjELeoDskxztidFPFcIfATQTCeSFK2dqOJ
bDw16gLG+NXQTqiLL5+LXVLt+eE07NYGc5oVh0B1a3JkPDufbrfPLD22cU0yKHwY
qymRvV1JSD9p2jq4yRHdPJTy8/sKKw==
=CS/l
-----END PGP SIGNATURE-----

--Sig_/QPlZWTPGr0k1gtB4pQ6ulNl--
