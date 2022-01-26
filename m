Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3549D62B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiAZXcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiAZXcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:32:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C8C06161C;
        Wed, 26 Jan 2022 15:32:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jkg4f1KSBz4xjx;
        Thu, 27 Jan 2022 10:32:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643239970;
        bh=tOSmHSdOtNXkJf6+GUgljYj3ySWdRQU3phVxD4/19Bc=;
        h=Date:From:To:Cc:Subject:From;
        b=nBba9Ey6XXD7+uAl+Pm/JZXYUp+EDp4xY24CRLopMqhd+G12o7JYn9rR4qDpjDAlV
         3a04njWsWynZssrD6E6WzXSon2H5IuixFT3acGc+nZOFMfMAy6/zK+F+LzUc+kDiJE
         gAAc3InM6cdSpi6KJuHVkqtrloi28EkszQI1Nuv7qFvd4GqvcgnhqvLpG2Evn2upOp
         xfeayvGexKoFFh0YvymRvdAt0C2D+wdUCq+BLptU4/+KGZkwrQkkmBOR4u5l+lpf7M
         mTJkJCNrW5ERvu8lPRcr31pz58z8/MzfsGkJfd/NTj7YgHfVuelAVvKh0kk1l7xbkm
         qjJ8LZbG3IDFw==
Date:   Thu, 27 Jan 2022 10:32:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wenjing Liu <wenjing.liu@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20220127103249.3daf1f60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R+vyVjYeD_uF8xR//NHPIsV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R+vyVjYeD_uF8xR//NHPIsV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c

between commit:

  75b950ef6166 ("Revert "drm/amd/display: Fix for otg synchronization logic=
"")

from Linus' tree and commit:

  d9eb8fea6862 ("drm/amd/display: Drop DCN for DP2.x logic")

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

diff --cc drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 78192ecba102,72dd41e7a7d6..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@@ -1566,7 -1527,10 +1527,6 @@@ static enum dc_status apply_single_cont
  				&pipe_ctx->stream->audio_info);
  	}
 =20
- #if defined(CONFIG_DRM_AMD_DC_DCN)
 -	/* make sure no pipes syncd to the pipe being enabled */
 -	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.us=
e_pipe_ctx_sync_logic)
 -		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_=
idx);
 -
  	/* DCN3.1 FPGA Workaround
  	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
  	 * To do so, move calling function enable_stream_timing to only be done =
AFTER calling

--Sig_/R+vyVjYeD_uF8xR//NHPIsV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHx2iEACgkQAVBC80lX
0GxWyQf/Vue3ac9+OlYEe0v4c4ykyvIRcpc9M+4C3bY7SYunuredhRehCgXsi2T/
LIHfO5L37NO9leVYHmB+FUdPOZCmP/Q2NS6G0iulYF2aYN+zeSsIwE5rqszKA5yB
pkHSSO20htCxu+55wICNUMeuCL9ivQrfvk1mkV3iQd2rr4/aXLzMrSUkxb7BaC36
roFiMC23fqEBVMW4Gja7qbKfpGU4G+qQ+7fz04ui1haVupBpZGq6dz+embRSWH1I
YjgSbSJwZvwNODYCjhdJ4ART1hBSt0m7vGQPePAIm8C5ezoo7jbzKBluZ6mjCmwO
0N/s6W6zOH6Hjtz+WzJiE3VDvP+Ebg==
=yMNg
-----END PGP SIGNATURE-----

--Sig_/R+vyVjYeD_uF8xR//NHPIsV--
