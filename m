Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360FE4A55A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiBADcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:32:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50337 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiBADcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:32:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jnr8M3CB1z4xcR;
        Tue,  1 Feb 2022 14:32:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643686323;
        bh=dLU4egGGrGYk3VDw0OYY1dIcWP/b/YntjI8zp9zKwVk=;
        h=Date:From:To:Cc:Subject:From;
        b=b+ajlsECIksgd/qdanS0mh5NpDK/soVFwYnsARzCYimCtTzmaa9se9wgYfdDQN8FP
         yv4OR7MDx4Qx4MP/nnRgVcZOvNhQyzDPoIAmWRnnICKOmyROMFyiOzTN9OKPh6vVMs
         kRVtcAm0e+CBOm7cMBlCUAbnmA42MZIg9/iW0ncFK72NVdYX0VntlYvRf7PyswKtlJ
         b6PfDfQHFaJ+SWKcVSOtGbvb3nzpXkWE0z2UmPqzAw740FbZF7E7WZr+e6/fHY20kn
         PZorikMspFe0CRygVfO6NpAQJINI9fqPCDKN7u7c1nXpZUo6YUTWiq8MBDkYQUFpza
         hAgsRX4ScqYTA==
Date:   Tue, 1 Feb 2022 14:32:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220201143201.1883c3aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pNOq/2djbuHKn+iVjTpzkCB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pNOq/2djbuHKn+iVjTpzkCB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:43:
drivers/gpu/drm/amd/amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1428:87: error: expected ';' before '}'=
 token
 1428 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *a=
dev) { return false };
      |                                                                    =
                   ^~
      |                                                                    =
                   ;

(and many more)

Caused by commit

  11bc42ea179d ("drm/amd: add support to check whether the system is set to=
 s3")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 1 Feb 2022 14:24:40 +1100
Subject: [PATCH] drm/amd: fix semicolon positioning

Fixes: 11bc42ea179d ("drm/amd: add support to check whether the system is s=
et to s3")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index e61078cec072..2931c8ff4cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1425,7 +1425,7 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *a=
dev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
-static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false; }
 #endif
=20
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/pNOq/2djbuHKn+iVjTpzkCB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH4qbEACgkQAVBC80lX
0Gyc+Qf+M7NjzBBktRQBjVfIRhorQg8ipxhZBriUyqSuwIN64DOIpF2qrpwV9HPt
XZNtljcBZCcZSDf/qmk0AnoHAo6o229ZWl/7L69ReSUVp5zlcw8atxgCu2kLvlf1
/BmZ/LHrOzwFoQrBxgtz/CRlqNdAewDM5BI5dgudc5rKaMWrKRpT1Sed/q+6mlka
Aic+EaaBQC51ikPUyMLhvWPQhq3YvVVoVfLYQo14X3axBWSGTYQx2Jo2HeSZkOdm
xJ7ExNXjoS2WYSEY9GBdGrYLmapsQxy5xGc+TpgZd7kg3j3F+WJB1DBaSzuKBuZT
lr71dA8xrxNWfXtY2zW9YZNlSirIXQ==
=mE9M
-----END PGP SIGNATURE-----

--Sig_/pNOq/2djbuHKn+iVjTpzkCB--
