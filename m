Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B14690A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhLFHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:12:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:33929 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhLFHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:12:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6vfY365mz4xgq;
        Mon,  6 Dec 2021 18:08:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638774517;
        bh=74ug/3gxfB019QMgyEoJwVlEbtheSzN665REw1NK2i0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LDibWAtIzGieSUtIOTeWfCIwiEnFPTpC9WKUsn64NlEixffAPNfapIu8210Rqiwgs
         XMIaT2R2PidnwVpMIMUugQ8h7TQWfYD85uDRpcp5isIbjqXqeDN5mXEWEUirY5aH7O
         Vekrk2z5pShPsmcjMhxrNFIdNqYBg5HqaxcNrHCoov5laa1qa58zB9WSY324Txj68V
         6FdL1qaTvamQ7i0jAyk/Fas9Te3WoneA28Xk0ljGSLJxzg3GXD/yj0ks8VSYkN6jUL
         Zx+tNQcv+TR1RgxUrPcTcLLWyL2LWiAw8qIJ/nMVBX9zwxbWOE7El4lhoAxUetInId
         g7j/9kcMb6oBg==
Date:   Mon, 6 Dec 2021 18:08:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the fscache tree
Message-ID: <20211206180836.45cf22cf@canb.auug.org.au>
In-Reply-To: <20211130152753.6899aa0c@canb.auug.org.au>
References: <20211130152753.6899aa0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/olqxnyn6Qcc3t0fNb2ckReG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/olqxnyn6Qcc3t0fNb2ckReG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Nov 2021 15:27:53 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the fscache tree, today's linux-next build (arm64 defconfig)
> produced this warning:
>=20
> fs/9p/vfs_addr.c: In function 'v9fs_release_page':
> fs/9p/vfs_addr.c:140:16: warning: unused variable 'inode' [-Wunused-varia=
ble]
>   140 |  struct inode *inode =3D folio_inode(folio);
>       |                ^~~~~
>=20
> Introduced by commit
>=20
>   12b841dc2cfd ("9p: Copy local writes to the cache when writing to the s=
erver")

Still getting this ... It will cause build failures for any config with
CONFIG_9P_FSCACHE not set and CONFIG_WERROR set

--=20
Cheers,
Stephen Rothwell

--Sig_/olqxnyn6Qcc3t0fNb2ckReG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGttvQACgkQAVBC80lX
0GzSFAf/ecxcFZnmXLcioNf0YPU/1gWJq0X4Ry2YBAqEUsL4j4NmV1bQWwY+nc8c
BJoAOIvoIW1laoZbSokdQix5wa3UuiDkO4RYJIXnjSWjt1P5wfYqzNvOqdTlYfJF
T3EbZajZijTv4jSlyLEa7GpgW9+w2ei/1eRwaYSOGTUip55XOvCXhgdp33kgTorK
qYQUdIbxwhgIvGe0mCozsBVPPa6kztNMl/v3f6V2bQtEAf3VURx3LXuxpiEIwL24
oBxYTwfQ5FhdlfvgSFId+NOUVySfTRizvZt6b9jjYsJGHtGAHLEhzdwacfx4/oG5
bTtZAnTlfwP+JusIgWLwE0BFxm99vg==
=FJT7
-----END PGP SIGNATURE-----

--Sig_/olqxnyn6Qcc3t0fNb2ckReG--
