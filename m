Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01448ACFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiAKLvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiAKLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:51:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0962C06173F;
        Tue, 11 Jan 2022 03:51:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JY8Cr15zsz4xPt;
        Tue, 11 Jan 2022 22:51:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641901865;
        bh=xDjZlYMiLXu8q5CtfBWHCjmo534mIx6Wl9CrCDrU79o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vBASu3WHDAcontgZ/V/uOFth2iflVKlKzxjBsTNiMVk6s/SYU3Jwy3k0v4pv8YChc
         PREp8PU1CBmaSl5ztJnXkmvbCHjKh9eWCW8maKNMeCqQ1ubis6bLUQr5hQymmw/RTy
         zlc64MWatbtq/mubO5byDJgEKMQa8qe1IU/o3j3eleMEUcQcIIPw1XDlDF0HLbn8/R
         TI1YHxucL009acZ/c4/rmdxaErWQmv8MWoTdB/n0OyCqlbtBisd43gn0CBMRqB1VXu
         6URohSy7WUCi1o5X7Qn0P6Q6OS2/yNdLYVcVjZyUF02jHKsnCAdYj9CmgzgR2lwUFU
         RKYEcAxdDriqw==
Date:   Tue, 11 Jan 2022 22:51:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the slab
 tree
Message-ID: <20220111225101.114b655c@canb.auug.org.au>
In-Reply-To: <20211203182255.3800a09a@canb.auug.org.au>
References: <20211203182255.3800a09a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eSKq44_cfWj5rQa6vMefqOa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eSKq44_cfWj5rQa6vMefqOa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Dec 2021 18:22:55 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   mm/zsmalloc.c
>=20
> between commit:
>=20
>   5718b5cdd6e5 ("zsmalloc: Stop using slab fields in struct page")
>=20
> from the slab tree and commit:
>=20
>   efcc1718fe08 ("zsmalloc: move huge compressed obj from page to zspage")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc mm/zsmalloc.c
> index 0d3b65939016,7e03cc9363bb..000000000000
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@@ -824,10 -820,12 +820,12 @@@ static struct zspage *get_zspage(struc
>  =20
>   static struct page *get_next_page(struct page *page)
>   {
> - 	if (unlikely(PageHugeObject(page)))
> + 	struct zspage *zspage =3D get_zspage(page);
> +=20
> + 	if (unlikely(ZsHugePage(zspage)))
>   		return NULL;
>  =20
>  -	return page->freelist;
>  +	return (struct page *)page->index;
>   }
>  =20
>   /**
> @@@ -900,8 -893,7 +893,7 @@@ static void reset_page(struct page *pag
>   	ClearPagePrivate(page);
>   	set_page_private(page, 0);
>   	page_mapcount_reset(page);
> - 	ClearPageHugeObject(page);
>  -	page->freelist =3D NULL;
>  +	page->index =3D 0;
>   }
>  =20
>   static int trylock_zspage(struct zspage *zspage)
> @@@ -1042,9 -1039,9 +1039,9 @@@ static void create_page_chain(struct si
>   			SetPagePrivate(page);
>   			if (unlikely(class->objs_per_zspage =3D=3D 1 &&
>   					class->pages_per_zspage =3D=3D 1))
> - 				SetPageHugeObject(page);
> + 				SetZsHugePage(zspage);
>   		} else {
>  -			prev_page->freelist =3D page;
>  +			prev_page->index =3D (unsigned long)page;
>   		}
>   		prev_page =3D page;
>   	}

This is now a conflict between the akpm-current tree and Linus' tree -
that slab tree commit is now commit ffedd09fa9b0 ("zsmalloc: Stop using
slab fields in struct page") in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/eSKq44_cfWj5rQa6vMefqOa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHdbyUACgkQAVBC80lX
0GwCnAf+Irjk9xiRjLpLDqR7Wbk4fcw+U3kSfLfieCw0jNpUI7Auo01FbueX4bWo
2MEz5BfuSxJxeLNe2RLbaW1sAIV8XrsGUyheI+FUjR+NTVhJC8BO5/HmxZd6Nnz/
LAL1+cSp3X9iY1SbE4W++emgFKp7GTpV1/VUzglimQYzCDrwdA9S9i130oIxqb3W
tTIq/bd+ofxY+sytvnDRfydxzHM2xEokTFdCdUqcBv3kOltMCLvjZZPIkaiPZis3
+MfQPUmWnpHMmdOp+y7O47eWkxGgyF4W8gDgp3Q3MIoCj/B48D1FMvIkBXraJ+Ul
of95sB2BP4c+y1dHA9ZAWmYNDlQ8tg==
=pT3x
-----END PGP SIGNATURE-----

--Sig_/eSKq44_cfWj5rQa6vMefqOa--
