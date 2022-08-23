Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07859CF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiHWDfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiHWDfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:35:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175385301F;
        Mon, 22 Aug 2022 20:35:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cb8so9526759qtb.0;
        Mon, 22 Aug 2022 20:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=S7kkoLuNhQ00abOUTZOeGzFT/B6ZjSVP0n1Y49zWBjQ=;
        b=JdTkhWq1vq+LJ6+lCIrFJjrhYkNLpB3dYW7fjICh6fjyiKOWM5MQLNWF3y3E7y4mNM
         icWNHGy8KqSnVgv6UxpjNTaeKehtzUalGYzFtdcreTTdJ2Zv5CXRt/MtMk7HbBxl31p3
         zdq+7t7iVd1tiQUXg2X/8HIhyVjOTJT3DGHPO13yL3G5VqfhMbees8g389+bPst4HlUd
         SONn+ODQAeoo5ObgotrnfZFn/Fk+diXJn3quomTAk/BGPq7n6KdvwJQuWMdGqRk36qi9
         a3F7akbRgbygjCv/k/eWsEmSfd0W9b7C/+SsBO6xBJtEkbfgQVbW9p5zJkM5gCu1mJJu
         T1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=S7kkoLuNhQ00abOUTZOeGzFT/B6ZjSVP0n1Y49zWBjQ=;
        b=i8zTs1mLDRDups38A1zDxSnNhLVLxjGyKIpWLKiOV5a3uarDRmmpGmHhh3vv3W2Cf4
         HvFu6XcubSrqHzpUIcgiBleLH/jnx17rW9POIY992E5Avpr8mSdMGkxG+3RuMJW5CbB1
         N9izHdCSYkuQujyizpWUbD3YbATRjmRC11uNAw5NdmgNYSapvo1iDD7IxrMKDY0UCh/v
         YVqpg+OzUwwH2lLIcRXSIs8AaYfsfGmTaXQcFZA1hBjPL8fmqqoA7WCV53Z3qUCmHCQR
         ckU009+yg0WZtg9jRkztz9EBzfFbRxXO/P0rLTtr1kx0eo19vRUccdV6fmJNh1JT91k6
         Wb9Q==
X-Gm-Message-State: ACgBeo26KVmUa2hJtfl1bDXtva94SloRAS/JIgAo//N3AFc7dCuiNNup
        oMtdJZoa0VLALWzqS8g5+GxM/4o/Irk=
X-Google-Smtp-Source: AA6agR5f3PUrASfnlz3yFpIlcpQDfUGYTTtFf82i3OjcmEdO41o7MDFECKT9CC/XSNDydlE2DYHNkw==
X-Received: by 2002:ac8:5c89:0:b0:343:4e44:3dbe with SMTP id r9-20020ac85c89000000b003434e443dbemr17715136qta.531.1661225732213;
        Mon, 22 Aug 2022 20:35:32 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b006b9c355ed75sm11575583qkb.70.2022.08.22.20.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 20:35:31 -0700 (PDT)
Subject: Re: [RESEND PATCH] clk: ls1c: Fix PLL rate calculation
To:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Du Huanpeng <dhu@hodcarrier.org>
References: <20220823033414.198525-1-seanga2@gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <a43019fd-67c4-022a-83ac-40f0302c7cf4@gmail.com>
Date:   Mon, 22 Aug 2022 23:35:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20220823033414.198525-1-seanga2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 11:34 PM, Sean Anderson wrote:
> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1],=
 I
> noticed the following calculation, which is copied from
> drivers/clk/loongson1/clk-loongson1c.c:
>=20
> ulong ls1c300_pll_get_rate(struct clk *clk)
> {
> 	unsigned int mult;
> 	long long parent_rate;
> 	void *base;
> 	unsigned int val;
>=20
> 	parent_rate =3D clk_get_parent_rate(clk);
> 	base =3D (void *)clk->data;
>=20
> 	val =3D readl(base + START_FREQ);
> 	mult =3D FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
> 	return (mult * parent_rate) / 4;
> }
>=20
> I would like to examine the use of M_PLL and FRAC_N to calculate the mu=
ltiplier
> for the PLL. The datasheet has the following to say:
>=20
> START_FREQ =E4=BD=8D    =E7=BC=BA=E7=9C=81=E5=80=BC      =E6=8F=8F=E8=BF=
=B0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FRAC_N     23:16 0           PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=95=B0=E7=
=9A=84=E5=B0=8F=E6=95=B0=E9=83=A8=E5=88=86
>=20
>                   =E7=94=B1          PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=
=95=B0=E7=9A=84=E6=95=B4=E6=95=B0=E9=83=A8=E5=88=86
> M_PLL      15:8  NAND_D[3:0] (=E7=90=86=E8=AE=BA=E5=8F=AF=E4=BB=A5=E8=BE=
=BE=E5=88=B0 255=EF=BC=8C=E5=BB=BA=E8=AE=AE=E4=B8=8D=E8=A6=81=E8=B6=85=E8=
=BF=87 100)
>                   =E9=85=8D=E7=BD=AE
>=20
> which according to google translate means
>=20
> START_FREQ Bits  Default       Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> FRAC_N     23:16 0             Fractional part of the PLL multiplicatio=
n factor
>=20
>                   Depends on    Integer part of PLL multiplication fact=
or
> M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] i=
t is
>                   configuration  recommended not to exceed 100)
>=20
> So just based on this description, I would expect that the formula to b=
e
> something like
>=20
> 	rate =3D parent * (256 * M_PLL + FRAC_N) / 256 / 4
>=20
> However, the datasheet also gives the following formula:
>=20
> 	rate =3D parent * (M_PLL + FRAC_N) / 4
>=20
> which is what the Linux driver has implemented. I find this very unusua=
l.
> First, the datasheet specifically says that these fields are the intege=
r and
> fractional parts of the multiplier. Second, I think such a construct do=
es not
> easily map to traditional PLL building blocks. Implementing this formul=
a in
> hardware would likely require an adder, just to then set the threshold =
of a
> clock divider.
>=20
> I think it is much more likely that the first formula is correct. The a=
uthor of
> the datasheet may think of a multiplier of (say) 3.14 as
>=20
> 	M_PLL =3D 3
> 	FRAC_N =3D 0.14
>=20
> which together sum to the correct multiplier, even though the actual va=
lue
> stored in FRAC_N would be 36.
>=20
> I suspect that this has slipped by unnoticed because when FRAC_N is 0, =
there is
> no difference in the formulae. The following patch is untested, but I s=
uspect
> it will fix this issue. I would appreciate if anyone with access to the=

> hardware could measure the output of the PLL (or one of its derived clo=
cks) and
> determine the correct formula.
>=20
> [1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarrie=
r.org/T/#u
>=20
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>=20
>   drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loong=
son1/clk-loongson1c.c
> index 1ebf740380ef..2aa839b05d6b 100644
> --- a/drivers/clk/loongson1/clk-loongson1c.c
> +++ b/drivers/clk/loongson1/clk-loongson1c.c
> @@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_=
hw *hw,
>   	u32 pll, rate;
>  =20
>   	pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);
> -	rate =3D ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> +	rate =3D (pll & 0xff00) + ((pll >> 16) & 0xff);
>   	rate *=3D OSC;
> -	rate >>=3D 2;
> +	rate >>=3D 10;
>  =20
>   	return rate;
>   }
>=20

+CC Stephen Boyd

