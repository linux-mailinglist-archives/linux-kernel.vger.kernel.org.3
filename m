Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98374B1D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiBKD7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:59:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiBKD66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:58:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C85F84
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:58:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw0Gk6vqsz4xNn;
        Fri, 11 Feb 2022 14:58:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644551935;
        bh=tANgVZE3P47aF53XSfN41u2Y4MtV+aBH3rrzoHjf0Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TJc10X1humPxq54tTHXpi37q4W3JhMDlUmefID+CHV/iE11sjIcO8BYDjCeY11/iu
         N/8vUtnehArEWreU1PcHiqKssHxNjtDwoAQG/BFAA8zu2vmyXOw4WrK1Egfntjk/02
         YR91FZMYgKjkif7/f9QoRButM9z/SHQlIv80u5Xq8C4FE2DKp/VImq4WoCq+UiZSZq
         JTU1jdLMWRy8hXfzKlw73+TRMBJg14Jgl4exgZsA0GibsuyRrZcQ1xj98VNZZONYTp
         g9R01QhjUtMDflCL35GymVwSzSQOvZV/hgxALOh8Tvt8THrPJdPuXnr8oi8iHuPzhq
         OKjIDpc26Kt0w==
Date:   Fri, 11 Feb 2022 14:58:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-mm 1/2 v2] mm/internal: Implement no-op
 mlock_page_drain() for !CONFIG_MMU
Message-ID: <20220211145853.329ff344@canb.auug.org.au>
In-Reply-To: <8eae6026-098-befb-92d3-b9ad2ad57776@google.com>
References: <20220209094158.21941-1-sj@kernel.org>
        <20220209094158.21941-2-sj@kernel.org>
        <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com>
        <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
        <8eae6026-098-befb-92d3-b9ad2ad57776@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uzV4b3Z7XYHDfaFovndMX.Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uzV4b3Z7XYHDfaFovndMX.Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hugh,

On Wed, 9 Feb 2022 20:44:02 -0800 (PST) Hugh Dickins <hughd@google.com> wro=
te:
>
> From: SeongJae Park <sj@kernel.org>
>=20
> Commit 4b3b8bd6c8287 ("mm/munlock: mlock_page() munlock_page() batch by
> pagevec") in -mm tree[1] implements 'mlock_page_drain()' under
> CONFIG_MMU only, but the function is used by 'lru_add_drain_cpu()',
> which defined outside of CONFIG_MMU.  As a result, below build error
> occurs.
>=20
>     /linux/mm/swap.c: In function 'lru_add_drain_cpu':
>     /linux/mm/swap.c:637:2: error: implicit declaration of function 'mloc=
k_page_drain' [-Werror=3Dimplicit-function-declaration]
>       637 |  mlock_page_drain(cpu);
>           |  ^~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>     /linux/scripts/Makefile.build:289: recipe for target 'mm/swap.o' fail=
ed
>=20
> This commit fixes it by implementing no-op 'mlock_page_drain()' for
> !CONFIG_MMU case, similar to 'mlock_new_page()'.
>=20
> [1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-munlock-mlock_page-m=
unlock_page-batch-by-pagevec.patch
>=20
> [hughd: add need_mlock_page_drain() stub too]
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Andrew, Stephen, please add as fix to
> mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
> Thanks!
>=20
>  mm/internal.h |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -508,6 +508,8 @@ static inline void mlock_vma_page(struct page *page,
>  static inline void munlock_vma_page(struct page *page,
>  			struct vm_area_struct *vma, bool compound) { }
>  static inline void mlock_new_page(struct page *page) { }
> +static inline bool need_mlock_page_drain(int cpu) { return false; }
> +static inline void mlock_page_drain(int cpu) { }
>  static inline void vunmap_range_noflush(unsigned long start, unsigned lo=
ng end)
>  {
>  }

Added to linux-next from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/uzV4b3Z7XYHDfaFovndMX.Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIF3v0ACgkQAVBC80lX
0Gw6SAf/YdMw2mcK7OcCmFZERxK4VtcnUrURgP2yV67H8pWoh3aYufIiNrTX8QWK
IL6uVdq7lXdjUD5JWcvlu7LRBIHicNfcbqSaHtBQJJlCYDbBc+Vnuk0EkFz8ERJC
3LwUxJnzrwYDz2C0uDma8tm5OGYnVzyAQYRmLXHtVRVtn3inOltpGo261fCuCzlU
w3ojkVO09YGG1uF1tZoDQlx/vXSqyNLI7uvn8jAA1pgPDqM3KmypQn/ZINpwihT5
c8SUMvx9tkPUTkXsKBLsHFyvtXC0egOynMcRUs3BGjnZHNnCRWUxv0ZIRB3SyVUu
0xiKlfryatRYI9O1++ksAjlmlFa7IA==
=n70x
-----END PGP SIGNATURE-----

--Sig_/uzV4b3Z7XYHDfaFovndMX.Y--
