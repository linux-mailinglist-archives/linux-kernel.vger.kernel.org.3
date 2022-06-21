Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB1552B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbiFUHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiFUHSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:18:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA01DA55;
        Tue, 21 Jun 2022 00:18:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRyXT6vXDz4xDB;
        Tue, 21 Jun 2022 17:18:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655795883;
        bh=EGoYRYQjOBwtBkVxbuTSwAYJiJuLfrshpCY8FKmKS5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGabhqUSjK/D+ZVivf08qY6OomSshSz0UwEwt3rfHSKXyWD+R3YOtSHShF0B3u3uL
         h+8KHShyhHAo2pcx/BDtnQ55CpiHNuovljKZjTjuZAEbihOwcmhNIh/c0Lvv9NeJPZ
         69VRW2VYARVa2lIGYlfjr0/h97Bdvw99/4J9A7e8BtZfiU4pX2IyGLjt0pJRl8N0DS
         oJ0m6gW5JW4Vys1wGOPdmnx+omXkg58xsVSBYzW6hO9P5I/YCkycxNOtT05VUA3jg9
         mNvxD06oHhNBoBd97z6wNPsNYKZM7Zn7rYe2nUYxwHcIiNnqcBnNbrrjtIbO07rk9e
         DqCDwau0FAwGQ==
Date:   Tue, 21 Jun 2022 17:18:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: linux-next: build failures after merge of the mm tree
Message-ID: <20220621171800.0397976a@canb.auug.org.au>
In-Reply-To: <20220620164246.0d3f7784@canb.auug.org.au>
References: <20220620164246.0d3f7784@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.gKofYcDqE7_tSi1YTSVd61";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.gKofYcDqE7_tSi1YTSVd61
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jun 2022 16:42:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
>=20
> In file included from arch/x86/include/asm/page.h:86,
>                  from arch/x86/include/asm/thread_info.h:12,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:7,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:6,
>                  from include/linux/slab.h:15,
>                  from include/linux/crypto.h:20,
>                  from arch/x86/kernel/asm-offsets.c:9:
> include/linux/mm.h: In function 'destroy_large_folio':
> include/asm-generic/memory_model.h:35:21: error: implicit declaration of =
function 'page_to_section'; did you mean 'present_section'? [-Werror=3Dimpl=
icit-function-declaration]
>    35 |         int __sec =3D page_to_section(__pg);                     =
 \
