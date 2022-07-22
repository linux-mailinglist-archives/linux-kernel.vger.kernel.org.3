Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5257DDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiGVJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiGVJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:27:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423FDCB767;
        Fri, 22 Jul 2022 02:17:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lq3jR4DdNz4xGX;
        Fri, 22 Jul 2022 19:16:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658481419;
        bh=W+TwO9wkD+1yXZNYLaEdJ/NY32OIzj+hu9rae9kHaSQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pwqHnFSV0he70fv+FVjuVYDa0s05o+4T9QUJmbrIwUHW1HhhpR5DYVzIDzeOaPiZV
         I5ZdKGb38nwaR0D+KVlP9cZJ3/S+hVGD3D44/z5CdzyXfUfarWiXr3ytR96BP96arX
         c/aPahTd5LqWzVQC9LbRUJz1lhI0ISpysCHMSVci/lguJAfogJO6xPctjzFvhAKWnP
         d+dExOEtLK07KkXvupkKXaJkwFpEbZwQVIgg5hI9zgHteLY4A3qltxWLvzsizEcN7o
         J9gDNMBTsSVxzJaUnTewk08Q/co9QYsScPsq5PNhN7iB4sl+J5w8mWc/aKQzD7SZV6
         gl1qWHVfNSQVw==
Date:   Fri, 22 Jul 2022 19:16:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220722191657.1d7282c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VX5WcUkPTO_bd1gBHNCMmjS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VX5WcUkPTO_bd1gBHNCMmjS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/cred.h:16,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
 1203 |         nodemask_t                      mems_allowed;
      |         ^~~~~~~~~~
In file included from include/linux/gfp.h:7,
                 from include/linux/percpu_counter.h:16,
                 from include/linux/sched/user.h:7,
                 from include/linux/cred.h:17,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/mmzone.h:1166:41: error: unknown type name 'nodemask_t'
 1166 |                                         nodemask_t *nodes);
      |                                         ^~~~~~~~~~
In file included from include/linux/gfp.h:7,
                 from include/linux/percpu_counter.h:16,
                 from include/linux/sched/user.h:7,
                 from include/linux/cred.h:17,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/mmzone.h:1185:41: error: unknown type name 'nodemask_t'
 1185 |                                         nodemask_t *nodes)
      |                                         ^~~~~~~~~~
include/linux/mmzone.h:1211:41: error: unknown type name 'nodemask_t'
 1211 |                                         nodemask_t *nodes)
      |                                         ^~~~~~~~~~
include/linux/mmzone.h:1254:39: error: unknown type name 'nodemask_t'
 1254 | static inline bool movable_only_nodes(nodemask_t *nodes)
      |                                       ^~~~~~~~~~
In file included from include/linux/percpu_counter.h:16,
                 from include/linux/sched/user.h:7,
                 from include/linux/cred.h:17,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/gfp.h:198:17: error: unknown type name 'nodemask_t'
  198 |                 nodemask_t *nodemask);
      |                 ^~~~~~~~~~
include/linux/gfp.h:200:17: error: unknown type name 'nodemask_t'
  200 |                 nodemask_t *nodemask);
      |                 ^~~~~~~~~~
include/linux/gfp.h:203:33: error: unknown type name 'nodemask_t'
  203 |                                 nodemask_t *nodemask, int nr_pages,
      |                                 ^~~~~~~~~~
include/linux/gfp.h: In function 'alloc_pages_bulk_list':
include/linux/gfp.h:215:16: error: implicit declaration of function '__allo=
c_pages_bulk'; did you mean 'alloc_pages_bulk_list'? [-Werror=3Dimplicit-fu=
nction-declaration]
  215 |         return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_page=
s, list, NULL);
      |                ^~~~~~~~~~~~~~~~~~
      |                alloc_pages_bulk_list
In file included from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:55,
                 from include/linux/ipc.h:5,
                 from include/uapi/linux/sem.h:5,
                 from include/linux/sem.h:5,
                 from include/linux/compat.h:14,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/gfp.h: In function '__alloc_pages_node':
