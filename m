Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36164C61BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiB1DSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiB1DSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:18:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC6029CB5;
        Sun, 27 Feb 2022 19:18:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6QYc4T1lz4xcZ;
        Mon, 28 Feb 2022 14:17:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646018280;
        bh=lvFotgi2nbWrax1SqwtUR3EuEokM47rQLD5f0//Rv2s=;
        h=Date:From:To:Cc:Subject:From;
        b=hAFB+X+e835Rluh1PCYMjeKlXa/xFFQho/aRuOCh/Ft9eO8h1U7YsEC3JG0zeZcj+
         XLkBdPIBu8qKbJQWJokqNTZZXwaJjmJproOQIwFY52YUdJ6DwaQQMANzSmVF/moDvu
         KwOCIhLMHtBeiVR0GG91aa4dvb3wXSFyz1zzrDJauNpH51BrWoHCmFSRuC8YLlGv4N
         ObVxiZgYcos9DbH32+GJK4Lp8RxZwbAcTFvnx50S36MR2SQbEScddINI1zltBs7LVa
         tCLwXgV4xdQocvbG34ypz8luc9kIYBChpbHjJE8D6oHBgi8MN7Ve2kGLwhFn4cYBUB
         pKllH0/W//UZw==
Date:   Mon, 28 Feb 2022 14:17:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Leslie Shi <Yuliang.Shi@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tomohito Esaki <etom@igel.co.jp>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20220228141752.6a80abf6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2XtXidRlKSt0ljo5KkyPRnb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2XtXidRlKSt0ljo5KkyPRnb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c

between commit:

  e2b993302f40 ("drm/amdgpu: bypass tiling flag check in virtual display ca=
se (v2)")

from Linus' tree and commit:

  2af104290da5 ("drm: introduce fb_modifiers_not_supported flag in mode_con=
fig")

from the drm tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c4387b38229c,9e5fc4cdb8ec..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@@ -1141,7 -1148,7 +1148,8 @@@ int amdgpu_display_framebuffer_init(str
  	if (ret)
  		return ret;
 =20
- 	if (!dev->mode_config.allow_fb_modifiers && !adev->enable_virtual_displa=
y) {
 -	if (dev->mode_config.fb_modifiers_not_supported) {
++	if (dev->mode_config.fb_modifiers_not_supported &&
++	    !adev->enable_virtual_display) {
  		drm_WARN_ONCE(dev, adev->family >=3D AMDGPU_FAMILY_AI,
  			      "GFX9+ requires FB check based on format modifier\n");
  		ret =3D check_tiling_flags_gfx6(rfb);

--Sig_/2XtXidRlKSt0ljo5KkyPRnb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcPuAACgkQAVBC80lX
0GyLbAf/Rbr/jGbxNq2x31e5B1z3s0FJHWa2kxEMBw0Eon3w3d1HszcHsQWDP2Qw
1ErgbxMtAEl2Ii2NUke+vacfmPKbMgaqfZdDVtOYZBVT1rD/QvnUOLvQZuOOVOIG
GKOvcuOlpTVH6xeb6GW55A8bcwRi3mU5rWfs/KYIe2u/CLH+Ah2ErSbZ9JtiZI9b
qJyCysTpUh28HQnPeqqeQzqAhtCUpX07ELST1inOdc+HIk8qqUfdAofLlJboeNVJ
X7iWhLZMmTWSW15XzKyXuCk1aBhEadnczHe7Newj960xXLeqz9vyRNfufhQnTJmc
zW7MXzVCVFQLN31yOudclauUGXVK3w==
=r7RX
-----END PGP SIGNATURE-----

--Sig_/2XtXidRlKSt0ljo5KkyPRnb--
