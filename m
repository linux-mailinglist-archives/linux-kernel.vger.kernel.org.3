Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BB517D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiECGtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiECGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:49:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570A3701F;
        Mon,  2 May 2022 23:46:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ksr890WLlz4xbw;
        Tue,  3 May 2022 16:46:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651560361;
        bh=tMEfCsXhkaG6WI8QRSczSysWLlHIYhMrSAPheKhAP/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tTsHBG737DYpp7nELi62nuLH4qpKLgNOXnuNZ1y+b2YgzgXEE8Ih4qSzjmL/lGD0Y
         9XAdeGrqlFFPpp7BWHVkUPQE6Bjqh/i40XKWjNYkBxs9A/TM6ay+jZY21TftGXqWon
         uCWNrWEq/XEllEur8W5XDas7i6L0V++Nf0nKE/t54t2thh39go0ZBxMstm6C8JEr7R
         wAmqOi/jAUsMZNNFLwR8UlvWGcbmwUcpXnt1yiadYaDyxDxVkBOBKDd6/AOcfdZcty
         HC2/eJLivzRdUGR8NzefnLXK0uH6bgPIsV1Owp15/7R+PGJMmAZKC/oe/DiIpeLDXj
         OBqcLWwS0IUcQ==
Date:   Tue, 3 May 2022 16:45:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220503164559.32bbb782@canb.auug.org.au>
In-Reply-To: <Ym++SI1ftbRg+9zK@casper.infradead.org>
References: <20220502204903.64e94442@canb.auug.org.au>
        <Ym++SI1ftbRg+9zK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qsVvkrZiJmszjv0Z1KAdLnS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qsVvkrZiJmszjv0Z1KAdLnS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 2 May 2022 12:19:36 +0100 Matthew Wilcox <willy@infradead.org> wrot=
e:
>
> On Mon, May 02, 2022 at 08:49:03PM +1000, Stephen Rothwell wrote:
> >=20
> > After merging the mm tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this: =20
> [... i wish our BUILD_BUGs produced nicer output from the compiler ...]
> > Reverting the following commits makes the problem go away:
> >=20
> >   2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_=
folio()")
> >   94cdf3e8c0bf ("mm/shmem: convert shmem_getpage_gfp to use a folio")
> >   3674fd6cadf5 ("mm/shmem: convert shmem_alloc_and_acct_page to use a f=
olio")
> >   b0bb08b2d5f3 ("mm/shmem: turn shmem_alloc_page() into shmem_alloc_fol=
io()")
> >   8d657a77c6fe ("mm/shmem: turn shmem_should_replace_page into shmem_sh=
ould_replace_folio")
> >   9a44f3462edc ("mm/shmem: convert shmem_add_to_page_cache to take a fo=
lio")
> >   561fd8bee1dc ("mm/swap: add folio_throttle_swaprate")
> >   cb4e56ee240d ("mm/shmem: use a folio in shmem_unused_huge_shrink")
> >   22bf1b68e572 ("vmscan: remove remaining uses of page in shrink_page_l=
ist")
> >   7d15d41b7c4a ("vmscan: convert the activate_locked portion of shrink_=
page_list to folios")
> >   8a6aff9c51c7 ("vmscan: move initialisation of mapping down")
> >   b79338b3d217 ("vmscan: convert lazy freeing to folios")
> >   719426e40146 ("vmscan: convert page buffer handling to use folios")
> >   339ba7502e13 ("vmscan: convert dirty page handling to folios") =20
>=20
> Oops.  allnoconfig on x86 reproduces the problem.  This fixes it;
> happy to go back and produce a new set of patches for Andrew to
> preserve bisectability.
>=20
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2999190adc22..e9e0d591061d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -347,7 +347,6 @@ static inline void prep_transhuge_page(struct page *p=
age) {}
>  static inline bool
>  can_split_folio(struct folio *folio, int *pextra_pins)
>  {
> -	BUILD_BUG();
>  	return false;
>  }
>  static inline int
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 673a0e783496..d62936ffe74d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -738,7 +738,7 @@ static int shmem_add_to_page_cache(struct folio *foli=
o,
>  		xas_store(&xas, folio);
>  		if (xas_error(&xas))
>  			goto unlock;
> -		if (folio_test_large(folio)) {
> +		if (folio_test_pmd_mappable(folio)) {
>  			count_vm_event(THP_FILE_ALLOC);
>  			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
>  		}
> @@ -1887,10 +1887,7 @@ static int shmem_getpage_gfp(struct inode *inode, =
pgoff_t index,
>  		goto unlock;
>  	}
> =20
> -	if (folio_test_large(folio))
> -		hindex =3D round_down(index, HPAGE_PMD_NR);
> -	else
> -		hindex =3D index;
> +	hindex =3D round_down(index, folio_nr_pages(folio));
> =20
>  	if (sgp =3D=3D SGP_WRITE)
>  		__folio_set_referenced(folio);
> @@ -1909,7 +1906,7 @@ static int shmem_getpage_gfp(struct inode *inode, p=
goff_t index,
>  	spin_unlock_irq(&info->lock);
>  	alloced =3D true;
> =20
> -	if (folio_test_large(folio) &&
> +	if (folio_test_pmd_mappable(folio) &&
>  	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>  			hindex + HPAGE_PMD_NR - 1) {
>  		/*
>=20

I applied the above patch to the mm tree merge today (instead of all
the reverts) and it fixed the build problems for me.

--=20
Cheers,
Stephen Rothwell

--Sig_/qsVvkrZiJmszjv0Z1KAdLnS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJwz6cACgkQAVBC80lX
0Gz4qQgApTu9F933hgt2WW0s+TPeOmOXr5n1ey6qPvKVMRJTSNlCNqDYFaIyfU5F
BkQC48dA2rZ75c8wFco5V2AnGOzIB9129+dp1ZUMlQ/+gFZGxayo2jC0W+KR33OK
+0q6oxZkFLDSny7Dy+8963ncHYyrJ+dzZGahQ3qZB4Gs4GxrVDwkStpEoOIh0leo
BPxP9v0AEmcladgfDVly+B/8iYvioiRlenhfhfiqVsVkYYWQDlg5qfCLF+QBagFJ
8Qfse/rRYFOExcTTZvYjIyhTfZhIz/9uXLvVUnRmJ8ldQIRiRpFLy/IBclZS5l74
KLbDme10x5aSQTO5vzi1Z48dxsp//w==
=jliF
-----END PGP SIGNATURE-----

--Sig_/qsVvkrZiJmszjv0Z1KAdLnS--
