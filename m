Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0304D7D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiCNI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiCNI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF41C124
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E2261248
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3391BC340E9;
        Mon, 14 Mar 2022 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246521;
        bh=S9vix76jdKI5gsBNVAg7Bm5LQCqseW4E3hDfbQ3wg50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQfp85B2ZE7JeU6Qdva0EXqN6lI2FhtvPCGZl+Z4PfK3YBItf7vEdI4kczNhJI06A
         y5UC9XQ8zfErT3zjCMVCul4vIH6CB6w0uCXFwrcxTCwf9JhzN0k57NGqvRbUkmQoHe
         cdcXSjhAGEx2t8dnw3t/MaxZIC9z2iPJlc6GYrInOPCw/U4dll8Zx9sg4dN+yxD2RX
         03/XRPzmzfbv2FirRrjPdyMkiZglGLhLUt5h2180g0gIIwES1g6Mc75RdFEBrZTCy4
         nm5JEq6NTOnj3HVlhPFS/vmX3vE6gcaZb02elu2na60566cWqxK0alvmkUT8YxuCj6
         +WAdOiUIjKXOQ==
Date:   Mon, 14 Mar 2022 08:28:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v1 2/2] regmap: allow a defined reg_base to be added to
 every address
Message-ID: <Yi78tDT3t7mcGtEn@sirena.org.uk>
References: <20220313224524.399947-1-colin.foster@in-advantage.com>
 <20220313224524.399947-3-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvDae/BQZC9yMxsy"
Content-Disposition: inline
In-Reply-To: <20220313224524.399947-3-colin.foster@in-advantage.com>
X-Cookie: Most of your faults are not your fault.
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gvDae/BQZC9yMxsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 13, 2022 at 03:45:24PM -0700, Colin Foster wrote:

> There's an inconsistency that arises when a register set can be accessed
> internally via MMIO, or externally via SPI. The VSC7514 chip allows both
> modes of operation. When internally accessed, the system utilizes __iomem,
> devm_ioremap_resource, and devm_regmap_init_mmio.

> For SPI it isn't possible to utilize memory-mapped IO. To properly operat=
e,
> the resource base must be added to the register before every operation.

The problem here isn't the mixed buses, the problem is that the hardware
designers have for some unknown reason decided to not use the same
register addresses on the two buses which just seems pointlessly
unhelpful.

>=20
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  drivers/base/regmap/internal.h | 1 +
>  drivers/base/regmap/regmap.c   | 6 ++++++
>  include/linux/regmap.h         | 3 +++
>  3 files changed, 10 insertions(+)
>=20
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/interna=
l.h
> index 88f710e7ce31..b4df36c7b17d 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -63,6 +63,7 @@ struct regmap {
>  	regmap_unlock unlock;
>  	void *lock_arg; /* This is passed to lock/unlock functions */
>  	gfp_t alloc_flags;
> +	unsigned int reg_base;
> =20
>  	struct device *dev; /* Device we do I/O on */
>  	void *work_buf;     /* Scratch buffer used to format I/O */
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 1c7c6d6361af..5e12f7cb5147 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -821,6 +821,8 @@ struct regmap *__regmap_init(struct device *dev,
>  	else
>  		map->alloc_flags =3D GFP_KERNEL;
> =20
> +	map->reg_base =3D config->reg_base;
> +
>  	map->format.reg_bytes =3D DIV_ROUND_UP(config->reg_bits, 8);
>  	map->format.pad_bytes =3D config->pad_bits / 8;
>  	map->format.reg_downshift =3D config->reg_downshift;
> @@ -1736,6 +1738,7 @@ static int _regmap_raw_write_impl(struct regmap *ma=
p, unsigned int reg,
>  			return ret;
>  	}
> =20
> +	reg +=3D map->reg_base;
>  	reg >>=3D map->format.reg_downshift;
>  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
>  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
> @@ -1907,6 +1910,7 @@ static int _regmap_bus_formatted_write(void *contex=
t, unsigned int reg,
>  			return ret;
>  	}
> =20
> +	reg +=3D map->reg_base;
>  	reg >>=3D map->format.reg_downshift;
>  	map->format.format_write(map, reg, val);
> =20
> @@ -2349,6 +2353,7 @@ static int _regmap_raw_multi_reg_write(struct regma=
p *map,
>  		unsigned int reg =3D regs[i].reg;
>  		unsigned int val =3D regs[i].def;
>  		trace_regmap_hw_write_start(map, reg, 1);
> +		reg +=3D map->reg_base;
>  		reg >>=3D map->format.reg_downshift;
>  		map->format.format_reg(u8, reg, map->reg_shift);
>  		u8 +=3D reg_bytes + pad_bytes;
> @@ -2677,6 +2682,7 @@ static int _regmap_raw_read(struct regmap *map, uns=
igned int reg, void *val,
>  			return ret;
>  	}
> =20
> +	reg +=3D map->reg_base;
>  	reg >>=3D map->format.reg_downshift;
>  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
>  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 40fb9399add6..de81a94d7b30 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -239,6 +239,8 @@ typedef void (*regmap_unlock)(void *);
>   *              used.
>   * @reg_downshift: The number of bits to downshift the register before
>   *		   performing any operations.
> + * @reg_base: Value to be added to every register address before perform=
ing any
> + *	      operation.
>   * @pad_bits: Number of bits of padding between register and value.
>   * @val_bits: Number of bits in a register value, mandatory.
>   *
> @@ -363,6 +365,7 @@ struct regmap_config {
>  	int reg_bits;
>  	int reg_stride;
>  	int reg_downshift;
> +	unsigned int reg_base;
>  	int pad_bits;
>  	int val_bits;
> =20
> --=20
> 2.25.1
>=20

--gvDae/BQZC9yMxsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIu/LMACgkQJNaLcl1U
h9DgMggAhHwzoLr4vFg+j5raGGM7r0hgzpyWSwew/U+iIF0xR0/LEDIcMB8gU19y
WwICivyWZRdLMWKnwwL9FbAORU35kg2menajYjZ3+jkidX3Ay+RJ6Z9Vp/7aENxQ
g+xAXTMUon1s5CY8OKYud+eEwY2wiNNqhkl1DYE8kxAJkH4bf2rBf4WRxD64jUM4
SeRagTjpbHOvDYGfIBQ+MMJm/Ppbf4YfHPBR4Tmu+ZU/HRha6NfdPbMQEyu+9F+V
MsFpeuC0vqmdPSwZvCgwVIXcPv8oE6GIOEY5fUeWwtth9RCZgPcBSYOru6zQ/JOS
BNyFli7S/RVIEM7gp6ePD76MgE/L4Q==
=xLi+
-----END PGP SIGNATURE-----

--gvDae/BQZC9yMxsy--
