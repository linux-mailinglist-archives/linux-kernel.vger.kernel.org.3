Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3648054C0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbiFOFAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbiFOFAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:00:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99742EC9;
        Tue, 14 Jun 2022 22:00:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNCmG65TDz4xYL;
        Wed, 15 Jun 2022 15:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655269215;
        bh=2I6Hz9b1Qxy3zQMcWY/zCUhk7UnIlJJ9z8VjkIyipTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6cqBzxtqAT61MfG6WYRqC+8r2Upijo7XAfSxOnKzy9SHh8Wr4qSpbJvnC9ywyTln
         pMiNLv2tgdHFbGY1SZCa3RGq4JKB+eTZcexiDv1CM5tfzUsal3jHtooitFM4bTlkUH
         XU/wtDyKslbMhsV3JYHKo/WK+RpmlQ3Ng4lLITHmHPWAps7hRclT4PwZ5io/u0teeJ
         105ZhwobCbA2aF5PAjVnfglj+ywiQQDtqu+NJdzefRsuBuXAtnaGalymE7JRP9/xan
         rvGhlEHBtCbXBsYtUsQD1V55cliQLWE2v9dU/WtpQg7WlsUQStes8ol95fHFB3ssl2
         VuIgQ6QlstxPA==
Date:   Wed, 15 Jun 2022 15:00:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220615150013.30c9d7ad@canb.auug.org.au>
In-Reply-To: <20220603144315.5adcddbf@canb.auug.org.au>
References: <20220603144315.5adcddbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GfF5FNPPFHk2DES6nnecO+1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GfF5FNPPFHk2DES6nnecO+1
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

I am still getting the above failure.

> gcc: error: unrecognized command-line option '-msse'
> gcc: error: unrecognized command-line option '-msse2'
> make[5]: *** [scripts/Makefile.build:251: drivers/gpu/drm/amd/amdgpu/../d=
isplay/dc/dcn32/dcn32_resource.o] Error 1
> gcc: error: unrecognized command-line option '-msse'
> gcc: error: unrecognized command-line option '-msse2'

These are fixed.

--=20
Cheers,
Stephen Rothwell

--Sig_/GfF5FNPPFHk2DES6nnecO+1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKpZ10ACgkQAVBC80lX
0GxxeQf/aZTmoG3Ugse8aakXQ4ydv4Amgfn6LL9NtEfr05RkUYRvpVGV956Y4QYV
TlnlzWCJb3YcQYMwAkGLS/QOD16u62fDA5MyHXdIfJVDG9RNVnnUkoCbrb8Jo87G
UNuvdqKEaK8Ti+F0CA+BQZVKT3lOWisICtb0geylFAl7x32Ia7LYBDW6P8wO+0ab
wqs2/qNOkuUrHOJenzgk+cYhd4C55ITwj+PjRnmLi8jwbXTh+4pbjR/JlLa1s6D6
yZ88/iQaq9CiVZ9Vj21vDc8OvanvEy4Pan0kSyc46ACDD8nubLJInQqP3rOT/wz7
mj8xNUXiwq8MKLPe9yv+0gAFTHyhwA==
=JEeY
-----END PGP SIGNATURE-----

--Sig_/GfF5FNPPFHk2DES6nnecO+1--
