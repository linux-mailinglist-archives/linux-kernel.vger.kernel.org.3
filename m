Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C5D51B4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiEEBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiEEBFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:05:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A14616E;
        Wed,  4 May 2022 18:01:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtwPr07YBz4xR1;
        Thu,  5 May 2022 11:01:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651712497;
        bh=O28Fz7CzvoTnkVVnMBqZtMC7csy8lC3fCl7PzbR9WiA=;
        h=Date:From:To:Cc:Subject:From;
        b=cBi4I9HcmQDMj8QReRCBCp/GPiHAorpSaeNiugQPggK2XbDMO3OYef89INv9pjE3d
         l7bGcKwm4zT+KnFCmdhFw+JenbQf5xByIZT2gxi+OtH+FNQdtOueO2jO/20l3T9dua
         OBaqrMGpu12obgdwXWkAa8pbzpJkmmkbTfdHn5iAAdaLsXl1o2E0ddABMLLFb4iFK+
         fQ15I0liLzRaMvdPA9hSIkw4aPOL/9zkwjYkJ16/YdpDvwzgJaJoa3w2BMKwz8VTTl
         JwOY38F3AKEZVfbbqysuC2a+Gr3drhJmcGqmNvT+jb+BJBE1IVZClgD1CoVCAhXoi7
         KObhTpAHn/VYA==
Date:   Thu, 5 May 2022 11:01:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-msm tree with the drm tree
Message-ID: <20220505110134.583417b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p6pn4M.mqrHXcKuX5ZM2SLb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p6pn4M.mqrHXcKuX5ZM2SLb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/Kconfig

between commit:

  1e0f66420b13 ("drm/display: Introduce a DRM display-helper module")

from the drm tree and commit:

  f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")

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

diff --cc drivers/gpu/drm/msm/Kconfig
index 864fdc20afef,a6110fc67ac4..000000000000
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@@ -12,8 -12,8 +12,9 @@@ config DRM_MS
  	select IOMMU_IO_PGTABLE
  	select QCOM_MDT_LOADER if ARCH_QCOM
  	select REGULATOR
+ 	select DRM_DP_AUX_BUS
 -	select DRM_DP_HELPER
 +	select DRM_DISPLAY_DP_HELPER
 +	select DRM_DISPLAY_HELPER
  	select DRM_KMS_HELPER
  	select DRM_PANEL
  	select DRM_BRIDGE

--Sig_/p6pn4M.mqrHXcKuX5ZM2SLb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzIe4ACgkQAVBC80lX
0GzzDggAgSZws/i/jFHBCSWfn/YAZYkglT/enoDLpdwpBCkILZB9zse94cdeCSGz
P00mBrENxEVy2MFyx/Q9xbzqwpKzFAKTQ4Mvu+OndxiVL92hSjagBniR2IqGAFD1
21CAiNWZdRtGwRfRrO01Z65EAKA6VLE9xmg+S7M9VqcY9AFeOum3ReZFgr1l+8fp
SDnFoN1hp26HuNrwUVCaeAwFEGgQ7CYLFHEr0htko3VCnQ7fiA5q9I1nvLrN6hgr
Flo0E1tkysgmYFaB+c/fma0HMT2rBBSTzl184Y6Kd8kKLiyhapAoSQ3M+cp0dIev
n64Bv2btx3aFaB1TQo6Uwctg9sAAGQ==
=clpE
-----END PGP SIGNATURE-----

--Sig_/p6pn4M.mqrHXcKuX5ZM2SLb--
