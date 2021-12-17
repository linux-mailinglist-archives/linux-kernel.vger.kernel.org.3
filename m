Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EDF478B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhLQMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLQMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:39:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EAC061574;
        Fri, 17 Dec 2021 04:39:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFpTk0jjTz4xbr;
        Fri, 17 Dec 2021 23:39:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639744795;
        bh=nsJIk8BV4J9cx49eUDdaldIhENhHvqO2ucZI2RNmU6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=czenW1I+e5ejS2wybZTdTiabdQozsunHn6tCOabXRJMW/AwwYEd9OjQpRvQgeFOV2
         NhaLYIDZY/RKrkfiwkzBTfywU54KdxOUm9krxBt0egsDWZN05LWhzOeVn20eL6eKKp
         MWLp3KI9PB2XJT8/4cUGVupmVg20A/F6gmB7uOcnsws4foYLVGf9R9csJFrxSV/kvY
         820S7Of9ZJChg/iFu8nt3we39wttn2ff1pE01D574SnMy4uHOl94Wfre3XZzLxjof3
         gYwhb2/zPxCPe/4P+h+ZSwuaLl9sve9ZbC1R0Kn1q6mWn2OsSKD9lAQYvqGPIDESKX
         nSh/wa9AQVVew==
Date:   Fri, 17 Dec 2021 23:39:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the slab
 tree
Message-ID: <20211217233953.28062c5b@canb.auug.org.au>
In-Reply-To: <20211203181951.79618878@canb.auug.org.au>
References: <20211203181951.79618878@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ott/_LIrJC2ztXbfGcPesLO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ott/_LIrJC2ztXbfGcPesLO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Dec 2021 18:19:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   mm/memcontrol.c
>=20
> between commit:
>=20
>   eefa12e18a92 ("mm/memcg: Convert slab objcgs from struct page to struct=
 slab")
>=20
> from the slab tree and commit:
>=20
>   93e959c235eb ("mm/memcg: relocate mod_objcg_mlstate(), get_obj_stock() =
and put_obj_stock()")
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
> diff --cc mm/memcontrol.c
> index 522fff11d6d1,69d4fdafbb80..000000000000
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@@ -2816,10 -2769,63 +2769,63 @@@ retry
>    */
>   #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUN=
T)
>  =20
> + /*
> +  * Most kmem_cache_alloc() calls are from user context. The irq disable=
/enable
> +  * sequence used in this case to access content from object stock is sl=
ow.
> +  * To optimize for user context access, there are now two object stocks=
 for
> +  * task context and interrupt context access respectively.
> +  *
> +  * The task context object stock can be accessed by disabling preemptio=
n only
> +  * which is cheap in non-preempt kernel. The interrupt context object s=
tock
> +  * can only be accessed after disabling interrupt. User context code can
> +  * access interrupt object stock, but not vice versa.
> +  */
> + static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
> + {
> + 	struct memcg_stock_pcp *stock;
> +=20
> + 	if (likely(in_task())) {
> + 		*pflags =3D 0UL;
> + 		preempt_disable();
> + 		stock =3D this_cpu_ptr(&memcg_stock);
> + 		return &stock->task_obj;
> + 	}
> +=20
> + 	local_irq_save(*pflags);
> + 	stock =3D this_cpu_ptr(&memcg_stock);
> + 	return &stock->irq_obj;
> + }
> +=20
> + static inline void put_obj_stock(unsigned long flags)
> + {
> + 	if (likely(in_task()))
> + 		preempt_enable();
> + 	else
> + 		local_irq_restore(flags);
> + }
> +=20
> + /*
> +  * mod_objcg_mlstate() may be called with irq enabled, so
> +  * mod_memcg_lruvec_state() should be used.
> +  */
> + static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
> + 				     struct pglist_data *pgdat,
> + 				     enum node_stat_item idx, int nr)
> + {
> + 	struct mem_cgroup *memcg;
> + 	struct lruvec *lruvec;
> +=20
> + 	rcu_read_lock();
> + 	memcg =3D obj_cgroup_memcg(objcg);
> + 	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> + 	mod_memcg_lruvec_state(lruvec, idx, nr);
> + 	rcu_read_unlock();
> + }
> +=20
>  -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *=
s,
>  -				 gfp_t gfp, bool new_page)
>  +int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>  +				 gfp_t gfp, bool new_slab)
>   {
>  -	unsigned int objects =3D objs_per_slab_page(s, page);
>  +	unsigned int objects =3D objs_per_slab(s, slab);
>   	unsigned long memcg_data;
>   	void *vec;
>  =20

This is now a conflict between the slab tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ott/_LIrJC2ztXbfGcPesLO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8hRkACgkQAVBC80lX
0Gzbqwf/Zb+TF7hmPvSyL6VuEMvxGp+ytUa0OwTS7gT0FjfDjhWTJJXY/eAD1Xe/
cAEEuPAeHEGLHMEKFI/Yq1rms8TQhgx907ZoFJycZ/61+noxhvYgYQ6YAlfnpPjQ
RkMoHsnNdAIc7jPVyZysPJQxk54W3ZfNYERlMn+bKGQQre/Myow7ApnJYQCgUELF
/QNkB75wleo+ZccqlDc3ed8NhzoPiqkS6AZEV3U/Syg7vQfJZTlBpGdAE9HbulLO
stwrUy5o3HS7NRmnCzV3nyUFwEXlmTUhlEk8O7GRFcbjGQOvgndq8F2B4jUVTF1p
5hCTivtYggppTWSqaTi448Fa+KYh0Q==
=FavT
-----END PGP SIGNATURE-----

--Sig_/ott/_LIrJC2ztXbfGcPesLO--