>       |                     ^~~~~~~~~~~~~~~
> include/asm-generic/memory_model.h:40:32: note: in definition of macro '_=
_pfn_to_page'
>    40 | ({      unsigned long __pfn =3D (pfn);                    \
>       |                                ^~~
> include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__=
page_to_pfn'
>    52 | #define page_to_pfn __page_to_pfn
>       |                     ^~~~~~~~~~~~~
> include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
>   214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>       |                                      ^~~~~~~~~~~
> include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
>   312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
>       |                                 ^~~~~~~~
> include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
>   928 |         enum compound_dtor_id dtor =3D folio_page(folio, 1)->comp=
ound_dtor;
>       |                                      ^~~~~~~~~~
> In file included from include/linux/memcontrol.h:20,
>                  from include/linux/swap.h:9,
>                  from include/linux/suspend.h:5,
>                  from arch/x86/kernel/asm-offsets.c:13:
> include/linux/mm.h: At top level:
> include/linux/mm.h:1556:29: error: conflicting types for 'page_to_section=
'; have 'long unsigned int(const struct page *)'
>  1556 | static inline unsigned long page_to_section(const struct page *pa=
ge)
>       |                             ^~~~~~~~~~~~~~~
> In file included from arch/x86/include/asm/page.h:86,
>                  from arch/x86/include/asm/thread_info.h:12,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:7,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:6,
>                  from include/linux/slab.h:15,
>                  from include/linux/crypto.h:20,
>                  from arch/x86/kernel/asm-offsets.c:9:
> include/asm-generic/memory_model.h:35:21: note: previous implicit declara=
tion of 'page_to_section' with type 'int()'
>    35 |         int __sec =3D page_to_section(__pg);                     =
 \
>       |                     ^~~~~~~~~~~~~~~
> include/asm-generic/memory_model.h:40:32: note: in definition of macro '_=
_pfn_to_page'
>    40 | ({      unsigned long __pfn =3D (pfn);                    \
>       |                                ^~~
> include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__=
page_to_pfn'
>    52 | #define page_to_pfn __page_to_pfn
>       |                     ^~~~~~~~~~~~~
> include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
>   214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>       |                                      ^~~~~~~~~~~
> include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
>   312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
>       |                                 ^~~~~~~~
> include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
>   928 |         enum compound_dtor_id dtor =3D folio_page(folio, 1)->comp=
ound_dtor;
>       |                                      ^~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> Caused by commit (I think)
>=20
>   d3b90b76e101 ("mm: convert destroy_compound_page() to destroy_large_fol=
io()")
>=20
> I have reverted these commits fot today:
>=20
> 56629699b3dd mm/swap: convert __delete_from_swap_cache() to a folio
> e5085f2cc241 mm/swap: convert delete_from_swap_cache() to take a folio
> 169f02f4efb1 mm: convert page_swap_flags to folio_swap_flags
> d3b90b76e101 mm: convert destroy_compound_page() to destroy_large_folio()
>=20
> Then I got:
>=20
> mm/hugetlb_vmemmap.c: In function 'vmemmap_optimizable_pages':
> mm/hugetlb_vmemmap.c:110:24: error: implicit declaration of function 'spa=
rse_decode_mem_map' [-Werror=3Dimplicit-function-declaration]
>   110 |         vmemmap_page =3D sparse_decode_mem_map(ms->section_mem_ma=
p,
>       |                        ^~~~~~~~~~~~~~~~~~~~~
> mm/hugetlb_vmemmap.c:110:22: warning: assignment to 'struct page *' from =
'int' makes pointer from integer without a cast [-Wint-conversion]
>   110 |         vmemmap_page =3D _sparsedecode_mem_map(ms->section_mem_ma=
p,
>       |                      ^
> cc1: some warnings being treated as errors
>=20
> from my arm64 defconfig build.
>=20
> Caused by commit
>=20
>   10a768735470 ("mm: memory_hotplug: make hugetlb_optimize_vmemmap compat=
ible with memmap_on_memory")
>=20
> So I gave up and used the mm tree from next-20220617 for today.

Today, I reverted the following commits instead:

10a768735470 mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible w=
ith memmap_on_memory
cececf2df493 mm: memory_hotplug: enumerate all supported section flags
56629699b3dd mm/swap: convert __delete_from_swap_cache() to a folio
e5085f2cc241 mm/swap: convert delete_from_swap_cache() to take a folio
169f02f4efb1 mm: convert page_swap_flags to folio_swap_flags
d3b90b76e101 mm: convert destroy_compound_page() to destroy_large_folio()
19211dae45bb mm/swap: convert __page_cache_release() to use a folio

--=20
Cheers,
Stephen Rothwell

--Sig_/.gKofYcDqE7_tSi1YTSVd61
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKxcKgACgkQAVBC80lX
0Gw9Ewf9GXmuZy7oI2z6WdE7/cMEJLc+X6UreyfX5QIRJVm4Nu9Un90CIy5JHcqZ
A/PZJ7EIb0TEvqdWJH7FZOMcrpV84St/5iF4QGuY836cmH3pAHfynxk3oho/876d
OVXEO/ltSAtmw10nh+ouxtUWwHXWZ/0OGx4T6IvfH2k0lR04fXCm4Ty61mMq/Gpz
dIIUq/QKXM8DXZkg5XnkpD7ojay38T7w3jX2hxJvK6HMb6YnjKuncTi3gVo/j1hN
6aJbxykGhghyK6vf0rO8rACPHcXuzJd4+H7uzKPUnRbkV5ZhaUxkCfk/UYE+2dq3
tSxbNj15KYgPNpIpPCErKKtZTFgwQA==
=LPu5
-----END PGP SIGNATURE-----

--Sig_/.gKofYcDqE7_tSi1YTSVd61--
