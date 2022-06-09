Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38EB5441CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiFIDPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:15:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844562F2;
        Wed,  8 Jun 2022 20:15:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJTjb0c86z4xD1;
        Thu,  9 Jun 2022 13:14:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654744499;
        bh=S+jXWrp5osNxAjIG20y4ZnatpHi8Kk2mowmjjJQL3As=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SVjUK9C2H9yTPTA3uwZGIl0O9HO7GdnJqidQQQffjuD6sIkEC/Yb587kVSRFc/HnB
         H8stgLrNQTClsRQC88te9UY4XuvAQ1EjUY0VKBi0Oshw7ShP8t7PmANQnxxq7HjbG8
         sB/Lbop5Eq7Uayix75mOvPZGofeii34r+6eXI9ccqd3i228TGLR1bD66fe6X5Ebet1
         MeuFf+jsvnoxpqwSS6TAvE6YRKt572N0FTk1QBDrwoRPXY2sz4RIcWGKIZPIc1bRam
         YGVb8XRGOGbjXCkvNX3v6N9t2triDCUvbFewaLX+wnUKnIAGUXs3Iaogbl4Ugas3yQ
         /TeJJ/0SF9HNg==
Date:   Thu, 9 Jun 2022 13:14:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220609131457.57f3b602@canb.auug.org.au>
In-Reply-To: <20220603144315.5adcddbf@canb.auug.org.au>
References: <20220603144315.5adcddbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/76yUxgoUC8Ke8zmAiwpOtLP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/76yUxgoUC8Ke8zmAiwpOtLP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Jun 2022 14:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
 In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
3835:1: error: the frame size of 2752 bytes is larger than 2048 bytes [-Wer=
ror=3Dframe-larger-than=3D]
>  3835 | } // ModeSupportAndSystemConfigurationFull
>       | ^
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dml/dcn32/display_mode_vba_32.o] Error 1
> gcc: error: unrecognized command-line option '-msse'
> gcc: error: unrecognized command-line option '-msse2'
> make[5]: *** [scripts/Makefile.build:251: drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dcn32/dcn32_resource.o] Error 1
> gcc: error: unrecognized command-line option '-msse'
> gcc: error: unrecognized command-line option '-msse2'
>=20
> Caused (probably) by commits
>=20
>   5cbb369e32bd ("drm/amd/display: DML changes for DCN32/321")
>   b5dbe04a9c8c ("drm/amd/display: add CLKMGR changes for DCN32/321")
>   4f185390597e ("drm/amd/display: add DCN32/321 specific files for Displa=
y Core")
>=20
> I have used the amdgpu tree from next-20220601 again for today.

I am still getting these failures.

--=20
Cheers,
Stephen Rothwell

--Sig_/76yUxgoUC8Ke8zmAiwpOtLP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKhZbEACgkQAVBC80lX
0GxlZQf/evQehEh8429L+22Ejt2EmoYjdIxcJx82xbRDQs7ZzxYSOorpWHAzCf6O
jYAxmE/zlCHMYoRXgci4oLvZisVXHqGM6UUhfxkjlQVXa1oc5mQqy74qlG6uIN66
Gzbr6LURMidZrbItFwABqL7Ki3gbEy6damY9+YTVosfXSu9Md0rMR2YrZjzfi/nP
AOVyXfhI0MicyY1V1FnX5LgNQspf2G1mZ+iMFPgPdivI6pi4AxtIeM1qS4Yu2UrG
uhO+30ttJpBbqWUC/FfiM9seuB3ASHu1rselqbVyzGNjRQtHysolnEhLrwqCH9wX
uLNKC6/qQjvdR+VLUDpeL8b+cN37XQ==
=4QpF
-----END PGP SIGNATURE-----

--Sig_/76yUxgoUC8Ke8zmAiwpOtLP--
