Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C248FF61
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiAPV5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiAPV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:57:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398CC061574;
        Sun, 16 Jan 2022 13:57:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcTQh58kPz4y4B;
        Mon, 17 Jan 2022 08:57:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642370221;
        bh=+44FdQ9yi9zlm/WpV+A+PqUF4BuStBMbD1wHprju17I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GP1GT6Z6Iqws/tc1gWnUKafWEhVCxauPyw7qgvFz8FAkKCwnjYqPuo3O7KPd2f0Jj
         SeY03uei+iFHMlGM9BQQ1wAohyP9lehSTSc1/9nb4uwX+u1Kbk1Mzs6peFmANoxRO6
         VVxyzeJklmJc9WxQLDxF8Hd1lz1qhsBoVkeoYtGVxqq4yTFGEsypZsxO+kJxZs/rIK
         CL5UH91ZDRifRPFnuGyl88IRIxC9wnNzdrJTGsj5jzr6GGW+sxLX0HpffYGp3XHkhn
         SZOZXduXHYtNtX5h1eh12uRqmIi9cqtBWfg9nka9g6El2z6H0wVmEM/Sj+ZEAwbrkE
         hY+mcgn3kVpmA==
Date:   Mon, 17 Jan 2022 08:57:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Venky Shankar <vshankar@redhat.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the ceph
 tree
Message-ID: <20220117085700.389949a8@canb.auug.org.au>
In-Reply-To: <20220114145502.2ab21d46@canb.auug.org.au>
References: <20220114145502.2ab21d46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+g05TpvkkHvSzhVKHgXFjii";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+g05TpvkkHvSzhVKHgXFjii
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 14 Jan 2022 14:55:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got conflicts in:
>=20
>   include/linux/ceph/libceph.h
>   net/ceph/ceph_common.c
>=20
> between commit:
>=20
>   4153c7fc937a ("libceph: rename parse_fsid() to ceph_parse_fsid() and ex=
port")
>=20
> from the ceph tree and commit:
>=20
>   f9126de5849a ("mm: allow !GFP_KERNEL allocations for kvmalloc")
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
>=20
> diff --cc include/linux/ceph/libceph.h
> index 644f224eccf7,309acbcb5a8a..000000000000
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@@ -295,8 -295,6 +295,7 @@@ extern bool libceph_compatible(void *da
>  =20
>   extern const char *ceph_msg_type_name(int type);
>   extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid=
 *fsid);
> - extern void *ceph_kvmalloc(size_t size, gfp_t flags);
>  +extern int ceph_parse_fsid(const char *str, struct ceph_fsid *fsid);
>  =20
>   struct fs_parameter;
>   struct fc_log;
> diff --cc net/ceph/ceph_common.c
> index decae43b4262,9441b4a4912b..000000000000
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@@ -190,34 -190,7 +190,7 @@@ int ceph_compare_options(struct ceph_op
>   }
>   EXPORT_SYMBOL(ceph_compare_options);
>  =20
> - /*
> -  * kvmalloc() doesn't fall back to the vmalloc allocator unless flags a=
re
> -  * compatible with (a superset of) GFP_KERNEL.  This is because while t=
he
> -  * actual pages are allocated with the specified flags, the page table =
pages
> -  * are always allocated with GFP_KERNEL.
> -  *
> -  * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
> -  */
> - void *ceph_kvmalloc(size_t size, gfp_t flags)
> - {
> - 	void *p;
> -=20
> - 	if ((flags & (__GFP_IO | __GFP_FS)) =3D=3D (__GFP_IO | __GFP_FS)) {
> - 		p =3D kvmalloc(size, flags);
> - 	} else if ((flags & (__GFP_IO | __GFP_FS)) =3D=3D __GFP_IO) {
> - 		unsigned int nofs_flag =3D memalloc_nofs_save();
> - 		p =3D kvmalloc(size, GFP_KERNEL);
> - 		memalloc_nofs_restore(nofs_flag);
> - 	} else {
> - 		unsigned int noio_flag =3D memalloc_noio_save();
> - 		p =3D kvmalloc(size, GFP_KERNEL);
> - 		memalloc_noio_restore(noio_flag);
> - 	}
> -=20
> - 	return p;
> - }
> -=20
>  -static int parse_fsid(const char *str, struct ceph_fsid *fsid)
>  +int ceph_parse_fsid(const char *str, struct ceph_fsid *fsid)
>   {
>   	int i =3D 0;
>   	char tmp[3];

This is now a conflict between the ceph tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+g05TpvkkHvSzhVKHgXFjii
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHklKwACgkQAVBC80lX
0GwQ7wgAiISglzpGUpBWS07YF4AiK9msJDK0BTTIYUvv8dPYytmjEubZ5wUWBVcA
AC+bIjz7I5401hLuO+k7aperW4K1KHl8/lUUEa1YrexNOu1ZZ1NrXchWc7xnkPyl
rp9Lq4d2ItDZT0MA6/U7Rboh90hNaA67YElyFWZfWI2ebwJEpuVvNmZKIJdijKTJ
kGne2Lxr0s3a8r4trS/xtDWfh2AyJEKPjaILr88agA8VBdskZ4XcanmpZcEamKjO
4hVY740Kk7+0QaZs3WczZUxgxM67LELapctHorNMlXblcgqVmMsHFDN3FMVx/2br
GQ09gwLUZinvffdPjCw/oaBz0zOwcQ==
=kwAz
-----END PGP SIGNATURE-----

--Sig_/+g05TpvkkHvSzhVKHgXFjii--
