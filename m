Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA6A49A8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320608AbiAYDNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:13:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55213 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1317576AbiAYDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:02:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjWqL1B89z4yCK;
        Tue, 25 Jan 2022 14:02:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643079743;
        bh=TvDJrkrqUKutpB4iDmLWYqvoeUHMikzPzXuaP881VMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BQXNgbl3V8MHe/t7kUpggFKVC1K56HQMdvb4uOvYomfBBIZ8hCHn8oshvVkdpKddu
         3ThCOsmvhkWPBvdkqtoMZdCN9l3FKDJY9R9lawxMMDrSy5SF0F0qdRsznvHPfC+p/+
         dlfgL6qRIcIObUxxG3FrS38YsRKV+RuGe4AZp7VaFxokRq6zdERcGe1XqqRpeCervG
         z2FvIgTbuYCEYIsrWL/ycQ1ci9WyxH1Hbnc0Asp+3FWZgXVQK9YNI58B6a6mOeE0Uz
         02hH01pl+BGDZ85nPM2lhxZ8264/elWKItJJQ8ZiUxSiSpPmSfgy1SEZwIeqz+px4x
         ef1ZZAulYjquA==
Date:   Tue, 25 Jan 2022 14:02:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125140221.5c1f4640@canb.auug.org.au>
In-Reply-To: <20220125135546.1a2e1d6b@canb.auug.org.au>
References: <20220125135546.1a2e1d6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cnjjE1VOxX+DM8Z37u7_5St";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cnjjE1VOxX+DM8Z37u7_5St
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jan 2022 13:55:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the kspp tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> drivers/gpu/drm/kmb/kmb_plane.c: In function 'kmb_plane_atomic_disable':
> drivers/gpu/drm/kmb/kmb_plane.c:165:34: error: array subscript 3 is above=
 array bounds of 'struct layer_status[2]' [-Werror=3Darray-bounds]
>   165 |                 kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL2=
_ENABLE;
>       |                 ~~~~~~~~~~~~~~~~~^~~~~~~~~~
> In file included from drivers/gpu/drm/kmb/kmb_plane.c:17:
> drivers/gpu/drm/kmb/kmb_drv.h:61:41: note: while referencing 'plane_statu=
s'
>    61 |         struct layer_status             plane_status[KMB_MAX_PLAN=
ES];
>       |                                         ^~~~~~~~~~~~
> drivers/gpu/drm/kmb/kmb_plane.c:162:34: error: array subscript 2 is above=
 array bounds of 'struct layer_status[2]' [-Werror=3Darray-bounds]
>   162 |                 kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL1=
_ENABLE;
>       |                 ~~~~~~~~~~~~~~~~~^~~~~~~~~~
> In file included from drivers/gpu/drm/kmb/kmb_plane.c:17:
> drivers/gpu/drm/kmb/kmb_drv.h:61:41: note: while referencing 'plane_statu=
s'
>    61 |         struct layer_status             plane_status[KMB_MAX_PLAN=
ES];
>       |                                         ^~~~~~~~~~~~
>=20
> Exposed by commit
>=20
>   4ba545781e20 ("Makefile: Enable -Warray-bounds")
>=20
> Originally introduced by commmit
>=20
>   7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
>=20
> Maybe should have been fixed by
>=20
>   c026565fe9be ("drm/kmb: Enable alpha blended second plane")
>=20
> I have applied the following hack for now.

Actually, this one:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jan 2022 13:45:26 +1100
Subject: [PATCH] hack for building with -Warray-bounds

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plan=
e.c
index 00404ba4126d..b54197920712 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -158,12 +158,14 @@ static void kmb_plane_atomic_disable(struct drm_plane=
 *plane,
 	case LAYER_1:
 		kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_VL2_ENABLE;
 		break;
+#if 0
 	case LAYER_2:
 		kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL1_ENABLE;
 		break;
 	case LAYER_3:
 		kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL2_ENABLE;
 		break;
+#endif
 	}
=20
 	kmb->plane_status[plane_id].disable =3D true;
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/cnjjE1VOxX+DM8Z37u7_5St
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvaD0ACgkQAVBC80lX
0GzIlwf/YbfmBUupjdnZLXT6He7H2h+ikh6AHDDlE5lgPdRvOoZUPh0rYidLl5gG
taH43NaDTc1z8mth7cQafT3S/r8K0+499FC1lKFmI4AeGj61DJg9hiyBRZvjuKvA
IYb9TV1Ba/3SMFG4PE1w8uMlW3VPvUXXhp/AkX4u6/S+vgPr6DzyC63uv1dD5F9a
XVAO9c72Xua/Z0wMVadKsjd7jsXgxl+XyQqZLPumAi1fOixvXb8Z3y03Xp0qjvHx
AH89s9PVfD9NAdwnTt755ankalaqeT+YDWg5ytK6xX3X3P8GPy/6tgFRN+hWBai5
TZ8d+WOMJ8DTYUQqkMOA/5MBmeAMWQ==
=KboG
-----END PGP SIGNATURE-----

--Sig_/cnjjE1VOxX+DM8Z37u7_5St--
