Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1470648F2FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiANXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:25:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:39949 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:25:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JbHTC5KhSz4y4c;
        Sat, 15 Jan 2022 10:25:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642202704;
        bh=S/xwmXo/YzNqKT1dwiPfnnu5ocUbhfK0VxfOdQ8giZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b04M5qQ1qTlQhTuqPg2XqdfNG0hjq0I+Wf0WS4gOspi/P/Km8dwqJ4NtRSyJLYoub
         A/kM2NnBlZ29JDHK4oJYcUNhS+gQaYoD1t3l7/lneBGytCMnamKDwdVESCciMnhnNQ
         ghgV4o/0Aq4+4HwXLYESywT2yFHI+5wvXCvTWx70/JSondJGZUCMkTiKQZuCC5DEyx
         CUohffCiD6m2YT+JVALePJKmR++CpEdbgBCnyLq1Sb9bbwMDTURRdmJ8xKZ+/vHVH2
         LsvaXJ0LPUKo4/Pkaa99U+gW7ZaRyP0gHvh9SWISCgtFSg97vVuW4Nuk1U+kuMWyVe
         klZG6JrXlB1jw==
Date:   Sat, 15 Jan 2022 10:25:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220115102501.70c416c9@canb.auug.org.au>
In-Reply-To: <20220114113639.2e2cc115@canb.auug.org.au>
References: <20220114113639.2e2cc115@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wm9tp1.NuXUDN8CqDkuqvwl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wm9tp1.NuXUDN8CqDkuqvwl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 14 Jan 2022 11:36:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'program_=
timing_sync':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1409:17: error: 'struc=
t dc_config' has no member named 'use_pipe_ctx_sync_logic'
>  1409 |   if (dc->config.use_pipe_ctx_sync_logic) {
>       |                 ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1412:20: error: 'struc=
t pipe_ctx' has no member named 'pipe_idx_syncd'
>  1412 |     if (pipe_set[j]->pipe_idx_syncd =3D=3D pipe_set[0]->pipe_idx_=
syncd) {
>       |                    ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1412:51: error: 'struc=
t pipe_ctx' has no member named 'pipe_idx_syncd'
>  1412 |     if (pipe_set[j]->pipe_idx_syncd =3D=3D pipe_set[0]->pipe_idx_=
syncd) {
>       |                                                   ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1418:17: error: 'struc=
t pipe_ctx' has no member named 'pipe_idx_syncd'
>  1418 |      pipe_set[j]->pipe_idx_syncd =3D pipe_set[0]->pipe_idx_syncd;
>       |                 ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1418:47: error: 'struc=
t pipe_ctx' has no member named 'pipe_idx_syncd'
>  1418 |      pipe_set[j]->pipe_idx_syncd =3D pipe_set[0]->pipe_idx_syncd;
>       |                                               ^~
>=20
> Caused by git doing a bad automatic merge with Linus' tree because commit
>=20
>   75b950ef6166 ("Revert "drm/amd/display: Fix for otg synchronization log=
ic"")
>=20
> has been cherry-picked into the amdgpu tree and then a fixed version of
> the reverted commit applied on top.  It would be easier if just a
> fix up for the oriingal commit was added to the amdgpu tree, or Linus'
> tree was merged into the amdgpu tree and then the fixed version applied.
>=20
> I have used the amdgpu tree from next-20220113 for today.

This is what I have had to apply as a merge fix up to make this work:

(This is basically all the files that were not changed by the revert and
fix pair of patches)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 15 Jan 2022 10:01:47 +1100
Subject: [PATCH] fix up for bad merge due to cherry-picked and fixed commit

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  8 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 5 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index d4ff6cc6b8d9..b3912ff9dc91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3217,6 +3217,60 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link=
_enc_for_det_lt(
 }
 #endif
=20
+void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
+
+	/* If pipe backend is reset, need to reset pipe syncd status */
+	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_old =3D	&dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx =3D &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream ||
+				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
+
+			/* Reset all the syncd pipes from the disabled pipe */
+			for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
+				pipe_ctx_syncd =3D &context->res_ctx.pipe_ctx[j];
+				if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) =3D=3D pipe_ctx_old->pip=
e_idx) ||
+					!IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
+					SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
+			}
+		}
+	}
+}
+
+void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
+	struct dc_state *context,
+	uint8_t disabled_master_pipe_idx)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
+
+	pipe_ctx =3D &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
+	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) !=3D disabled_master_pipe_idx) ||
+		!IS_PIPE_SYNCD_VALID(pipe_ctx))
+		SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
+
+	/* for the pipe disabled, check if any slave pipe exists and assert */
+	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_check =3D &context->res_ctx.pipe_ctx[i];
+
+		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) =3D=3D disabled_master_pip=
e_idx) &&
+			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i !=3D disabled_master_pipe_idx=
))
+			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%=
d]\n",
+				i, disabled_master_pipe_idx);
+	}
+}
+
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmit=
ter transmitter)
 {
 	/* TODO - get transmitter to phy idx mapping from DMUB */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index da2c78ce14d6..288e7b01f561 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -344,6 +344,7 @@ struct dc_config {
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
+	bool use_pipe_ctx_sync_logic;
 };
=20
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 78192ecba102..f1593186e964 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1566,6 +1566,10 @@ static enum dc_status apply_single_controller_ctx_to=
_hw(
 				&pipe_ctx->stream->audio_info);
 	}
