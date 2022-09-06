Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B75AE196
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiIFHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiIFHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:49:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91EB17AA7;
        Tue,  6 Sep 2022 00:49:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMHbb4yDfz4xGD;
        Tue,  6 Sep 2022 17:49:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662450588;
        bh=ZkmYQ2PqBE137l1VRN7e9H+W7zy0IhuEctYp3R9mOSw=;
        h=Date:From:To:Cc:Subject:From;
        b=RkMHhKhgyGdS7u6fcN6YonCtRyTQI9+jEE4sXuiU+/lEcQRjhDCpFz7sejxATzmJh
         3kS9I7txPClyRhNDZ1376S2wk9kp/B6JRgF2qfKjdpFxHGt5AyFQg6qoKYTGq96Xca
         g0prl5JMbEi/NGiOxVoDXLomMvTJvaPrSu3n6MFGbtjGMOaDDxV1PRjZQ/86CWTRfB
         kGO86D2nXS9zYGlFiMnbE36NVUdIypt2oTijHpig91gDFkkvDB7N46R/ClyAfAteTS
         xUt/iw2PPNgNcQ88UHsFDjuJhiM70uiIEI0vNd1Uw2tXVLUpUqgHIzGxoy7W1idruV
         /wZsvzjs8SWrg==
Date:   Tue, 6 Sep 2022 17:49:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: linux-next: manual merge of the kspp tree with the tip tree
Message-ID: <20220906174946.61819060@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sp=cXDFOcebNKKIpMUPGYwG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sp=cXDFOcebNKKIpMUPGYwG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  lib/Kconfig.debug

between commit:

  724c299c6a0e ("perf/hw_breakpoint: Add KUnit test for constraints account=
ing")

from the tip tree and commit:

  bb26bbd0a067 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/Kconfig.debug
index e40550a5bdd3,1f267c0ddffd..000000000000
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -2533,16 -2542,15 +2545,25 @@@ config STACKINIT_KUNIT_TES
  	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
  	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
 =20
 +config HW_BREAKPOINT_KUNIT_TEST
 +	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 +	depends on HAVE_HW_BREAKPOINT
 +	depends on KUNIT=3Dy
 +	default KUNIT_ALL_TESTS
 +	help
 +	  Tests for hw_breakpoint constraints accounting.
 +
 +	  If unsure, say N.
 +
+ config FORTIFY_KUNIT_TEST
+ 	tristate "Test fortified str*() and mem*() function internals at runtime=
" if !KUNIT_ALL_TESTS
+ 	depends on KUNIT && FORTIFY_SOURCE
+ 	default KUNIT_ALL_TESTS
+ 	help
+ 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
+ 	  by the str*() and mem*() family of functions. For testing runtime
+ 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
+=20
  config TEST_UDELAY
  	tristate "udelay test driver"
  	help

--Sig_/sp=cXDFOcebNKKIpMUPGYwG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMW+5oACgkQAVBC80lX
0GyA1Af8DzWPSckiL++ldBVfvWwMRtj/iwCV2e2ykXVo5kqrXirY/aWEPxRKtSrI
SKLXhPheZufg2Uyf2nYUy6HxrKvfRnsrpqfuWHOybZi6ni/iVwQ7hvlfx7nBesCg
mIeqs/a+0G02YEbrt4sZ1KsKydnVbfAX/IL1lJbq3vlKhukha5HO0XDxqoyW3QPl
4AeqKuSPbVwBn2q0/ep9dz1kfp/na0q79CxNSojAbMYNz68MXxH4SgxbhM7/y5dV
D0B4kPI1sta3cQZn5jq8yqnKcrIFIrAxFHQDgI1GfseMIvqTBXkPujxREWm6X7n3
MViWBYX+Qsyt0Q/gaXtCCOe2DakDUw==
=AGFo
-----END PGP SIGNATURE-----

--Sig_/sp=cXDFOcebNKKIpMUPGYwG--
