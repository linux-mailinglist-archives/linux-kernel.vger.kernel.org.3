Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B74B250C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiBKL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:57:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiBKL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:57:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629BEF59;
        Fri, 11 Feb 2022 03:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27FB619D7;
        Fri, 11 Feb 2022 11:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8AFC340E9;
        Fri, 11 Feb 2022 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580640;
        bh=Ldm8EIHYQkasgOKAyJYfBnfhmYzcyDdgCKPot/eIAKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVN/tu7d46VUpGsP/aB2HlzKRep/f4FLtWEiS4B8ITy+aVMgZUSYPr3Zeox/LWTeE
         1LBl195xbe/y0SHR6KPmmhUh/Q1H5R8VH5kzdy82My44bWuE4dSayeShRL3L/ALyZE
         OTZ1Isj2Cjg/zIZWbBh20CaUrCpK7nlK5NNsx5mIJl3n6KXgF+WLVTQVwz5aVbdqD2
         Cz8Vw52wkCDUY2wbSsU63O7Gu3X4rYaCdkbBxD9Dishad9a1uXl3iDTvLztNZTj5SB
         WspQPTbKt9OH60RC6Xifx7S+uHZcgLjrzE/X6xF+icNjz5v+cMMirR7D4vp6bQae27
         J1QiwLBJdYDCw==
Date:   Fri, 11 Feb 2022 11:57:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     Tom Rix <trix@redhat.com>, Li-hao Kuo <lhjeff911@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH] spi: Fix warning for Clang build
Message-ID: <YgZPGyMjJ10eK/SG@sirena.org.uk>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
 <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
 <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
 <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NvE0JsC/dVXmBGff"
Content-Disposition: inline
In-Reply-To: <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NvE0JsC/dVXmBGff
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 04:59:00AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:
> Yes. I think the function can be simplified as follows

> static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, str=
uct spi_device *spi,
> 				       struct spi_transfer *xfer)
> {
> 	struct sp7021_spi_ctlr *pspim =3D spi_master_get_devdata(ctlr);
> 	struct device *dev =3D pspim->dev;
> 	int ret;
>=20
> 	mode =3D SP7021_SPI_IDLE;
> 	if (xfer->tx_buf && xfer->rx_buf) {
> 		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
> 		return -EINVAL;

Since only unidirectional transfers are supported...

> 	} else if (xfer->tx_buf) {
> 		xfer->tx_dma =3D dma_map_single(dev, (void *)xfer->tx_buf,
> 					      xfer->len, DMA_TO_DEVICE);
> 		if (dma_mapping_error(dev, xfer->tx_dma))
> 			return -ENOMEM;
> 		ret =3D sp7021_spi_slave_tx(spi, xfer);
> 	} else if (xfer->rx_buf) {
> 		xfer->rx_dma =3D dma_map_single(dev, xfer->rx_buf, xfer->len,
> 					      DMA_FROM_DEVICE);
> 		if (dma_mapping_error(dev, xfer->rx_dma))
> 			return -ENOMEM;
> 		ret =3D sp7021_spi_slave_rx(spi, xfer);
> 	}
>=20
> 	if (xfer->tx_buf)
> 		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
> 	if (xfer->rx_buf)
> 		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);

=2E..you could even fold the unmapping into the if/else tree above.
Otherwise this looks good to me, please send a patch.

--NvE0JsC/dVXmBGff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGTxsACgkQJNaLcl1U
h9B+TAf/YCtAIAmkCrNTybdoi5JUfqSpnQIzE8Q9UGKolsOIQLunISnaeNXtPFCu
K7h1RDK3bMlFZghiE7dtitnI2QhbCJXTaH7mmqhYD224nq/41RNvrvFoy++Cn3H5
jeGrWoVrwXqDmRbCrrXXKI2nzSMWienupaPT2gXVjSmJWRCne2YP3sa79DRGhV8F
5ZeBGh5ZLj6EEOrVJ2lx1OLd5bDhLOq1AZ+ZSBsMEvYXHYT0QDQ7xHdtmx6zSnZb
YyXNrzFWb+GRgub6eVxDec5ki9uWwbsaRcVTcbBbDAiHX6MHMwmrLutXouYiOmcp
XRkcoDiQlzVuaYIfpWbC8PW3KjiFyg==
=0iSE
-----END PGP SIGNATURE-----

--NvE0JsC/dVXmBGff--
