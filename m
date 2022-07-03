Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35587564891
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGCQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiGCQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:40:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9706154;
        Sun,  3 Jul 2022 09:40:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k14so6814286qtm.3;
        Sun, 03 Jul 2022 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u+xp3Xfhyj2h4RiBWfUaXw+nD5F3F1r+zubvc/HCtbA=;
        b=LbImrogi+bqI75rGwVoqt0WTJicx+TayHHFvqZGm4bzGI8V2mSRzvhKqIcwNGsliEr
         5o76i7zSp6MxdVeYNN0ymCH2FAUe78Y+iXGKPmfWdTGKVQAx0D+/4jkdnPTt34rAe5ng
         NnryDbmvAGwuKcD+WTPp8zWohL5CB3MQjiHt4/F+ofQzhsKWDGsGzJp/7G4S/dx2RuEp
         ZWhLznwLiGV7Cc9t0cC9j4RFt0osY0oOeLCncdtD2wdcEw9wmiU7PRj5w+s75Hb4KshI
         9oFnN6SmB5BhrdyD3Y0hYsMHern2SjV43VOfS/4YD+t4wA+auEtDn9ouJuHWs0GAMLTY
         UI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u+xp3Xfhyj2h4RiBWfUaXw+nD5F3F1r+zubvc/HCtbA=;
        b=z3FIEa3MjbeVu9gA4VfOyURi53ndnkfY0+erDTjHT/zH3zIKuY21bZsVVaQ3CUMDx2
         SgVZ7eyvgp2ygxvsrTd8lm4fvIoy6DdCH0I+AbRpgp+A+3blF//opcVRUKY1htbWwzY2
         mfEV7JeQKjiW13L3hUNY1gjyn573ivj2tgIn9oOWJQNGtH+Iow1XdSoQuMOZzgI1UUdM
         RiRrJROp+pe9SN2UgwrCKUZ0WvCMLS9NWUg1BRDoBtVn6Ved/HtYqAHwBVRg7KNJvLhm
         2zYaJWPJEEPubZUsDt0Oi4TMhf5SvPwKLMOsf+rF7LKbFFCAeqPHmlfJRd8AMNzVFhyO
         ZZFw==
X-Gm-Message-State: AJIora/3hwUn32P0fvJIaian3Anozl9Q+UsWgml0M+yDv1r+oZDBbPpf
        6IGgmMnSrN5VKjN17fxzg6lx/3UMh5h56lt48zA=
X-Google-Smtp-Source: AGRyM1uqIs5zlJ7pA8AgTCinVpHPprrG2MifKpTo7bv68esmtiwbtHp41axO/DvFKSeoHmQFgEqXL/uP+faEtICti3c=
X-Received: by 2002:ad4:5c64:0:b0:472:f016:bfde with SMTP id
 i4-20020ad45c64000000b00472f016bfdemr3864305qvh.52.1656866444208; Sun, 03 Jul
 2022 09:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624165211.4318-1-r.stratiienko@gmail.com> <e5837e14-739e-5137-7398-3acfc8a54b84@sholland.org>
In-Reply-To: <e5837e14-739e-5137-7398-3acfc8a54b84@sholland.org>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Sun, 3 Jul 2022 19:40:33 +0300
Message-ID: <CAGphcd=BKWxOj0bdN386S+KPF=nRiug9hX51gOJAib7u0hdjXw@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration
 to support DFS
To:     Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
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

Hello Samuel,

Thanks for having a look.

=D0=B2=D1=81, 3 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 09:50, Samuel Holla=
nd <samuel@sholland.org>:
>
> On 6/24/22 11:52 AM, Roman Stratiienko wrote:
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
> >
> > | Register  | Name           | Bits  | Values | Result |
> > | --        | --             | --    | --     | --     |
> > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> >
> > Once bits that caused system failure disabled (kept default 0),
> > it was discovered that GPU_CLK.MUX was used during DFS for some
> > reason and was causing the failure too.
>
> The GPU module clock has only one parent declared, so it is surprising th=
at the
> mux would get set. Did this happen while the kernel driver was changing t=
he
> frequency?

I looked through the ccu code and didn't see anything that may cause
issues, so I tested again and DFS works with MUX this time.

I'll drop this change in v2.

>
> > After disabling GPU_PLL.OUTDIV the system started to fail during
> > booting for some reason until the maximum frequency of GPU_PLL
> > clock was limited to 756MHz.
>
> The manual lists PLL_GPU's maximum frequency as 800 MHz. I assume you cho=
se 756
> MHz because that is the highest OPP. That should be okay, too.

Setting the frequency higher than 756 makes the GPU very unstable.

I decided to validate it again and removed the frequency limitation
and can't see any issues so far.

I'll also drop this change in v2.

>
> > After all the changes made DVFS started to work seamlessly.
> >
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h6.c
> > index 2ddf0a0da526f..d941238cd178a 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk =3D {
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
> > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> > +     .max_rate       =3D 756000000UL,
> >       .common         =3D {
> >               .reg            =3D 0x030,
> >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, =
"deinterlace",
> >  static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace", "psi-ahb=
1-ahb2",
> >                     0x62c, BIT(0), 0);
> >
> > -static const char * const gpu_parents[] =3D { "pll-gpu" };
> > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > -                                    0, 3,    /* M */
> > -                                    24, 1,   /* mux */
> > -                                    BIT(31), /* gate */
> > -                                    CLK_SET_RATE_PARENT);
> > +/* GPU_CLK divider kept disabled to avoid interferences with DFS */
> > +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> > +                   BIT(31), CLK_SET_RATE_PARENT);
>
> These changes look fine to me. You also need to set the initial value for=
 the
> fixed fields in the driver's probe function.

Will do that in v2.

I have no idea what was causing additional issues in my previous test
session. Let's forget about them for now.

Regards,
Roman.

>
> Regards,
> Samuel
