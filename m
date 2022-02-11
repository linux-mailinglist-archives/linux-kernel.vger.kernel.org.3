Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A84B24BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiBKLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:48:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiBKLsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:48:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FFCF1;
        Fri, 11 Feb 2022 03:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A31B61A2F;
        Fri, 11 Feb 2022 11:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A7BC340E9;
        Fri, 11 Feb 2022 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580111;
        bh=YoCVOJggdhVgQz5b42wFoa68cSdGl/d4Njs42FeDO4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HttKNvu1EEIIaVqh72OV3ri6kgbwsSa2NWzQhYw047IZmzoazzb4sryRTUc+rUd3+
         PzqwbJDBOJ53y3E4JV55CuwyD/ofxsisIYnCT1nmDqgTO7zg+nsrvKS5QDxzELKoUQ
         qFsiqc9SZoIu5btb3BmgM+BxlNbakU36kDt/G/c3dru6AED3pt0iOrFoKkqlE30z1S
         lpXWvRtOiqExiT0gr86ugKFJJvCENouYtXpw1FSBXNBuKiNqkiExl0yyKwcnaDjV6z
         V/4POKs+I1VS0SRDYfNk8IzuuWggjAITLOtF2O723xrpePyRvtEfgljQKZI2czGUB1
         zEcCkismY9I1A==
Date:   Fri, 11 Feb 2022 11:48:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 5/6] spi: rockchip: Support cs-gpio
Message-ID: <YgZNCoYeArYTECYC@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-5-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JOcgAXEiGUZsEFyr"
Content-Disposition: inline
In-Reply-To: <20220211034344.4130-5-jon.lin@rock-chips.com>
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


--JOcgAXEiGUZsEFyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 11:43:41AM +0800, Jon Lin wrote:
> 1.Add standard cs-gpio support
> 2.Refer to spi-controller.yaml for details
>=20
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
>=20
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None

Why is this the one patch in the series with any versioning information?

> -		ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
> -				      BIT(spi->chip_select));
> +		if (spi->cs_gpiod)
> +			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
> +		else
> +			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, BIT(spi->chip_sele=
ct));

This appears to be making the device control chip select 0 if a GPIO
chip select is used - that's going to work poorly if there's a device
using that chip select.  It should be fine to prohibit that
configuration if the hardware requires that a GPIO be controlled,
especially if the native chip select can be pinmuxed to a GPIO, but it
ought to be at least documented that this won't work and ideally
detected.

--JOcgAXEiGUZsEFyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGTQoACgkQJNaLcl1U
h9DjPwf+OfcmObP2QW45XxCOJbf7uVjeWK5FG6A+YWwUTRr4kndfSY5uRxnkZLGC
Kat9Z5P6BA4GLywzjFEWEoMotmyycFVQUOi0wrcCt/0ApT1GT3CqQcd69iEOBxpl
KHgJjajQfjUt8N+sLjfVa4aX64khXYR6bIe9VwiVhGh4HgjKYaK1IeXVI/DvgGnl
3gDqab+XiU/6O9AByXRIeAJFKaBJldHaEqG5nLRMiFrzusZ6iVOfGRFLCkNTfak4
crACzQi+lc/Ue+ihwOpAHqZz4lJgY0k7GnIpULj+SqFH8aVPrRW+zUXXuGnHeamB
7GKhEofIYj5SFkrd+luilKBU36pHPQ==
=rrmN
-----END PGP SIGNATURE-----

--JOcgAXEiGUZsEFyr--
