Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40CC51BC6F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354409AbiEEJvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348259AbiEEJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:51:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5075A4F470;
        Thu,  5 May 2022 02:47:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kv84Q70ndz4ySn;
        Thu,  5 May 2022 19:47:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651744039;
        bh=8K7OWDpXc0cEi6KPmmnFY0Qjde5xITIcHSPfGXDF4bQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tIORQ+VT3JqyJQLIHBemC29hvqyP9DnkrSIrLRHXPJlHrS3e/qfWMXpeVc5Kj+b+t
         wtO/B5VtgVzCWaIxMV3uYbNuLkfURE8nMJZ3VkFIFug1dSNxkC9xRtwW8Uvz5XZN17
         LYSdaJFEhFN5KQq2njF96FwsWi//okm05d0wD7F8nFDof/jxjW1TWJfpc83Q88QBrQ
         3KtbMg1fblCzMQHt1JuSFXf3dxSpMWnlFV6L4OQaH1tGUUGKJzCwO8/nAMVJZhMIQq
         dpWosw0bAMBGkerw1HAazvNM0F7S/oMar372fHF25lFT+hHBKFo3P2V+KH9R7kTz7V
         UiVHOdNCei6/Q==
Date:   Thu, 5 May 2022 19:47:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Jack Xiao <Jack.Xiao@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220505194717.065db7ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4z9Q+UDxW1c+QVT8Qsuywg7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4z9Q+UDxW1c+QVT8Qsuywg7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:26:
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c: In function 'mes_v11_0_mqd_init':
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:34: error: 'CP_HQD_PQ_CONTROL__E=
NDIAN_SWAP_MASK' undeclared (first use in this function); did you mean 'CP_=
HQD_PQ_CONTROL__PRIV_STATE_MASK'?
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro '=
REG_FIELD_MASK'
 1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
      |                                    ^~~
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:15: note: in expansion of macro =
'REG_SET_FIELD'
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:34: note: each undeclared identi=
fier is reported only once for each function it appears in
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro '=
REG_FIELD_MASK'
 1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
      |                                    ^~~
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:15: note: in expansion of macro =
'REG_SET_FIELD'
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:34: error: 'CP_HQD_PQ_CONTROL__E=
NDIAN_SWAP__SHIFT' undeclared (first use in this function); did you mean 'C=
P_HQD_PQ_CONTROL__PRIV_STATE__SHIFT'?
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro '=
REG_FIELD_SHIFT'
 1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
      |                                     ^~~
drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:697:15: note: in expansion of macro =
'REG_SET_FIELD'
  697 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |               ^~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:28:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function 'gfx_v11_0_cp_gfx_resum=
e':
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:34: error: 'CP_RB0_CNTL__BUF_SW=
AP_MASK' undeclared (first use in this function); did you mean 'CP_RB0_CNTL=
__TMZ_STATE_MASK'?
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |                                  ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro '=
REG_FIELD_MASK'
 1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
      |                                    ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:15: note: in expansion of macro=
 'REG_SET_FIELD'
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:34: note: each undeclared ident=
ifier is reported only once for each function it appears in
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |                                  ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro '=
REG_FIELD_MASK'
 1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
      |                                    ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:15: note: in expansion of macro=
 'REG_SET_FIELD'
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:34: error: 'CP_RB0_CNTL__BUF_SW=
AP__SHIFT' undeclared (first use in this function); did you mean 'CP_RB0_CN=
TL__TMZ_STATE__SHIFT'?
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |                                  ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro '=
REG_FIELD_SHIFT'
 1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
      |                                     ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:3413:15: note: in expansion of macro=
 'REG_SET_FIELD'
 3413 |         tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function 'gfx_v11_0_compute_mqd_=
init':
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4063:34: error: 'CP_HQD_PQ_CONTROL__=
ENDIAN_SWAP_MASK' undeclared (first use in this function); did you mean 'CP=
_HQD_PQ_CONTROL__PRIV_STATE_MASK'?
 4063 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1177:36: note: in definition of macro '=
REG_FIELD_MASK'
 1177 | #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
      |                                    ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4063:15: note: in expansion of macro=
 'REG_SET_FIELD'
 4063 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |               ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4063:34: error: 'CP_HQD_PQ_CONTROL__=
ENDIAN_SWAP__SHIFT' undeclared (first use in this function); did you mean '=
CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT'?
 4063 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1176:37: note: in definition of macro '=
REG_FIELD_SHIFT'
 1176 | #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
      |                                     ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4063:15: note: in expansion of macro=
 'REG_SET_FIELD'
 4063 |         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, =
1);
      |               ^~~~~~~~~~~~~

Caused by commit

  028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")

This build has __BIG_ENDIAN set.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 May 2022 19:14:25 +1000
Subject: [PATCH] mark CONFIG_DRM_AMDGPU as depending on CONFIG_CPU_LITTLE_E=
NDIAN

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e88c497fa010..2aaa9ef1168d 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -244,6 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
 config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI && MMU
+	depends on CPU_LITTLE_ENDIAN
 	select FW_LOADER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/4z9Q+UDxW1c+QVT8Qsuywg7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJznSUACgkQAVBC80lX
0Gz5HQf+MVdK1DIdSOWtEA/fkRVBGb/BMzWmQYZIqmeWUGv/LTjdhtqVdg9weslv
7VIqaRhKogZQSqBYGgG7QdIm2vKrOTYtUc5MHW8NrNgS6kbuwnMvW7jlmk7OBbNW
BUecCHsWi64gbmtINHT2Bjr8E+KGbNeu5RUzYvuS3zT9aguFPxaVmmAI58vyNt21
icNs1cZsk0gBqg8yrxnyqOTYI2Siikgircum5S8sYEfqm/Lviq4agg0lxbw5pAko
HmZEl9YHmXjXqwNEHqDl6PN3tj+BLmPNdgOYe17WUJrZ2vfB+/oYK9X74IMiQ6wR
yLq1fmCbz1rY8H0JyeoB+QTDffiWFg==
=NcuA
-----END PGP SIGNATURE-----

--Sig_/4z9Q+UDxW1c+QVT8Qsuywg7--
