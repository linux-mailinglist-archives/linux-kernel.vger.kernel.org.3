Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC14E5C15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbiCWXyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiCWXyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:54:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A92250E;
        Wed, 23 Mar 2022 16:53:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP4tQ17lLz4xMW;
        Thu, 24 Mar 2022 10:53:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648079598;
        bh=QWbQZIL1WNc0TqpkYrfT/aLlmcPobuq3woCP1SvPq8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUzGl7Wr5phjc8GfnMAucbQPJFtIzMHR4INbAj5MMVTqwPvg+UpXV4swsqs59Izo8
         D90L8UZMJxh7J5qR6B9kNMEqPsG4WZ29yDLHWop9SGrjwzVlp0d7xB8WvduuuMKOPG
         nux+/THvaMVeN2PXvOiHl8xA3YiYcm2afB3XiHByR+xTBdFxEVS1XxmONIN9bEaTfK
         gEJ2t0Mp73o4UFIOzYqUEQ+e+G4Z9cBZlvHZcVHWL6sHxUBJBZyMkSzTNlU6GbLGw+
         Z4SK8CcZSBD64rpmVnvZdq7URCrw43RjnRjGYIrFw8O6GPjRmFkSGwQ84N0ENh35N1
         VVHhWlDoiryAw==
Date:   Thu, 24 Mar 2022 10:53:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the fscache
 tree
Message-ID: <20220324105317.67a81b0e@canb.auug.org.au>
In-Reply-To: <20220315202512.62f54300@canb.auug.org.au>
References: <20220315202512.62f54300@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JpZyvv+m=uhQ3hEwq3F9or5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JpZyvv+m=uhQ3hEwq3F9or5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 20:25:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the folio tree got a conflict in:
>=20
>   fs/9p/vfs_addr.c
>=20
> between commit:
>=20
>   0c31679cf2c0 ("netfs: Add a netfs inode context")
>=20
> from the fscache tree and commit:
>=20
>   09f7fc259e5d ("fscache: Convert fscache_set_page_dirty() to fscache_dir=
ty_folio()")
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
> diff --cc fs/9p/vfs_addr.c
> index ed06f3c34e98,76956c9d2af9..000000000000
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@@ -353,9 -370,9 +336,9 @@@ static bool v9fs_dirty_folio(struct add
>   #endif
>  =20
>   const struct address_space_operations v9fs_addr_operations =3D {
>  -	.readpage =3D v9fs_vfs_readpage,
>  -	.readahead =3D v9fs_vfs_readahead,
>  +	.readpage =3D netfs_readpage,
>  +	.readahead =3D netfs_readahead,
> - 	.set_page_dirty =3D v9fs_set_page_dirty,
> + 	.dirty_folio =3D v9fs_dirty_folio,
>   	.writepage =3D v9fs_vfs_writepage,
>   	.write_begin =3D v9fs_write_begin,
>   	.write_end =3D v9fs_write_end,

This is now a conflict between the fscache tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/JpZyvv+m=uhQ3hEwq3F9or5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7su0ACgkQAVBC80lX
0GwcSAf+M5/TYbCxC9pigKxLcM1ZrvphMcvIVJ+7gN5omFTm4RN1Kf7yeyrGmgur
cZPWEwRZeXjXy8N+6+T1MmAM3MPp+jXTS4wJppqkDpjTqjt0s/Zutl7htEl9PiUc
owL+V6ElNh6JzlU6pVPu08N14u92klsm/RGOyVaFSHN/x1JbbVaLG6Hn83yWU3fN
zqdQqqgB/RcWTXOoHW++uKGr7VnNrPUp2IXXPz6+HGJ+hiLGq/xuV3h+JqlJ8de3
l5bJWXGV37AvWcuws9Za7yEvg2A8tbrVqajwpWxhYsnud9RFM8yuAvTFaRcm5p/i
HDiTYayrFYZ06wrMWw8WeWro0gkZ0g==
=qrNA
-----END PGP SIGNATURE-----

--Sig_/JpZyvv+m=uhQ3hEwq3F9or5--
