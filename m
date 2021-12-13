Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EB473344
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhLMRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhLMRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:54:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3DC061574;
        Mon, 13 Dec 2021 09:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1890A6118A;
        Mon, 13 Dec 2021 17:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DA6C34602;
        Mon, 13 Dec 2021 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639418088;
        bh=qk6Bi7thbB3v296C67QONIDxHVUP0X+qynXl9syyNEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgPt4xEQghPOo/XV5QV+GLw7CBXeviHCRtRsKI+DauZwZekbcueyjjgDF/f0Osu03
         OGOnkHrdwD8wzt2N3zXQMcP1+h4vef2y0r4Ypy2l1f+u3zuTwFKEvirMdZUBwX2bch
         uRBsKrg3cnTTJ7RSIivudnOCkuyKoNUB8+HYWOMwIeEuOnn4u1lf/xr71ciasP8KDR
         oihP80f2K+sM7RUx0i5Ke+8LBoRg0YAW+op4jxizWt+Ite43e7PzWsS3iTYRFw9L9a
         9VC/i0oyQTQWzQzkzsm5vxmwwmzj2YAdkqYtWti9Y3XPNWyunSfyLmeNlFtb6Gbj75
         1Wi5dI846GZZQ==
Date:   Mon, 13 Dec 2021 17:54:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <YbeI45NiYnhMzCSk@sirena.org.uk>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
 <YbaIwa/9utI9SD1u@sirena.org.uk>
 <d566c897-ee7d-f32f-1548-57f037c69c89@marcan.st>
 <YbdtLFSrwjYcz/zz@sirena.org.uk>
 <d87ae109-4b58-7465-b16e-3bf7c9d60f1f@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MptNy4LA5HttZAK1"
Content-Disposition: inline
In-Reply-To: <d87ae109-4b58-7465-b16e-3bf7c9d60f1f@marcan.st>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MptNy4LA5HttZAK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 14, 2021 at 02:10:26AM +0900, Hector Martin wrote:
> On 14/12/2021 00.56, Mark Brown wrote:
> > On Mon, Dec 13, 2021 at 12:50:49PM +0900, Hector Martin wrote:

> > > > Some brackets or an intermediate variable wouldn't hurt here, especially
> > > > given the line length.

> > > How about this?

> > > return (200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2) <= t->speed_hz;

> > That's better but it's still a very long line which is half the issue.

> I think it's quite readable at this point (especially with the comment above
> explaining it anyway). Note that these days a lot of people consider lines
> up to 100 chars okay in the kernel, and checkpatch uses that limit. Do you
> have a specific change in mind?

The 100 characters is a "don't send silly checkpatch fixes" thing not a
target to aim for (see also the ternery operator stuff).  Like I said an
intermediate variable wouldn't hurt, for example for the FIFO trigger
level into a fifo_trigger variable.

> > There's currently a bit of a fashion for people with very old SPI blocks
> > to make incompatible new versions recently, a lot of it seems to be
> > driven by things like flash engine support.  Sometimes these things end
> > up getting instantiated together as they have different purposes and the
> > incompatibilties make the IPs larger.

> I think if they haven't changed it by now they probably won't; e.g. they
> tacked on DMA using a coprocessor instead of changing the block itself. I
> don't think Apple uses SPI for anything performance-critical. They don't
> even bother with QSPI for the NOR flash (which is mostly only used for
> bootloaders and variable storage).

This feels like tempting fate but I guess...

> > Have you done a contrast and compare with the Samsung driver?  Given
> > both this and your comments above about this dating back to the original
> > iPhone...

> You mean the *two* Samsung drivers? :-)

> It seems Samsung like to keep making up incompatible SPI blocks. This one
> shares a *few* bits in a *couple* registers with spi-s3c24xx driver, which
> point to a common lineage, but those registers aren't even at the same
> addresses. Not enough in common for it to make sense to try to use one
> driver for both (unlike with UART, where it was close enough to be added as
> a new Samsung UART variant, or I2C, where we could refactor the pasemi
> driver to add a platform backend alongside the existing PCI support and
> mostly use it as-is).

Their older SPI block has quite a few issues IIRC, I think DMA was the
big difference between the two but ICBW.

--MptNy4LA5HttZAK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3iOMACgkQJNaLcl1U
h9BrzQf/W82Fz9nvRR9H3dlCsuqCikPA3hH/AoM04l8YuQwBAK1QDHA9LnM5I0vl
Sh7ykeZIsSG24jYrXvvQLR74yapBrU0M/LlmLUCDO50T2BqxeuM+d2B3qJ5Us/CO
apICVuEqxBccwZYe9ZHR03mGeDOmEAYqc/K9UwMiIRgHzf4bpN4W3GJb54VWXWrK
kgUVSbRgledypK5C2Kwh9ez3n7BXrR/Ka5x/Ne7l+90L62z24YFPnmAVNmhCaRCe
jWlj9rawudJfkcP/3gSmAg0CrsYtfw0P9xe5KB14mjhDEq2Y+W8tLzc77IbCEJX7
k6osUrmnWPJk6pIrIxNTfUMi97xTlw==
=Rsct
-----END PGP SIGNATURE-----

--MptNy4LA5HttZAK1--
