Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFD4785B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhLQHr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLQHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:47:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22EC061574;
        Thu, 16 Dec 2021 23:47:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFh0G24V4z4xbd;
        Fri, 17 Dec 2021 18:47:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639727246;
        bh=C0aQyyBoJ0vc0jsTLBJ+s6i4ahtjhd7xmSrL0SXR4tM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PVKFpKTqtrliIJ6ST8dGuhkI2ieeKEysX89PQQUUuaJTsDg0Gzec7chhIIYDEB5nx
         a52tGdNfjtEkhWWbta8i9j0ZmeUTIU4SdcSEwFf+Sk8U1tJXR7jDe2MRo1iXfikKam
         PiOKsZAZ35I941IdTPQgWaKBy+YRmrgp+AgLmylcSQVARoQoOfjPocWBsVVQfjnQ/f
         Dx3Q2RzHBX5xn47++ZdWOdiQJGvNF8ysd1nCyTMlSjYW1S4IyhDwMN5ssx2IoNRCGF
         0XDU7hKK2yASKjRs6S6WnKXgUcLL9fbMb7pF6wc7EMW/Vd5xXgwuVTyUEKnyjZKtTL
         4IN0CFOmB43mg==
Date:   Fri, 17 Dec 2021 18:47:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the userns tree with the cel tree
Message-ID: <20211217184725.6be885a1@canb.auug.org.au>
In-Reply-To: <YbugCP144uxXvRsk@sirena.org.uk>
References: <20211216193412.2441434-1-broonie@kernel.org>
        <YbugCP144uxXvRsk@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5gplELS6X4wl.E=eU9iTRmV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5gplELS6X4wl.E=eU9iTRmV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 16 Dec 2021 20:22:32 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 16, 2021 at 07:34:12PM +0000, broonie@kernel.org wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the userns tree got a conflict in:
> >=20
> >   fs/nfsd/nfssvc.c =20
>=20
> This is also causing further build errors including but not limited to:
>=20
> /tmp/next/build/kernel/fork.c: In function 'copy_process':
> /tmp/next/build/kernel/fork.c:2106:4: error: label 'bad_fork_cleanup_thre=
adgroup_lock' used but not defined
>  2106 |    goto bad_fork_cleanup_threadgroup_lock;
>       |    ^~~~
>=20
> Partly due to vaccine side effects and partly in the interest of time
> I'm going to use the userns tree from yesterday.

Caused by commit

  40966e316f86 ("kthread: Ensure struct kthread is present for all kthreads=
")

The label is guarded by CONFIG_NUMA, but the new goto is not.

This is still failing, so I have used the userns tree from next-20211215
for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5gplELS6X4wl.E=eU9iTRmV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8QI0ACgkQAVBC80lX
0GzRzAgAi2xK5hclMCt9NJgpbrn0FYbp/4PqrB/UARw83oOiH1Lv8Z9jF5YYTl17
1Smy9fNjlqEIu5k7WKnMomKKh0UoO0aZLWSnHfB1dKHtQt+8cZ09o7eqXSnUaXin
L5xmdMWWwXsvCWzzNOAvw+bu3ckYaDbeTlLwgoSSBjnCAdnF+7mVtBgFxxpR1DBb
YoCbN68wYJbOtjymJ2nqOSxFW9p23pecDAzBzPPa1WYVDLZKeJSoxffwQEUcK3ij
04JFg1X9CBmCLPV67FiIfRyaKD7bKGGMlStAsQFoJ2thSFh3QmIWV8YHdH4Pa6QS
td9Ps3AGpGcX9DgvQTHTlyxeK0o9WA==
=XbHE
-----END PGP SIGNATURE-----

--Sig_/5gplELS6X4wl.E=eU9iTRmV--
