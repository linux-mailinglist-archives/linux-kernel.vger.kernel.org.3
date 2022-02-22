Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DD4C017C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiBVSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiBVShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:37:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB01E0AD5;
        Tue, 22 Feb 2022 10:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FE161583;
        Tue, 22 Feb 2022 18:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B962FC340E8;
        Tue, 22 Feb 2022 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645555017;
        bh=cZVj2to85O+PQ1olYQUt+4ZXnAEO+ZaqtiSsiAd1RxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncoQ56LcvCbF+u+RDOVbS5WMYctSGS9KigK1X7tIBDCpf74Mppj/zc3uqIC64Z9d7
         pYAHF4JeS9R8WeQ9VZ6Ohf7Ru0Enwxzv82bFJTbmaoEDgHitKd9yU2UOf6yhEChtaj
         6oqRzOakk4SoVpz6KkRFDaMSNxZhuT5aOguo4/tMK06cXL3kZno46ta0Z+Vi7+32mA
         V3bgzUfMx0ViTP9Lt5QYYLEZ1dGdmImasTwcgPolvCx7SGFJ43KcCGzycLAxUbOzcY
         tdvTN/SvINbmqyqyaVWC0wVc6ogksodwqUm8s88Mi5/u3DbKZG3Rd0cu11yYOsjcAL
         iL8vgnSPjplDA==
Date:   Tue, 22 Feb 2022 18:36:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Message-ID: <YhUtQ/8Kgcx4OY4S@sirena.org.uk>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-5-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2dt5HGRedkKEQZId"
Content-Disposition: inline
In-Reply-To: <20220222175611.58051-5-kyarlagadda@nvidia.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2dt5HGRedkKEQZId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2022 at 11:26:10PM +0530, Krishna Yarlagadda wrote:

> Add ACPI ID for Tegra QUAD SPI. Switch to common device property calls.
> Skip clock calls that are not updated in ACPI boot.

> @@ -1377,6 +1400,8 @@ static int __maybe_unused tegra_qspi_runtime_suspen=
d(struct device *dev)
>  	struct spi_master *master =3D dev_get_drvdata(dev);
>  	struct tegra_qspi *tqspi =3D spi_master_get_devdata(master);
> =20
> +	if (has_acpi_companion(tqspi->dev))
> +		return 0;
>  	/* flush all write which are in PPSB queue by reading back */
>  	tegra_qspi_readl(tqspi, QSPI_COMMAND1);

As well as clock stuff this is also skipping flushing of pending writes
- is that intentional?  It's not called out in the changelog and seems
like something that could cause issues if someone runs on a system where
the firmware does implement runtime suspend.

--2dt5HGRedkKEQZId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVLUIACgkQJNaLcl1U
h9B91Af/V0Mz9zlkixlXsHowRNpP67V4tM0YmpfXrzB6Y1fCXNS+xNOoCC7CqsD7
tkhG66C+UKCmENOKOso53ErNiSYDswdKQdawM8fEmRI0Bm2CNhyG6JayCeCmsgCx
v2AMcW2Kw0pNAWJzR0SqJzreyT7A+zc4IrSt0dq45CFesYbwiayeEX11vzhzEL6z
8WZwfG1N4bCKWQnt/Fhu7unGmM42hIuWB3dXKm7XZP3+3QxxwUNYOPE6ZSUn6Vyz
wS9jxAknsbiNB7Nd8fayHaQrBF8w3Tw6Kg4oNLAFx198yz87DvcCUUlr2c2W/zgs
WRAEZKb3NizNWeBI6yHA0py8jXNEvQ==
=n2OX
-----END PGP SIGNATURE-----

--2dt5HGRedkKEQZId--
