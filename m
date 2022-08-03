Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6924588F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiHCPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiHCPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:02:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DF23343E;
        Wed,  3 Aug 2022 08:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C33E3B822B6;
        Wed,  3 Aug 2022 15:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D396C433D6;
        Wed,  3 Aug 2022 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659538954;
        bh=mG9KuClzuGA1M1GHAHw7JDlXdOb4ykyi/EyfmWqDpfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbeYB2OsSGg7giWrkT7Sptux3c4hyupzhiA6jsBptzRGyo8oswcP5gjNiZnmV5mmM
         1k2e9iOHfAZKJm0WaqNQHNw4G1e8Vob8fV0hGqJqnLxWRE8FDXPIpjWErTVlHHLOmR
         YmwrNYsC0ZM96EL0x2C3chgl2BQJ+O+peJEuNgICrYGMIFiLHmyuWEFBULg2IG9ZB/
         4/wjXDj0mujuwy7yWv/3p8Pd9x0K17qegzD76xPjg80N73wGSC2OIcAJ7//Lzm1Wh5
         kxfd4e7juT4enx8FmNCbxKIlqzuZ3fS3DZmkTXPOJVuYSfuUNQ8je8/sWTy9YZByiq
         ua5USfFotdYsQ==
Date:   Wed, 3 Aug 2022 16:02:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bitbang: Fix lsb-first Rx
Message-ID: <YuqOBYJSP8Pm7Bz5@sirena.org.uk>
References: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VPCBSpUrVeeiBXd"
Content-Disposition: inline
In-Reply-To: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VPCBSpUrVeeiBXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2022 at 03:58:57PM +0100, Robin Murphy wrote:
> Shifting the recieved bit by "bits" inserts it at the top of the
> *currently remaining* Tx data, so we end up accumulating the whole
> transfer into bit 0 of the output word. Oops.
>=20
> For the algorithm to work as intended, we need to remember where the
> top of the *original* word was, and shift Rx to there.

So if this never worked we presumably have some systems out there which
somehow rely on the old behaviour that we need to fix somehow - copying
in everyone from the original change...

> Fixes: 1847e3046c52 ("spi: gpio: Implement LSB First bitbang support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/spi/spi-bitbang-txrx.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txr=
x.h
> index 267342dfa738..2dcbe166df63 100644
> --- a/drivers/spi/spi-bitbang-txrx.h
> +++ b/drivers/spi/spi-bitbang-txrx.h
> @@ -116,6 +116,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
>  {
>  	/* if (cpol =3D=3D 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
> =20
> +	u8 rxbit =3D bits - 1;
>  	u32 oldbit =3D !(word & 1);
>  	/* clock starts at inactive polarity */
>  	for (; likely(bits); bits--) {
> @@ -135,7 +136,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
>  		/* sample LSB (from slave) on leading edge */
>  		word >>=3D 1;
>  		if ((flags & SPI_MASTER_NO_RX) =3D=3D 0)
> -			word |=3D getmiso(spi) << (bits - 1);
> +			word |=3D getmiso(spi) << rxbit;
>  		setsck(spi, cpol);
>  	}
>  	return word;
> @@ -148,6 +149,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
>  {
>  	/* if (cpol =3D=3D 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
> =20
> +	u8 rxbit =3D bits - 1;
>  	u32 oldbit =3D !(word & 1);
>  	/* clock starts at inactive polarity */
>  	for (; likely(bits); bits--) {
> @@ -168,7 +170,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
>  		/* sample LSB (from slave) on trailing edge */
>  		word >>=3D 1;
>  		if ((flags & SPI_MASTER_NO_RX) =3D=3D 0)
> -			word |=3D getmiso(spi) << (bits - 1);
> +			word |=3D getmiso(spi) << rxbit;
>  	}
>  	return word;
>  }
> --=20
> 2.36.1.dirty
>=20

--3VPCBSpUrVeeiBXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqjgUACgkQJNaLcl1U
h9ALeAf/difGM2lFAlzO+P43em34PQsDdeREDNtiCsJ88CtKzfyDaTPzIwqQ14Of
6lmj9dF2TdmBsQCa4j4db+RDA2tl2tQO8aWCoyYNbSVzj94/ck2yoiAIfbtM3UzU
d8N83zetC8iyzBiMaisdZQYwVa6kGGQP/oHMp1S0P88MEc2MGw0kT9O94iDutRON
Sk4oKEtOjYh/ID+Uv92J+145GnJlvXBsRJG2RB6X4lZ+unuOq9epdv6uKMXhSgDV
DnfzGUshW+P42XDjtGsqUShxpKZieU7XPK1Etzg/AkZCIbidQupPBL72c8DFQraW
kSBBGavACfbeU3N9JPBrVLUh6bWIlw==
=xJUg
-----END PGP SIGNATURE-----

--3VPCBSpUrVeeiBXd--
