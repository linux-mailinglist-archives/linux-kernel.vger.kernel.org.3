Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E4591078
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiHLMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiHLMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:03:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E7AFAF4;
        Fri, 12 Aug 2022 05:03:44 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E503BFF80A;
        Fri, 12 Aug 2022 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660305821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJDSkuzgeV8CqTp6TkfD/obtXLV+oEiR4ZcU8k4v+ek=;
        b=NPJ7eC0zKp7U4oyJ4vf8ZxTJ0Je4iWxUBdKluIPWfjmqXkLsTFUv2FUqvOhOH8XVp8Onf6
        OGGltD1A9dvIegtAfnTODq70SwsvzOx/X15+IU76jR5+59z8+9kUXLMPCV2BFylPVPpzd7
        L0I+b5LEibDiTHpT44wEnE/IMvRbkN8YW8ZbbpvS8UsgD+zVHLV0P7wqmA0h+JLmfTEixd
        JoSFfrxBh1Ybi4jL0J7S1DctX7N8DKlGS4NaxOLECRqAYbar5NBp7Sdj9nN6hRUj8bFfhd
        9JgZDpuyT1/YMwpiun5Nk2ZQN1nV7f7gei2qeR8JBIKx2Sc2iWnrw4/FUK7xZQ==
Date:   Fri, 12 Aug 2022 14:03:37 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/8] phy: allwinner: phy-sun6i-mipi-dphy: Set enable bit
 last
Message-ID: <YvZBmZ+SfrJuAzAs@aptenodytes>
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cZWc4gSUKHi2eZD5"
Content-Disposition: inline
In-Reply-To: <20220812075603.59375-7-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cZWc4gSUKHi2eZD5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri 12 Aug 22, 02:56, Samuel Holland wrote:
> The A100 variant of the DPHY requires configuring the analog registers
> before setting the global enable bit. Since this order also works on the
> other variants, always use it, to minimize the differences between them.

Did you get a chance to actually test this with either DSI/CSI-2 hardware?
I vaguely remember that the order mattered. Do you have an idea of what the
Allwinner BSP does too?

Otherwise I could give it a try, at least with my MIPI CSI-2 setup
that uses the driver.

Cheers,

Pau

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/al=
lwinner/phy-sun6i-mipi-dphy.c
> index 625c6e1e9990..9698d68d0db7 100644
> --- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> +++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> @@ -183,10 +183,6 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy =
*dphy)
>  		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
>  		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
> =20
> -	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
> -		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
> -		     SUN6I_DPHY_GCTL_EN);
> -
>  	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
>  		     SUN6I_DPHY_ANA0_REG_PWS |
>  		     SUN6I_DPHY_ANA0_REG_DMPC |
> @@ -244,6 +240,10 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy =
*dphy)
>  			   SUN6I_DPHY_ANA2_EN_P2S_CPU_MASK,
>  			   SUN6I_DPHY_ANA2_EN_P2S_CPU(lanes_mask));
> =20
> +	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
> +		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
> +		     SUN6I_DPHY_GCTL_EN);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.35.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--cZWc4gSUKHi2eZD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmL2QZkACgkQ3cLmz3+f
v9FGyQf+P9y9cIf8pj9y0dDk8rWiTtCyuoScQ7U+K4YYW1ai+/FUC1qkgnDnOcjw
MLMI6hSgtI73b0JVFagBpmR2RuEhUnYLZzlmfKeA6+85XNe/7y873RpiDz+qonjj
MhPjOgfUgriStjzBdtL/uLVZZ7nIEmz7aRA4XstW6LbSjcY38zqEKGxdDq5Phfbt
dPK1i7nqSj8inGOrwr0Xky8movDO2Vp1+x+42RwX7YcgEX6haJLPUHLBkd5ccMFX
//EI0XVoSnw01M2G8iUaR4Zn1FAUrDaBTDkMPhurRdLb8iIxf4RCfWvV96G/kZv1
DpFCAGrSKoEKO9XZROsSggMoOSjC1g==
=EDd0
-----END PGP SIGNATURE-----

--cZWc4gSUKHi2eZD5--
