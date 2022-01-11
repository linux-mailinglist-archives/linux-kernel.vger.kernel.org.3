Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001248BB43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346744AbiAKXJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:09:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54739 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbiAKXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:09:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYRGM713Wz4y41;
        Wed, 12 Jan 2022 10:09:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641942556;
        bh=08NokgJc73R+NC0VqWdeZC2r+IFiHVxfrx3GJGjwno8=;
        h=Date:From:To:Cc:Subject:From;
        b=RKIHenyqpTWsoks/OpkzuERZSVhUjCLDg3xmG3aGR2ntnltVFvQP6GoR1jrS1cuwz
         rgebBwr7kOguO3ZBMU6br/FMNRO5FSKKtZEdEbgdSepIseyrpm19c1JPZNXMYJB1zn
         Geqsv6ANg/nTvUwivVnmA+9vfaeA0NYS07fwdWP+f+/gfcojJU8VY7ICkKHUnmeSkQ
         dA7wWPSnfeD8+koY4LzYN9NrKsHgKj1OMk8tSsHuJIuHgB6XpYulfs5fpyEQ7fxoe0
         6/f73ZjAnwquAg4OvVMzvP3g8V39sig1THZUN47tK/kwEDGLDCgUZGCROcfwuaITgy
         liH391Gy9+BHQ==
Date:   Wed, 12 Jan 2022 10:09:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wenjing Liu <wenjing.liu@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20220112100914.4354b1b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fDpdK7j5YvSYin7AlwdO6JA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fDpdK7j5YvSYin7AlwdO6JA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got conflicts in:

  drivers/gpu/drm/amd/display/dc/core/dc_resource.c
  drivers/gpu/drm/amd/display/dc/inc/resource.h

between commit:

  75b950ef6166 ("Revert "drm/amd/display: Fix for otg synchronization logic=
"")

from Linus' tree and commit:

  580013b2cef8 ("drm/amd/display: unhard code link to phy idx mapping in dc=
 link and clean up")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index de5c7d1e0267,b3912ff9dc91..000000000000
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@@ -3216,3 -3216,90 +3216,36 @@@ struct hpo_dp_link_encoder *resource_ge
  	return hpo_dp_link_enc;
  }
  #endif
+=20
 -void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 -		struct dc_state *context)
 -{
 -	int i, j;
 -	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
 -
 -	/* If pipe backend is reset, need to reset pipe syncd status */
 -	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
 -		pipe_ctx_old =3D	&dc->current_state->res_ctx.pipe_ctx[i];
 -		pipe_ctx =3D &context->res_ctx.pipe_ctx[i];
 -
 -		if (!pipe_ctx_old->stream)
 -			continue;
 -
 -		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
 -			continue;
 -
 -		if (!pipe_ctx->stream ||
 -				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
 -
 -			/* Reset all the syncd pipes from the disabled pipe */
 -			for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
 -				pipe_ctx_syncd =3D &context->res_ctx.pipe_ctx[j];
 -				if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) =3D=3D pipe_ctx_old->pi=
pe_idx) ||
 -					!IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
 -					SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
 -			}
 -		}
 -	}
 -}
 -
 -void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 -	struct dc_state *context,
 -	uint8_t disabled_master_pipe_idx)
 -{
 -	int i;
 -	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
 -
 -	pipe_ctx =3D &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
 -	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) !=3D disabled_master_pipe_idx) ||
 -		!IS_PIPE_SYNCD_VALID(pipe_ctx))
 -		SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
 -
 -	/* for the pipe disabled, check if any slave pipe exists and assert */
 -	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
 -		pipe_ctx_check =3D &context->res_ctx.pipe_ctx[i];
 -
 -		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) =3D=3D disabled_master_pi=
pe_idx) &&
 -			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i !=3D disabled_master_pipe_id=
x))
 -			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[=
%d]\n",
 -				i, disabled_master_pipe_idx);
 -	}
 -}
 -
+ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmi=
tter transmitter)
+ {
+ 	/* TODO - get transmitter to phy idx mapping from DMUB */
+ 	uint8_t phy_idx =3D transmitter - TRANSMITTER_UNIPHY_A;
+=20
+ #if defined(CONFIG_DRM_AMD_DC_DCN)
+ 	if (dc->ctx->dce_version =3D=3D DCN_VERSION_3_1 &&
+ 			dc->ctx->asic_id.hw_internal_rev =3D=3D YELLOW_CARP_B0) {
+ 		switch (transmitter) {
+ 		case TRANSMITTER_UNIPHY_A:
+ 			phy_idx =3D 0;
+ 			break;
+ 		case TRANSMITTER_UNIPHY_B:
+ 			phy_idx =3D 1;
+ 			break;
+ 		case TRANSMITTER_UNIPHY_C:
+ 			phy_idx =3D 5;
+ 			break;
+ 		case TRANSMITTER_UNIPHY_D:
+ 			phy_idx =3D 6;
+ 			break;
+ 		case TRANSMITTER_UNIPHY_E:
+ 			phy_idx =3D 4;
+ 			break;
+ 		default:
+ 			phy_idx =3D 0;
+ 			break;
+ 		}
+ 	}
+ #endif
+ 	return phy_idx;
+ }
diff --cc drivers/gpu/drm/amd/display/dc/inc/resource.h
index e589cbe67307,028180f58f71..000000000000
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@@ -208,4 -212,12 +208,6 @@@ struct hpo_dp_link_encoder *resource_ge
  		const struct dc_link *link);
  #endif
 =20
 -void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 -	struct dc_state *context);
 -
 -void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 -	struct dc_state *context,
 -	uint8_t disabled_master_pipe_idx);
+ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmi=
tter transmitter);
+=20
  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */

--Sig_/fDpdK7j5YvSYin7AlwdO6JA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHeDhoACgkQAVBC80lX
0Gx9nggAkeyfUWS2XRe4IvuNePf6t2G0m+BlFBGeZO+p/0EgJhKzqtRiNGda499m
jTqJaoik8+j0tH2SFWUP9PsgLPBtT6H07rt3RDLEZDgfWE1suyZ35uNWnjZmHRSj
ViBMt6dcQRz+g+0+IgGpjSO57KYFiX0FzctB/t70ZyZeWkSU3BdwMF+wGdXcWmEJ
V1KIibPEjzz7poMS1iyPeLhlr+Ro47KC7m4zTAuecvkVWEwLAu0yqL+nwv/fhsY1
7sLF42MSYUcZV2UZTqqEHGMwAGmEaEGf/t8UyjLsOqR2Sf9Zragw21wofIun1gBJ
CcXXLWUo0kq9LSo7B5+Wvvo9IisJxA==
=LgwU
-----END PGP SIGNATURE-----

--Sig_/fDpdK7j5YvSYin7AlwdO6JA--
