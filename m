Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0946357F011
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiGWPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGWPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:22:52 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48851AF1C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:22:50 -0700 (PDT)
Received: from [91.187.115.179] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1oFGxs-0003dI-EV; Sat, 23 Jul 2022 17:22:48 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1oFGxr-007CQ6-29;
        Sat, 23 Jul 2022 17:22:47 +0200
Date:   Sat, 23 Jul 2022 17:22:47 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/speculation: Make all RETbleed mitigations depend on
 X86_64
Message-ID: <YtwSR3NNsWp1ohfV@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z8C+AVnwRSr5Z1pP"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 91.187.115.179
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z8C+AVnwRSr5Z1pP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The mitigations for RETBleed are currently ineffective on x86_32 since
entry_32.S does not use the required macros.  However, for an x86_32
target, the kconfig symbols for them are still enabled by default and
/sys/devices/system/cpu/vulnerabilities/retbleed will wrongly report
that mitigations are in place.

Make all of these symbols depend on X86_64, and only enable RETHUNK by
default on X86_64.

Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e58798f636d4..1670a3fed263 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2473,7 +2473,7 @@ config RETHUNK
 	bool "Enable return-thunks"
 	depends on RETPOLINE && CC_HAS_RETURN_THUNK
 	select OBJTOOL if HAVE_OBJTOOL
-	default y
+	default y if X86_64
 	help
 	  Compile the kernel with the return-thunks compiler option to guard
 	  against kernel-to-user data leaks by avoiding return speculation.
@@ -2482,21 +2482,21 @@ config RETHUNK
=20
 config CPU_UNRET_ENTRY
 	bool "Enable UNRET on kernel entry"
-	depends on CPU_SUP_AMD && RETHUNK
+	depends on CPU_SUP_AMD && RETHUNK && X86_64
 	default y
 	help
 	  Compile the kernel with support for the retbleed=3Dunret mitigation.
=20
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
-	depends on CPU_SUP_AMD
+	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
 	  Compile the kernel with support for the retbleed=3Dibpb mitigation.
=20
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
-	depends on CPU_SUP_INTEL
+	depends on CPU_SUP_INTEL && X86_64
 	default y
 	help
 	  Compile the kernel with support for the spectre_v2=3Dibrs mitigation.

--z8C+AVnwRSr5Z1pP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLcEkIACgkQ57/I7JWG
EQkQCRAAvXDKjsJP19VZK4xBZ6ZrprCVwZ0DxMhsgAtY607LWnBVuEFMgb/D5ODn
pRf7go9zlbsNl8rm8uNuucDB9GVANBF8tT3MwyCsbqXl93V7VUr9SB+Rlf2iOcas
TWQEKZf1XRHLcVxj/QDtZKSoE1G9J9BiJV5Kgw6LjCkEdZd6PPdH2REUgoLFIrCq
pZvsh4YkyrqWezVRx+SkI7qfXnVNkQ/jIJF9ml7b8nFbOZD3uuLcmY3+N9mVbwrg
6olMW6rfSOxuGzecARdizchlSWF5k6k/TBRivd2K8TM9XQ0Ra0TBI0jQPDYeIKcZ
wxiQ2RnfKmZOZmZ0wDkgBA8qTwM5gUNCwb9vLaMFRqTZaYxQP59vP8XY6DeOksG2
P9G4skfzNUNvpyEu4GoXPQxiOXS5nqpf7siXNcjYlXZjz7gQ5fLoyI48wyu8SM2A
WCUdCZQpFsb2yuCnkcZylN5jqQhamqiEIhPVMiY6oc7MoRRcmlKwCfzWgNr3Xuc5
eUyd2HFrcFt/8T2a5GIVqMdU2XpMs5DC9EBP0eO0QmWZLFtjv4R7RwBlblWT3bwe
TBLctI2OInQjMRP6Ztha+IjJVsC8MSjfdHfJQWMPwVdSyA+SY2GbspA0pVR8qaj2
S4zy8gTpoV7m02BTFpqVHYhVu0xsYXx7qXBpKduwpujU0j6T9MM=
=rlZt
-----END PGP SIGNATURE-----

--z8C+AVnwRSr5Z1pP--
