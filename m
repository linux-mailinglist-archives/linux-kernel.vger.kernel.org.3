Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A649A8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320264AbiAYDMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:12:13 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:45491 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiAYC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:56:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjWgr67Z3z4y7S;
        Tue, 25 Jan 2022 13:55:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643079355;
        bh=exfOBrNGIq18HB9bpbg5tO06O42Lp4/sVUlZzo7SeNc=;
        h=Date:From:To:Cc:Subject:From;
        b=W7k5uazm+p1A9H6KRBm5c9OJP2/bU55qmgAbohHKdtPzWBfB6cX39goZyjzRxtQX8
         vD5Vv04G2flS6FcQaS0nd8qjTgmEBUp/vdnAQ9BAq5dPeg9/Cu1i9BtaGfz2q/sWD3
         QRi4770hsK2puISXNjZGspRzKXr72sKHtOqc6va/MYBCHtF/5up5OusqH0Jsli8wVc
         H7pW8oU6Zcs4xUOEGB78gZNwvNAnNijV+gqoYBNCcxwAtLvqxjG18vkrKPlpqCwUUv
         4TeNvUPE5jCc9ZZYdHlDY3zToT1ZH1HrGBVl74a37zZnlcyxp4za9E22C/YZNc6A0r
         o1YjAByTuLsaw==
Date:   Tue, 25 Jan 2022 13:55:46 +1100
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
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125135546.1a2e1d6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nrM2XqSEID89HGMexxVxPDt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nrM2XqSEID89HGMexxVxPDt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/kmb/kmb_plane.c: In function 'kmb_plane_atomic_disable':
drivers/gpu/drm/kmb/kmb_plane.c:165:34: error: array subscript 3 is above a=
rray bounds of 'struct layer_status[2]' [-Werror=3Darray-bounds]
  165 |                 kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL2_E=
NABLE;
      |                 ~~~~~~~~~~~~~~~~~^~~~~~~~~~
In file included from drivers/gpu/drm/kmb/kmb_plane.c:17:
drivers/gpu/drm/kmb/kmb_drv.h:61:41: note: while referencing 'plane_status'
   61 |         struct layer_status             plane_status[KMB_MAX_PLANES=
];
      |                                         ^~~~~~~~~~~~
drivers/gpu/drm/kmb/kmb_plane.c:162:34: error: array subscript 2 is above a=
rray bounds of 'struct layer_status[2]' [-Werror=3Darray-bounds]
  162 |                 kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL1_E=
NABLE;
      |                 ~~~~~~~~~~~~~~~~~^~~~~~~~~~
In file included from drivers/gpu/drm/kmb/kmb_plane.c:17:
drivers/gpu/drm/kmb/kmb_drv.h:61:41: note: while referencing 'plane_status'
   61 |         struct layer_status             plane_status[KMB_MAX_PLANES=
];
      |                                         ^~~~~~~~~~~~

Exposed by commit

  4ba545781e20 ("Makefile: Enable -Warray-bounds")

Originally introduced by commmit

  7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")

Maybe should have been fixed by

  c026565fe9be ("drm/kmb: Enable alpha blended second plane")

I have applied the following hack for now.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jan 2022 13:45:26 +1100
Subject: [PATCH] hack for building with -Warray-bounds

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plan=
e.c
index 00404ba4126d..c12e900c6c93 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -161,9 +161,11 @@ static void kmb_plane_atomic_disable(struct drm_plane =
*plane,
 	case LAYER_2:
 		kmb->plane_status[plane_id].ctrl =3D LCD_CTRL_GL1_ENABLE;
 		break;
+#if 0
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

--Sig_/nrM2XqSEID89HGMexxVxPDt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvZrIACgkQAVBC80lX
0Gxj6gf/ZKsSyaOBUb43GfeYY9eBBKNOBDJcX1eTPHcB9bK6bcGRWWXMviVjIOJU
IZ4U07Wd0ytcz1CSbOEATioVlukDAjwKt4ZXgdBAR5/+JNIn+M6WLTGqXJly3izc
MfuXgQAzDN+Q+Drt+vL/hcSXlq/O26egplrB/mww0j48pCt2FPvf2gona+mVtMol
OhLIEH6olM3HGUYAx5cnhuMfDs8UpA+4tMfYZkkP2bzpiDy8zC2mzByFFPR2NcbF
2L/uqM4IcsnVb67egQ8ViXOtL9ak5dEZG/MFmvkyWm5XOsP9CuukHMxatcD9J0+F
wTRKnfvQx95m3nONtNW+meNeKKz+TQ==
=uTQR
-----END PGP SIGNATURE-----

--Sig_/nrM2XqSEID89HGMexxVxPDt--
