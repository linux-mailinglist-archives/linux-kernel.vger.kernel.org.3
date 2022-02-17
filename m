Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB54B9923
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBQGWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:22:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQGWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:22:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD608120F7F;
        Wed, 16 Feb 2022 22:22:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jzl9K5xxsz4xZ2;
        Thu, 17 Feb 2022 17:22:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645078934;
        bh=uKWNm3J+WC7L/u81wG0mBLFfBOhF1YJaiPHErcbfWSE=;
        h=Date:From:To:Cc:Subject:From;
        b=CYzOlECFm6db9nftI75S9LCIJvuAPuRyy3yKU0WmdYsqcjsjAmWs3ml8sVT1+VB08
         F2l6lUhvNpPwvya80cNm7J16sn9ywZZt+mvW3HGT8HzkcaxraeoQx5HRBrowILFkdD
         2IOMPHfalK5PiJ30eIo+lhOfIXzuvcVJLBABWmyL3mKAUgZ+9HJbXjdYEXeUTDKpmK
         c9uYRtoKJYHg9FEx2o7igPAp+0wLlq+yTBBlNbwDD35pbatcv8Hf9O/tFMUwUG/AV+
         eHsv85sSKbAXFaYRynoUVob2Kn7Mxgm42RLIcaIVUpsfvOXIPbIXf48hXejO4cygq8
         rQWPj3R8jpj7A==
Date:   Thu, 17 Feb 2022 17:22:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the maple tree with the memblock tree
Message-ID: <20220217172213.355ca4f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hvt/4DAfGD6OLjPgp=HGPgj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hvt/4DAfGD6OLjPgp=HGPgj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the maple tree got a conflict in:

  tools/testing/radix-tree/linux.c

between commit:

  5a198c3f9b0b ("tools: Move gfp.h and slab.h from radix-tree to lib")

from the memblock tree and commit:

  3a77b4e41d4f ("radix tree test suite: Add support for slab bulk APIs")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/radix-tree/linux.c
index 81539f543954,3383d748c650..000000000000
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@@ -77,6 -118,97 +117,71 @@@ void kmem_cache_free(struct kmem_cache=20
  	pthread_mutex_unlock(&cachep->lock);
  }
 =20
+ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **=
list)
+ {
+ 	if (kmalloc_verbose)
+ 		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+=20
+ 	pthread_mutex_lock(&cachep->lock);
+ 	for (int i =3D 0; i < size; i++)
+ 		kmem_cache_free_locked(cachep, list[i]);
+ 	pthread_mutex_unlock(&cachep->lock);
+ }
+=20
+ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t si=
ze,
+ 			  void **p)
+ {
+ 	size_t i;
+=20
+ 	if (kmalloc_verbose)
+ 		pr_debug("Bulk alloc %lu\n", size);
+=20
+ 	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+ 		if (cachep->non_kernel < size)
+ 			return 0;
+=20
+ 		cachep->non_kernel -=3D size;
+ 	}
+=20
+ 	pthread_mutex_lock(&cachep->lock);
+ 	if (cachep->nr_objs >=3D size) {
+ 		struct radix_tree_node *node;
+=20
+ 		for (i =3D 0; i < size; i++) {
+ 			node =3D cachep->objs;
+ 			cachep->nr_objs--;
+ 			cachep->objs =3D node->parent;
+ 			p[i] =3D node;
+ 			node->parent =3D NULL;
+ 		}
+ 		pthread_mutex_unlock(&cachep->lock);
+ 	} else {
+ 		pthread_mutex_unlock(&cachep->lock);
+ 		for (i =3D 0; i < size; i++) {
+ 			if (cachep->align) {
+ 				posix_memalign(&p[i], cachep->align,
+ 					       cachep->size * size);
+ 			} else {
+ 				p[i] =3D malloc(cachep->size * size);
+ 			}
+ 			if (cachep->ctor)
+ 				cachep->ctor(p[i]);
+ 			else if (gfp & __GFP_ZERO)
+ 				memset(p[i], 0, cachep->size);
+ 		}
+ 	}
+=20
+ 	for (i =3D 0; i < size; i++) {
+ 		uatomic_inc(&nr_allocated);
+ 		uatomic_inc(&cachep->nr_allocated);
+ 		uatomic_inc(&cachep->nr_tallocated);
+ 		if (kmalloc_verbose)
+ 			printf("Allocating %p from slab\n", p[i]);
+ 	}
+=20
+ 	return size;
+ }
+=20
 -void *kmalloc(size_t size, gfp_t gfp)
 -{
 -	void *ret;
 -
 -	if (!(gfp & __GFP_DIRECT_RECLAIM))
 -		return NULL;
 -
 -	ret =3D malloc(size);
 -	uatomic_inc(&nr_allocated);
 -	if (kmalloc_verbose)
 -		printf("Allocating %p from malloc\n", ret);
 -	if (gfp & __GFP_ZERO)
 -		memset(ret, 0, size);
 -	return ret;
 -}
 -
 -void kfree(void *p)
 -{
 -	if (!p)
 -		return;
 -	uatomic_dec(&nr_allocated);
 -	if (kmalloc_verbose)
 -		printf("Freeing %p to malloc\n", p);
 -	free(p);
 -}
 -
  struct kmem_cache *
  kmem_cache_create(const char *name, unsigned int size, unsigned int align,
  		unsigned int flags, void (*ctor)(void *))

--Sig_/hvt/4DAfGD6OLjPgp=HGPgj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN6ZUACgkQAVBC80lX
0GzMDgf/XF8wAJxcZUeeD/W8mIqhuldt3LiU2Z0ZMvvnvoGhcWEdEazf93m93tN8
PfCPeRfA3B8AsUSN32ehlPZsb8NCMg5/YFHe5WTQmcZyMzs+qeF3x3DZprVqHvON
WNM/qtld8oFxFIn4tu/4jw7nrIQOLsJE32swrYGxaxrDvthIerabspveWidKLpx4
iGYMGr/U944ighDVubkPYe3nvm7v2qfPQ2YmbdPXut7AQUt12nM8Bo3gdfEXXn0i
x2w3XX6DbttFp8QFkMjo0Z8HqYEX4cIiGxKNRTqmqFrFBuQi4c9Z/6Lnq3FvuGCV
WU9GjbylRByCk8AovNIPIfTQJ4KvZA==
=qPM/
-----END PGP SIGNATURE-----

--Sig_/hvt/4DAfGD6OLjPgp=HGPgj--
