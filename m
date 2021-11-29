Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE24616E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhK2Nrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhK2Npk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:45:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21047C08EC74;
        Mon, 29 Nov 2021 04:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA6CB80EE5;
        Mon, 29 Nov 2021 12:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBDC53FCE;
        Mon, 29 Nov 2021 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638188847;
        bh=E5i6DFSVI4jA9y4loEyL6K4AOYrtzhJ3Mj+wiiM39UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rC+HsB+rQU7cQ2DGY/SENyf8O/IbKCXH2z6uqabnulyrUepxqLQnI2cpE/dc0Vj70
         9EtvZLPnGz7xLth5zts5G5ulROIgs8ljulGCPMIuIdL3Sj8ayxlvEktBiMZbVbHTXP
         2sdGnJcvpTwlCSm2lC8cBTKZZGuGVTvDGVoir2WC98bar9+gwA3bViz8TojXbRBfFD
         GEcB5LuERQ+nwz81GO/FfupzUih5mmUCzGSfEOZH6sDHxDjvHxLSPyvgaGA7Kpba3Q
         1yXh5HiZOzRM+j8vuV6668PP3qzkOKIEfcwWRmK1jJjVMwwgitdqcjTNJrw6NdhMUZ
         o3eW+zpnVeADw==
Date:   Mon, 29 Nov 2021 12:27:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
Message-ID: <YaTHKuohUNt/hVLq@sirena.org.uk>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
 <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7UU9/U8laDFRwE1"
Content-Disposition: inline
In-Reply-To: <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7UU9/U8laDFRwE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 29, 2021 at 09:09:30AM +0000, Krishna Yarlagadda wrote:

> > > +#ifdef CONFIG_ACPI
> > > +	if (ACPI_FAILURE(acpi_evaluate_object(ACPI_HANDLE(tqspi->dev),
> > > +					      "_RST", NULL, NULL)))
> > > +		dev_err(tqspi->dev, "failed to reset device\n"); #endif

> > What happens when this runs on a DT system?

> For a DT system reset handle would be present and this code will not run

This code is really unclearly structured, the early return doesn't
match the normal kernel style and the ifdefs aren't helping with
clarity.  Please restructure it so it's clear that *both* cases have
checks for the correct firmware type being present.

That said frankly I'd expect this handling of ACPI reset to be pushed
into the reset code, it's obviously not good to be open coding this in
drivers when this looks like it's completely generic to any ACPI object
so shouldn't be being open coded in individual driers especially with
the ifdefery.  Shouldn't the reset API be able to figure out that an
object with _RST has a reset control and provide access to it through
the reset API?

--Y7UU9/U8laDFRwE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGkxykACgkQJNaLcl1U
h9Crpwf+M2lKT8k9MyiOlgGyvbaUGlT/K1iYeMFMcHUTxpJHq5PFnxqGd50jKqLB
OTdmmuNZ+WxSrhirzI+/IrppEbORlp9P1xhrIqTnLYqQZ+2dR9IbxY5OnZ2Usy01
43yPEhfoK69045WPWw9RyQ4a/u+FxI+k+jA/zwbB390VNr0XVoc7JXXHhPhdZy/2
VvcWTJF4Bs2ld4IR/bhQKmMxfR+g3jYACgJl6orlxUPU4GL8Gm+kAVDw+9iT3MgM
C4j3dfKnlh2vB6V5j6roleO7jjst2AhuU8ADzYqFeDfLViMEuJ3XjExr5d6qoFgJ
q8uZgkg7+I21aOg2b3UlEg4KbRGmmA==
=rb4w
-----END PGP SIGNATURE-----

--Y7UU9/U8laDFRwE1--
