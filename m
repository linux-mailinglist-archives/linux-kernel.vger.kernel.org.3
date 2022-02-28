Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150754C6DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiB1NVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiB1NVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:21:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40F78074;
        Mon, 28 Feb 2022 05:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A1E3CE13C2;
        Mon, 28 Feb 2022 13:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF064C340F8;
        Mon, 28 Feb 2022 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054418;
        bh=o/CvXx4X3p45ofJ1pzjZHgKPmpguRZfGlNKzR8f6Wg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOCgrTzYxfN3PRYdBeY1pfySaOpypqEADWnAswRz6i4EysaTBmq/klKbpRh/xR/Cl
         Wv2exoh0EMUDWNaNhpOVTmBGv6nVtbUKLMtNOXj2W9rxz29zxGNPrtOVyIbB6WO80C
         rqBRzejL5iOgdgGsLeKZrbws5W0TiHbFqvWO9pcx0bGSq8R/0VjkPwanM5D5gVwgko
         iSBaDHp1ETR28H7A7cqs69jhPVEGH4dYOkTLkaHwUH8P5sHJiqyiZ4qB6oLqfNjqVg
         rytQbIppmX0DsxO3DCJua/ieak6JXn3iYRdJo27JDYRl3JLZ4iAgo52wDGsc+1qKO5
         vSEPBPPf/x+ng==
Date:   Mon, 28 Feb 2022 13:20:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: fsl-spi: Implement trailing clock mode
Message-ID: <YhzMDU5kz3QERByJ@sirena.org.uk>
References: <cover.1645950971.git.christophe.leroy@csgroup.eu>
 <f66ae24b31f10f7c3a999a77a6cfab7b2d073c6a.1645950971.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G9LOwKe7hVjk3Nvl"
Content-Disposition: inline
In-Reply-To: <f66ae24b31f10f7c3a999a77a6cfab7b2d073c6a.1645950971.git.christophe.leroy@csgroup.eu>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G9LOwKe7hVjk3Nvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 27, 2022 at 11:00:35AM +0100, Christophe Leroy wrote:

> +	if (!status && spi->mode & SPI_TRAILING) {
> +		struct spi_transfer t = {
> +			.len = 1,
> +			.tx_buf = "",
> +			.bits_per_word = 4
> +		};
> +
> +		status = fsl_spi_setup_transfer(spi, &t);
> +		if (!status)
> +			status = fsl_spi_bufs(spi, &t, 0);
> +	}
> +	m->status = status;

This seems to be begging for a generic implementation in the core rather
than being driver specific - drivers would for the most part need
updating to advertise less than 8 bit per word transfers but the basic
operation isn't really device specific and it pretty much fits with the
existing interfaces.

--G9LOwKe7hVjk3Nvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIczAwACgkQJNaLcl1U
h9DioAf/XkajEKaFraLURr6txXU0HOAdW2tQn6oxElgs6zI8nyqHP8FgwzT4QadB
upxIj0Zvs/Rjykn1pORMsVquc75dojQ7fz4KsM+ldYRRXJEnI6jDsoqKZlCmAVRs
+3uA6xjRmEVh+GhHrsYFjrA9EZS1GYgXOVFx9V5HQ6xM5e5K1C3pDFIgu8qo3++R
1YGlEr1F0MTTpQSv6EuFaXQmCd02u4ASeuqRsIa0PfnVX4qemsaRBWm6PIR3FxNf
dJ393Fz4WNiFIDpx4M4h9FWzfAbKszLn1g2YlONdGjTfr6QEAogyJxXgealyQL8y
O541q+NuNjAIsUrynwJ9HLFri3ds5w==
=C/rm
-----END PGP SIGNATURE-----

--G9LOwKe7hVjk3Nvl--
