Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE309496B25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiAVJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiAVJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:05:01 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DDC06173B;
        Sat, 22 Jan 2022 01:05:00 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Jgr153n5tz9svd;
        Sat, 22 Jan 2022 10:04:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Sat, 22 Jan 2022 20:04:41 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fcntl.2: document F_GET_SEALS on tmpfs peculiarity
Message-ID: <20220122090441.ktxh43lpgsd2dxj4@senku>
References: <20220122005251.1441343-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envdxlah4rr2kem4"
Content-Disposition: inline
In-Reply-To: <20220122005251.1441343-1-kolyshkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envdxlah4rr2kem4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adding the maintainers of mm/{shmem,memfd}.c and fs/hugetlbfs/ just in
case this was not intended behaviour.

On 2022-01-21, Kir Kolyshkin <kolyshkin@gmail.com> wrote:
> Currently, from the description of file sealing it can be deduced that
> unless the fd is a memfd, all sealing operations fail with EINVAL.
>=20
> Apparently, it's not true for tmpfs or hugetlbfs -- F_GET_SEALS returns
> 1 (F_SEAL_SEAL) for an fd opened on these filesystems (probably because
> those are used to back memfd files).
>=20
> Fix the description to mention that peculiarity. Not knowing this can
> result in incorrect code logic (see [1], where the code mistook a
> descriptor of a file opened on on tmpfs for a memfd).
>=20
> While at it, clarify that fcntl does not actually return EINVAL, but
> sets errno to it (as it is usually said elsewhere).
>=20
> [1] https://github.com/opencontainers/runc/pull/3342
>=20
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  man2/fcntl.2 | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/man2/fcntl.2 b/man2/fcntl.2
> index 7b5604e3a..f951b05ff 100644
> --- a/man2/fcntl.2
> +++ b/man2/fcntl.2
> @@ -1402,10 +1402,23 @@ file seals can be applied only to a file descript=
or returned by
>  (if the
>  .B MFD_ALLOW_SEALING
>  was employed).
> -On other filesystems, all
> +On all other filesystems, except
> +.BR tmpfs (5)
> +and
> +.BR hugetlbfs ,
> +all
>  .BR fcntl ()
> -operations that operate on seals will return
> +operations that operate on seals will fail with
> +.I errno
> +set to
>  .BR EINVAL .
> +For a descriptor from a file on
> +.BR tmpfs (5)
> +or
> +.BR hugetlbfs ,
> +.B F_GET_SEALS
> +returns
> +.BR F_SEAL_SEAL .
>  .PP
>  Seals are a property of an inode.
>  Thus, all open file descriptors referring to the same inode share
> --=20
> 2.33.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--envdxlah4rr2kem4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYevIpgAKCRCdlLljIbnQ
EmUiAQDTNHQDDzlD7fS/Xwxwk5Zxh73/hn1PZUcq5/8zkcummgD/SaHHLa8KogLj
nc5oNbmQK9xoMMbju8mARw7LIpqLmg8=
=sgIs
-----END PGP SIGNATURE-----

--envdxlah4rr2kem4--
