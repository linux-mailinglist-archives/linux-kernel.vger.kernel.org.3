Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC44D0558
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiCGRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiCGRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:38:06 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319808F9AD;
        Mon,  7 Mar 2022 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1646674626; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VPg7tVTG05IVaRuXCwoMmbPC0+mZEfleGOuxTVt05Y=;
        b=Na7NNibdC0c9uW7eYGWqOvj4PxyVc428EVT7lTAxooru/aikh/BqEWfQ3KoUjJW6Qjomnc
        MqBvJoM6QJKK5d6BwfiMGNoupypbCyS9n2T3Ch2wKRKN+Z9CFb+wl16XndliCIOTHy7KQv
        ulZ3caZG8mgChvbd6UayiyslfhBaPwk=
Date:   Mon, 07 Mar 2022 17:35:45 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] pinctrl: ingenic: Fix regmap on X series SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <L7YD8R.AHQE1WAT7PG92@crapouillou.net>
In-Reply-To: <20220224145821.518835-1-aidanmacdonald.0x0@gmail.com>
References: <20220224145821.518835-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le jeu., f=E9vr. 24 2022 at 14:58:22 +0000, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The X series Ingenic SoCs have a shadow GPIO group which is at a=20
> higher
> offset than the other groups, and is used for all GPIO configuration.
> The regmap did not take this offset into account and set max_register
> too low, so the regmap API blocked writes to the shadow group, which
> made the pinctrl driver unable to configure any pins.
>=20
> Fix this by adding regmap access tables to the chip info.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v1:=20
> https://lore.kernel.org/linux-mips/20220209230452.19535-1-aidanmacdonald.=
0x0@gmail.com/
>=20
>  drivers/pinctrl/pinctrl-ingenic.c | 53=20
> ++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 2712f51eb238..074c94edd90b 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -119,6 +119,9 @@ struct ingenic_chip_info {
>  	unsigned int num_functions;
>=20
>  	const u32 *pull_ups, *pull_downs;
> +
> +	unsigned int max_register;
> +	const struct regmap_access_table* access_table;
>  };
>=20
>  struct ingenic_pinctrl {
> @@ -228,6 +231,7 @@ static const struct ingenic_chip_info=20
> jz4730_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4730_functions),
>  	.pull_ups =3D jz4730_pull_ups,
>  	.pull_downs =3D jz4730_pull_downs,
> +	.max_register =3D 4 * 0x30 - 4,
>  };
>=20
>  static const u32 jz4740_pull_ups[4] =3D {
> @@ -337,6 +341,7 @@ static const struct ingenic_chip_info=20
> jz4740_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4740_functions),
>  	.pull_ups =3D jz4740_pull_ups,
>  	.pull_downs =3D jz4740_pull_downs,
> +	.max_register =3D 4 * 0x100 - 4,
>  };
>=20
>  static int jz4725b_mmc0_1bit_pins[] =3D { 0x48, 0x49, 0x5c, };
> @@ -439,6 +444,7 @@ static const struct ingenic_chip_info=20
> jz4725b_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4725b_functions),
>  	.pull_ups =3D jz4740_pull_ups,
>  	.pull_downs =3D jz4740_pull_downs,
> +	.max_register =3D 4 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4750_pull_ups[6] =3D {
> @@ -576,6 +582,7 @@ static const struct ingenic_chip_info=20
> jz4750_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4750_functions),
>  	.pull_ups =3D jz4750_pull_ups,
>  	.pull_downs =3D jz4750_pull_downs,
> +	.max_register =3D 6 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4755_pull_ups[6] =3D {
> @@ -741,6 +748,7 @@ static const struct ingenic_chip_info=20
> jz4755_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4755_functions),
>  	.pull_ups =3D jz4755_pull_ups,
>  	.pull_downs =3D jz4755_pull_downs,
> +	.max_register =3D 6 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4760_pull_ups[6] =3D {
> @@ -1089,6 +1097,7 @@ static const struct ingenic_chip_info=20
> jz4760_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4760_functions),
>  	.pull_ups =3D jz4760_pull_ups,
>  	.pull_downs =3D jz4760_pull_downs,
> +	.max_register =3D 6 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4770_pull_ups[6] =3D {
> @@ -1429,6 +1438,7 @@ static const struct ingenic_chip_info=20
> jz4770_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4770_functions),
>  	.pull_ups =3D jz4770_pull_ups,
>  	.pull_downs =3D jz4770_pull_downs,
> +	.max_register =3D 6 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4775_pull_ups[7] =3D {
> @@ -1702,6 +1712,7 @@ static const struct ingenic_chip_info=20
> jz4775_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4775_functions),
>  	.pull_ups =3D jz4775_pull_ups,
>  	.pull_downs =3D jz4775_pull_downs,
> +	.max_register =3D 7 * 0x100 - 4,
>  };
>=20
>  static const u32 jz4780_pull_ups[6] =3D {
> @@ -1966,6 +1977,7 @@ static const struct ingenic_chip_info=20
> jz4780_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(jz4780_functions),
>  	.pull_ups =3D jz4780_pull_ups,
>  	.pull_downs =3D jz4780_pull_downs,
> +	.max_register =3D 6 * 0x100 - 4,
>  };
>=20
>  static const u32 x1000_pull_ups[4] =3D {
> @@ -2179,6 +2191,17 @@ static const struct function_desc=20
> x1000_functions[] =3D {
>  	{ "mac", x1000_mac_groups, ARRAY_SIZE(x1000_mac_groups), },
>  };
>=20
> +static const struct regmap_range x1000_access_ranges[] =3D {
> +	regmap_reg_range(0x000, 0x400 - 4),
> +	regmap_reg_range(0x700, 0x800 - 4),
> +};
> +
> +/* shared with X1500 */
> +static const struct regmap_access_table x1000_access_table =3D {
> +	.yes_ranges =3D x1000_access_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(x1000_access_ranges),
> +};
> +
>  static const struct ingenic_chip_info x1000_chip_info =3D {
>  	.num_chips =3D 4,
>  	.reg_offset =3D 0x100,
> @@ -2189,6 +2212,7 @@ static const struct ingenic_chip_info=20
> x1000_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(x1000_functions),
>  	.pull_ups =3D x1000_pull_ups,
>  	.pull_downs =3D x1000_pull_downs,
> +	.access_table =3D &x1000_access_table,
>  };
>=20
>  static int x1500_uart0_data_pins[] =3D { 0x4a, 0x4b, };
> @@ -2300,6 +2324,7 @@ static const struct ingenic_chip_info=20
> x1500_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(x1500_functions),
>  	.pull_ups =3D x1000_pull_ups,
>  	.pull_downs =3D x1000_pull_downs,
> +	.access_table =3D &x1000_access_table,
>  };
>=20
>  static const u32 x1830_pull_ups[4] =3D {
> @@ -2506,6 +2531,16 @@ static const struct function_desc=20
> x1830_functions[] =3D {
>  	{ "mac", x1830_mac_groups, ARRAY_SIZE(x1830_mac_groups), },
>  };
>=20
> +static const struct regmap_range x1830_access_ranges[] =3D {
> +	regmap_reg_range(0x0000, 0x4000 - 4),
> +	regmap_reg_range(0x7000, 0x8000 - 4),
> +};
> +
> +static const struct regmap_access_table x1830_access_table =3D {
> +	.yes_ranges =3D x1830_access_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(x1830_access_ranges),
> +};
> +
>  static const struct ingenic_chip_info x1830_chip_info =3D {
>  	.num_chips =3D 4,
>  	.reg_offset =3D 0x1000,
> @@ -2516,6 +2551,7 @@ static const struct ingenic_chip_info=20
> x1830_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(x1830_functions),
>  	.pull_ups =3D x1830_pull_ups,
>  	.pull_downs =3D x1830_pull_downs,
> +	.access_table =3D &x1830_access_table,
>  };
>=20
>  static const u32 x2000_pull_ups[5] =3D {
> @@ -2969,6 +3005,17 @@ static const struct function_desc=20
> x2000_functions[] =3D {
>  	{ "otg", x2000_otg_groups, ARRAY_SIZE(x2000_otg_groups), },
>  };
>=20
> +static const struct regmap_range x2000_access_ranges[] =3D {
> +	regmap_reg_range(0x000, 0x500 - 4),
> +	regmap_reg_range(0x700, 0x800 - 4),
> +};
> +
> +/* shared with X2100 */
> +static const struct regmap_access_table x2000_access_table =3D {
> +	.yes_ranges =3D x2000_access_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(x2000_access_ranges),
> +};
> +
>  static const struct ingenic_chip_info x2000_chip_info =3D {
>  	.num_chips =3D 5,
>  	.reg_offset =3D 0x100,
> @@ -2979,6 +3026,7 @@ static const struct ingenic_chip_info=20
> x2000_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(x2000_functions),
>  	.pull_ups =3D x2000_pull_ups,
>  	.pull_downs =3D x2000_pull_downs,
> +	.access_table =3D &x2000_access_table,
>  };
>=20
>  static const u32 x2100_pull_ups[5] =3D {
> @@ -3189,6 +3237,7 @@ static const struct ingenic_chip_info=20
> x2100_chip_info =3D {
>  	.num_functions =3D ARRAY_SIZE(x2100_functions),
>  	.pull_ups =3D x2100_pull_ups,
>  	.pull_downs =3D x2100_pull_downs,
> +	.access_table =3D &x2000_access_table,
>  };
>=20
>  static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8=20
> reg)
> @@ -4168,7 +4217,9 @@ static int __init ingenic_pinctrl_probe(struct=20
> platform_device *pdev)
>  		return PTR_ERR(base);
>=20
>  	regmap_config =3D ingenic_pinctrl_regmap_config;
> -	regmap_config.max_register =3D chip_info->num_chips *=20
> chip_info->reg_offset;
> +	regmap_config.rd_table =3D chip_info->access_table;
> +	regmap_config.wr_table =3D chip_info->access_table;
> +	regmap_config.max_register =3D chip_info->max_register;

You could do something like this:
if (chip_info->access_table) {
    regmap_config.rd_table =3D chip_info->access_table;
    regmap_config.wr_table =3D chip_info->access_table;
} else {
    regmap_config.max_register =3D chip_info->num_chips *=20
chip_info->reg_offset;
}

Then you wouldn't need to add a .max_register field for every other SoC.

Cheers,
-Paul

>=20
>  	jzpc->map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
>  	if (IS_ERR(jzpc->map)) {
> --
> 2.34.1
>=20


