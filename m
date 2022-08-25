Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742ED5A1040
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiHYMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiHYMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC289A9A4;
        Thu, 25 Aug 2022 05:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F1A61B5D;
        Thu, 25 Aug 2022 12:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE42C433D6;
        Thu, 25 Aug 2022 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661430079;
        bh=/4tyMqLwSYhTo6yY0rsvHIOoMQsngmHs6o8X1S+4aTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtMOVQdXhwpz7nIrnm5Gba5UnYa9i5CHqSeU3lPDnf9eyZpg/5kKEtdM+iorAF5Jh
         wZhDXbUlasf63yLILMis4Z11XsrekyklpzPwvwhwEcuTdVCLxMer8IAslnMxowOfvM
         FLLfiZlkWv1QAv1AdRamBCGPP4Axxo0Zpulaw0R/ayEPzvjX7eBTNqKExzWizCdgGZ
         3yci6tqVUFCFR4aWvXXNe4SlcRxa1NTQc28AE9bHJwemIsx1aywqdaKdxB8fNH6QGJ
         VfdxhX6ecWi0aoQbxuBrq0SajgDSZ10fYEqS6IUPolkdyQ1AAtF6Fl1m12vfi6MxX9
         XePoD94Sac6gg==
Date:   Thu, 25 Aug 2022 13:21:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christian =?utf-8?Q?Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
Subject: Re: [PATCH v4] regulator: core: Resolve supply name earlier to
 prevent double-init
Message-ID: <YwdpOX0xCzYwhjmx@sirena.org.uk>
References: <YvorNPDQQr2SH/NF@sirena.org.uk>
 <20220818124646.6005-1-christian@kohlschutter.com>
 <CGME20220825113251eucas1p247c3d57de823da148ca4790975a4aba8@eucas1p2.samsung.com>
 <58b92e75-f373-dae7-7031-8abd465bb874@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DbctYosMDif7tras"
Content-Disposition: inline
In-Reply-To: <58b92e75-f373-dae7-7031-8abd465bb874@samsung.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DbctYosMDif7tras
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 01:32:50PM +0200, Marek Szyprowski wrote:

> This patch landed recently in linux next as commit 8a866d527ac0=20
> ("regulator: core: Resolve supply name earlier to prevent double-init").=
=20
> Unfortunately it breaks booting of Samsung Exynos 5800 based Peach-Pi=20
> (arch/arm/boot/dts/exynos5800-peach-pi.dts) and Peach-Pit=20
> (arch/arm/boot/dts/exynos5420-peach-pit.dts) Chromebooks. The last=20
> message in the kernel log is a message about disabling 'vdd_1v2'=20
> regulator. This regulator is not used directly, however it is a supply=20
> for other critical regulators.

This suggests that supplies are ending up not getting bound.  Could you
perhaps add logging to check that we're attempting to resolve the supply
(in the


+       if ((rdev->supply_name && !rdev->supply) &&
+                       (rdev->constraints->always_on ||
+                        rdev->constraints->boot_on)) {

block)?  I'd also note that it's useful to paste the actual error
messages you're seeing rather than just a description of them.

--DbctYosMDif7tras
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMHaTgACgkQJNaLcl1U
h9DLYQf7B64bhLUc+XVLb50HyPYEuouG6CPrbSDpaP2LdPCV5ijkpdYx+xOImms8
VBIpJzR27r14ovgqmLn839wTIJn+tHa5YPfe4OdvLeJRwq5Luwb8kwnJiVk9I7nk
MTSkpYAV2naDRV9mqNxCvgNo3EtW5Gz627m7uNoWhV8qHkv/kk2eN2s8tJ7d+nEM
/MQSdJtZEHk25mHtPVrWuX4Z6ejmYJTjI7ltGXb6jOvL5lKzDJSJyD2uLDlTJDKT
B9lOMJEMxffHThMkAqZzSHT7YpIGnsiyIdlhMAAcTTiE/GhXk5ZOfKp0tq9IPORr
bAX1v/mTHcPq/XgOiHRZ4V70Yac+jA==
=bQca
-----END PGP SIGNATURE-----

--DbctYosMDif7tras--
