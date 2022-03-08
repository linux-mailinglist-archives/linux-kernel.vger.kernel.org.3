Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA394D2470
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350799AbiCHWnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiCHWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:43:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CF1E3E3;
        Tue,  8 Mar 2022 14:42:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCr1l5yqzz4xvN;
        Wed,  9 Mar 2022 09:42:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646779356;
        bh=8Sp8Dfbj1LkAvt7lEhSomDcYJ/vdGYhIUpg4uCoUwBo=;
        h=Date:From:To:Cc:Subject:From;
        b=Dnn63a4hmJK4uzgMiVCnYr44lY8KciMyGgzoswr2xWneQ9Ec+GiDn19zQsxxDAaZ+
         KgEGhZSH17kmnWSfiYlATkgIs08L4YdtMj2xBkwFrz9VStfgCJA2glE4rt6ZSQyfqy
         XYJHnJkIpM8ka4bS++GHS5LVH4UMFFvvKwtJZKkqB+laFAu9rcwlFch65Y03GUlWZk
         lK9y0j8db6pccjcXukzIT/kFCa2kCVHmVGBfvC8CWoYKQLhwbPVFiS2OSOzQdtua/v
         ERUvDeYU/ozlFR/qZC75PYQ+Yj8UVdVXbLZvCw6c1WhdL1ds0FitU+UgP53hiS63GE
         0C0Rc369EiE2g==
Date:   Wed, 9 Mar 2022 09:42:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20220309094235.146df5bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Na/Y_JquJgGpQg7LcO7l9hz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Na/Y_JquJgGpQg7LcO7l9hz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/kernel/cpufeature.c

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

diff --cc arch/arm64/kernel/cpufeature.c
index d33687673f6b,32aa0eb3ed68..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -231,7 -226,10 +231,11 @@@ static const struct arm64_ftr_bits ftr_
  };
 =20
  static const struct arm64_ftr_bits ftr_id_aa64isar2[] =3D {
 +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_CLE=
ARBHB_SHIFT, 4, 0),
+ 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+ 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_APA3_SHIFT, 4, 0),
+ 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
+ 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_GPA3_SHIFT, 4, 0),
  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_=
RPRES_SHIFT, 4, 0),
  	ARM64_FTR_END,
  };

--Sig_/Na/Y_JquJgGpQg7LcO7l9hz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIn29sACgkQAVBC80lX
0GxY+AgAiSzPrluV0/1c3k5DtF3PhfbiHo5o49UN4QjJD9wnPtx56wH/Jll1crPd
zHadQdqHo4MygXZ6F7h1kR+h7SFCMMOQtLDBRuPRZVLKjfA5BvSWTHd9iwpkahDH
+PSY0v+wCkA55SsAyh+FuxFQzPYMpA8LgkCf/97Lt98HBwYfcEm+u4rYPRfBEBQe
G5zl+W/oIz4lJHn+v5k6wJ27+FMl+/1Ji2OncdhF2sR8P2bqk93SN9+JbY1FAL1B
JbG6XzlcqFbW8+9qLaE0RG+hA2teFGQi4K9LWZbUP3SmgQHeV5WiQ3BFfqBTWG8A
nK5+TSe9Cj8QlW/ITL3XjC4H0DQp+w==
=zDhV
-----END PGP SIGNATURE-----

--Sig_/Na/Y_JquJgGpQg7LcO7l9hz--
