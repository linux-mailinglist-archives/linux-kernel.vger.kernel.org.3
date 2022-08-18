Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161F2597C47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiHRDgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRDgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:36:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8A5D126;
        Wed, 17 Aug 2022 20:36:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so928545ejc.7;
        Wed, 17 Aug 2022 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=T/2mVkL6UP+T2DXZhWWVUjggRKMFf9g6i9WM+ljIyVQ=;
        b=BYzEghcwFkBcD7A6zWs3WzR3B0gUnGWUrbDuTc5xx11MOYGRYvZGzUgs5Bl/ctwyQ8
         f4PIRM+utzgCqEM3R6gvUD74KIxbnt3vwEwy+9ZxmGC3tSQuEHvI9I5EgRW7zBgsoFmd
         jY+d3fYqzu0mIaElLNWY6J6cg+rpjMOtW5jWIySXaqZcWgyuGGlhXqqn0iPkPCdit9VO
         9ixNdYTin+ymQrc/t9Pnurxs+xriQdbMBDPQfuC3AcurR2vWkHlIJVTA57EN1Sc9Px9S
         RcnTI/yEJBeL8/GfX3xqCvulfdhbRtU21Lp+r6yAOxzF5yeblE/qrWwlPXMRFGOAvkDl
         Lu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=T/2mVkL6UP+T2DXZhWWVUjggRKMFf9g6i9WM+ljIyVQ=;
        b=M8gzOav4KQfcRER+hJdwHwJZSK9bPiIk8bWvp8ervlV4mHbSlkjLhP9IsajgbDR8xW
         qSXfbD7aGby44tN/KvyITJmWPJNsmMbu24aP6mmaBzzes7Ui+uZqA3G43ksogQ7SNBc2
         OWOKt8E8JaWFo9y8pFUAvcxILNs9pU4MzP6W+W4kr1koj3W5DAQDlOyWKmLKku9TZPh1
         pm1J+I7YIVnNLEcuNvcxnj6vxyhlFdiIhOnvsi8K+pcfSU3FryvAjaxebhR/tK1fPwEt
         UqxwwU5FDZLtkoYAcDFQGKY3TmuPV5V14EkqGiKNTxh1AWaMgSU/Lj5byiLl15dt4bf+
         0qDw==
X-Gm-Message-State: ACgBeo0qYjnljQi1SqsoCNHtK/gFDXyAyRjwJ2yijBIG1bhMrSiORFDJ
        UHoarUz2wF1rC2K81e1X8P72p2r2O4MQ4PlqzuE=
X-Google-Smtp-Source: AA6agR4/YmmiBdH0KTeertmhcBZU0uCTsCJ7X2g08B2BoPa7m2wObJ72BASYMmIZhLCRs0GIDs/9dMZh2dja9edP2/c=
X-Received: by 2002:a17:907:3f24:b0:730:bcbd:395d with SMTP id
 hq36-20020a1709073f2400b00730bcbd395dmr680668ejc.540.1660793773978; Wed, 17
 Aug 2022 20:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220419051114.1569291-1-seanga2@gmail.com>
In-Reply-To: <20220419051114.1569291-1-seanga2@gmail.com>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 18 Aug 2022 11:36:02 +0800
Message-ID: <CAJhJPsUM=LrgrKcoA8xT=4JWt8uxjn6yDxP9vjuZmvb4WvjPZQ@mail.gmail.com>
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
To:     Sean Anderson <seanga2@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Du Huanpeng <dhu@hodcarrier.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean, Du,
I saw you are discussing the PLL rate calculation issue.
My question is whether the upstream kernel works on your ls1c300?
For me, it never works, even the earliest version which LS1C support was me=
rged.
After the kernel is loaded by PMON, there is no console output at all.
I also confirm this issue with Yang.
BTW, my board is 1C300B.
Are your board is different from me? Or your bootloader?

Thanks!

