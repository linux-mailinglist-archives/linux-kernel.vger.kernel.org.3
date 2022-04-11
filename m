Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD514FC281
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiDKQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348290AbiDKQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:38:48 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E62DAB8;
        Mon, 11 Apr 2022 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649694991; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKIdiPCa6AdKy3aeZWJmLncBvmV88ceUe5XNIR3UBxQ=;
        b=pzqHrTBTxMmTIZ2GuBCvRERJgNhDuydhqoWEJh9pjC/YFx/WdQ2znC6qX+HJ4MkXnZdJQJ
        /7Tnsvmm9KSay0Z3MifEH9QGPldSI3yD30YYVDzv4N/mXkxXRA6/ld2KpqKHfMybdo9XWa
        bDvgPhryvUsMzLNiOkoSikXrus7yb10=
Date:   Mon, 11 Apr 2022 17:36:21 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <LSO6AR.0DFDW2C6UEWT@crapouillou.net>
In-Reply-To: <YlRSiUkdFkNoPMaH@localhost>
References: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
        <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
        <FKM6AR.T3U5W4W42W2R3@crapouillou.net> <YlRSiUkdFkNoPMaH@localhost>
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

Le lun., avril 11 2022 at 17:08:41 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> On Mon, Apr 11, 2022 at 04:48:15PM +0100, Paul Cercueil wrote:
>>  Hi Aidan,
>>=20
>>  Le lun., avril 11 2022 at 16:42:41 +0100, Aidan MacDonald
>>  <aidanmacdonald.0x0@gmail.com> a =E9crit :
>>  > The TCU clock gate on X1000 wasn't requested by the driver and=20
>> could
>>  > be gated automatically later on in boot, which prevents timers=20
>> from
>>  > running and breaks PWM.
>>  >
>>  > Add a workaround to support old device trees that don't specify=20
>> the
>>  > "tcu" clock gate. In this case the kernel will print a warning and
>>  > attempt to continue without the clock, which is wrong, but it=20
>> could
>>  > work if "clk_ignore_unused" is in the kernel arguments.
>>  >
>>  > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>  > ---
>>  >  drivers/clk/ingenic/tcu.c | 38=20
>> ++++++++++++++++++++++++++------------
>>  >  1 file changed, 26 insertions(+), 12 deletions(-)
>>  >
>>  > diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
>>  > index 77acfbeb4830..ce8c768db997 100644
>>  > --- a/drivers/clk/ingenic/tcu.c
>>  > +++ b/drivers/clk/ingenic/tcu.c
>>  > @@ -31,6 +31,7 @@ struct ingenic_soc_info {
>>  >  	unsigned int num_channels;
>>  >  	bool has_ost;
>>  >  	bool has_tcu_clk;
>>  > +	bool allow_missing_tcu_clk;
>>  >  };
>>  >
>>  >  struct ingenic_tcu_clk_info {
>>  > @@ -320,7 +321,8 @@ static const struct ingenic_soc_info
>>  > jz4770_soc_info =3D {
>>  >  static const struct ingenic_soc_info x1000_soc_info =3D {
>>  >  	.num_channels =3D 8,
>>  >  	.has_ost =3D false, /* X1000 has OST, but it not belong TCU */
>>  > -	.has_tcu_clk =3D false,
>>  > +	.has_tcu_clk =3D true,
>>  > +	.allow_missing_tcu_clk =3D true,
>>  >  };
>>  >
>>  >  static const struct of_device_id __maybe_unused
>>  > ingenic_tcu_of_match[] __initconst =3D {
>>  > @@ -354,15 +356,27 @@ static int __init ingenic_tcu_probe(struct
>>  > device_node *np)
>>  >  	if (tcu->soc_info->has_tcu_clk) {
>>  >  		tcu->clk =3D of_clk_get_by_name(np, "tcu");
>>  >  		if (IS_ERR(tcu->clk)) {
>>  > -			ret =3D PTR_ERR(tcu->clk);
>>  > -			pr_crit("Cannot get TCU clock\n");
>>  > -			goto err_free_tcu;
>>  > -		}
>>  > -
>>  > -		ret =3D clk_prepare_enable(tcu->clk);
>>  > -		if (ret) {
>>  > -			pr_crit("Unable to enable TCU clock\n");
>>  > -			goto err_put_clk;
>>  > +			/*
>>  > +			 * Old device trees for some SoCs did not include the
>>  > +			 * TCU clock because this driver (incorrectly) didn't
>>  > +			 * use it. In this case we complain loudly and attempt
>>  > +			 * to continue without the clock, which might work if
>>  > +			 * booting with workarounds like "clk_ignore_unused".
>>  > +			 */
>>=20
>>  Why not unconditionally enable it instead? Then it would boot=20
>> without
>>  clk_ignore_unused.
>>=20
>>  Cheers,
>>  -Paul
>=20
> I could, but why add essentially dead code to the kernel? Maintaining=20
> the
> old behavior has the "advantage" that it remains broken in the same=20
> way as
> before, so any workarounds anyone was using will continue to work the=20
> same.
> And if they were not using workarounds and got a broken kernel, this=20
> patch
> will not make anything *more* broken, in fact it will not cause any=20
> change
> in behavior in that case (aside from the warning message).

OK.

-Paul

> But if you think it's best to just enable the clock anyway, let me=20
> know
> and I'll send a new patch.
>=20
> Regards,
> Aidan
>=20
>>=20
>>  > +			if (tcu->soc_info->allow_missing_tcu_clk &&
>>  > +			    PTR_ERR(tcu->clk) =3D=3D -EINVAL) {
>>  > +				pr_warn("TCU clock missing from device tree, please update=20
>> your
>>  > device tree\n");
>>  > +				tcu->clk =3D NULL;
>>  > +			} else {
>>  > +				pr_crit("Cannot get TCU clock from device tree\n");
>>  > +				goto err_free_tcu;
>>  > +			}
>>  > +		} else {
>>  > +			ret =3D clk_prepare_enable(tcu->clk);
>>  > +			if (ret) {
>>  > +				pr_crit("Unable to enable TCU clock\n");
>>  > +				goto err_put_clk;
>>  > +			}
>>  >  		}
>>  >  	}
>>  >
>>  > @@ -432,10 +446,10 @@ static int __init ingenic_tcu_probe(struct
>>  > device_node *np)
>>  >  			clk_hw_unregister(tcu->clocks->hws[i]);
>>  >  	kfree(tcu->clocks);
>>  >  err_clk_disable:
>>  > -	if (tcu->soc_info->has_tcu_clk)
>>  > +	if (tcu->clk)
>>  >  		clk_disable_unprepare(tcu->clk);
>>  >  err_put_clk:
>>  > -	if (tcu->soc_info->has_tcu_clk)
>>  > +	if (tcu->clk)
>>  >  		clk_put(tcu->clk);
>>  >  err_free_tcu:
>>  >  	kfree(tcu);
>>  > --
>>  > 2.35.1
>>  >
>>=20
>>=20


