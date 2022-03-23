Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3084E5C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346591AbiCWX5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiCWX5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:57:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7B6E369;
        Wed, 23 Mar 2022 16:56:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP4xW1fvJz4xdL;
        Thu, 24 Mar 2022 10:55:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648079759;
        bh=5op/+Ee75X6jMM9LpJ8tw2XhdqLCfxHaxlloqYK9zEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQbvhSakIX4btAB6skak3+FVtQKO6l/qB7zI1laEwbHNqeCJtZGhwA6wyt9IYRPqK
         zPCZRYIh+Z3y+4f45+0EyzFoPJudPlRJAS9Tt0hNM4b99iwNdYfOaBmL/Dk3QRkba3
         7OvoEfmfYLwYfv4MdlqUlqsilxnsmspVEe5zaSXjKjkPQpMhm6qs72x7Rc+JAjIyf4
         xTfhHQmE9Aej5MeFNDbxzZsdMkJ8fWQCjMaJDCnAy56QfIDL+aeuUjdi7R6DMeRzrS
         WuiF3oChoJIKkmxGk+PphRHz0scgJA6oRi9B5cgLW2WYWsGizDn/H2GJHpgk0Ujco6
         UC5TOP3LZ0cAA==
Date:   Thu, 24 Mar 2022 10:55:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: linux-next: manual merge of the folio tree with the nfs tree
Message-ID: <20220324105558.3df66122@canb.auug.org.au>
In-Reply-To: <20220315204540.4f9f6b66@canb.auug.org.au>
References: <20220315204540.4f9f6b66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YOl1qoAM5X0Nnf/3wEM7BOP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YOl1qoAM5X0Nnf/3wEM7BOP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 20:45:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the folio tree got a conflict in:
>=20
>   fs/nfs/file.c
>=20
> between commit:
>=20
>   8786fde8421c ("Convert NFS from readpages to readahead")
>=20
> from the nfs tree and commit:
>=20
>   821405cf3ebb ("fs: Convert trivial uses of __set_page_dirty_nobuffers t=
o filemap_dirty_folio")
>=20
> from the folio tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc fs/nfs/file.c
> index 81c80548a5c6,2df2a5392737..000000000000
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@@ -518,8 -514,8 +518,8 @@@ static void nfs_swap_deactivate(struct=20
>  =20
>   const struct address_space_operations nfs_file_aops =3D {
>   	.readpage =3D nfs_readpage,
>  -	.readpages =3D nfs_readpages,
>  +	.readahead =3D nfs_readahead,
> - 	.set_page_dirty =3D __set_page_dirty_nobuffers,
> + 	.dirty_folio =3D filemap_dirty_folio,
>   	.writepage =3D nfs_writepage,
>   	.writepages =3D nfs_writepages,
>   	.write_begin =3D nfs_write_begin,

This is now a conflict between the nfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YOl1qoAM5X0Nnf/3wEM7BOP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7s44ACgkQAVBC80lX
0GyVzAf/dmpdo89C6sZaB74WjkBcwSFh2BLuWSPSfjKaCGCL5lfYJ6qx9cKXtEDc
UIhIp7kd0yzl34h9kJ1U7SZ4QLI7vJSLcC/cYMIQgXfDb0Swk2iaP/HM9PBUN6kd
5t4yTqVeSLcRyahxvCsVxlMsX4zVMfoKy8wtBbJrmW07L1IHFvB83rb4p2ZAbESY
hxmvvz+0pTfO/SzPoV+2vPqwnbDhos8lmjLacL3MQ5/mMV1fezs8Jkcorbr6z5iJ
4MDvX0tL3O6Q3KyAHXSxx0Uwco16CFUn62B5bVQKDqsLgK+EOiz3E5Oq32qih/GJ
MgI01AMC+y/3G/ny/rrvodyjcoLT2Q==
=hpPn
-----END PGP SIGNATURE-----

--Sig_/YOl1qoAM5X0Nnf/3wEM7BOP--
