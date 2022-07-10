Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527DA56D1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGJW2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 18:28:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FBA13EBC;
        Sun, 10 Jul 2022 15:28:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh1qq71Bzz4xhn;
        Mon, 11 Jul 2022 08:28:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657492088;
        bh=t2x2etyRIE9UyBEZxb6gCj5pB9F+yYo2kF1BwbNXc80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M11jrNWPw7pyiQvQhFU7d4enjLEA8FLuj6KPKofCJFSmYWXdVhJSNCIqm/jbDWZfS
         6QlmKRmkXdsNG9pYExPQEI10FePRb4GdkDLuBEmWbM2E4lkR0CPwZ7x9cL9ct8MKHQ
         yYoHry4Gd5Yqpx0hMeIL9NusFmpvNE8jEkHeUFlptmmHQmb9+hDb73mt/SnS5l0Y12
         8qmYZpRc3rvVgbdVPOXGpYsZKCiujIUZ/9kSFn+7FoGWEnfpBgYY5b/XxQ3dwVogRz
         NNa3G0yMDg4kkAsE65nDnfZ6JoxppeFQ74aKOlHe4qiBf3WpoUIa8sWZMRwaoc5OXa
         7HxSN9ksaSwWA==
Date:   Mon, 11 Jul 2022 08:28:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220711082807.745ee22d@canb.auug.org.au>
In-Reply-To: <YshKnxb4VwXycPO8@magnolia>
References: <20220708194437.7eafe774@canb.auug.org.au>
        <YshKnxb4VwXycPO8@magnolia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7D3RKxNX24FwTFPfEbTajvY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7D3RKxNX24FwTFPfEbTajvY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Darrick,

On Fri, 8 Jul 2022 08:17:51 -0700 "Darrick J. Wong" <djwong@kernel.org> wro=
te:
>
> This isn't quite correct -- references to xfs_perag objects must be
> released once they are acquired.  The following patch against today's
> tree fixes this problem:
>=20
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index f3c62c19475e..69d9c83ea4b2 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -127,10 +127,12 @@ xfs_dax_notify_ddev_failure(
> =20
>  		pag =3D xfs_perag_get(mp, agno);
>  		error =3D xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
> -		if (error)
> +		if (error) {
> +			xfs_perag_put(pag);
>  			break;
> +		}
> =20
> -		cur =3D xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
> +		cur =3D xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
> =20
>  		/*
>  		 * Set the rmap range from ri_low to ri_high, which represents
> @@ -151,6 +153,7 @@ xfs_dax_notify_ddev_failure(
>  				xfs_dax_failure_fn, &notify);
>  		xfs_btree_del_cursor(cur, error);
>  		xfs_trans_brelse(tp, agf_bp);
> +		xfs_perag_put(pag);
>  		if (error)
>  			break;
> =20

Thanks, I will add that to the resolution from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/7D3RKxNX24FwTFPfEbTajvY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLUncACgkQAVBC80lX
0GwlqAf/WeUw62MEgfmaLpCUh5mt5gqu50WTo4hdDHEOXVoMxDFqz1EY/LbzAcUu
twtMKf60dMR1IS3zbgekFKLVuAjGu4Nwrjvj+nha6EOjxyf/4o4a3IZyL69NN8HY
/hJsw3hQ7Fj1N7PfdF/gbj90+IU5Tpejdx4gDTqdMfoLuzjsatQVc4zM3IKneB3h
gqDYttyBbQA33VwvCxPmkh3kSfk5ZnGN+bWTcAUyqk0WMDma3XTENZgMpIGP5308
3OMHayMLhsJQL/TXfcLLKNm1qbQuJV2JvB4ayp1X1D7zQ9bO5yeorZAGVy/r3qyJ
DYQVDxlSJxWcnvkpmsCopzdIy0aoYQ==
=RLOP
-----END PGP SIGNATURE-----

--Sig_/7D3RKxNX24FwTFPfEbTajvY--
