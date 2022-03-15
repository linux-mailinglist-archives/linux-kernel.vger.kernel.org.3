Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303274D999E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbiCOKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbiCOKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D839F52E11;
        Tue, 15 Mar 2022 03:49:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHqsd40Q1z4xw2;
        Tue, 15 Mar 2022 21:49:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647341369;
        bh=iYE9dJHDTT8H7bqrMBV1EnYaqbnrrezKk7EQTKogbcI=;
        h=Date:From:To:Cc:Subject:From;
        b=qIihu0phsKEqMkqI3Hlvk0QfYokGGny6ddBoiWTwWhEaLdbQRO+CVYntOUzyteSYq
         woZ9yB4UTeELpVDc+DZHZoiOvLbuyBX97S8qriBFjLhTAgZ5oq+UUR4/t8RU/ectWs
         ltWTKO270IFcZnCFUxdaAzvcVfHaIupIrDapYiEvUFewLDt1ugSMDnWqibe9Qtc2c9
         OrBzsKuRcxnVEI0kBIeMUhY8IrqopMGX0/G1f65TuaCPfJbUszQFUnfXK5TdyRp/ae
         zGW7Gq8nrGqR2Wklhgk4iZ9hfzb9OH0o6qtUHpqeqJNuARCmDI0SDdmaZrprnBYXZK
         Qd/L+FToHkS4w==
Date:   Tue, 15 Mar 2022 21:49:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with Linus' tree
Message-ID: <20220315214924.27f5e360@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oj0r1jFpsjdfgToetMx4HKq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oj0r1jFpsjdfgToetMx4HKq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  arch/arm64/Kconfig

between commit:

  6e2edd6371a4 ("arm64: Ensure execute-only permissions are not allowed wit=
hout EPAN")

from Linus' tree and commit:

  afcf5441b9ff ("arm64: Add gcc Shadow Call Stack support")

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

diff --cc arch/arm64/Kconfig
index 181679ffedac,de01e77f4db7..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -1259,7 -1252,10 +1260,7 @@@ config HW_PERF_EVENT
  	def_bool y
  	depends on ARM_PMU
 =20
- # Supported by clang >=3D 7.0
 -config ARCH_HAS_FILTER_PGPROT
 -	def_bool y
 -
+ # Supported by clang >=3D 7.0 or GCC >=3D 12.0.0
  config CC_HAVE_SHADOW_CALL_STACK
  	def_bool $(cc-option, -fsanitize=3Dshadow-call-stack -ffixed-x18)
 =20

--Sig_/oj0r1jFpsjdfgToetMx4HKq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwbzQACgkQAVBC80lX
0Gzi6Af9HC+4RwrGbaXdZ1Xs3TcJrnFoDKWz5zoAxmXsD1NSLN3qdSUR3jxOvnkf
U6tpofOQW1TWBmrAAScXEEYgoqUxnz/1QkwnPwja81JGmGVjLXUL0phLo9EQF7b3
onn9qhY3vEXwO715/m2c6umTb0sarBekMZuPUCxYI6f9AyLdgxiOGzZXFaYY03wn
T7zQq+FPRAfUwVuj6t2AKmLEAOGf4cGNUYJS68lJpqXMVOGhB9t23FkEhgEJMJrv
C7hwZDu5EDmeoe2E+2UM8ChHzsx13YSiwydq2Mudi5ab8zI/Lvlj5nmufEDE5UbV
Gg/+QXmRJs6NuVEAUgj2h7dyvSxklg==
=G5DD
-----END PGP SIGNATURE-----

--Sig_/oj0r1jFpsjdfgToetMx4HKq--
