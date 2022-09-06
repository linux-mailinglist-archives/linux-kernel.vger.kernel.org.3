Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C245ADC3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiIFAP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiIFAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:15:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC814F682;
        Mon,  5 Sep 2022 17:15:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM5Wp3dbjz4x1d;
        Tue,  6 Sep 2022 10:15:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662423351;
        bh=uvwhs5LkYByPAUSDc55RSvlMkaNGa3ewrceu/px4Iy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dx78H16jr755pXikoUsnpAT7NYJ9z8xJ89U7u3hQuWsTsvToTagkppp5aCEEO4ryN
         XKTX4ADoRYH2pm5zt7gKG6Qjj4I2AKIWUr1LcTvyZYO+YNrq1S3s253BA2Dt5flQ0q
         atnJ8CkyNrhMHLKNRJh3RnpsJ+AW+0UP31WUNA7BjhnHj9pRz0HQWwrXfVYh3vjXij
         VurE4Ytz7ctdQhyAcLjF9lqyK75Bv5iKj3yWEmFehMvqsg1XuhdJUznqW595XmhDM2
         kEcXQtE4YSBbA5dpMJ+rzO076nfNMKUqB39H4v51Ryvmbu2dCfjqXsIz6QYGzrU1HA
         r9zB2dxYT0b3w==
Date:   Tue, 6 Sep 2022 10:15:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20220906101549.1cfee0d4@canb.auug.org.au>
In-Reply-To: <20220906095055.498d90ea@canb.auug.org.au>
References: <20220906095055.498d90ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CRYrN=XD6G0mVc67TMvLduU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CRYrN=XD6G0mVc67TMvLduU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Sep 2022 09:50:55 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the btrfs tree got a conflict in:
>=20
>   fs/btrfs/zoned.c
>=20
> between commit:
>=20
>   6ca64ac27631 ("btrfs: zoned: fix mounting with conventional zones")
>=20
> from the btrfs-fixes tree and commit:
>=20
>   e5182af66852 ("btrfs: convert block group bit field to use bit helpers")
>=20
> from the btrfs tree.
>=20
> I fixed it up (the former removed some of the code modified by the latter)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Actually the fix up is below ...

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/zoned.c
index 62e7007a7e46,dc96b3331bfb..000000000000
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@@ -1426,17 -1402,32 +1426,16 @@@ int btrfs_load_block_group_zone_info(st
  		cache->seq_zone =3D true;
 =20
  	if (num_conventional > 0) {
 -		/*
 -		 * Avoid calling calculate_alloc_pointer() for new BG. It
 -		 * is no use for new BG. It must be always 0.
 -		 *
 -		 * Also, we have a lock chain of extent buffer lock ->
 -		 * chunk mutex.  For new BG, this function is called from
 -		 * btrfs_make_block_group() which is already taking the
 -		 * chunk mutex. Thus, we cannot call
 -		 * calculate_alloc_pointer() which takes extent buffer
 -		 * locks to avoid deadlock.
 -		 */
 -
  		/* Zone capacity is always zone size in emulation */
  		cache->zone_capacity =3D cache->length;
 -		if (new) {
 -			cache->alloc_offset =3D 0;
 -			goto out;
 -		}
 -		ret =3D calculate_alloc_pointer(cache, &last_alloc);
 -		if (ret || map->num_stripes =3D=3D num_conventional) {
 -			if (!ret)
 -				cache->alloc_offset =3D last_alloc;
 -			else
 -				btrfs_err(fs_info,
 +		ret =3D calculate_alloc_pointer(cache, &last_alloc, new);
 +		if (ret) {
 +			btrfs_err(fs_info,
  			"zoned: failed to determine allocation offset of bg %llu",
 -					  cache->start);
 +				  cache->start);
 +			goto out;
 +		} else if (map->num_stripes =3D=3D num_conventional) {
 +			cache->alloc_offset =3D last_alloc;
- 			cache->zone_is_active =3D 1;
  			goto out;
  		}
  	}
@@@ -1528,16 -1529,10 +1530,16 @@@ out
  		ret =3D -EIO;
  	}
 =20
 -	if (!ret)
 +	if (!ret) {
  		cache->meta_write_pointer =3D cache->alloc_offset + cache->start;
- 		if (cache->zone_is_active) {
 -
 -	if (ret) {
++		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {
 +			btrfs_get_block_group(cache);
 +			spin_lock(&fs_info->zone_active_bgs_lock);
 +			list_add_tail(&cache->active_bg_list,
 +				      &fs_info->zone_active_bgs);
 +			spin_unlock(&fs_info->zone_active_bgs_lock);
 +		}
 +	} else {
  		kfree(cache->physical_map);
  		cache->physical_map =3D NULL;
  	}

--Sig_/CRYrN=XD6G0mVc67TMvLduU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWkTUACgkQAVBC80lX
0GwKJQf+J23/uLehFPTk9OuQsSTePNsu8Tx3aLRPPrcVf+EVGLYbxmC5bTUC4dOW
6LRrqpZ5iuh9upgW55kPZ0ymcox2taTxk23AthOQgg72v4vS1tHDsM9uMb0ZrvSD
1cIlu4PDPhcl1u1qdzCy/k4udyytm362WabYtwR9kPjO4MRkgb2+aMPSgZtrPTfL
p1rJWc178KjZWCFsKMjCGJR2Ol5xKf1wdulnQnaTR1UqAMoGyvyQuA8MbRhgoS95
9AVBvCrck1vi4O93Dx2Eklu9MG8ArqCOQ6BXDFSf9JflJAH0HkhBFqQYcTVUu9+r
AE6/BQqbZZWS89pIO8cHUoGVP4OdBA==
=wIuH
-----END PGP SIGNATURE-----

--Sig_/CRYrN=XD6G0mVc67TMvLduU--