include/linux/gfp.h:241:52: error: implicit declaration of function 'node_o=
nline'; did you mean 'node_zonelist'? [-Werror=3Dimplicit-function-declarat=
ion]
  241 |         VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid)=
);
      |                                                    ^~~~~~~~~~~
include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON=
_INVALID'
   30 | #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
      |                                                               ^
include/linux/gfp.h:241:9: note: in expansion of macro 'VM_WARN_ON'
  241 |         VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid)=
);
      |         ^~~~~~~~~~
In file included from include/linux/percpu_counter.h:16,
                 from include/linux/sched/user.h:7,
                 from include/linux/cred.h:17,
                 from include/linux/seq_file.h:13,
                 from arch/powerpc/include/asm/machdep.h:6,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/gfp.h:243:16: error: implicit declaration of function '__allo=
c_pages'; did you mean '__add_pages'? [-Werror=3Dimplicit-function-declarat=
ion]
  243 |         return __alloc_pages(gfp_mask, order, nid, NULL);
      |                ^~~~~~~~~~~~~
      |                __add_pages
include/linux/gfp.h:243:16: warning: returning 'int' from a function with r=
eturn type 'struct page *' makes pointer from integer without a cast [-Wint=
-conversion]
  243 |         return __alloc_pages(gfp_mask, order, nid, NULL);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/gfp.h: In function '__folio_alloc_node':
include/linux/gfp.h:252:16: error: implicit declaration of function '__foli=
o_alloc'; did you mean '__folio_alloc_node'? [-Werror=3Dimplicit-function-d=
eclaration]
  252 |         return __folio_alloc(gfp, order, nid, NULL);
      |                ^~~~~~~~~~~~~
      |                __folio_alloc_node
include/linux/gfp.h:252:16: warning: returning 'int' from a function with r=
eturn type 'struct folio *' makes pointer from integer without a cast [-Win=
t-conversion]
  252 |         return __folio_alloc(gfp, order, nid, NULL);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/gfp.h: At top level:
include/linux/gfp.h:366:49: error: unknown type name 'nodemask_t'
  366 |                                        int nid, nodemask_t *nodemas=
k);
      |                                                 ^~~~~~~~~~
In file included from include/linux/mm.h:703,
                 from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:10,
                 from arch/powerpc/include/asm/machdep.h:8,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/huge_mm.h: In function '__transparent_hugepage_enabled':
include/linux/huge_mm.h:166:13: error: implicit declaration of function 'vm=
a_is_dax' [-Werror=3Dimplicit-function-declaration]
  166 |         if (vma_is_dax(vma))
      |             ^~~~~~~~~~
include/linux/huge_mm.h: In function 'file_thp_enabled':
include/linux/huge_mm.h:183:29: error: invalid use of undefined type 'struc=
t file'
  183 |         inode =3D vma->vm_file->f_inode;
      |                             ^~
include/linux/huge_mm.h:187:17: error: implicit declaration of function 'in=
ode_is_open_for_write' [-Werror=3Dimplicit-function-declaration]
  187 |                !inode_is_open_for_write(inode) && S_ISREG(inode->i_=
mode);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/stat.h:7,
                 from include/linux/compat.h:12,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/huge_mm.h:187:64: error: invalid use of undefined type 'struc=
t inode'
  187 |                !inode_is_open_for_write(inode) && S_ISREG(inode->i_=
mode);
      |                                                                ^~
include/uapi/linux/stat.h:22:28: note: in definition of macro 'S_ISREG'
   22 | #define S_ISREG(m)      (((m) & S_IFMT) =3D=3D S_IFREG)
      |                            ^
In file included from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:10,
                 from arch/powerpc/include/asm/machdep.h:8,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/mm.h: At top level:
include/linux/mm.h:1833:49: error: unknown type name 'nodemask_t'
 1833 | extern void show_free_areas(unsigned int flags, nodemask_t *nodemas=
k);
      |                                                 ^~~~~~~~~~
include/linux/mm.h: In function 'get_num_physpages':
include/linux/mm.h:2518:9: error: implicit declaration of function 'for_eac=
h_online_node'; did you mean 'for_each_online_pgdat'? [-Werror=3Dimplicit-f=
unction-declaration]
 2518 |         for_each_online_node(nid)
      |         ^~~~~~~~~~~~~~~~~~~~
      |         for_each_online_pgdat