Sean Anderson <seanga2@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 13:11=E5=86=99=E9=81=93=EF=BC=9A
>
> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
> noticed the following calculation, which is copied from
> drivers/clk/loongson1/clk-loongson1c.c:
>
> ulong ls1c300_pll_get_rate(struct clk *clk)
> {
>         unsigned int mult;
>         long long parent_rate;
>         void *base;
>         unsigned int val;
>
>         parent_rate =3D clk_get_parent_rate(clk);
>         base =3D (void *)clk->data;
>
>         val =3D readl(base + START_FREQ);
>         mult =3D FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
>         return (mult * parent_rate) / 4;
> }
>
> I would like to examine the use of M_PLL and FRAC_N to calculate the mult=
iplier
> for the PLL. The datasheet has the following to say:
>
> START_FREQ =E4=BD=8D    =E7=BC=BA=E7=9C=81=E5=80=BC      =E6=8F=8F=E8=BF=
=B0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FRAC_N     23:16 0           PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=95=B0=E7=
=9A=84=E5=B0=8F=E6=95=B0=E9=83=A8=E5=88=86
>
>                  =E7=94=B1          PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=95=
=B0=E7=9A=84=E6=95=B4=E6=95=B0=E9=83=A8=E5=88=86
> M_PLL      15:8  NAND_D[3:0] (=E7=90=86=E8=AE=BA=E5=8F=AF=E4=BB=A5=E8=BE=
=BE=E5=88=B0 255=EF=BC=8C=E5=BB=BA=E8=AE=AE=E4=B8=8D=E8=A6=81=E8=B6=85=E8=
=BF=87 100)
>                  =E9=85=8D=E7=BD=AE
>
> which according to google translate means
>
> START_FREQ Bits  Default       Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> FRAC_N     23:16 0             Fractional part of the PLL multiplication =
factor
>
>                  Depends on    Integer part of PLL multiplication factor
> M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] it =
is
>                  configuration  recommended not to exceed 100)
>
> So just based on this description, I would expect that the formula to be
> something like
>
>         rate =3D parent * (255 * M_PLL + FRAC_N) / 255 / 4
>
> However, the datasheet also gives the following formula:
>
>         rate =3D parent * (M_PLL + FRAC_N) / 4
>
> which is what the Linux driver has implemented. I find this very unusual.
> First, the datasheet specifically says that these fields are the integer =
and
> fractional parts of the multiplier. Second, I think such a construct does=
 not
> easily map to traditional PLL building blocks. Implementing this formula =
in
> hardware would likely require an adder, just to then set the threshold of=
 a
> clock divider.
>
> I think it is much more likely that the first formula is correct. The aut=
hor of
> the datasheet may think of a multiplier of (say) 3.14 as
>
>         M_PLL =3D 3
>         FRAC_N =3D 0.14
>
> which together sum to the correct multiplier, even though the actual valu=
e
> stored in FRAC_N would be 36.
>
> I suspect that this has slipped by unnoticed because when FRAC_N is 0, th=
ere is
> no difference in the formulae. The following patch is untested, but I sus=
pect
> it will fix this issue. I would appreciate if anyone with access to the
> hardware could measure the output of the PLL (or one of its derived clock=
s) and
> determine the correct formula.
>
> [1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarrier.=
org/T/#u
>
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongso=
n1/clk-loongson1c.c
> index 703f87622cf5..2b98a116c1ea 100644
> --- a/drivers/clk/loongson1/clk-loongson1c.c
> +++ b/drivers/clk/loongson1/clk-loongson1c.c
> @@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw=
 *hw,
>         u32 pll, rate;
>
>         pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);
> -       rate =3D ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> +       rate =3D (pll & 0xff00) + ((pll >> 16) & 0xff);
>         rate *=3D OSC;
> -       rate >>=3D 2;
> +       rate >>=3D 10;
>
>         return rate;
>  }
> --
> 2.35.1
>


--=20
Best regards,

Kelvin Cheung
