Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7B54FB42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383138AbiFQQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiFQQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:37:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F149243
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:37:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2Ey7-0007cZ-1m; Fri, 17 Jun 2022 18:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2Ey4-0015oi-MY; Fri, 17 Jun 2022 18:37:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2Ey4-00H0DT-Vg; Fri, 17 Jun 2022 18:37:08 +0200
Date:   Fri, 17 Jun 2022 18:37:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Kbuild: change CONFIG_FRAME_WARN for 32-bit
Message-ID: <20220617163702.fqyomgoknvinlq6u@pengutronix.de>
References: <20220617150922.1878926-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vvxfvo7nyze7l5k"
Content-Disposition: inline
In-Reply-To: <20220617150922.1878926-1-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vvxfvo7nyze7l5k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

your To: was empty, I wonder if that was on purpose?!

On Fri, Jun 17, 2022 at 05:08:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The introduction of CONFIG_GCC_PLUGIN_LATENT_ENTROPY raised the
> warning limit for 32-bit architectures to a much higher value in
> 2016. Initially this had no effect for Arm machines as their kernels
> tend to be cross-compiled, and the feature detection for the plugin did
> not work with common cross compilers.
>=20
> I could not find the original regression report that led to the warning
> limit getting raised, but I have been unable to reproduce this with gcc-12
> and linux-5.18 -- all frame sizes appear to be be below the normal 1024
> byte limit on at least arm32 and i386.
>=20
> However, the KASAN feature introduced later on does raise the frame size
> of a number of functions above the warning limit, in almost all cases to
> somewhere below 1280 bytes. The effect is that an arm allmodconfig build
> produces no warnings because of the check for the latent entropy plugin,
> but a normal KASAN based build with gcc does produce build warnings or
> failures when CONFIG_WERROR is set.
>=20
> The 1280 byte limit is an arbitrary choice here, as it disables almost
> all warnings but leaves a few outliers that are probably better addressed
> with code changes. There are a number of functions that are just below the
> normal 1024 byte limit at the moment, and an extra 256 bytes for those
> is within the expectation, but more than that is probably an indication
> of a bad design or a real bug.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3da5f9acb966..8a3afd837e99 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -387,9 +387,9 @@ endif # DEBUG_INFO
>  config FRAME_WARN
>  	int "Warn for stack frames larger than"
>  	range 0 8192
> -	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>  	default 2048 if PARISC
>  	default 1536 if (!64BIT && XTENSA)
> +	default 1280 if (!64BIT && KASAN_STACK)
>  	default 1024 if !64BIT
>  	default 2048 if 64BIT
>  	help

I wasn't aware this was configurable with a Kconfig symbol.

Thanks for addressing that issue, the reasoning looks good and right.
I just now noticed you explained your findings earlier in irc, only
found them because I digged my irc logs for my original report to you.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6vvxfvo7nyze7l5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKsraYACgkQwfwUeK3K
7Am13wgAht/EoLIfsWbf01mPJ4JarrmTBuxvcJRWOGPorV9nmUkfVpopm/uNctk+
Gcag/FXrsgkSbTcM29QN6ziWWgCK08ashS0YFNr1069GCuiTVISlXB2cUoDFYVbf
o4WQdz0uYvHKJGbWHLbgnaOxnjp3B1X5uujI5k2AL4CeaD7VG4fVBBic4g3lzkdh
HibLDNrIFFdM3jp/BrQZwrXrusVhkbWn7PO9L4wpD9lSYB9OgCDGu4qHJOCz1DGL
UQx8FhbPNcG2PLtVfWNCAyaq5q+rpmLlpZnLOkmLzAG3FGsF5XEDIhccgs+5IyDi
V95j9pAzlh/UBYyHJAxD9/Zknefp4Q==
=ledw
-----END PGP SIGNATURE-----

--6vvxfvo7nyze7l5k--
