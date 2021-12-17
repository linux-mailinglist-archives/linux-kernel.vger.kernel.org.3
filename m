Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAE4792EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhLQRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLQRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:38:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B3C061574;
        Fri, 17 Dec 2021 09:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04CFB6235A;
        Fri, 17 Dec 2021 17:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0F8C36AE1;
        Fri, 17 Dec 2021 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639762690;
        bh=KSC69LXmJ2qmcuLX64LjAPcS+rqMlLkKGLTIFI495DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRd88ETNhn+5XiLKxtzhzU3EotCdanKOz6id7uZxj80YPbXipqGO9SI3FhBPYSyQB
         wDtx5EWbixwbjP1V89uodfeoFEgQMpeeNZNWx+5hjU+pe8osuPHnUlFqKKi/0mEGvu
         Q7aO/2t1t1JBXNSKo9wrkrg2UGgNuuEfOHq8uF21s+26kfypfb9vGIWTKJuU5sEnPb
         gcIY6wRjIZS6Pxj6gxtOs33vqaMXGQ3DFoVKDftHjE7FR8+k1NFTLSkRzX2ufmwtdU
         UjxjKeeWaHYsxrLoJqVwnkFnTDOuQ/TJCrgwP9z7FR6vk2bQXEPb5ajVBA0yvWiOWe
         W7B85I9akMQWA==
Date:   Fri, 17 Dec 2021 17:38:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, andyshevchenko@gmail.com,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH v4 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YbzK/Xm8hONUc5w6@sirena.org.uk>
References: <cover.1639123362.git.lhjeff911@gmail.com>
 <65fb77debacc95ed3f54adac978ba24f2470f92e.1639123362.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HmoM7nfQl5bJDP3e"
Content-Disposition: inline
In-Reply-To: <65fb77debacc95ed3f54adac978ba24f2470f92e.1639123362.git.lhjeff911@gmail.com>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HmoM7nfQl5bJDP3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 10, 2021 at 05:02:47PM +0800, Li-hao Kuo wrote:

> +static irqreturn_t sp7021_spi_sla_irq(int irq, void *dev)
> +{
> +	struct sp7021_spi_ctlr *pspim = dev;
> +	unsigned int data_status;
> +
> +	data_status = readl(pspim->sla_base + SP7021_DATA_RDY_REG);
> +	writel(data_status | SP7021_SLA_CLR_INT, pspim->sla_base + SP7021_DATA_RDY_REG);
> +	complete(&pspim->sla_isr);
> +	return IRQ_NONE;
> +}

This will always return IRQ_NONE even if the interrupt actually fired -
that should eventually cause genirq to complain that there's a problem
with the interrupt never being handled I think (though perhaps if the
interrupt stops asserting it'll pick up on that).  It should return
IRQ_HANDLED if there was something asserted in SP7021_DATA_RDY_REG.

Apart from that one thing this all looks good as far as I can see.

--HmoM7nfQl5bJDP3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8yvwACgkQJNaLcl1U
h9ALmgf7Bm9dw9gaf7ABbuXZjiSxKbhiiGExGh0sWRWYIMo8Bj5n3jO1Pi1FlX42
LxUseRCZKZ2Un3jHTKyIMWF1BlDgQ+k6l51grVAyee4tiFlXPbwNMHy/NAznXbTw
zdeDkyRjkCistTaoFx0PNk9x1Tu5SS0c6ngBhGuvh2aiJO1p4a4rdTDukGK4vYWH
z6oecHYKRWA07wokpJc+jJMQZguqz0vFpztuv8X3E9vh95JC2uYKDWn7bN2eym56
Svfj3bzUA8EZxF/jrQexFpWG6k8CzSBQMPXPh9HcFTgzByxAZjx62nn4Yw7qbX3n
wK5iGFS+OfyhpsF9M0J7dFeKe4g4Dg==
=qqgm
-----END PGP SIGNATURE-----

--HmoM7nfQl5bJDP3e--
