Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1C4DCD82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiCQSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiCQSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D7E125F;
        Thu, 17 Mar 2022 11:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A80616F4;
        Thu, 17 Mar 2022 18:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A26C340E9;
        Thu, 17 Mar 2022 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647541426;
        bh=gmfgy7LaF0s0gaVSHa3My66L5FxCF3tKWU8s+3gPVcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZdqNsG+9B6h8iDeFvDDSlK7pjPIk/wJ7cRBXbHRnnEa0BPBv2LSlOzvkB8C2CRVGy
         xuevyRTZejPvRJzVxTib0kVE8UA+XsQs1J1UbkRTsdRzbTAZhHI7ZluWiHUSoC7K3Y
         s1B3e7rwmQQdlgp3OViomrEhc7/6dPm3E7MWUw89GwLdvB1fPI3exIC7sj6LusACci
         IAHIgngy2Hy+GU6MMP8RNJilSfbPxUVtQEu70TsvPyPTNn+ApilQ8qoI02RaAX/liS
         aTuM6Ja4A5WSXpDtgyD0zSeHWLzlhPLKtdK0uSt30US1xG7umAP8SVufEofSmNOKQt
         CeugymxZC6Ogg==
Date:   Thu, 17 Mar 2022 18:23:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, krisman@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: amd: Configure device speed
Message-ID: <YjN8rOiCNssuOf2M@sirena.org.uk>
References: <20220317141453.15868-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2K0O4UsjGkkSmnk"
Content-Disposition: inline
In-Reply-To: <20220317141453.15868-1-andrealmeid@collabora.com>
X-Cookie: What foods these morsels be!
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I2K0O4UsjGkkSmnk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 11:14:53AM -0300, Andr=E9 Almeida wrote:

> Create mechanism to configure device clock frequency. For now, it can
> only set the device to use the maximum speed.

This changelog doesn't really tell me what the patch does - what is the
mechanism?  What exactly do you mean by "use the maximum speed" and why
aren't the normal speed setting interfaces supported?

> +/* Set device speed to the maximum frequency supported */
> +static bool max_speed;
> +module_param(max_speed, bool, 0644);

It s very surprising to have a module parameter for this, we should be
setting it by quirk.  If this is system specific presumably it's
possibly per controller system specific so a module parameter doesn't
cut it, and in general we don't have device specific command line quirks
like this.

> +static const struct amd_spi_freq amd_spi_freq[] =3D {
> +	{ AMD_SPI_MAX_HZ,   F_100MHz,         0},
> +	{       66660000, F_66_66MHz,         0},
> +	{       50000000,   SPI_SPD7,   F_50MHz},
> +	{       33330000, F_33_33MHz,         0},
> +	{       22220000, F_22_22MHz,         0},
> +	{       16660000, F_16_66MHz,         0},
> +	{        4000000,   SPI_SPD7,    F_4MHz},
> +	{        3170000,   SPI_SPD7, F_3_17MHz},
> +	{ AMD_SPI_MIN_HZ,   F_800KHz,         0},
> +};

This looks like a table of specific clock frequencies.  Why not just
implement the standard interface for setting the speed of SPI transfers?

> +static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
> +{
> +	unsigned int i, spd7_val, enable_val;
> +
> +	if (speed_hz =3D=3D amd_spi->speed_hz)
> +		return 0;
> +
> +	if (speed_hz < AMD_SPI_MIN_HZ)
> +		return -EINVAL;

Why not just check to see if we don't find a matching value in the
table?

> +	for (i =3D 0; i < ARRAY_SIZE(amd_spi_freq); i++) {
> +		if (speed_hz >=3D amd_spi_freq[i].speed_hz) {
> +			if (amd_spi->speed_hz =3D=3D amd_spi_freq[i].speed_hz)
> +				return 0;
> +
> +			amd_spi->speed_hz =3D amd_spi_freq[i].speed_hz;

This would be easier to read if it were refactored so that the code
applying the setting is factored out of the loop looking for a matching
entry in the table - that way most of the code would have less
indentation.

> +			enable_val =3D (amd_spi_freq[i].enable_val << AMD_SPI_ALT_SPD_SHIFT)
> +				     & AMD_SPI_ALT_SPD_MASK;
> +			amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, enable_val,
> +					       AMD_SPI_ALT_SPD_MASK);

So enable_val is actually the value to write to _ALT_SPD in _ENA_REG?
It might be clearer to call it alt_spd or something.  I have to say that
the use of set and clear on the same bitfield in the same operation is
surprising and I'd have to go and check the implementation to verify
that the set happens after the clear - it would be helpful to have an
_update_bits() style helper for these operations, it's more directly
what's being done.

> +
> +			if (amd_spi->speed_hz =3D=3D AMD_SPI_MAX_HZ)
> +				amd_spi_setclear_reg32(amd_spi, AMD_SPI_ENA_REG, 1,
> +						       AMD_SPI_SPI100_MASK);

This is the same register as above - could things be combined, and also
doesn't the operation need to be reversed if we ever set a speed other
than the maximum?

--I2K0O4UsjGkkSmnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIzfKwACgkQJNaLcl1U
h9BusQf8CrslqKuE1jo4Z69ncAfOSENzXAESWwjN8wblrz50HZRy+T+e/VxnVGLT
91zjPJEwuFBd0iXQCVxZjdHV1VoDJJrHz48S358jfR0fgae4WtsUBvPgaJg/6gvT
UIvN7thNOQU/ZfYZcmvsOJ3vFbpC62oKpIVWCzExvGKltAkoet4bn12vatrtL6bg
LMt60tEcr0lHON6lnXQRABW/CBa1fKX+3r8MTXs2PpOUXwCdMxPApvPOD2ZEwk8K
6ad7lTkKGxdVLurJ3AMvkFhY6LSNGdoU5W0IwGWCz7AK2hSD53b6g+Hs/HB32K8E
use4zAF2deLgbO2o0j3UFqL1iLjbQQ==
=ljba
-----END PGP SIGNATURE-----

--I2K0O4UsjGkkSmnk--
