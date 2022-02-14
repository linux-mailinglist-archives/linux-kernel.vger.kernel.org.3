Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661424B4270
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiBNHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:00:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiBNHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:00:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA7575DD;
        Sun, 13 Feb 2022 23:00:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jxw950SNLz4xPv;
        Mon, 14 Feb 2022 18:00:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644822041;
        bh=9j5wM1xu7+Youllh7eWo2TtvexX2Ec2GaWIzXe1Huls=;
        h=Date:From:To:Cc:Subject:From;
        b=JlUoyUcE77r2G+5Xc7+E9LD3IjBy5sa+rfmg2yi5eswigrVuMr0hi4grNNW6Ig7KJ
         6qR3E3O41og91BvvCP6sYQSons/85EGPmE0shduCB/vQf0kD2xXTpZKYvdV0Rk3V6s
         yiMEzDm996D5teWAYJp+Fmz9NNaJ/Kn0y0/46n7xUzqea1hzlG1mnDTyAS5cQumkeh
         rRpV49beye9CJ1vl32CujwiYAonHbfyma0euCtMJr2vWA/zJZ7vyHRoVE7CVViGcb1
         F1nVY9UknKI4zquboJ4aEDkDk97enrzUrVOl3uJ0UCER0vPz5FaHb/JJ0+W7YpDD2U
         GMeZ1t3sOjL3A==
Date:   Mon, 14 Feb 2022 18:00:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220214180040.44f8316a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Jvn3.4.Ycg7TpMedO5l4EnN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jvn3.4.Ycg7TpMedO5l4EnN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kvm/book3s_hv_uvmem.c: In function 'kvmppc_uvmem_get_page':
arch/powerpc/kvm/book3s_hv_uvmem.c:691:39: error: invalid use of undefined =
type 'struct dev_pagemap'
  691 |         pfn_first =3D kvmppc_uvmem_pgmap.range.start >> PAGE_SHIFT;
      |                                       ^
arch/powerpc/kvm/book3s_hv_uvmem.c:693:50: error: invalid use of undefined =
type 'struct dev_pagemap'
  693 |                    (range_len(&kvmppc_uvmem_pgmap.range) >> PAGE_SH=
IFT);
      |                                                  ^
arch/powerpc/kvm/book3s_hv_uvmem.c: In function 'kvmppc_uvmem_page_free':
arch/powerpc/kvm/book3s_hv_uvmem.c:1010:44: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1010 |                         (kvmppc_uvmem_pgmap.range.start >> PAGE_SHI=
FT);
      |                                            ^
arch/powerpc/kvm/book3s_hv_uvmem.c: At top level:
arch/powerpc/kvm/book3s_hv_uvmem.c:1026:21: error: variable 'kvmppc_uvmem_o=
ps' has initializer but incomplete type
 1026 | static const struct dev_pagemap_ops kvmppc_uvmem_ops =3D {
      |                     ^~~~~~~~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1027:10: error: 'const struct dev_pagema=
p_ops' has no member named 'page_free'
 1027 |         .page_free =3D kvmppc_uvmem_page_free,
      |          ^~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1027:22: error: excess elements in struc=
t initializer [-Werror]
 1027 |         .page_free =3D kvmppc_uvmem_page_free,
      |                      ^~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1027:22: note: (near initialization for =
'kvmppc_uvmem_ops')
arch/powerpc/kvm/book3s_hv_uvmem.c:1028:10: error: 'const struct dev_pagema=
p_ops' has no member named 'migrate_to_ram'
 1028 |         .migrate_to_ram =3D kvmppc_uvmem_migrate_to_ram,
      |          ^~~~~~~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1028:27: error: excess elements in struc=
t initializer [-Werror]
 1028 |         .migrate_to_ram =3D kvmppc_uvmem_migrate_to_ram,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1028:27: note: (near initialization for =
'kvmppc_uvmem_ops')
arch/powerpc/kvm/book3s_hv_uvmem.c: In function 'kvmppc_uvmem_init':
arch/powerpc/kvm/book3s_hv_uvmem.c:1172:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1172 |         kvmppc_uvmem_pgmap.type =3D MEMORY_DEVICE_PRIVATE;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1172:35: error: 'MEMORY_DEVICE_PRIVATE' =
undeclared (first use in this function); did you mean 'CONFIG_DEVICE_PRIVAT=
E'?
 1172 |         kvmppc_uvmem_pgmap.type =3D MEMORY_DEVICE_PRIVATE;
      |                                   ^~~~~~~~~~~~~~~~~~~~~
      |                                   CONFIG_DEVICE_PRIVATE
arch/powerpc/kvm/book3s_hv_uvmem.c:1172:35: note: each undeclared identifie=
r is reported only once for each function it appears in
arch/powerpc/kvm/book3s_hv_uvmem.c:1173:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1173 |         kvmppc_uvmem_pgmap.range.start =3D res->start;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1174:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1174 |         kvmppc_uvmem_pgmap.range.end =3D res->end;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1175:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1175 |         kvmppc_uvmem_pgmap.nr_range =3D 1;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1176:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1176 |         kvmppc_uvmem_pgmap.ops =3D &kvmppc_uvmem_ops;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1178:27: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1178 |         kvmppc_uvmem_pgmap.owner =3D &kvmppc_uvmem_pgmap;
      |                           ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1179:16: error: implicit declaration of =
function 'memremap_pages'; did you mean 'memcmp_pages'? [-Werror=3Dimplicit=
-function-declaration]
 1179 |         addr =3D memremap_pages(&kvmppc_uvmem_pgmap, NUMA_NO_NODE);
      |                ^~~~~~~~~~~~~~
      |                memcmp_pages
arch/powerpc/kvm/book3s_hv_uvmem.c:1179:14: error: assignment to 'void *' f=
rom 'int' makes pointer from integer without a cast [-Werror=3Dint-conversi=
on]
 1179 |         addr =3D memremap_pages(&kvmppc_uvmem_pgmap, NUMA_NO_NODE);
      |              ^
arch/powerpc/kvm/book3s_hv_uvmem.c:1197:9: error: implicit declaration of f=
unction 'memunmap_pages'; did you mean 'memcmp_pages'? [-Werror=3Dimplicit-=
function-declaration]
 1197 |         memunmap_pages(&kvmppc_uvmem_pgmap);
      |         ^~~~~~~~~~~~~~
      |         memcmp_pages
In file included from include/linux/device.h:17,
                 from arch/powerpc/include/asm/io.h:27,
                 from include/linux/io.h:13,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:11,
                 from include/linux/highmem.h:11,
                 from include/linux/pagemap.h:11,
                 from arch/powerpc/kvm/book3s_hv_uvmem.c:89:
arch/powerpc/kvm/book3s_hv_uvmem.c: In function 'kvmppc_uvmem_free':
arch/powerpc/kvm/book3s_hv_uvmem.c:1210:46: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1210 |         release_mem_region(kvmppc_uvmem_pgmap.range.start,
      |                                              ^
include/linux/ioport.h:278:76: note: in definition of macro 'release_mem_re=
gion'
  278 | #define release_mem_region(start,n)     __release_region(&iomem_res=
ource, (start), (n))
      |                                                                    =
        ^~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1211:57: error: invalid use of undefined=
 type 'struct dev_pagemap'
 1211 |                            range_len(&kvmppc_uvmem_pgmap.range));
      |                                                         ^
