Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3564730FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhLMP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:56:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbhLMP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:56:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1EE76115B;
        Mon, 13 Dec 2021 15:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45393C34602;
        Mon, 13 Dec 2021 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639410993;
        bh=3FGWIya7q7VvGFx4Lkkcd0Ne7ihM+mYzlpUX97z0UNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VP1+gsD0rXjVlGo5TX2Xt9z7yb/w6/tTvBPkNytu5AaJl9pqoyL+K2WPy6+WvKZ+k
         7DENnYuGy0pIZ3Ja6/5FwPKCyyJrGGNEjV0/+VhRxjUMJv7wFLbmXRPMc4DfzTaIkl
         3kTQ3r0muW4fAqeOzuab5VUg9lL2Xrti2TiuUZ2UeSfjC3/d+VUYPT6PRvX5QCBjAy
         Rrbo9Bm3XNNG2PSYFASUbgV87Vqj71cXgyAH6SmrLuOabZGeX/5UGspY29seVlX31U
         afY29edg+UhEaOqsxBj8D1u32khMKY8+MuvgJBAHnyoLM1xm1E9TDLkpRvoIYcmvB6
         bUKf7FKr/Q6KA==
Date:   Mon, 13 Dec 2021 15:56:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <YbdtLFSrwjYcz/zz@sirena.org.uk>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
 <YbaIwa/9utI9SD1u@sirena.org.uk>
 <d566c897-ee7d-f32f-1548-57f037c69c89@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hVycDoLG7hCwps6L"
Content-Disposition: inline
In-Reply-To: <d566c897-ee7d-f32f-1548-57f037c69c89@marcan.st>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hVycDoLG7hCwps6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 13, 2021 at 12:50:49PM +0900, Hector Martin wrote:
> On 13/12/2021 08.41, Mark Brown wrote:
> > On Sun, Dec 12, 2021 at 12:47:26PM +0900, Hector Martin wrote:

> > > @@ -0,0 +1,566 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Apple SoC SPI device driver
> > > + *

> > Please keep the entire comment a C++ one so things look more
> > intentional.

> I thought this pattern was pretty much the standard style.

It's common, especially given all the automated conversions, but ugly.

> > > +	/* We will want to poll if the time we need to wait is
> > > +	 * less than the context switching time.
> > > +	 * Let's call that threshold 5us. The operation will take:
> > > +	 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
> > > +	 *    200000 * bits_per_word * fifo_threshold <= hz
> > > +	 */
> > > +	return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <= t->speed_hz;

> > Some brackets or an intermediate variable wouldn't hurt here, especially
> > given the line length.

> How about this?

> return (200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2) <= t->speed_hz;

That's better but it's still a very long line which is half the issue.

> > > +static const struct of_device_id apple_spi_of_match[] = {
> > > +	{ .compatible = "apple,spi", },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, apple_spi_of_match);

> > This is an awfully generic compatible.  It's common to use the SoC name
> > for the IP compatibles when they're not otherwise identified?

> Apple like to keep blocks compatible across SoC generations - I think this
> one dates, at least to some extent, to the original iPhone or thereabouts.
> We do use per-SoC compatibles in the DTs in case we need to throw in per-SoC
> quirks in the future ("apple,t8103-spi", "apple,spi"), but for drivers like
> this we prefer to use generic compatibles as long as backwards compatibility
> doesn't break. If Apple do something totally incompatible (like they did
> with AIC2 in the latest chips), we'll bump to something like apple,spi2.
> This happens quite rarely, so it makes sense to just keep things generic
> except for these instances. That way old kernels will happily bind to the
> block in newer SoCs if it is compatible.

There's currently a bit of a fashion for people with very old SPI blocks
to make incompatible new versions recently, a lot of it seems to be
driven by things like flash engine support.  Sometimes these things end
up getting instantiated together as they have different purposes and the
incompatibilties make the IPs larger.

> If we had a detailed lineage of what SoCs used what blocks and when things
> changed we could try something else, like using the first SoC where the
> specific block version was introduced, but we don't... so I think it makes
> sense to just go with generic ones where we don't think things have changed
> much since the dark ages. FWIW, Apple calls this one spi-1,spimc and claims
> "spi-version = 1" and the driver has Samsung in the name... so the history
> of this block definitely goes back quite a ways :-)

Have you done a contrast and compare with the Samsung driver?  Given
both this and your comments above about this dating back to the original
iPhone...

--hVycDoLG7hCwps6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3bSsACgkQJNaLcl1U
h9Bzdwf+PGHs9oh8m1YUtFsWJbVlGeTVE/c3v5RRT2+tdSdxxMZvly6i9WXg7HvJ
CS/CU9DD4Eyx2uaRh8ULfNBz50PweySACW0FZhFVDlOmPTYLHSFEDcQ9yVMV+xjc
yYW3lcovDQ0zlvtBj0BbeI9l2K9cR7Iro98W5Vaa0DjdD9NpLeTfqxR++ZbWKe2s
DjqL0MI5ZCxplrr192B/L3IrD87J22nEO6J/VCNTRoXmkXbkQj/hjXLwE43BBg9A
fhuJTnmffWmLZTAVWp589+Pow69vF0fDHoXgbCUJGhb7h+y+kTzShIu6/N75bI6P
6YUOGHhSYBAQEKRWPSIEQTiVvZu9zQ==
=mLOb
-----END PGP SIGNATURE-----

--hVycDoLG7hCwps6L--
