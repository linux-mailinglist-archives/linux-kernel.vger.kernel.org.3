Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27F58098F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiGZCkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiGZCkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:40:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A92CE03;
        Mon, 25 Jul 2022 19:40:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsLjk21fwz4x1b;
        Tue, 26 Jul 2022 12:40:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658803210;
        bh=ffPbgwsAiF6f9gP1BoTJ3ZTtIV+bTqNsS3kxf/UFcWw=;
        h=Date:From:To:Cc:Subject:From;
        b=M5UeYee0MWczs8lgpT3Vk8LfoKOOdhOcWp6UMYFbcCHdDxjYwJuBvcYY7ed9S0tZ9
         uUo9byHDPa62dNhC93lFDoyTs8dCZVSJrbchzbZuVIXCI+KmUyD/5prLb1b+tJque8
         bfnN2U3tLw/TkMLXl0jj/BOUSFfWEZFhS/Rtx9+QY4dgY26vRvmFbK/FToemLmYdcD
         ph5qIE4EIcllZ0v/HsCyMGLSlaAgH0GOUAT4U/ZzVHkijhlxKL9IeQ9ptYJYHiyQ4I
         l4AjEiHokyFc29HLXc82HEyxjZHnJSf+ywDJIhpLFTEm6M+AbOnSbWnfACC2ZC9iVa
         Y/oQxuobiDNOQ==
Date:   Tue, 26 Jul 2022 12:39:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the amdgpu tree with the powerpc-fixes
 tree
Message-ID: <20220726123949.357cece8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HalYUGpJ3pAUkov+3DQMFHZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HalYUGpJ3pAUkov+3DQMFHZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/display/Kconfig

between commits:

  c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")

from the powerpc-fixes tree and commit:

  3876a8b5e241 ("drm/amd/display: Enable building new display engine with K=
COV enabled")

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

diff --cc drivers/gpu/drm/amd/display/Kconfig
index ec6771e87e73,96cbc87f7b6b..000000000000
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@@ -6,7 -6,7 +6,7 @@@ config DRM_AMD_D
  	bool "AMD DC - Enable new display engine"
  	default y
  	select SND_HDA_COMPONENT if SND_HDA_CORE
- 	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128) && !(KCOV_INSTRUME=
NT_ALL && KCOV_ENABLE_COMPARISONS)
 -	select DRM_AMD_DC_DCN if (X86 || PPC64)
++	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128)
  	help
  	  Choose this option if you want to use the new display engine
  	  support for AMDGPU. This adds required support for Vega and


--Sig_/HalYUGpJ3pAUkov+3DQMFHZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLfU/YACgkQAVBC80lX
0GyLLQgAhhY4KdYihV9xUmSYc/ELpAv5uV8zN7OIe0g2DoQbTzfpCKKUcI8iiQrj
fDF6NO515TQ4f8MdbypFQMsykzX6brlHni/5YNwNZqBzKNafWQ9lCjQsylgn/MZA
FfqMKH8yxyI10AHNxNIfizy+zAtyMQZbdu9WjAVYSTflnGZYJfmOp5NYrEGoO94r
gqoi3Wa5XUbiTjTI/X4sDFqfjUOmRfoVk3L+lvs94ZSD4Yk3fpfdvuT2YllhPj7C
dZBN53KlnlSVw+yMs94aWB2ldwtMzWy8cLYKTBoRqJdZAF8T/g2A2URXaRDvCIJa
E7mkyFtHESBJEsIUosQf720WjSq+3A==
=Pv19
-----END PGP SIGNATURE-----

--Sig_/HalYUGpJ3pAUkov+3DQMFHZ--
