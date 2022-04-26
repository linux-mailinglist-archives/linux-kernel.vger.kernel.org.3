Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D589250F630
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbiDZIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbiDZIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8C0403D5;
        Tue, 26 Apr 2022 01:30:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnZpF4Pyqz4ySX;
        Tue, 26 Apr 2022 18:30:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650961846;
        bh=cBtamjcdMrl1lr8mEXPJ4M3wlinoEv8uv5M/sx0Fo7E=;
        h=Date:From:To:Cc:Subject:From;
        b=nZC6aHmP7oY6UJj+boFIbMOre3CB0dlZx9FxHkcpBEejany4y/wTJHmY+v4+o4sRp
         fwR6h9M5ALvgv4LZDEvN3dXLBjlQ7Au0pjcN6LB0ii5vonvn3ejWpdB5lDLX19JBx2
         aJVPv4oNYLw0hf8KYsle02XBtBVhnQ17yy+kM3YDEJTDSnEoKf8Sc6yyfUF+HyilLI
         M1Iu7ixMl10/FrIux0bQqrRoeJMu/5FBO90UzEduvy0186oe7xjLqgueANcSuAIdTX
         JEUSAqfYRCEv6pCDXeaS5FmmUgGjSAyKfyPGxrbQf0p3x9lJiPpkzKt+auZMDIcKaE
         iLk1TlAz8SdRg==
Date:   Tue, 26 Apr 2022 18:30:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220426183044.4f72059b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5cYsxUw5ftwaVcHzMg.4l0k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5cYsxUw5ftwaVcHzMg.4l0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machin=
e'
   34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from sound/soc/soc-acpi.c:9:
include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_f=
ind_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach=
 *)'
   38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_f=
etch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=3Dimplicit-f=
unction-declaration]
   58 |         struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
      |                                    ^~~~~~~~~~~~~~~~~~~
      |                                    device_match_acpi_dev
sound/soc/soc-acpi.c:58:36: error: initialization of 'struct acpi_device *'=
 from 'int' makes pointer from integer without a cast [-Werror=3Dint-conver=
sion]
sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct ac=
pi_device'
   64 |         if (adev && adev->status.present && adev->status.functional=
) {
      |                         ^~
sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct ac=
pi_device'
   64 |         if (adev && adev->status.present && adev->status.functional=
) {
      |                                                 ^~
sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_e=
xtract_package' [-Werror=3Dimplicit-function-declaration]
   80 |                 status =3D acpi_extract_package(myobj,
      |                          ^~~~~~~~~~~~~~~~~~~~
sound/soc/soc-acpi.c: At top level:
sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_packag=
e_from_hid'
   95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from sound/soc/soc-acpi.c:9:
include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_f=
ind_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_packa=
ge_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_packa=
ge_context *)'}
   44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_lis=
t'
  109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
      |                           ^~~~~~~~~~~~~~~~~~~~~~~
In file included from sound/soc/soc-acpi.c:9:
include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_=
codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
   51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(voi=
d *arg)
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  47a1886a610a ("ASoC: Intel: avs: Enable AVS driver only on x86 platforms")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 26 Apr 2022 18:01:06 +1000
Subject: [PATCH] partial revert of "ASoC: Intel: avs: Enable AVS driver onl=
y on x86 platforms"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index be42c4eff165..b0b46deb25c6 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
=20
 config SND_SOC_INTEL_AVS
 	tristate "Intel AVS driver"
-	depends on (X86 && ACPI) || COMPILE_TEST
+	depends on (X86 && ACPI)
 	depends on PCI
 	depends on COMMON_CLK
 	select SND_SOC_ACPI
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/5cYsxUw5ftwaVcHzMg.4l0k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnrbQACgkQAVBC80lX
0Gwrzwf/Wnf6i6TNLDZh3eb5zrEBhx9ZFQiGZU7fuhViFCKeov9VlI7JS4a+xQPn
6m2bE1cWVCasjvIKMil15ZLm8whmtRyvml1l0mQ1p/D8uOqziyDypxj7Wj/CQYaR
RNf2Yg4YB3j3UsN2zoQGPNdb9cDeou5C/UwtgTBKbqrCg8mfXvNLcmMf1NI9sZI4
yfawQXp6inMcTpisNz79LSuiWaqZOOVby42byjcymyl++LQon8aOwtI8aZ6uxEwW
UkkxU9a5p6L/5lSa1GLPOkqED+gA1Q8FEipBBMlSsvS0wUys7jcwPIy5fhA73wlB
cdFd4Bp86m9kUm9KvtK6S8ELXqIOXg==
=V5EX
-----END PGP SIGNATURE-----

--Sig_/5cYsxUw5ftwaVcHzMg.4l0k--
