Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE62527BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiEPCMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiEPCMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:12:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7222518;
        Sun, 15 May 2022 19:12:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1jSf01XSz4xXJ;
        Mon, 16 May 2022 12:12:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652667155;
        bh=IEla7Gt7PCntdFnq1ZgeZ7O6mAGwQWBXpjY0hOvftAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mj/STyxhI8LA9SuvEgRau5+Jj/i7FAChIXCBJF6egDgq4DvdqXWySPxf/LM0Fw7s1
         0Ns0o+0IuA/liUOZTjEhcaM5tzugw25BsJWYldfd9cQaad0rB/8f+oQJ0aPk9bHMNy
         lH80e3Bf25kjXYXlWMbTVBAq6Ro/1MIijkrXp9cTFOvT09Y2hlAeu7nB/p2KIbxHe7
         IAvZJUvdbufNINaPGWqIU077kWSqtAFoEpLRMNkpitJSqaYNsNlejuj5/6wzxwANoJ
         NM/IBmX4j+BMf1SMllSN+hBwHnASJI5010n1uVCGui5k0eh6FMx1pGxxCqJnbp9ZUO
         HEOxz8OPezVqQ==
Date:   Mon, 16 May 2022 12:12:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the gfs2 tree with the btrfs tree
Message-ID: <20220516121232.6cf7660b@canb.auug.org.au>
In-Reply-To: <20220510102458.0ab0172f@canb.auug.org.au>
References: <20220510102458.0ab0172f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h.ZQG5ILS8Fc//hgr+A6fQm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h.ZQG5ILS8Fc//hgr+A6fQm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 May 2022 10:24:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the gfs2 tree got a conflict in:
>=20
>   fs/gfs2/file.c
>=20
> between commit:
>=20
>   39c93b0bf7a6 ("iomap: add per-iomap_iter private data")
>=20
> from the btrfs tree and commit:
>=20
>   db0c1968e935 ("gfs2: Variable rename")
>=20
> from the gfs2 tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc fs/gfs2/file.c
> index 76307a90bf81,d18a7c2201c0..000000000000
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@@ -839,11 -839,12 +839,12 @@@ retry_under_glock
>   	pagefault_disable();
>   	to->nofault =3D true;
>   	ret =3D iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> - 			   IOMAP_DIO_PARTIAL, NULL, written);
>  -			   IOMAP_DIO_PARTIAL, read);
> ++			   IOMAP_DIO_PARTIAL, NULL, read);
>   	to->nofault =3D false;
>   	pagefault_enable();
> + 	/* No increment (+=3D) because iomap_dio_rw returns a cumulative value=
. */
>   	if (ret > 0)
> - 		written =3D ret;
> + 		read =3D ret;
>  =20
>   	if (should_fault_in_pages(ret, to, &prev_count, &window_size)) {
>   		size_t leftover;
> @@@ -906,7 -908,7 +908,7 @@@ retry_under_glock
>  =20
>   	from->nofault =3D true;
>   	ret =3D iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
> - 			   IOMAP_DIO_PARTIAL, NULL, read);
>  -			   IOMAP_DIO_PARTIAL, written);
> ++			   IOMAP_DIO_PARTIAL, NULL, written);
>   	from->nofault =3D false;
>  =20
>   	if (ret =3D=3D -ENOTBLK)

This is now a conflict between the btrfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/h.ZQG5ILS8Fc//hgr+A6fQm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKBsxAACgkQAVBC80lX
0GwqAgf/eoaGzhH2Jk43nCQIyBR9KIrveoOKlNQ1UA/yrJmsF+k9H+vQVsth/G/I
lLHIXUeq47tT8lZwCdIJ9QylRqf+28Cnm8cQzX8CjcV3SdY8+KjlSWmlHCrLfHw4
ScG4ZVae1px3kcvbm5K9pnmKx+SNyG0rlgKuXsg3kF65XAWCPoe5QL/ivixUl9pL
gKg4RrctB1HCugoHrtiqsr0H2/mnUPoRfgCMi3o7JdWzuUb8qtJhIIRKpAP/8fp2
nGiVXSg+HZmP5Gs50LiNDhzlvm7udfgurdfYGMg5TZt1MZ+N60I0r0oLYFutzISS
JJFPDOWFw30RVQTFiHhF+xJbK9klgw==
=mSgV
-----END PGP SIGNATURE-----

--Sig_/h.ZQG5ILS8Fc//hgr+A6fQm--
