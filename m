Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C5F485D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbiAFApD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbiAFAok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:44:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F4C061245;
        Wed,  5 Jan 2022 16:44:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JTng81lQFz4xgr;
        Thu,  6 Jan 2022 11:44:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641429877;
        bh=oJEm9UZTQOdDnyKkahGUfCvqK0BBdI9KSwf46TYUum8=;
        h=Date:From:To:Cc:Subject:From;
        b=n+t403u+H0T+9aQg+/RCKC5GyQjyvqoXkPowo6PD51/OgoSldWtoOa9qdlo1+v0cZ
         n0Nz5e/tTui4dk6mLJB45BHvDT0HJieZxgWq6rNLwYGRwUpVXcSnwi+TqG+93AAZG9
         wdENWeAdX9Bt2OBvM18a2wgf8FPMEp6AjSS6v9EgbruzTtx8DCaNInRHMHhq0Cp4y5
         jIUcd45vYGWSmS4NpOCGRg9QoMWnuD2s24MPX5M8nhehv/CjxMzlU0BpEEW+DiAdIY
         fhsT9wHtUyUjsUZFN1WQbB6ewIIJFR9y3DySy6mR0BXiI9+1vQQ/oAazR2onGEQrOy
         BPFqzf5DFLAIw==
Date:   Thu, 6 Jan 2022 11:44:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20220106114434.32f9b4d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2QGUp/DJ2hcFdo8eOYsQ+c4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2QGUp/DJ2hcFdo8eOYsQ+c4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/hw/mlx5/mlx5_ib.h

between commit:

  4163cb3d1980 ("Revert "RDMA/mlx5: Fix releasing unallocated memory in der=
eg MR flow"")

from the rdma-fixes tree and commit:

  e517f76a3cb2 ("RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/mlx5_ib.h
index e636e954f6bf,b6030ef8f7af..000000000000
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@@ -664,9 -665,8 +665,9 @@@ struct mlx5_ib_mr=20
 =20
  	/* User MR data */
  	struct mlx5_cache_ent *cache_ent;
+ 	/* Everything after cache_ent is zero'd when MR allocated */
 +	struct ib_umem *umem;
 =20
- 	/* This is zero'd when the MR is allocated */
  	union {
  		/* Used only while the MR is in the cache */
  		struct {

--Sig_/2QGUp/DJ2hcFdo8eOYsQ+c4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHWO3IACgkQAVBC80lX
0GyHMQgAi48KwKu38tVFyTYCGQjPFdl/vD3nbGUNqoWNy663hzYc9/WRTsdNWg7m
iFuxP4puCrsYoreiOAEBsIOf64Zxr3IhFxwfhqhOQpt0WhKiMaQH5c3eyw48ThOx
/8pLnOWHSJKfeV0YjeXVdhR5eSFp0iJ9wpyur8ujeiuSN56S4pKdocGuD8wtKD1a
Oi9e3uB+ln56l9aHI3xxUxZBYJ2ncbpHNY7AFBN0zC1JVPkg/0NArs+EdZXVqwAi
szvn5l64xy0DJl0IEs6NONofkl8YCXmDapS9iO9rsBKe/LqUcmVTBlvLdTPgRG2A
XZ2xpKsPg9whOBc4b0WtfyjCVpH32Q==
=0qdn
-----END PGP SIGNATURE-----

--Sig_/2QGUp/DJ2hcFdo8eOYsQ+c4--
