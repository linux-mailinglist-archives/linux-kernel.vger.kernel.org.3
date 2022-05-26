Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD628534A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiEZGJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiEZGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:09:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E1EBC6EB;
        Wed, 25 May 2022 23:09:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7yDt1fl6z4xXj;
        Thu, 26 May 2022 16:09:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653545342;
        bh=ZGlsmdHZc+bJQ+gjaUCeYAQ3T1F2tJlVrpJacxrW88Q=;
        h=Date:From:To:Cc:Subject:From;
        b=HNy5NiMJXOPh7GPG25A7wNEV3m720JH8J4sFzLjsG3UPrhCNiziQOowVOvTASxou1
         6zkUgdsOltrXPZeacHhflvqarekRjXA++hsLCrHw2fWJvX5yf5YETgrwygCrrjan0c
         iTVQ5srKQFkdBkgpycvtbhaq6o3YUH1CeXRiegED3FIU88/hoxQ4eRPfwSsVHaYipl
         fscLG4vzQE2EAeJ17mb+oXe3z9AB0ee8BzapJOCfPDVh115y4WceDIG7XCCLxEAn5a
         x7CPgmoSGn1OxIV88rkAspajpwcn3d0A5oM3Bd2dMQzpjngDr6MjyRCuc+DrzGa1x8
         PiW2xXx8XvN0w==
Date:   Thu, 26 May 2022 16:09:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Glitta <glittao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20220526160900.1a61ba44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J4xZ7xDfQ4Lf.WDoeViPoo5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J4xZ7xDfQ4Lf.WDoeViPoo5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got conflicts in:

  init/Kconfig
  lib/Kconfig.debug

between commit:

  5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")

from Linus' tree and commit:

  21445ae47041 ("mm: Kconfig: reorganize misplaced mm options")

from the mm tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 26 May 2022 16:05:37 +1000
Subject: [PATCH] fix up for "mm: Kconfig: reorganize misplaced mm options"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 197eb287bf82..ce8dded36de9 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -57,6 +57,7 @@ config SLUB_DEBUG
 	default y
 	bool "Enable SLUB debugging support" if EXPERT
 	depends on SLUB && SYSFS
+	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
 	  result in significant savings in code size. This also disables
@@ -66,6 +67,7 @@ config SLUB_DEBUG
 config SLUB_DEBUG_ON
 	bool "SLUB debugging on by default"
 	depends on SLUB && SLUB_DEBUG
+	select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
 	default n
 	help
 	  Boot with debugging on by default. SLUB boots by default with
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/J4xZ7xDfQ4Lf.WDoeViPoo5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKPGXwACgkQAVBC80lX
0Gy5MQf/fCahqIbB+7Lzbu7NuFgb2qdmlg+fWOWuMldxXhZi6A47HX8K5nUxquDr
3LyFj2zciyGNI9iOuWCNRWZ+nkMI7VTc3+VuvZ2UiFMqGnM849cqXWjSbzhY8ZRl
2VDh1f2Czbg1EoUxkPNaCWXAqw8r6TdFnAnN074SJ2whcfjSA0bWiFCad7yFkaxL
audavUJzAdKBVRcGxpCYtAgpzuwuUkrw8HieLjeYJsxpVUdWL6uUcvX4QVkw4vdV
sllSDgiJYwtWkix1pVUt107w3JFsWl/alQeuic8Lr1qOSBrkT/Z/JFxf4ehI/VRH
oLj1ozzLnk2kjzeZ2Boim+fEkQLkjg==
=n8bh
-----END PGP SIGNATURE-----

--Sig_/J4xZ7xDfQ4Lf.WDoeViPoo5--
