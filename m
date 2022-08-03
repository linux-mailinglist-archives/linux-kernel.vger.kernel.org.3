Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351115894D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiHCX2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCX2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:28:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709352B606;
        Wed,  3 Aug 2022 16:28:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m7so13937017qkk.6;
        Wed, 03 Aug 2022 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fTNd6U92aMpnpUk4vc+/qMilauOgZ+f0bSF9oL3Kd8=;
        b=hMpNLPKlItbeL4FVVwcxF5vkjrf3ZW1ojnVtnJ1gUV32gqco84APvLVZoW25JNgnzG
         K49N7Lb8+yP9rzO7Mcuu1HJRIvl4yz8K4N76S7wHHXogERApdk85u1FmHOMfknn2w/Rz
         8qfxaZqDawhcLs5RWkKv1UfRQOCnGAaAX5QR80Ny4nBbLr8tkrDEwKNwycAjKzwc0Ffy
         B1cakb/FKsPNA7DJfTw6Mc+xw9SGFFOTJK1MFV3cOD52sMGMKTT3pN7Hd9T6Wi/T33UA
         gBwlwHXnjEDp/+TKv27lpvon3pCIp70e4VDT8KJq6Ztkjgx5aGQTqiRC6uWTI8j1Xznc
         fj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fTNd6U92aMpnpUk4vc+/qMilauOgZ+f0bSF9oL3Kd8=;
        b=yXzUbCDTwbf9kSUWMLzqQK2jTpiuSBCyAHXV89OOfaz4WrLEIqQ6oeGF46USiogklm
         RB5+LZi2FFItxM7OMyG7UpmdZomi9+9VjoeLCQF+Jto1V+1qbkktpwM8FnawMiKhd5Iz
         ylddEZy5yCsUQ6Y9IgZ/6WgStjaj5ICiLAbI48AYcdUdzn7a0Y3mBPVQDB0e9dP/4IFd
         ryLHqsMvDIxmpZyODhCOLKgVOXHvife28EfZsdEmEaVQrkEoTi9U7WUQ48mmEh1uCXdu
         rSStbyEp2korkBUT/l2J13EdVml9nuWQ/f6B3vJA1S7O6d6O6SchVHlnapzNWWvW5z0C
         UkhA==
X-Gm-Message-State: ACgBeo2XcGjyGmNW1RpwfOYGTskjwtDgF/rfkINMsC+KOH1YgMXPNAcH
        cDOjadTOPCdikwDk7rKki8Yknw7LH3A=
X-Google-Smtp-Source: AA6agR6DoNY5ZIjsvWjEXQ8FVjBB0iTJ8DcVbRyqFHMS6j1cUcMIrYBZSZ0BZsOYSlCyAKSJh0nG8Q==
X-Received: by 2002:a05:620a:22c4:b0:6b8:dcca:1368 with SMTP id o4-20020a05620a22c400b006b8dcca1368mr5866199qki.517.1659569323503;
        Wed, 03 Aug 2022 16:28:43 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a269b00b006b8cff25187sm4396904qkp.42.2022.08.03.16.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:28:42 -0700 (PDT)
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
To:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Du Huanpeng <dhu@hodcarrier.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>
References: <20220419051114.1569291-1-seanga2@gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <d92dd996-6961-5291-9504-1fe284b40dd6@gmail.com>
Date:   Wed, 3 Aug 2022 19:28:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20220419051114.1569291-1-seanga2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 1:11 AM, Sean Anderson wrote:
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
> 	rate =3D parent * (255 * M_PLL + FRAC_N) / 255 / 4
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
> index 703f87622cf5..2b98a116c1ea 100644
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

Since there have been no objections, can we apply this?

--Sean

