Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D904A2B5D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiA2DH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244882AbiA2DH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:07:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A1C061714;
        Fri, 28 Jan 2022 19:07:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jlzl335ggz4xcV;
        Sat, 29 Jan 2022 14:07:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643425634;
        bh=KWFwd9+aipIw2fDacQM/exJ32sgn8MY4BtMeE5pYf+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SaT6a+RhzhazLOeZADmAr6MIZoFi77Y2DynN9rNC0RCFxE4e5zaDMFRNzd/fZ0x5O
         EqK6t6UnQveAqFd/rD6FFx8t7Qrh49bzI5yZ5h0hSMUvwAG376kQ76z7hT/bPzsN8d
         3oLACVi7dCdTnW/O9736s0ocPMf12M5kd+bA5i87yNglsHnKaqygtFIwpbcV9zC81X
         dZWGgHaXbLUJjZnx9/NsQ+N6pVbD7Tx0sNt9wOlLQ6PQo2dL8umsGJpQpfw+6xv0vE
         Y7kQqxXMhcmVN8W7jtQ91t99/Mmae8Lx6/bJVOSoPuUUhKfW2U4MlY0wxzMdkEq9s0
         MrVrcMQlffycg==
Date:   Sat, 29 Jan 2022 14:07:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rmk+kernel@armlinux.org.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [next] arch/arm/kernel/setup.c:1028:63: error: 'SECTION_SIZE'
 undeclared
Message-ID: <20220129140710.1ef9f9a5@canb.auug.org.au>
In-Reply-To: <CA+G9fYvxxc4o5UjRfHVgmcaTN1ijxXX8e=OTP4t7PbRENmVBsQ@mail.gmail.com>
References: <CA+G9fYvxxc4o5UjRfHVgmcaTN1ijxXX8e=OTP4t7PbRENmVBsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WBFXjOTRkeblc9BBHNdrSIU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WBFXjOTRkeblc9BBHNdrSIU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Jan 2022 20:51:53 +0530 Naresh Kamboju <naresh.kamboju@linaro.or=
g> wrote:
>
> Following build errors noticed on Linux next 20220128 arm with tinyconfig.
>=20
> make --silent --keep-going --jobs=3D8 \
>    ARCH=3Darm \
>    CROSS_COMPILE=3Darm-linux-gnueabihf- \
>    'CC=3Dsccache arm-linux-gnueabihf-gcc' \
>    'HOSTCC=3Dsccache gcc'
>=20
> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> arch/arm/kernel/setup.c:1028:63: error: 'SECTION_SIZE' undeclared
> (first use in this function); did you mean 'SECTIONS_SHIFT'?
>  1028 |                 start =3D memblock_phys_alloc_range(crash_size,
> SECTION_SIZE,
>       |
> ^~~~~~~~~~~~
>       |
> SECTIONS_SHIFT
> arch/arm/kernel/setup.c:1028:63: note: each undeclared identifier is
> reported only once for each function it appears in
> make[3]: *** [scripts/Makefile.build:289: arch/arm/kernel/setup.o] Error 1
>=20
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> meta data:
> -----------
>     git describe: next-20220128
>     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
>     git_sha: b605fdc54c2b28c30ef06d9db99282d8a32ae4be
>     target_arch: arm
>     kconfig: tinyconfig
>     toolchain: gcc-11
>=20
> Build log:
> -------------
> https://builds.tuxbuild.com/24JPvTrXx7HvkQtxoIXqZtZoZkA/
>=20
> Steps to reproduce:
> --------------------
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> # Original tuxmake command with fragments listed below.
>=20
> tuxmake --runtime podman --target-arch arm --toolchain gcc-11
> --kconfig tinyconfig
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org

Caused by commit

  35f56ebeffca ("arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef")

from Andrew's patch series.

I assume CONFIG_MMU is not set in tinyconfig for arm (so neither of
asm/pgtable-[23]level.h are included by asm/pgtable.h)?  CONFIG_KEXEC
depends on CONFIG_MMU.
--=20
Cheers,
Stephen Rothwell

--Sig_/WBFXjOTRkeblc9BBHNdrSIU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH0r14ACgkQAVBC80lX
0Gwv/Af9Fp1HS7K7aV2ileoeVzjQy3Dx2RbhkWSDvloO7Aa3mIbiCEbvNp+f5fA6
mMWcxQFnpwzAZ5iLv1pcJh0LuRiuSK9pCCVfgEWuGj4hT7S8DM5eA+yCqtJ7JBS1
DX8iKlVzA3VkcUwApU7Ewvr3IJ/U4ZurljHdXQmSDKvZKjXAT351FhSEUEOQxPzN
OOu6hjBE6F9NaHuhNxd7Mih4gMfJPcuEW9DJaGOkhu8vkpLUC1kTtE7pvn3GMkqP
UZAB60qQVRtc+rG1Buo+wmlqj5LWVH/uq14G/Ey7odEGTTcBRWfDqJaFlBrl6aKy
iuwT0rZZVeZfb509CbE9rw5nJqrN+Q==
=MdCu
-----END PGP SIGNATURE-----

--Sig_/WBFXjOTRkeblc9BBHNdrSIU--
