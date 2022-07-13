Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7B5739BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiGMPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiGMPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:08:24 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C04BD1C;
        Wed, 13 Jul 2022 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657724871; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0FfxSaCkfFkbBWXxE6Wzj1PxCYfgbtK0yTCw52GkdM=;
        b=ZULgNyU35WqdIvHIEYL59a8ZtT6EuCJEilRjnhRRn4LbomjagX+Mn7qdh9yyvLvPsXHqIz
        naSlIhmIFq3PK+8JIZjMYjKp/xk8mjGMYVdH/KO6wPIjlPm/cXxL/AYCkFiEBQ7gEHs6LM
        C7Qdhlq/jAbRJeQ+Lv3MJkaZtmiFsXw=
Date:   Wed, 13 Jul 2022 16:07:39 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Zhou Yanjie <zhouyu@wanyeetech.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <ROSYER.QTJF8J14H2YX1@crapouillou.net>
In-Reply-To: <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
        <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le mer., juil. 13 2022 at 22:33:44 +0800, Zhou Yanjie=20
<zhouyu@wanyeetech.com> a =C3=A9crit :
> Hi Aidan,
>=20
> On 2022/7/9 =E4=B8=8A=E5=8D=8812:02, Aidan MacDonald wrote:
>> On some Ingenic SoCs, such as the X1000, there is a programmable
>> divider used to generate the I2S system clock from a PLL, rather
>> than a fixed PLL/2 clock. It doesn't make much sense to call the
>> clock "pll half" on those SoCs, so the clock name should really be
>> a SoC-dependent value.
>>=20
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>   sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
>> b/sound/soc/jz4740/jz4740-i2s.c
>> index 0dcc658b3784..a41398c24d0e 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -75,6 +75,8 @@ struct i2s_soc_info {
>>   	struct reg_field field_i2sdiv_capture;
>>   	struct reg_field field_i2sdiv_playback;
>>   =7F+	const char *pll_clk_name;
>> +
>>   	bool shared_fifo_flush;
>>   };
>>   =7F@@ -281,7 +283,7 @@ static int jz4740_i2s_set_sysclk(struct=20
>> snd_soc_dai *dai, int clk_id,
>>   		clk_set_parent(i2s->clk_i2s, parent);
>>   		break;
>>   	case JZ4740_I2S_CLKSRC_PLL:
>> -		parent =3D clk_get(NULL, "pll half");
>> +		parent =3D clk_get(NULL, i2s->soc_info->pll_clk_name);
>>   		if (IS_ERR(parent))
>>   			return PTR_ERR(parent);
>>   		clk_set_parent(i2s->clk_i2s, parent);
>> @@ -400,6 +402,7 @@ static const struct i2s_soc_info=20
>> jz4740_i2s_soc_info =3D {
>>   	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>>   	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>   	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>   	.shared_fifo_flush	=3D true,
>>   };
>>   =7F@@ -409,6 +412,7 @@ static const struct i2s_soc_info=20
>> jz4760_i2s_soc_info =3D {
>>   	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>   	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>   	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>   };
>=20
>=20
> Since JZ4760, according to the description of the I2SCDR register,
> Ingenic SoCs no longer use PLL/2 clock, but directly use PLL clock,
> so it seems also inappropriate to use "pll half" for these SoCs.

The device tree passes the clock as "pll half". So the driver should=20
use this name as well...

Cheers,
-Paul

>>   =7F  static struct snd_soc_dai_driver jz4770_i2s_dai =3D {
>> @@ -435,6 +439,7 @@ static const struct i2s_soc_info=20
>> jz4770_i2s_soc_info =3D {
>>   	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>   	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>   	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>   };
>=20
>=20
> Same here.
>=20
>=20
>>   =7F  static const struct i2s_soc_info jz4780_i2s_soc_info =3D {
>> @@ -443,6 +448,7 @@ static const struct i2s_soc_info=20
>> jz4780_i2s_soc_info =3D {
>>   	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>>   	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>>   	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>> +	.pll_clk_name		=3D "pll half",
>>   };
>>=20
>=20
> Same here.
>=20
>=20
> Thanks and best regards!
>=20
>=20
>>   static const struct snd_soc_component_driver jz4740_i2s_component=20
>> =3D {


