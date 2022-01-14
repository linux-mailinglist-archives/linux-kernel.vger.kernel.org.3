Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72948E31A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiANDzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiANDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:55:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C96C061574;
        Thu, 13 Jan 2022 19:55:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZnWC41nHz4y41;
        Fri, 14 Jan 2022 14:55:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642132504;
        bh=BZ85gLUvG6wjbkgOQH1+/8R492GOSo+QwVWunA51UnM=;
        h=Date:From:To:Cc:Subject:From;
        b=tfh1PuIHxRiGhzrA1AYWg1OPF+KLi5b3DQKKsnvgCUpq1JCfoGWW/CMkUFkR9tua5
         nli4iidlOsi0GZ/QTqLUfdK4FHtpeJRtLlAl7sa74TpmvEh9FFeZJ4GvGed+p5PWrQ
         kQIGPsu8xjZ2m4f0OjULGr2+4/DyKnh7B169Tge8uKfEQhQVcCpivl+4O4KR0WM9kB
         NAwE4/xCSgGL3Brn9Bh1QUbcURbdt9HkANdEImogOhsIinUm5D1SmdOYq7EGAwFz6n
         4oPER/C5tI1W8dvmdxzW7mdv6qVYBGgDK+aVNSO0WVZ/sDZYt8GupeGz2ZXEwMmg1B
         rwi2JB6xwb8CA==
Date:   Fri, 14 Jan 2022 14:55:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Venky Shankar <vshankar@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the ceph
 tree
Message-ID: <20220114145502.2ab21d46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qe4WlyxvoIBmtgUwLrC0XgN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qe4WlyxvoIBmtgUwLrC0XgN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got conflicts in:

  include/linux/ceph/libceph.h
  net/ceph/ceph_common.c

between commit:

  4153c7fc937a ("libceph: rename parse_fsid() to ceph_parse_fsid() and expo=
rt")

from the ceph tree and commit:

  f9126de5849a ("mm: allow !GFP_KERNEL allocations for kvmalloc")

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

diff --cc include/linux/ceph/libceph.h
index 644f224eccf7,309acbcb5a8a..000000000000
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@@ -295,8 -295,6 +295,7 @@@ extern bool libceph_compatible(void *da
 =20
  extern const char *ceph_msg_type_name(int type);
  extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *=
fsid);
- extern void *ceph_kvmalloc(size_t size, gfp_t flags);
 +extern int ceph_parse_fsid(const char *str, struct ceph_fsid *fsid);
 =20
  struct fs_parameter;
  struct fc_log;
diff --cc net/ceph/ceph_common.c
index decae43b4262,9441b4a4912b..000000000000
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@@ -190,34 -190,7 +190,7 @@@ int ceph_compare_options(struct ceph_op
  }
  EXPORT_SYMBOL(ceph_compare_options);
 =20
- /*
-  * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
-  * compatible with (a superset of) GFP_KERNEL.  This is because while the
-  * actual pages are allocated with the specified flags, the page table pa=
ges
-  * are always allocated with GFP_KERNEL.
-  *
-  * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
-  */
- void *ceph_kvmalloc(size_t size, gfp_t flags)
- {
- 	void *p;
-=20
- 	if ((flags & (__GFP_IO | __GFP_FS)) =3D=3D (__GFP_IO | __GFP_FS)) {
- 		p =3D kvmalloc(size, flags);
- 	} else if ((flags & (__GFP_IO | __GFP_FS)) =3D=3D __GFP_IO) {
- 		unsigned int nofs_flag =3D memalloc_nofs_save();
- 		p =3D kvmalloc(size, GFP_KERNEL);
- 		memalloc_nofs_restore(nofs_flag);
- 	} else {
- 		unsigned int noio_flag =3D memalloc_noio_save();
- 		p =3D kvmalloc(size, GFP_KERNEL);
- 		memalloc_noio_restore(noio_flag);
- 	}
-=20
- 	return p;
- }
-=20
 -static int parse_fsid(const char *str, struct ceph_fsid *fsid)
 +int ceph_parse_fsid(const char *str, struct ceph_fsid *fsid)
  {
  	int i =3D 0;
  	char tmp[3];

--Sig_/qe4WlyxvoIBmtgUwLrC0XgN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHg9BYACgkQAVBC80lX
0GwMtwf+IS1cxkePZovNYrJnpW484aNA5KSJ5ldHkuxOOZ1rvizijMF62EVSPCbV
orQzKGJEEPkx5kQxa82OaEpmgdkQAKcBOect/dIMmseQXxNeK274rjOpo9R/W5oR
YfecncZdBdPgVY50S+6shBSeb6BoA+GJLIzlpt8P12cUwmA6GDGoAdfHL6sRKA4E
ILLBLOrnPeUbb25PrhX4G8CvhTS3XJlPoP8XkYzZhIRE2k/tGmzZe8K7Eu0InBBe
FkGIjAB5HPPiSQIcC7yu/HjJgrHMd77iRnhTe2OilMLP5IA025Ao/63O8OAmyNzP
O8r1txiTA+Vx3CIKG8GkYzbygCaN0A==
=EUII
-----END PGP SIGNATURE-----

--Sig_/qe4WlyxvoIBmtgUwLrC0XgN--
