Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F775510A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiFTGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbiFTGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:43:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECCC2615;
        Sun, 19 Jun 2022 23:42:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRKpP51hpz4xL4;
        Mon, 20 Jun 2022 16:42:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655707374;
        bh=6ScCn/tWBEgOW+PpVwGFcbwlDIs836qEcGcwdghtMpo=;
        h=Date:From:To:Cc:Subject:From;
        b=cTaZWbdLiwpJ+TYms1iOnk5ACjxSopTTyaUq27+qGejHKq2VwQG6BenHIDnyKrQho
         xdMlkJT9FlbWZSsQyL2Sc/bx9NIT/pbVAU0J69hifjuHsL1i64SqJUVoFJTIzrRYok
         3NWL5hmz9hFgAOMNIk6lB4LW71ZHuiTXXoT1wH2HKS0Lzrzp64lgdFlI1fh0eC4Zs5
         udl9tXGXXYCGHnQDFpCat7vcDhDNtn+y1vcUue2nxnG6CaLrKtppz/Votk+RdEDWY2
         bXaHxu2vH8Bnb79rFmXY7009uX3jvJhdl9dvxfbBR8+YIUhYOfvf5p3npomeLLzgDP
         DhL+RAvmKXtUg==
Date:   Mon, 20 Jun 2022 16:42:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: linux-next: build failures after merge of the mm tree
Message-ID: <20220620164246.0d3f7784@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nEvQrf=/_4PARQsuSG08h03";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEXHASH_WORD,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nEvQrf=/_4PARQsuSG08h03
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

In file included from arch/x86/include/asm/page.h:86,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets.c:9:
include/linux/mm.h: In function 'destroy_large_folio':
include/asm-generic/memory_model.h:35:21: error: implicit declaration of fu=
nction 'page_to_section'; did you mean 'present_section'? [-Werror=3Dimplic=
it-function-declaration]
   35 |         int __sec =3D page_to_section(__pg);                      \
      |                     ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:40:32: note: in definition of macro '__p=
fn_to_page'
   40 | ({      unsigned long __pfn =3D (pfn);                    \
      |                                ^~~
include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__pa=
ge_to_pfn'
   52 | #define page_to_pfn __page_to_pfn
      |                     ^~~~~~~~~~~~~
include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
  214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
      |                                      ^~~~~~~~~~~
include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
  312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
      |                                 ^~~~~~~~
include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
  928 |         enum compound_dtor_id dtor =3D folio_page(folio, 1)->compou=
nd_dtor;
      |                                      ^~~~~~~~~~
In file included from include/linux/memcontrol.h:20,
                 from include/linux/swap.h:9,
                 from include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
include/linux/mm.h: At top level:
include/linux/mm.h:1556:29: error: conflicting types for 'page_to_section';=
 have 'long unsigned int(const struct page *)'
 1556 | static inline unsigned long page_to_section(const struct page *page)
      |                             ^~~~~~~~~~~~~~~
In file included from arch/x86/include/asm/page.h:86,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets.c:9:
include/asm-generic/memory_model.h:35:21: note: previous implicit declarati=
on of 'page_to_section' with type 'int()'
   35 |         int __sec =3D page_to_section(__pg);                      \
      |                     ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:40:32: note: in definition of macro '__p=
fn_to_page'
   40 | ({      unsigned long __pfn =3D (pfn);                    \
      |                                ^~~
include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__pa=
ge_to_pfn'
   52 | #define page_to_pfn __page_to_pfn
      |                     ^~~~~~~~~~~~~
include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
  214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
      |                                      ^~~~~~~~~~~
include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
  312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
      |                                 ^~~~~~~~
include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
  928 |         enum compound_dtor_id dtor =3D folio_page(folio, 1)->compou=
nd_dtor;
      |                                      ^~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit (I think)

  d3b90b76e101 ("mm: convert destroy_compound_page() to destroy_large_folio=
()")

I have reverted these commits fot today:

56629699b3dd mm/swap: convert __delete_from_swap_cache() to a folio
e5085f2cc241 mm/swap: convert delete_from_swap_cache() to take a folio
169f02f4efb1 mm: convert page_swap_flags to folio_swap_flags
d3b90b76e101 mm: convert destroy_compound_page() to destroy_large_folio()

Then I got:

mm/hugetlb_vmemmap.c: In function 'vmemmap_optimizable_pages':
mm/hugetlb_vmemmap.c:110:24: error: implicit declaration of function 'spars=
e_decode_mem_map' [-Werror=3Dimplicit-function-declaration]
  110 |         vmemmap_page =3D sparse_decode_mem_map(ms->section_mem_map,
      |                        ^~~~~~~~~~~~~~~~~~~~~
mm/hugetlb_vmemmap.c:110:22: warning: assignment to 'struct page *' from 'i=
nt' makes pointer from integer without a cast [-Wint-conversion]
  110 |         vmemmap_page =3D _sparsedecode_mem_map(ms->section_mem_map,
      |                      ^
cc1: some warnings being treated as errors

from my arm64 defconfig build.

Caused by commit

  10a768735470 ("mm: memory_hotplug: make hugetlb_optimize_vmemmap compatib=
le with memmap_on_memory")

So I gave up and used the mm tree from next-20220617 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/nEvQrf=/_4PARQsuSG08h03
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKwFuYACgkQAVBC80lX
0Gw7AwgAinOzy8+RCKYZpkajQdvJZH6fDAZ/vSsE8TitrcHKzWbiXCl7aDpC+T/4
HWFkx9jsqF8RBcLzI2BeqEVHa2K9xZyUm0csx9PFTLJUCluBKpi9unziAtPLX2yB
1reGCPL285oBpEaXvsAfaZK0ajLy4lkOpZ00Gy60wIr3IUcTK1CyNaHVXK/v6bmX
GHImsBOWHjxu+4UdsVShnUMmIsQVJzW5cAUmPz1nnZQ9TapC3ZfoMZPdyUAdRnXR
dJgVYXR8zo4+wSBnoRW8CtpdgQMZMZVGrG5pgCyJLTdvfCec6/x0uUsr6E+WhLtI
eNgPXkoq6lbAbRrfd0oN8PS5dPbmGw==
=UdCX
-----END PGP SIGNATURE-----

--Sig_/nEvQrf=/_4PARQsuSG08h03--
