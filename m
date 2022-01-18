Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73CC492C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiARRmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:42:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56810 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiARRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:42:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA806123D;
        Tue, 18 Jan 2022 17:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0139C340E0;
        Tue, 18 Jan 2022 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642527722;
        bh=CYMf003Iq/DrB18YGBUbDhdfRptl/QHoELPBspzPY7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDAHsNvHKIL5MrFk6hUQlGQ+57uSdI0u/bXYS+ec4ftE3YAfTtm03vh7VpulHKiIV
         fYjI6A/pOsXocYll8WrB99SUAK8pWHwBQvdKeIy1XzFW9WAPugU/SLfRPCQU/mRDc9
         NoiZhDKxOnigysHXdYM898eLeW7FpEMfO9Kdp3lmZ6FPvkrdJCwp+VmOrFPE1AwyyA
         OzlC6Dfx1OUP68E6+eu9UErYNcPAE0e10av/qn001rmZCC9z2X1NmrX5Gc+Yr8pDQP
         HDxe06P2nKBMQkQimDuHNA2XXLYb5DEnEOiILjQcoPXK8dU66XEABJ5HXmtjHEd4Sk
         jiDDTULeNMHbw==
Date:   Tue, 18 Jan 2022 17:41:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, andyshevchenko@gmail.com,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Message-ID: <Yeb75aOOckAfNTTG@sirena.org.uk>
References: <cover.1642494310.git.lhjeff911@gmail.com>
 <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWj0J1tk77zuAC0Y"
Content-Disposition: inline
In-Reply-To: <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWj0J1tk77zuAC0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 18, 2022 at 04:42:38PM +0800, Li-hao Kuo wrote:

Looks mostly good - a couple of small nits below but nothing major.

> +static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
> +				       struct spi_transfer *xfer)
> +{

> +	for (i = 0; i <= xfer_cnt; i++) {
> +		mutex_lock(&pspim->buf_lock);

This lock is redundant: it is only ever held in this function which is
guaranteed by the core to never be called twice concurrently.

> +	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_master_irq,
> +			       IRQF_TRIGGER_RISING, pdev->name, pspim);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, pspim->s_irq, sp7021_spi_slave_irq,
> +			       IRQF_TRIGGER_RISING, pdev->name, pspim);
> +	if (ret)
> +		return ret;

Are you sure the driver is ready to handle interrupts without any of the
other resources?  Normally interrupts are one of the last things to be
requested.

--cWj0J1tk77zuAC0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm++QACgkQJNaLcl1U
h9AloQf/R9CmVeZkSoLiD5F1sjADwvC/s2mKlTHBm2WFheDAynPMLNrjKPMziv4c
9cbnuUMl8AIIX/G9B/XrE3htb9F4vOojNd9+uLyWbFuQlNwSFlNh0cqAnbg86r0U
hR74iH/g8JUN50VZrGGbYrvHv1T1tgI8LCXgMt9MaS1QBNiItnPhgTBy+VslAZS4
lt3iBzyD6mN0yrVlfWVlBHyYjjYq2EU5Zj0DOSCQ9ywT35KNCH26nUtjqPt8qdpa
hoDZ/vVbNxSMLKf2wZuADpm1JL9tSzlPmyER83CjNabeLrtZcuW2WDR5chtDZ06T
3ao2LoKq9N19CXXMB/lMypwT6cwkHw==
=2Z0W
-----END PGP SIGNATURE-----

--cWj0J1tk77zuAC0Y--