=20
+	/* make sure no pipes syncd to the pipe being enabled */
+	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use=
_pipe_ctx_sync_logic)
+		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_i=
dx);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
@@ -2297,6 +2301,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 	enum dc_status status;
 	int i;
=20
+	/* reset syncd pipes from disabled pipes */
+	if (dc->config.use_pipe_ctx_sync_logic)
+		reset_syncd_pipes_from_disabled_pipes(dc, context);
+
 	/* Reset old context */
 	/* look up the targets that have been removed since last commit */
 	hws->funcs.reset_hw_ctx_wrap(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 42ed47e8133d..8d64187478e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2260,6 +2260,9 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg =3D 0;
 	dc->caps.color.mpc.ocsc =3D 1;
=20
+	/* Use pipe context based otg sync logic */
+	dc->config.use_pipe_ctx_sync_logic =3D true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/=
drm/amd/display/dc/inc/core_types.h
index 890280026e69..943240e2809e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -382,6 +382,7 @@ struct pipe_ctx {
 	struct pll_settings pll_settings;
=20
 	uint8_t pipe_idx;
+	uint8_t pipe_idx_syncd;
=20
 	struct pipe_ctx *top_pipe;
 	struct pipe_ctx *bottom_pipe;
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/Wm9tp1.NuXUDN8CqDkuqvwl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHiBk0ACgkQAVBC80lX
0Gwh3wf8DAF2beKH8ziM7h4VnNDLAaZRKMdKHJgH0h15seqdY9D3QmO/J85d3q7e
zUuBH3JX+VqslfjyQVBGJdhbcGL7bbb76Skpf3D5Ydpc9ou3iAEYU3NpQwDw2sXG
8jj9rY7DoLaO5uq6+JL1P+j57iaiO2DjgP1qj0TKHBksGN+uPlxE+Wd1hA/jDbi2
5nnhyft/DgYXtB7VQYPa/PPBXysuAPilBwU1/DYl/GlaFht2PY5imG0FhBiLJQxO
uxC/os7CmuDGIVfvAP3lolG3g80vbI+xonGCp91l6UwfH8p3MRFb/JJkvAFpyk5/
fkMhk8helTujmFeQVYNqd3adtKK3hw==
=lSH3
-----END PGP SIGNATURE-----

--Sig_/Wm9tp1.NuXUDN8CqDkuqvwl--
