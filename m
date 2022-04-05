Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5764F20B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiDEBwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 21:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDEBws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:52:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA9386347;
        Mon,  4 Apr 2022 18:07:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXTf92gnvz4xXK;
        Tue,  5 Apr 2022 10:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649120003;
        bh=yWJj/XDly7PKBcBsIePwdijaqceEq7HoP2lgWDGUzjE=;
        h=Date:From:To:Cc:Subject:From;
        b=oZySHRRqJoqMe0goHMP66Ql+m2+0q3c8gww/7QVi+MZFoTWHqTeBgi9TpY2eRnnm6
         wp2Zn47wayZsgwnh6hqJQb7jtrfKpnEMLgANRZ1CAJlvXDF1qla1k5jjpcgM0UFMqm
         98/q8uvVAQcYMUjDwVgXpMV8uihbFemo3f3JS11wrre2Pf6dwZa5gnQoMLbzgiKmbT
         D4oybWFSxPZukv+gOxkpYc8BhDyeaCJOURTFjOL/dOMY6uD5Js/r/xKA7fKXJOh2VM
         YpqyAqNFeCda1qywMI2OHQIQSw2DY69ls+hPgCRQ01fy9p+2VzVA3uHBXMSCnxEmMp
         KUBE7+uoUPvAA==
Date:   Tue, 5 Apr 2022 10:53:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Juha-Pekka =?UTF-8?B?SGVpa2tpbMOk?= 
        <juha-pekka.heikkila@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20220405105319.2eb47e9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j==zcLUSd_ZwS9jYUrBZVK3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j==zcLUSd_ZwS9jYUrBZVK3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_pci.c

between commit:

  132aaaf01788 ("drm/i915: add needs_compact_pt flag")

from Linus' tree and commits:

  072ce4164f97 ("drm/i915/dg2: Tile 4 plane format support")
  412c942bdfae ("drm/i915/ats-m: add ATS-M platform info")

from the drm-intel tree.

I fixed it up (I think, see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/i915_pci.c
index c32c0c6661c8,8e321d300e0c..000000000000
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@@ -1040,25 -1038,35 +1040,36 @@@ static const struct intel_device_info x
  	.require_force_probe =3D 1,
  };
 =20
+ #define DG2_FEATURES \
+ 	XE_HP_FEATURES, \
+ 	XE_HPM_FEATURES, \
+ 	DGFX_FEATURES, \
+ 	.graphics.rel =3D 55, \
+ 	.media.rel =3D 55, \
+ 	PLATFORM(INTEL_DG2), \
+ 	.has_4tile =3D 1, \
+ 	.has_64k_pages =3D 1, \
++	.needs_compact_pt =3D 1, \
+ 	.has_guc_deprivilege =3D 1, \
+ 	.platform_engine_mask =3D \
+ 		BIT(RCS0) | BIT(BCS0) | \
+ 		BIT(VECS0) | BIT(VECS1) | \
+ 		BIT(VCS0) | BIT(VCS2)
+=20
  __maybe_unused
  static const struct intel_device_info dg2_info =3D {
- 	XE_HP_FEATURES,
- 	XE_HPM_FEATURES,
+ 	DG2_FEATURES,
  	XE_LPD_FEATURES,
- 	DGFX_FEATURES,
- 	.graphics.rel =3D 55,
- 	.media.rel =3D 55,
- 	PLATFORM(INTEL_DG2),
- 	.has_guc_deprivilege =3D 1,
- 	.has_64k_pages =3D 1,
- 	.needs_compact_pt =3D 1,
- 	.platform_engine_mask =3D
- 		BIT(RCS0) | BIT(BCS0) |
- 		BIT(VECS0) | BIT(VECS1) |
- 		BIT(VCS0) | BIT(VCS2),
- 	.require_force_probe =3D 1,
  	.display.cpu_transcoder_mask =3D BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |
  			       BIT(TRANSCODER_C) | BIT(TRANSCODER_D),
+ 	.require_force_probe =3D 1,
+ };
+=20
+ __maybe_unused
+ static const struct intel_device_info ats_m_info =3D {
+ 	DG2_FEATURES,
+ 	.display =3D { 0 },
+ 	.require_force_probe =3D 1,
  };
 =20
  #undef PLATFORM

--Sig_/j==zcLUSd_ZwS9jYUrBZVK3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLkwAACgkQAVBC80lX
0GwCmwf/YLukNlv4VfvGolLJqjb0d4+V3vRIOgWor4TZgbiIvKvEI7wcYjf1Xotp
hw7jpLNt7ameGWV5+pKmYmUybFgjJJofMSI0cQaYkByRfT7Yml3Ov29TbNV3Pfu+
lSCt7asqLuubKGMfov41OxfkDtKK6aaCbAOPmO0yORo6rHVWkce1hRHSCXTfBGKX
nNrqGYiHCZud8k8V7he8P3Zf2tBqz4FJ1o5nzoKled5MT8mSux8NyFTinbDdwIAe
3hbbWcOgqQqlROVkTcjLWbDP4F4xFMUFTofnZzaS1nBRpmK+ZN3a8dbRzaP/jISD
B0q4OkRNTVifbgmONUvcm9I+VX65uw==
=R9kd
-----END PGP SIGNATURE-----

--Sig_/j==zcLUSd_ZwS9jYUrBZVK3--