include/linux/mm.h:2518:34: error: expected ';' before 'phys_pages'
 2518 |         for_each_online_node(nid)
      |                                  ^
      |                                  ;
 2519 |                 phys_pages +=3D node_present_pages(nid);
      |                 ~~~~~~~~~~       =20
include/linux/mm.h: At top level:
include/linux/mm.h:2569:42: error: unknown type name 'nodemask_t'
 2569 | extern void show_mem(unsigned int flags, nodemask_t *nodemask);
      |                                          ^~~~~~~~~~
include/linux/mm.h:2578:33: error: unknown type name 'nodemask_t'
 2578 | void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *f=
mt, ...);
      |                                 ^~~~~~~~~~
include/linux/mm.h: In function 'seal_check_future_write':
include/linux/mm.h:3411:21: error: 'F_SEAL_FUTURE_WRITE' undeclared (first =
use in this function)
 3411 |         if (seals & F_SEAL_FUTURE_WRITE) {
      |                     ^~~~~~~~~~~~~~~~~~~
include/linux/mm.h:3411:21: note: each undeclared identifier is reported on=
ly once for each function it appears in
In file included from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/fs.h: At top level:
include/linux/fs.h:2977:20: error: conflicting types for 'inode_is_open_for=
_write'; have 'bool(const struct inode *)' {aka '_Bool(const struct inode *=
)'}
 2977 | static inline bool inode_is_open_for_write(const struct inode *inod=
e)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/mm.h:703,
                 from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:10,
                 from arch/powerpc/include/asm/machdep.h:8,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/huge_mm.h:187:17: note: previous implicit declaration of 'ino=
de_is_open_for_write' with type 'int()'
  187 |                !inode_is_open_for_write(inode) && S_ISREG(inode->i_=
mode);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/fs.h:3364:20: error: conflicting types for 'vma_is_dax'; have=
 'bool(const struct vm_area_struct *)' {aka '_Bool(const struct vm_area_str=
uct *)'}
 3364 | static inline bool vma_is_dax(const struct vm_area_struct *vma)
      |                    ^~~~~~~~~~
In file included from include/linux/mm.h:703,
                 from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:10,
                 from arch/powerpc/include/asm/machdep.h:8,
                 from arch/powerpc/include/asm/archrandom.h:5,
                 from include/linux/random.h:109,
                 from include/linux/nodemask.h:97,
                 from include/linux/list_lru.h:12,
                 from include/linux/fs.h:13,
                 from include/linux/compat.h:17,
                 from arch/powerpc/kernel/asm-offsets.c:12:
include/linux/huge_mm.h:166:13: note: previous implicit declaration of 'vma=
_is_dax' with type 'int()'
  166 |         if (vma_is_dax(vma))
      |             ^~~~~~~~~~

I am not sure which commit caused this.  Though I suspect

  bbe8fb1a3c53 ("lib/nodemask: inline next_node_in() and node_random()")

which added the include of random.h to nodemask.h

I have used the bitmap tree from next-20220721 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VX5WcUkPTO_bd1gBHNCMmjS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLaawoACgkQAVBC80lX
0GxysQgAglqgFNvpCJ2p0p5Z3qdAAfSfDSgoe6jqXFq6Qyh72M2YNUxBQYRg/dPs
UuU/ZoIYZShtGZUkLN3jqw9HaBDsUkrwv25K/KokIpjdfGUWa+AdSnSsMpuJ/hXU
p+tP8qLiqJGBW4HarM/DTNIJF8//6QMtH4fB6pm6TvDq6nm2LWgndbvn1GHMqOql
Zuz475PK8PsYTZad+RU+19IdGuAr99DLZAE8MvMFtNax34ZCc8bv7mZCZT+UvhyP
ys7UsrTeWE9ahd1tHSrKaz6ZZJG9pmKs2BlQlvT+Cbk2Fg83DS4Ss6U+CrTVbR+n
n5WD8dyN1ZN0VNxK4LNDYUD/Pr2L8w==
=BwNL
-----END PGP SIGNATURE-----

--Sig_/VX5WcUkPTO_bd1gBHNCMmjS--
