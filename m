Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE04D2468
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiCHWjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiCHWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:39:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BE43192B;
        Tue,  8 Mar 2022 14:38:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCqx53mqTz4xv3;
        Wed,  9 Mar 2022 09:38:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646779113;
        bh=dNLXA3LzwiSMOgm/wi+jqL8YdsV0EVDUVlCxmxElvPA=;
        h=Date:From:To:Cc:Subject:From;
        b=puTi5IgNdAdf4W1UTq37DelT0EGdYJ8p7wPPELmjhgpsrjr1WVbBIn/xIZJwLYgW+
         KXgqmDDy8E3B7r9v1RGomqZM51X2t+z9IrhHCvCPdOVLxZlc9+AXRvs4Su9kbNVINn
         iS0RTp/RFXeGfJENTe1B/fauco2CHQhkI14ratRv+w9vLV9I8vfMs3FWoep3LC7Bv7
         k6YBBw3LPGwc+OPf7GHKknV8nI3GE7vLGMatJQagAoaUIA6c2kykWlUn7eoTJfx2A8
         2yv8XYSJslyJIUTMtyJyp8wpHZ5w+iYIqDUcDSJirgEYCpgUDvcvovF0PPIxIG6nMC
         2jCzr9lcaHTwg==
Date:   Wed, 9 Mar 2022 09:38:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20220309093832.01585172@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//grCy0gAI5PQmVK+ZvIDWZQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//grCy0gAI5PQmVK+ZvIDWZQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/include/asm/sysreg.h

between commit:

  228a26b91228 ("arm64: Use the clearbhb instruction in mitigations")

from Linus' tree and commit:

  def8c222f054 ("arm64: Add support of PAuth QARMA3 architected algorithm")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/sysreg.h
index 932d45b17877,2023a0e6c6d6..000000000000
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@@ -773,7 -773,8 +773,9 @@@
  #define ID_AA64ISAR1_GPI_IMP_DEF		0x1
 =20
  /* id_aa64isar2 */
 +#define ID_AA64ISAR2_CLEARBHB_SHIFT	28
+ #define ID_AA64ISAR2_APA3_SHIFT		12
+ #define ID_AA64ISAR2_GPA3_SHIFT		8
  #define ID_AA64ISAR2_RPRES_SHIFT	4
  #define ID_AA64ISAR2_WFXT_SHIFT		0
 =20

--Sig_//grCy0gAI5PQmVK+ZvIDWZQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIn2ugACgkQAVBC80lX
0Gxzcgf7BErJRTWDE39FDsbMWtlssVzkSxPeUvtlkLYtOj2BS7I95jqj8+4lG93X
b0q7AMjG9FkcPkHlDiG16JMgWXa1tIHwlUByFRit0vvxZSbTFZxIrzdpk/BXaNNG
KS3eB+sGF868qybnYFJn3Hn+5Sc6LouxIsXNsCN0QCZReRlpKcFzYwomig8tC27P
I+hUSx6PH2NuJgfj/PMX9pIZMaojIqlHIujoxjFktKEW9fNtd47N+2yMqfMv+WQn
3Yjvls26dXskZe/Xz1xg4rfybpay3jZOScQfqHgq5z7UqtBaY0E6J3pFlB5DKmEQ
2tLnWBmDliT8VKNhaValH1NE4eeblA==
=ACFq
-----END PGP SIGNATURE-----

--Sig_//grCy0gAI5PQmVK+ZvIDWZQ--