include/linux/ioport.h:278:85: note: in definition of macro 'release_mem_re=
gion'
  278 | #define release_mem_region(start,n)     __release_region(&iomem_res=
ource, (start), (n))
      |                                                                    =
                 ^
arch/powerpc/kvm/book3s_hv_uvmem.c: At top level:
arch/powerpc/kvm/book3s_hv_uvmem.c:99:27: error: storage size of 'kvmppc_uv=
mem_pgmap' isn't known
   99 | static struct dev_pagemap kvmppc_uvmem_pgmap;
      |                           ^~~~~~~~~~~~~~~~~~
arch/powerpc/kvm/book3s_hv_uvmem.c:1026:37: error: storage size of 'kvmppc_=
uvmem_ops' isn't known
 1026 | static const struct dev_pagemap_ops kvmppc_uvmem_ops =3D {
      |                                     ^~~~~~~~~~~~~~~~

Presumably caused by commit

  5ba71dc7727a ("mm: don't include <linux/memremap.h> in <linux/mm.h>")

I applied the following patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 14 Feb 2022 17:47:53 +1100
Subject: [PATCH] fix for "mm: don't include <linux/memremap.h> in
 <linux/mm.h>"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_h=
v_uvmem.c
index 8b6438fa18fc..8cabdb39cbbc 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -91,6 +91,7 @@
 #include <linux/kvm_host.h>
 #include <linux/ksm.h>
 #include <linux/of.h>
+#include <linux/memremap.h>
 #include <asm/ultravisor.h>
 #include <asm/mman.h>
 #include <asm/kvm_ppc.h>
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Jvn3.4.Ycg7TpMedO5l4EnN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJ/hgACgkQAVBC80lX
0Gy00wf/f2NhFekXKQAySXzjZDKSgHXD+y+pnS0nGyfNtdz/2gJzgW5xm+Pp7kaR
ISzxCY3WHNqsDpCNRDZxMiQZTMn8c5RhE8RGRLKwgQ2CMb0KXdx0wKu4oCW9u5nO
4a6+FcuRWVzk6wYX9LPSSFpTVG1AO7jC3LqFOVqSzUYjsAK9ABQYASDqwBKcf4Eq
TGAu0A+INZiWpHy66jUTieIBrn77eB5ODfAYGut0pZ/+Kgry2EAewf3krucCPffC
q2FLUhUergkndT7uOUmdE2dRm0YYGpD8/KTxmD7Gc2U9y7R+i3aXk9wC0fb1DkIj
knbObRC8ggkD7P5FXe2kLJA+4wcKaA==
=ROAr
-----END PGP SIGNATURE-----

--Sig_/Jvn3.4.Ycg7TpMedO5l4EnN--
