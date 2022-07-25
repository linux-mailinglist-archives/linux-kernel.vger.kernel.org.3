Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2F57FE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiGYLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGYLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:16:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD5A462;
        Mon, 25 Jul 2022 04:16:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LryCf6cwnz4x1c;
        Mon, 25 Jul 2022 21:16:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658747775;
        bh=os6g/YgnmlK/C/Z8Fjj6oNNrjzfPn11eWgMm5uHJVWw=;
        h=Date:From:To:Cc:Subject:From;
        b=P243hvK9e4eZtLes7osp71Ue6sDylj/Bxv11z6hnNBg6tk261LslpEdrPXMK27Ehc
         dQnRxDniKJr2zsTjtjFN7GlGD6/rbyKeq2yxuDNLWwEucvnPjPRTI17Je2IUw744YD
         07pfjLP2n9Ik2L9KbHehH7sb6umhBq8OF+3HjhcVDcFE1al3yC4zkL+XuNKdBnTYR/
         8ujgal65ID/9Hy+KVIUARWqQ6L+WBbLwLl69iQAszywDvmXpWL3JgT/1k7S1Ji7E9y
         p1406edb2O88RwEZhXMFJ5JMX3urznEqrK4zKorI+hnWPTx2AoXIUmcanbSaoYj1Tf
         FI45zSlwgUa3g==
Date:   Mon, 25 Jul 2022 21:16:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220725211612.7e3331ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QKktcAAIFJeGUdWVtcJu.G6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QKktcAAIFJeGUdWVtcJu.G6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c:297:26: er=
ror: 'amdgpu_dm_crtc_late_register' undeclared here (not in a function); di=
d you mean 'amdgpu_umc_ras_late_init'?
  297 |         .late_register =3D amdgpu_dm_crtc_late_register,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                          amdgpu_umc_ras_late_init

Caused by commit

  a6c0b96cb899 ("drm/amd/display: Create a file dedicated for CRTC")

I have applied the following hack for today (just to make it build).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 25 Jul 2022 20:48:29 +1000
Subject: [PATCH] fixup for "drm/amd/display: Create a file dedicated for CR=
TC"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 16b624828e0d..3eb6ea3709bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -293,7 +293,7 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs=
 =3D {
 	.enable_vblank =3D dm_enable_vblank,
 	.disable_vblank =3D dm_disable_vblank,
 	.get_vblank_timestamp =3D drm_crtc_vblank_helper_get_vblank_timestamp,
-#if defined(CONFIG_DEBUG_FS)
+#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 	.late_register =3D amdgpu_dm_crtc_late_register,
 #endif
 };
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/QKktcAAIFJeGUdWVtcJu.G6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLee3wACgkQAVBC80lX
0GysoQgAl203WWglwrP+OiOpXuL6r5dW8lBcrmPO59mBIGY6cwL7A0PMp6gRnEej
BjPZZ8Ni0TmkGsHXXH3ZAScxXghIjg5ll4halL5WWntmbMxRxixEkCdvLR34mfSH
iG5rNxprW20irtAJ365nRHyfc35AkRKkhe6D281q/vhQPTvk3q56oD2FuLsSvZ4p
/yzWboBOvq2qOohs87N0KiQ6iwELcQ4mK7Cu2maGs3mtyHzRAe6yyRIRPCystso7
MHDXU4jjJxdIOmkRNmJd1qvJ8esnUl3kdcfE763/V2Kzf024/XvrNUkHT3OkMDfN
oUJiKzvs5J+eMLtF7nlIL/uPQV0AuA==
=dM7T
-----END PGP SIGNATURE-----

--Sig_/QKktcAAIFJeGUdWVtcJu.G6--
