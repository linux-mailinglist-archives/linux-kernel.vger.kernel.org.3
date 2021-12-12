Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F3471EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhLLXmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:42:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLLXmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:42:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BCE2B80D96;
        Sun, 12 Dec 2021 23:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB5C341C5;
        Sun, 12 Dec 2021 23:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639352519;
        bh=lk3mH8kKukrxhG2a4RLtcMc6cr6amu36lxEwuKTR6d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyetZoiMYnRGGR0Pqr155Sn348ArG4QuH1FuY4QEyFeezzEz71GbNe674poyMyydG
         ZyVFRngYZuLLsgttv3qn6XC4TjWEcqgbxx0EVaLFMGxKIrM7mYooHoVfk2Dwx0TrxE
         0EuAv3qTMt3q94686EkGsT8MKg/Pcy9gEa0/I4uI5lmOBdO+4BMPkqM8P39I7UZJJU
         9AcPSzwiW6gVJeOT5NETWQpuaEMykTz86TxBMmiPrjIO73bCNxxTB7MElOJaVYaC11
         jF7tUSoBUzMxCapFSlMnZcB8WhwC+EZffH4NiquQE4TvUaTudtCDnj3N5IEUk81ERo
         lyI1pnoKFhAJA==
Date:   Sun, 12 Dec 2021 23:41:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <YbaIwa/9utI9SD1u@sirena.org.uk>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fw7hCEaJSL+sKRan"
Content-Disposition: inline
In-Reply-To: <20211212034726.26306-4-marcan@marcan.st>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fw7hCEaJSL+sKRan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 12, 2021 at 12:47:26PM +0900, Hector Martin wrote:

This looks pretty good - one small issue and several stylistic nits
below.

> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple SoC SPI device driver
> + *

Please keep the entire comment a C++ one so things look more
intentional.

> +#define APPLE_SPI_DRIVER_NAME           "apple_spi"

This is referenced exactly once, just inline it.

> +	/* We will want to poll if the time we need to wait is
> +	 * less than the context switching time.
> +	 * Let's call that threshold 5us. The operation will take:
> +	 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
> +	 *    200000 * bits_per_word * fifo_threshold <= hz
> +	 */
> +	return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <= t->speed_hz;

Some brackets or an intermediate variable wouldn't hurt here, especially
given the line length.

> +	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
> +	bool poll = apple_spi_prep_transfer(spi, t);
> +	const void *tx_ptr = t->tx_buf;
> +	void *rx_ptr = t->rx_buf;
> +	unsigned int bytes_per_word = t->bits_per_word > 16 ? 4 : t->bits_per_word > 8 ? 2 : 1;

Please don't abuse the ternery operator like this - just write normal
conditional statements, they're much easier to read.  In general the
driver is a bit too enthusiastic about them and this one is next level.

> +static int apple_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	/* Disable all the interrupts just in case */
> +	reg_write(spi, APPLE_SPI_IE_FIFO, 0);
> +	reg_write(spi, APPLE_SPI_IE_XFER, 0);

Since the driver registers with the SPI subsystem using devm and
remove() gets run before devm gets unwound we still potentially have
transfers running when the driver gets removed and this probably isn't
going to cause them to go well - obviously it's an edge case and it's
unclear when someone would be removing the driver but we still shouldn't
do this.

> +static const struct of_device_id apple_spi_of_match[] = {
> +	{ .compatible = "apple,spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_spi_of_match);

This is an awfully generic compatible.  It's common to use the SoC name
for the IP compatibles when they're not otherwise identified?

--fw7hCEaJSL+sKRan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG2iL4ACgkQJNaLcl1U
h9B7KAf/dw2gSXKdNc0SFqWT4zq6Br3cGhgpr+Ql4v0TopsLRwZNYbC027D/mxt7
7aatw+PW0ybjWhN5LrZVsrEm7eB1OJ9qCZbLAU6b3HqcYMP5gAWjaSyxUSI4BM2H
I2qocLLnLhbFKOZXTWbux4wbvCbmq/DSmu/8EbdIgCqyEEI/duF0Fu2hpx1N0zCE
gm5JWZc5/Ctrqe7S26zwQvhw/oVEICFYTg3Mv5rRGBrwYD+HXh+iYrezXBhqDOTL
srLamb6c6iU2n3Q6RgCx7l90ok/eUfkeqOWXHKVvW8g8qmwHgOLugNyM/W9nOraz
w78bBG8XuCztz8tpg9eBUMWT6WSNnQ==
=zg23
-----END PGP SIGNATURE-----

--fw7hCEaJSL+sKRan--
