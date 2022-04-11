Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19D04FC4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349444AbiDKTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349560AbiDKTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:10:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763335DE2;
        Mon, 11 Apr 2022 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649704082; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYgVOenbHszt74j3RuFfH33wSZWuohjHucw3AcGoA90=;
        b=Y+jccw/XNiU/5f16Ken+4IUt56vH7lB0kFaDjDjbYb9feVL2XBGlXXKrPN7cfWKlm/Ej7f
        48zGHzOp2aJbZbLpImyCbyXGA+wbWBV209jywvPB+R4WjDtSB9U7qASYZ818MZXYu3dlYK
        aWa0zGHLKZ6eW1Vs3T5jsc4UCs5o9qQ=
Date:   Mon, 11 Apr 2022 20:07:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <4TV6AR.IAX9QJ9FYUOJ2@crapouillou.net>
In-Reply-To: <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
References: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
        <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
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



Le lun., avril 11 2022 at 16:42:41 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The TCU clock gate on X1000 wasn't requested by the driver and could
> be gated automatically later on in boot, which prevents timers from
> running and breaks PWM.
>=20
> Add a workaround to support old device trees that don't specify the
> "tcu" clock gate. In this case the kernel will print a warning and
> attempt to continue without the clock, which is wrong, but it could
> work if "clk_ignore_unused" is in the kernel arguments.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/tcu.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 77acfbeb4830..ce8c768db997 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -31,6 +31,7 @@ struct ingenic_soc_info {
>  	unsigned int num_channels;
>  	bool has_ost;
>  	bool has_tcu_clk;
> +	bool allow_missing_tcu_clk;
>  };
>=20
>  struct ingenic_tcu_clk_info {
> @@ -320,7 +321,8 @@ static const struct ingenic_soc_info=20
> jz4770_soc_info =3D {
>  static const struct ingenic_soc_info x1000_soc_info =3D {
>  	.num_channels =3D 8,
>  	.has_ost =3D false, /* X1000 has OST, but it not belong TCU */
> -	.has_tcu_clk =3D false,
> +	.has_tcu_clk =3D true,
> +	.allow_missing_tcu_clk =3D true,
>  };
>=20
>  static const struct of_device_id __maybe_unused=20
> ingenic_tcu_of_match[] __initconst =3D {
> @@ -354,15 +356,27 @@ static int __init ingenic_tcu_probe(struct=20
> device_node *np)
>  	if (tcu->soc_info->has_tcu_clk) {
>  		tcu->clk =3D of_clk_get_by_name(np, "tcu");
>  		if (IS_ERR(tcu->clk)) {
> -			ret =3D PTR_ERR(tcu->clk);
> -			pr_crit("Cannot get TCU clock\n");
> -			goto err_free_tcu;
> -		}
> -
> -		ret =3D clk_prepare_enable(tcu->clk);
> -		if (ret) {
> -			pr_crit("Unable to enable TCU clock\n");
> -			goto err_put_clk;
> +			/*
> +			 * Old device trees for some SoCs did not include the
> +			 * TCU clock because this driver (incorrectly) didn't
> +			 * use it. In this case we complain loudly and attempt
> +			 * to continue without the clock, which might work if
> +			 * booting with workarounds like "clk_ignore_unused".
> +			 */
> +			if (tcu->soc_info->allow_missing_tcu_clk &&
> +			    PTR_ERR(tcu->clk) =3D=3D -EINVAL) {
> +				pr_warn("TCU clock missing from device tree, please update your=20
> device tree\n");
> +				tcu->clk =3D NULL;
> +			} else {
> +				pr_crit("Cannot get TCU clock from device tree\n");
> +				goto err_free_tcu;
> +			}
> +		} else {
> +			ret =3D clk_prepare_enable(tcu->clk);
> +			if (ret) {
> +				pr_crit("Unable to enable TCU clock\n");
> +				goto err_put_clk;
> +			}
>  		}
>  	}
>=20
> @@ -432,10 +446,10 @@ static int __init ingenic_tcu_probe(struct=20
> device_node *np)
>  			clk_hw_unregister(tcu->clocks->hws[i]);
>  	kfree(tcu->clocks);
>  err_clk_disable:
> -	if (tcu->soc_info->has_tcu_clk)
> +	if (tcu->clk)
>  		clk_disable_unprepare(tcu->clk);
>  err_put_clk:
> -	if (tcu->soc_info->has_tcu_clk)
> +	if (tcu->clk)
>  		clk_put(tcu->clk);
>  err_free_tcu:
>  	kfree(tcu);
> --
> 2.35.1
>=20


