Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79233569F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiGGKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiGGKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:04:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A74506F;
        Thu,  7 Jul 2022 03:04:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdsT94X8Gz4xRC;
        Thu,  7 Jul 2022 20:04:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657188269;
        bh=i2dbOs/VUUaAO1Ljbk+HDAfdNK0zAjx0vQPqkcIQrxk=;
        h=Date:From:To:Cc:Subject:From;
        b=ar6bBk0KHYvZQmWIpTGFDS0n/4a9ezDkUaZiDHD+oWpeYqso2NT9xolx/9pVErXsP
         omsZzMRqJRoDfiIsEIwM7n16eFHQdU4D0mZzU2MFDi+VYCWQviVBaJvo05m0Y6ey+o
         iqe6v5T3y+mKJlOjZUcIUEfNBIGq/p4yMxQksWqYopc97g/q949xOXP7kcdNh3AvcE
         K6HVdVYX8OxZCZcoGwCHr13YQr5b2So1kCKDcjBe1HbXma6iJP8WT+55SiOBq5vpyU
         de/6uP8Xl5f45VGbghdpejqbudPcNv3j/gvLXiXzQWdhuGIsdBas6bAUSkPBslBU0z
         s/PVm669L09UQ==
Date:   Thu, 7 Jul 2022 20:04:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220707200428.3eb1a20e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j3ysHYpGTAI_Szgav8uDv3+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j3ysHYpGTAI_Szgav8uDv3+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
sound/soc/amd/acp-es8336.c:204:33: error: invalid use of undefined type 'st=
ruct acpi_device'
  204 |                 put_device(&adev->dev);
      |                                 ^~
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

  f94fa8405801 ("ASoC: amd: enable machine driver build for Jadeite platfor=
m")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/j3ysHYpGTAI_Szgav8uDv3+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGr6wACgkQAVBC80lX
0GzyRwf/e3jCKJhGWJjtf3gEUDsnMAAgkYg8UGWHhi4z2wi7eQujHgCgnEOxypti
ZPL3omrSzMd66G7SOyTzgtlds5m/JIT1CRwwp0wjQ8Mq55szZqHb6YmFKGnOIefL
aybl+0Wd4Unvg4S8+TvgsDdrwE2me6OtGDCUYilKtrsnfB+onYibn0hK91oC2kOl
1+jKCU0DV1y6wHDjDohATt/tczfub+t7r0KB2os1OVM6NCNhLVpYjKlGGeL7XQGI
P8FVdGNF48QGtbc03L+W7culE9hCR2HIS4/x2jQrfppPiDRHY35YGn81YEZMbIoE
iVqFq5p3rIheEJXf1L91QzKmaNcYhQ==
=fDIi
-----END PGP SIGNATURE-----

--Sig_/j3ysHYpGTAI_Szgav8uDv3+--
