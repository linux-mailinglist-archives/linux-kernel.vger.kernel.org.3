Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337F4FEBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiDMABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiDMABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 20:01:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D2E8B;
        Tue, 12 Apr 2022 16:58:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdN3P06Bpz4xLS;
        Wed, 13 Apr 2022 09:58:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649807926;
        bh=N4ZZVzzJnuy2Fd5DnetN+QoAuNBpC4fqq9B/ON6XDss=;
        h=Date:From:To:Cc:Subject:From;
        b=RApYBQnwO0JN9ghEAv0MjzcGT+TyirKBgVEYp5QFsH1n7Ysph1iIW4JQ5/fp7SUx8
         Mv1MDntFKn6erHvCS/GjJo2O0ox9Tv+RSCZY9OS4PxyMBFQGJXmrbTYKXJWn4BfrnR
         sKD3HZaBoDu7cOHF77fPhWdmd+TUztVWFQ7bWhUzLR/UYTvo7LN4ep/rQF5dtjjk5I
         aMyRa3c9TrMhO8jzRwRyQ3Agi3KXgBtw6B93E6JrRuJ8kGXX7cqtrbwHid90PxQ6Pt
         KMHuvH6VDutlkb88pNDONhj2tFgRi0g8NrWxWeiOdBo4ysXTcNhuvW6lffsMYdJ5co
         U8X7wPcn6c6IQ==
Date:   Wed, 13 Apr 2022 09:58:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Clark <robdclark@chromium.org>,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: linux-next: manual merge of the drm-msm tree with Linus' tree
Message-ID: <20220413095840.4eadca71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.ZsaRiRwDAwSteSkmx6B1WN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.ZsaRiRwDAwSteSkmx6B1WN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c

between commit:

  c228cb343a6d ("drm/msm/mdp5: Remove redundant zpos initialisation")

from Linus' tree and commit:

  047ae6655777 ("drm/msm/mdp5: check the return of kzalloc()")

from the drm-msm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 1ee824600995,85ef10b888e9..000000000000
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@@ -98,7 -91,17 +98,11 @@@ static void mdp5_plane_reset(struct drm
  		__drm_atomic_helper_plane_destroy_state(plane->state);
 =20
  	kfree(to_mdp5_plane_state(plane->state));
+ 	plane->state =3D NULL;
  	mdp5_state =3D kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
+ 	if (!mdp5_state)
+ 		return;
+=20
 -	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY)
 -		mdp5_state->base.zpos =3D STAGE_BASE;
 -	else
 -		mdp5_state->base.zpos =3D STAGE0 + drm_plane_index(plane);
 -	mdp5_state->base.normalized_zpos =3D mdp5_state->base.zpos;
 -
  	__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
  }
 =20

--Sig_/.ZsaRiRwDAwSteSkmx6B1WN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJWEjAACgkQAVBC80lX
0Gx6Nwf+JkSd7c0YQ8aYHHYe7bXqq7Pq+hYyrYK5OWLWGfk3RGJ2+TjtiHiQ5oyq
bv15GlnKI5D9/i10BRfn74MtQEQYcuH9fF4RUAOLlrKTqB+u6BCTGcA2L02n3T7b
GMwRD6tuXofy/LFkrkFK26IMIZRq3oJXeQdyVZhqBa3CvCHvxmdjgxWBMwAs+lYZ
uzTnpMqlCQV7r4HcLf2Ws49XUYGq+ApYJt/QB7BRPBfrNB/K5GsrI7o29041GGP+
zFimaYwDK5iWbJIi/jusL+6DEhGk4mde8o2jkKStP1KBLU7nX3yUWjOUnsYKdmxw
jSzIZllDKAtRhPzqBXTLBS2NQAdyZw==
=eRl3
-----END PGP SIGNATURE-----

--Sig_/.ZsaRiRwDAwSteSkmx6B1WN--
