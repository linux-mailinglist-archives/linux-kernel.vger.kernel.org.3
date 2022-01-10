Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3F48A37E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiAJXQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:16:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:34837 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiAJXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:16:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXqSd1xnjz4xbT;
        Tue, 11 Jan 2022 10:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641856561;
        bh=sfR9eksd3kCKqgWf7HXPvaLjK2sSn75wSE/Mzzk4wbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eYFv3RrQ9QzmYjBgCqTwFsEI8ysmQ89PaY4mCqYWZvsu0Bi6oK6m5107ULoRTJ2Ou
         QY00+1DbzQJDpHvbBsk+zMrRjnbo+/mSse9RMZ8XtQmFovl6Z2TsXNBNWXkzEbx6ct
         SfxWZn+O2JY9Xae8hk3ht5fEVr0xmOKcUQpOfNNpN7cn/eJC2MyKP0Hil+3kkiiOPC
         0PLaigOvfsLrblMycHDT4NqHfWFjAjf3W1OIfHT7oDca81JWlRs0UCEaiG0Q/+io8S
         5ar5f9gdzzrEJrc4ZufJJ8yOXM+4QvYUZmEfFawOGnTBXBUeLC3zsNeMUlwOoVZqQM
         iDOJoe8zvxnwQ==
Date:   Tue, 11 Jan 2022 10:15:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Harinder Singh <sharinder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 jc_docs tree
Message-ID: <20220111101559.3f787248@canb.auug.org.au>
In-Reply-To: <20211224163707.70e04c0f@canb.auug.org.au>
References: <20211224163707.70e04c0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X4P7J5LXokEFGYhT4fQCZo8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X4P7J5LXokEFGYhT4fQCZo8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 24 Dec 2021 16:37:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kunit-next tree got a conflict in:
>=20
>   Documentation/dev-tools/kunit/start.rst
>=20
> between commit:
>=20
>   c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")
>=20
> from the jc_docs tree and commit:
>=20
>   4c2911f1e140 ("kunit: tool: reconfigure when the used kunitconfig chang=
es")
>=20
> from the kunit-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc Documentation/dev-tools/kunit/start.rst
> index a858ab009944,0a5e65540974..000000000000
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@@ -59,19 -44,23 +59,20 @@@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST
>  =20
>   	CONFIG_LIST_KUNIT_TEST=3Dy
>  =20
>  -:doc:`kunit_tool <kunit-tool>` will ensure that all config options set =
in
>  -``.kunitconfig`` are set in the kernel ``.config`` before running the t=
ests.
>  -It'll warn you if you haven't included the dependencies of the options =
you're
>  -using.
>  +Before running the tests, kunit_tool ensures that all config options
>  +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
>  +you if you have not included dependencies for the options used.
>  =20
> - .. note ::
> -    The configuration is only updated if the ``.kunitconfig`` is not a
> -    subset of ``.config``. You can use tools (for example:
> -    make menuconfig) to adjust other config options.
> + .. note::
> +    If you change the ``.kunitconfig``, kunit.py will trigger a rebuild =
of the
> +    ``.config`` file. But you can edit the ``.config`` file directly or =
with
> +    tools like ``make menuconfig O=3D.kunit``. As long as its a superset=
 of
> +    ``.kunitconfig``, kunit.py won't overwrite your changes.
>  =20
>  -
>  -Running the tests (KUnit Wrapper)
>  ----------------------------------
>  -
>  -To make sure that everything is set up correctly, simply invoke the Pyt=
hon
>  -wrapper from your kernel repo:
>  +Running Tests (KUnit Wrapper)
>  +-----------------------------
>  +1. To make sure that everything is set up correctly, invoke the Python
>  +   wrapper from your kernel repository:
>  =20
>   .. code-block:: bash
>  =20

This is now a conflict between the jc_docs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/X4P7J5LXokEFGYhT4fQCZo8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHcvi8ACgkQAVBC80lX
0Gx34Af/ZlUfL0BUpamQQwuOwJjAt3ucEyrez2VLeSglKvTvMF8fGgaUduIrmfI2
0NVJ5s6Lbah73JS7n2whP8EsP4PUTQE4gqJQxEBG0pJP2A4kaSi4rW5Xm3TnKrtB
yi8sAsvcwurYn7ofF26pwFa8W3K3Q7raMJpE6dzg8MTJY/L/CTZ4F1j3+TymjdVn
hWhEUf9DUzZ8mGZGKKauxtJFneKC+tHNaB+oov84DvUZt6F2LG2YQ0oNaKH+1de/
McF/wgya8YePhPhEV4m66I8miAbELJFEAWmjpXic2yA6hYpeSggx8L5mkw4Amfcg
5aut5GkFrw+KzEnYWutkyHRz5kNXMQ==
=MU9L
-----END PGP SIGNATURE-----

--Sig_/X4P7J5LXokEFGYhT4fQCZo8--
