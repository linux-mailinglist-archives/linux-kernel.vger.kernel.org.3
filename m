Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00811576203
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGOMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGOMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:44:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8253B5D594;
        Fri, 15 Jul 2022 05:44:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkrfP3HHxz4xZD;
        Fri, 15 Jul 2022 22:44:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657889087;
        bh=+6PXPZIukil825g3WgxAnyRCEE+uB/jPmnZfVYSdSZM=;
        h=Date:From:To:Cc:Subject:From;
        b=SS+PJHknLTkIqYRMOVsINw1EP2jCdhwhTQpcT6iPYM71zoE0YP0N+04sX7MIeDx9e
         +/ZVT0S5q7fKwFiwEBHnZ5O5S/AyFVsSw+Mm+39/nQFjTUrqf7ToX9KOthxZV1CMJ7
         Wms4NcmQ6jlNByamNJD3SmWuZuiCt1KMznOjT8ArPyHEIgqQUyLH0BmjJgd3TjQ/xT
         i1KEvIWkXb5S6xzs7ancQMNiCrbFCf35FzIkd5YTYI/9vlIU3eJjM0pPx2XxX+0JNf
         rBLKK2vDG/qtV7Fp10fQQFkIQpiU5cL7y/S1yZk2eegAcR5aMTpVoD6GeU2HduU+uf
         URiiOk1FnT3ZQ==
Date:   Fri, 15 Jul 2022 22:44:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: linux-next: build failure after merge of the sound tree
Message-ID: <20220715224443.46ce75ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tc+ApL3edy=coBk2tZfD.4u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tc+ApL3edy=coBk2tZfD.4u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound tree, today's linux-next build (powerpc
allyesconfig) failed like this:

sound/pci/hda/cs35l41_hda.c: In function 'cs35l41_get_acpi_sub_string':
sound/pci/hda/cs35l41_hda.c:693:43: error: invalid use of undefined type 's=
truct acpi_device'
  693 |         status =3D acpi_evaluate_object(adev->handle, "_SUB", NULL,=
 &buffer);
      |                                           ^~

Caused by commit

  d60b05b4c780 ("ALSA: hda: cs35l41: Allow compilation test on non-ACPI con=
figurations")

along with commit

  eef375960210 ("ALSA: hda: cs35l41: Support reading subsystem id from ACPI=
")

I have reverted commit d60b05b4c780 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tc+ApL3edy=coBk2tZfD.4u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRYTsACgkQAVBC80lX
0GzADwf/SxxNIWifSnwkykYpb22uegXnUcygQsF7R7ZZ9vy5/Ms3pdVpRUcw0F10
o8q8yNWPH2CLMA/tCiFNZKEW5NhnAKsd5FRmRZa4uPjFJdftMieSosya8Og32upa
SpJyAqJMweHeW6tJ1xor5YHVQcy0VD94DtTv4iuLNJJ4E3IwS1C0DU+8C1WohKkD
hyLlqj6gjMSzUbqpuaxc6cjCmwr/K74iTp0mMycPKGvujruG0nZWZi2YrkGLcIN5
JySMzwD1lSGDyaqr5j8J8S1QtkXSLU7GJqrThjQktj8irxEyaR/JHczgnJJj4vuL
RIv2rGS9fvp8aTzuZmQD+A1JdAcDFw==
=XegK
-----END PGP SIGNATURE-----

--Sig_/Tc+ApL3edy=coBk2tZfD.4u--
