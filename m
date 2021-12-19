Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4E47A30B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 00:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhLSXqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 18:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhLSXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 18:46:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95688C061574;
        Sun, 19 Dec 2021 15:46:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHK9b2P2Hz4xbt;
        Mon, 20 Dec 2021 10:46:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639957571;
        bh=jZ+M4GM4XoEZ7eWzEwsAjRNXfEWBySADp84bOP2qZI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VP8B0+cpazRQB3BjcXThfQ5U3y82fBM4MbVq4REtTkHiKDPDtuyrH6FTa3ykLznF7
         am0FYhlK4FaRh4wQfIsBRG1fJfJtK63I5hyaZPqHM0N/3yy0pP8Zt7yOHsXFVCJpFI
         LG1paJ8IWG3CE0OLbjoMx89+5atE2XRR8KQUYUvLuLvgF6hvro3W7az1f6gt6ID+TT
         ylC123isCwB0pQlxgT/U4omy4rZqqYGhho3L+2YnUb2KhhhrO/9XCQJsI2luH5YPir
         Ujvbif8PGEE8FV+WxhBTu9ROASxAF6xTLIrxnAtfrzq1h5qXyg1nmipWl8vKI2ybXq
         ryYg/KFyCcCug==
Date:   Mon, 20 Dec 2021 10:46:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     broonie@kernel.org, Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the cifs tree with the fscache tree
Message-ID: <20211220104610.5f074aec@canb.auug.org.au>
In-Reply-To: <20211216124317.4143405-1-broonie@kernel.org>
References: <20211216124317.4143405-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9RwpTx/TZjurmp4EB2a1cba";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9RwpTx/TZjurmp4EB2a1cba
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Dec 2021 12:43:17 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the cifs tree got a conflict in:
>=20
>   fs/cifs/inode.c
>=20
> between commit:
>=20
>   830c476f5eb82 ("cifs: Support fscache indexing rewrite (untested)")
>=20
> from the fscache tree and commit:
>=20
>   68f87ec9c1ce3 ("cifs: ignore resource_id while getting fscache super co=
okie")

This is now commit

  b774302e8856 ("cifs: ignore resource_id while getting fscache super cooki=
e")

in Linus' tree.

> from the cifs tree.
>=20
> diff --cc fs/cifs/inode.c
> index dc2fe76450b96,279622e4eb1c2..0000000000000
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@@ -1372,20 -1370,6 +1367,7 @@@ iget_no_retry
>   		iget_failed(inode);
>   		inode =3D ERR_PTR(rc);
>   	}
>  +
> - 	if (!rc) {
> - 		/*
> - 		 * The cookie is initialized from volume info returned above.
> - 		 * Inside cifs_fscache_get_super_cookie it checks
> - 		 * that we do not get super cookie twice.
> - 		 */
> - 		rc =3D cifs_fscache_get_super_cookie(tcon);
> - 		if (rc < 0) {
> - 			iget_failed(inode);
> - 			inode =3D ERR_PTR(rc);
> - 		}
> - 	}
> -=20
>   out:
>   	kfree(path);
>   	free_xid(xid);

so this is now a conflict between the fscache tree and Linus's tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9RwpTx/TZjurmp4EB2a1cba
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/xEIACgkQAVBC80lX
0Gz32Af+JYzcgRqXkzVcfP/tAeLSjgkA0q3fyqVZhXJOkyBzc2LTMi7AhEiDKCAJ
S8Mm/Wa/N8ISV5c81wP5RJr5ClD1kcyHjo2bcD1q0dmEmTyume8YoXO/neVZjHdA
ceRiAf3CEZnGgE05xWtaYcudBBveJ+8OuayLn4Be6ePRlbfNwPy8R2J4+QScxqMD
5vO7SX0jTDErUS6ObY+yxhfC6ZEQoYg3Kh+b+ilyFyMqNqT9rz8Vvdg8iVGSLxiZ
4RkqhSyz2LWnXwLu72OYMMhZ2c2tgBJQw3cZbkFSeAOPF2lW4qmDHNP6oanxdCjg
AGW8iLnDlf4EHyZlX8Cjz1arF96ghA==
=d0KT
-----END PGP SIGNATURE-----

--Sig_/9RwpTx/TZjurmp4EB2a1cba--
