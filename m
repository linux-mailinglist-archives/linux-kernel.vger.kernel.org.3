Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA99567452
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGEQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiGEQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:29:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7F1D30B;
        Tue,  5 Jul 2022 09:29:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id ck6so14413394qtb.7;
        Tue, 05 Jul 2022 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=frZfKP9LN/+rExEoWp6ML2iGfeji+NFrp11uK/sqtZk=;
        b=Ps0DWO6T4WzbDGYeEutFMBaCJEv6EwmO6yfNhrrW9fLvenOnLf8CpHHSeOAY2uvSzw
         FK7iZ8B6E0AnzHWlnS513BjspevScYhXSq/uM6yfsMgYH/t9vvSn99fYpJ4tYxcJPRvI
         pG0YzWt8lsWyIwohAoe9w0qNxwNbQ4mhgJZ9AL1hkb1Kmr+k/iyikzaljHLv4ZoV1Vzq
         i204rqTImulYU6xSsxbh2BzDqQ1ONvXpsds4nrqCDLU94le1JUeqoNfqUPEssfMfDj4L
         +ESly7tYqPuMo8yHqDapC3YyjA/6SUp5ehLxFFHbIU1XjMvB7Hgxo0zJoSgCOPMCShuk
         pQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=frZfKP9LN/+rExEoWp6ML2iGfeji+NFrp11uK/sqtZk=;
        b=WVZnQxZsrkprKpxx7KzRIlZw/1NSIMoqZKR7DvnD3moVrAHwSwgdu5M91ZC79Pgf9f
         gCJZhSYXHseXQck2H/NCLrwi8uTvWtl17Uq5gZZMDsEADRCSx50VtxpXDa/xg4Sl8kIP
         C50Iv7FFNvYYAKGY84MgnmmMbdDIP3J8swHRDYwYn3GSI2OR/uskO15hxKWgu1AVeNmC
         XsZkKR+VrvBn39OZP3Z+r2ORCE3a4b/nJbHGqTM2Wa7Ny5oeWyNLMx/ZLuve9tpoKBbu
         JvDsAP8AP5LZUC0ETB3tdcar39rHtescy4I+Xr31eXKcGzTx0Fu/iRu/HE7Fyl/Rx0T3
         IokA==
X-Gm-Message-State: AJIora+FeU5AyXL/3+VEZUilTugCp6O1ju+hLOvX18DvTOxahErarXyY
        H6fU+h8nNOodBGrXvwVvJMzOja6aL+/QWe7jy6q4b7F6mdQ=
X-Google-Smtp-Source: AGRyM1smvkcc+wx4+dbpJGx0vkJJ67YmA9Lz9S1Sq/2SC52pCZM6JvlduT21q1pxjdSSSb5JIE37QAOE/SzRBkSoX1A=
X-Received: by 2002:ac8:5dd4:0:b0:31d:4044:c46c with SMTP id
 e20-20020ac85dd4000000b0031d4044c46cmr14241012qtx.174.1657038590357; Tue, 05
 Jul 2022 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220705075226.359475-1-r.stratiienko@gmail.com> <5580615.DvuYhMxLoT@kista>
In-Reply-To: <5580615.DvuYhMxLoT@kista>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Tue, 5 Jul 2022 19:29:39 +0300
Message-ID: <CAGphcd=O-BQRJwQbUbbFMt29jxHf+KpJWrrm5SmMhumkCBam0Q@mail.gmail.com>
Subject: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock
 configuration to support DFS
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Hi Jernej,

=D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 19:07, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
>
> Hi Roman,
>
> Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko napisal(a=
):
> > Using simple bash script it was discovered that not all CCU registers
> > can be safely used for DFS, e.g.:
> >
> >     while true
> >     do
> >         devmem 0x3001030 4 0xb0003e02
> >         devmem 0x3001030 4 0xb0001e02
> >     done
> >
> > Script above changes the GPU_PLL multiplier register value. While the
> > script is running, the user should interact with the user interface.
> >
> > Using this method the following results were obtained:
> > | Register  | Name           | Bits  | Values | Result |
> > | --        | --             | --    | --     | --     |
> > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> >
> > DVFS started to work seamlessly once dividers which caused the
> > glitches were set to fixed values.
> >
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> >
> > ---
> >
> > Changelog:
> >
> > V2:
> > - Drop changes related to mux
> > - Drop frequency limiting
> > - Add unused dividers initialization
> >
> > V3:
> > - Adjust comments
>
> I don't see any comment fixed, at least not to "1", as we discussed. Did =
I miss
> anything?

I've added the "bits" word, so now it should sound correct.

> Also, please add min and max.

What is the rationale for additional limits?
CPU_PLL doesn't have these limits. I don't want to make them different.

> I also consent to R-B, which you
> didn't include.

I was expecting an explicit 'review-by' line. Anyway I can add it and
resend v4 if it's necessary.

Regards,
Roman

> Did you resend v2 instead of v3?
>
> Best regards,
> Jernej
>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..068d1a6b2eb=
f3
> > 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> >       },
> >  };
> >
> > +/* For GPU PLL, using an output divider for DFS causes system to fail =
*/
> >  #define SUN50I_H6_PLL_GPU_REG                0x030
> >  static struct ccu_nkmp pll_gpu_clk =3D {
> >       .enable         =3D BIT(31),
> >       .lock           =3D BIT(28),
> >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> */
> >       .common         =3D {
> >               .reg            =3D 0x030,
> >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> >
> > +/* Keep GPU_CLK divider const to avoid DFS instability. */
> >  static const char * const gpu_parents[] =3D { "pll-gpu" };
> > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > -                                    0, 3,    /* M */
> > +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> >                                      24, 1,   /* mux */
> >                                      BIT(31), /* gate */
> >                                      CLK_SET_RATE_PARENT);
> > @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct platform_d=
evice
> > *pdev) if (IS_ERR(reg))
> >               return PTR_ERR(reg);
> >
> > +     /* Force PLL_GPU output divider bits to 0 */
> > +     val =3D readl(reg + SUN50I_H6_PLL_GPU_REG);
> > +     val &=3D ~BIT(0);
> > +     writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> > +
> > +     /* Force GPU_CLK divider bits to 0 */
> > +     val =3D readl(reg + gpu_clk.common.reg);
> > +     val &=3D ~GENMASK(3, 0);
> > +     writel(val, reg + gpu_clk.common.reg);
> > +
> >       /* Enable the lock bits on all PLLs */
> >       for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> >               val =3D readl(reg + pll_regs[i]);
> > --
> > 2.34.1
>
>
