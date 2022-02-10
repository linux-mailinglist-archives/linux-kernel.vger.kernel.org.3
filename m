Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEE4B0C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiBJLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbiBJLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:17:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B19CED;
        Thu, 10 Feb 2022 03:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0610CB824B3;
        Thu, 10 Feb 2022 11:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D18CC004E1;
        Thu, 10 Feb 2022 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644491825;
        bh=TMs8T46JkhWD17MU6Q6kh4Ty1QD38Xu9BdNDq7RPTHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhUQ3edk3MzLW571/PRloWrgytbXeIkRYXtXwriXcR/RI7lDwDXHiuUTqZelb1aj1
         6NHtzGGg1lNzCtJkIURNfxgMmZp5+RQt+wkFCopAOmBW0Sjg2ttpKB16Rt9+llEonP
         u6v8pi3P+sGxrByQRxTjhUsSR2HKCuIpempJ1D8C3tbOuux2BRN15ZyE9+Nb/R6cRb
         NorK7yUttFb5fjf2/2Dnrpfhu+GqJCxh2PAYkoPW7GjIpRNnWIm9xdfhltbn0RwBJ2
         l+26CbuBJIaYmXPl4JxrG5T9do5TIkqzlPcmLs2uyv7QRB4omzGCw8fqaItTCAs9Us
         qfb02/AR36n4w==
Date:   Thu, 10 Feb 2022 11:17:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com, trix@redhat.com
Subject: Re: [PATCH] spi: Fix warning for Clang build
Message-ID: <YgT0LMcDpCEYHFYg@sirena.org.uk>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwzCgcqywFylgluh"
Content-Disposition: inline
In-Reply-To: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwzCgcqywFylgluh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 10:36:56AM +0800, Li-hao Kuo wrote:

> -	int mode, ret;
> +	int mode, ret =3D 0;
> =20
>  	mode =3D SP7021_SPI_IDLE;
>  	if (xfer->tx_buf && xfer->rx_buf) {
> @@ -403,7 +403,7 @@ static int sp7021_spi_slave_transfer_one(struct spi_c=
ontroller *ctlr, struct spi
>  		ret =3D sp7021_spi_slave_rx(spi, xfer);
>  		break;
>  	default:
> -		break;
> +		return -EINVAL;

The return here means that the initialization is now redundant and will
stop the compiler spotting any future similar issues which isn't ideal.

--rwzCgcqywFylgluh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIE9CwACgkQJNaLcl1U
h9Du2wf/ZFQpNNtaTfjfELwDwMTkD6jFtGX/unYD+BAxcNttpg8+FKYN2j9l4rm+
wv+erGt9aIahmuN0SMZaQCYfhyky7rJH6Mhmte4Kiu5sqtLTu9es8+pavaDKx7ll
SZ9IKd99bNHeHVm6jJ79zu85DsjvRMhXSpNLriX0WbfUNiUc1NeyfbbAiAsYitEe
G7zVQgUBu7CtkorU3/AGS/UYJJciPX5C5A/+TpEZzKkmhqxhNjkLf+KEn7OKPyzc
gdTadqmPydu46MpW9bF8Zl5OS5YW4xmVcmfQRRyoF3AmcBk3zxhpRFyshh5BYpwp
ELaQSc01Z3E59r1IFLaPa4usbPo6IQ==
=95y6
-----END PGP SIGNATURE-----

--rwzCgcqywFylgluh--
