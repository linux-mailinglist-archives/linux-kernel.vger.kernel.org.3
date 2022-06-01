Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D4539EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiFAHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbiFAHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75C9CC88
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212EF612FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B292C385A5;
        Wed,  1 Jun 2022 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654069841;
        bh=PRgKqGr8Kck04Yn5U47Mvt1hxhk7Huy5KP4Y5la+pnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpHqCHW5xU5xuJ04MQacUZTNL7hl0VmJUD5NOP4VrmOVD7Gg+D1VG8iJIVkepEP6V
         U2bjo9vpiwsouLEzzS05ctExfiJ6CUU2+niUcskEn1aJ0nQtXt6bHUkQe/ZFIiRaIt
         mvxSHlgrRSkj4NlWV97MSR1PWmMRD53vqOUNN+0ry5VgVScZm4GEfpNQQeV7Z/8GhY
         GthgjFpHlshtuaAFK5MKNfrlC/aDUKaJMARe/7tc27VBH+LG6R6vouZPaiVN7ElWRb
         tMiqmxi7Yf9+jvEwuMXWjp1eHlw3hOZT3I4/xMH3o655JVE207B03NTq5dI25JgWfM
         kwyX6xxDgShJQ==
Date:   Wed, 1 Jun 2022 09:50:39 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference
 of noderef expression
Message-ID: <YpcaTwI4SvV3IrwF@sirena.org.uk>
References: <202205280635.XKlMkfKD-lkp@intel.com>
 <YpZJBoxqvaCLRQfX@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IO56PR2s3EuDY7aL"
Content-Disposition: inline
In-Reply-To: <YpZJBoxqvaCLRQfX@arm.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IO56PR2s3EuDY7aL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2022 at 05:57:42PM +0100, Catalin Marinas wrote:

> This looks wrong indeed. IIUC, something like below but waiting for Mark
> to confirm:
>=20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 819979398127..ac521b3403d6 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1965,7 +1965,7 @@ void __efi_fpsimd_end(void)
>  							   0,
>  							   SVCR_SM_MASK);
>  					if (!system_supports_fa64())
> -						ffr =3D efi_sm_state;
> +						ffr =3D false;

Yes, that looks right - feel free to add my Reviewed-by or I'll
do that when I see the patch sent properly.

--IO56PR2s3EuDY7aL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKXGk8ACgkQJNaLcl1U
h9BhUAf9FRg75H4oV4i/BwM7cGHEToFEzf56u9rqFEdInDw0ljrQDX7aLerEwY+A
bpZY2Vd3KKkb+wPDi9vlIYTCAyhPzbEW7V5Lui4BTk22XxP+soTvYVKOn1N6zSbs
XQr6JzHq3iN3yJRGtTO84kjIRvHqnr15gnJCJJxdNOndSqUWAIJChs2mpQbuvKSg
/UKDHv5Dv1Bp6vSjrK7ftVd24QVT8uIOteXEKwwNCGnCMXq5pIitboYcju7aKEv8
PHsDO+mbqg1FV5Vs69h+D6S4W1+yhDBqZXgNZBlw8Gos5HwkGM/TgLwpMtcqdP40
Ukm2Y6aY0UUHBWIfTmvjqOFK2AWJag==
=uyNY
-----END PGP SIGNATURE-----

--IO56PR2s3EuDY7aL--
