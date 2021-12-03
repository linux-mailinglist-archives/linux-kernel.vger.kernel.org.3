Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB346727D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378840AbhLCHXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242171AbhLCHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:23:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F0C06174A;
        Thu,  2 Dec 2021 23:19:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J542w1T60z4xQs;
        Fri,  3 Dec 2021 18:19:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638515993;
        bh=MtQGR3NRuBQP/ZxhNcFPqXrHo+5siRxGdSIvNzmGVHg=;
        h=Date:From:To:Cc:Subject:From;
        b=DKyfP1CDOGrm7mVLkj5oeHY33nKXxmECuOE7u2bFDTutgXFjR/Hfjk9WqZaulKToM
         R1op9jxp/UwfcHBTXEpdnPib7/9ky3KLGN5Fhyxe3YlXcUMVkqiY3840hHh++ZSRY5
         mYzzLK/Bq4MmDXhfq5yu2SAX5JhY1/UZSLt/CuXiVY0P7HRVDlbq6U0X58xrDabD9N
         hEMct40zPvgK/ejMuKYrUeBLySN5OrjuJR1K2ElerqVSIEFvk/LSsP8JUy2rlGMylf
         uRYwD4Ct7dzTmRxRVSD78su6GSWQwwt4NrDLS1aqRr0DjneAQi/7fUW3grZ2LP5Ums
         1oNiINqu4KqRA==
Date:   Fri, 3 Dec 2021 18:19:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the slab
 tree
Message-ID: <20211203181951.79618878@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xd8l5QaM4Uqfp75E89Fccpq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xd8l5QaM4Uqfp75E89Fccpq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/memcontrol.c

between commit:

  eefa12e18a92 ("mm/memcg: Convert slab objcgs from struct page to struct s=
lab")

from the slab tree and commit:

  93e959c235eb ("mm/memcg: relocate mod_objcg_mlstate(), get_obj_stock() an=
d put_obj_stock()")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memcontrol.c
index 522fff11d6d1,69d4fdafbb80..000000000000
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@@ -2816,10 -2769,63 +2769,63 @@@ retry
   */
  #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
 =20
+ /*
+  * Most kmem_cache_alloc() calls are from user context. The irq disable/e=
nable
+  * sequence used in this case to access content from object stock is slow.
+  * To optimize for user context access, there are now two object stocks f=
or
+  * task context and interrupt context access respectively.
+  *
+  * The task context object stock can be accessed by disabling preemption =
only
+  * which is cheap in non-preempt kernel. The interrupt context object sto=
ck
+  * can only be accessed after disabling interrupt. User context code can
+  * access interrupt object stock, but not vice versa.
+  */
+ static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+ {
+ 	struct memcg_stock_pcp *stock;
+=20
+ 	if (likely(in_task())) {
+ 		*pflags =3D 0UL;
+ 		preempt_disable();
+ 		stock =3D this_cpu_ptr(&memcg_stock);
+ 		return &stock->task_obj;
+ 	}
+=20
+ 	local_irq_save(*pflags);
+ 	stock =3D this_cpu_ptr(&memcg_stock);
+ 	return &stock->irq_obj;
+ }
+=20
+ static inline void put_obj_stock(unsigned long flags)
+ {
+ 	if (likely(in_task()))
+ 		preempt_enable();
+ 	else
+ 		local_irq_restore(flags);
+ }
+=20
+ /*
+  * mod_objcg_mlstate() may be called with irq enabled, so
+  * mod_memcg_lruvec_state() should be used.
+  */
+ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
+ 				     struct pglist_data *pgdat,
+ 				     enum node_stat_item idx, int nr)
+ {
+ 	struct mem_cgroup *memcg;
+ 	struct lruvec *lruvec;
+=20
+ 	rcu_read_lock();
+ 	memcg =3D obj_cgroup_memcg(objcg);
+ 	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+ 	mod_memcg_lruvec_state(lruvec, idx, nr);
+ 	rcu_read_unlock();
+ }
+=20
 -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 -				 gfp_t gfp, bool new_page)
 +int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 +				 gfp_t gfp, bool new_slab)
  {
 -	unsigned int objects =3D objs_per_slab_page(s, page);
 +	unsigned int objects =3D objs_per_slab(s, slab);
  	unsigned long memcg_data;
  	void *vec;
 =20

--Sig_/Xd8l5QaM4Uqfp75E89Fccpq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpxRcACgkQAVBC80lX
0GyZgwf/ZH4IRTI6CFSGTaTiAgV35zD5IBkHH7m5qIhJgMdsMkq5PuIa7a4BMSp/
HNuiYgjYZ+89qG0qD9lbOIKYsTKZSOPgMQJFD542sS3UGvL/5WMCfid6bDZbmKNn
2eTR/1dr3o3owQxoCCH7I7EJzagnpGDCq5W681qwhaXB0fg8e2m5OzOZnacqW5zF
l5OhJNzK3zHsCvk5qWfiv680tNvTfgfNVMbp8qBZHKrR6rojYHRUtWKg1OtOmIcp
1akslkPjVmyLxeqVGcSWPNj2gaDsYm8QxNiUrevCw6S3ucfemY956AZqQZ+mbTjJ
vx12BP5agAeMY0+TPWfFebPn3VB2WA==
=mail
-----END PGP SIGNATURE-----

--Sig_/Xd8l5QaM4Uqfp75E89Fccpq--
