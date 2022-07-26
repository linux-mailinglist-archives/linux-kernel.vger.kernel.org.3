Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A258117F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiGZKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGZKzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:55:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0682A40A;
        Tue, 26 Jul 2022 03:55:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsYhg5mLTz4xD7;
        Tue, 26 Jul 2022 20:54:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658832900;
        bh=9+FlBdhixnku9tvDNU2x0FUbAT6pp46SmivoR1KKXmc=;
        h=Date:From:To:Cc:Subject:From;
        b=Rix3gPihZpms4vF8c0T10bW0YnkEZsdGuWTj4WkD3kBAHBUNzTjWLCsGeqYo4nZvk
         8f7lD4JDa0dpqK3VG3G9L2XkWVV+oKHwWAP27ProP6mXMAdlDJnpYMdLyIkz6DbrTh
         2hVz349A+dU7FJQtMTlsjB2BwVObstTqgm3nqcrh7PkkQlFzGxf1bKPIISJNmOKbxN
         bqRJ2lv3c+atWyoQxZGAAGuiZ5OlgdNv2cbz3gHUfAA3Pd/kV22qkDzh6gdHc08v6m
         H90Rrw9n3cbm3XCF9kx/ZF79NF3MPjPoWo2nDSoDzvS9E+7X4WGMTq1SpiYT1qwEum
         b3tNPBZvpJdqQ==
Date:   Tue, 26 Jul 2022 20:54:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
Message-ID: <20220726205458.0b5ca446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CeiKauEEHzzZBzRc+c7yY7K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CeiKauEEHzzZBzRc+c7yY7K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, =
drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
ld: failed to merge target specific data of file drivers/gpu/drm/amd/displa=
y/dc/dcn30/dcn30_optc.o

I have reverted commit

  c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")

for today.

I suspect that commit

  3876a8b5e241 ("drm/amd/display: Enable building new display engine with K=
COV enabled")

may also be involved (or, at least, not sufficient).
--=20
Cheers,
Stephen Rothwell

--Sig_/CeiKauEEHzzZBzRc+c7yY7K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLfyAIACgkQAVBC80lX
0GwJBAf9EZNpA4iVSluHzLWaWB9a8czw25RD+eDinj7ZmdE2BQWyvIK9MpNj4yJO
4PM3TkoCT6h+/a+39ik3OhnAQi1//8ADT3jGlyS8OgYCf60eNk6n7s7K0wtnu9AB
j4bd/AbGQfFYQrUBGOFb7qP65cLONHIOe1Vlz5ztC6AvUZyIk2n+jc0wQWjWWgC5
aCrPTPym479IokYtU8wlYoMIyQN3d+7Gb58L1u6KZHbOV9knqdGyuuAccX1lKTFP
20PWeu121Nkqj3Lojtlk2V+OEpdytU/6XAqyj69/bQOButDBwat7fPWA1ErUyA+X
UlnVTPOdl4U77u7dT5wKsUA3SH+X4w==
=0cnc
-----END PGP SIGNATURE-----

--Sig_/CeiKauEEHzzZBzRc+c7yY7K--
