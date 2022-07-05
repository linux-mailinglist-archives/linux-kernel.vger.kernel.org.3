Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123E5567629
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiGESHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiGESHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:07:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F51F2CB;
        Tue,  5 Jul 2022 11:07:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d2so23064018ejy.1;
        Tue, 05 Jul 2022 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3MBhx1ORlPHZ9G4+h8YaWQcZ6SFmshxeCeN90vs+Vg=;
        b=EvCJru21FJDLrFNyWj1mt6ib9bZnl2/sCGMrbEAyt2dFLQM9z6JYnPe83RNIeK60bV
         jI3YqKyUUy7/e43JZ9kE7tQvoBV0i4VJAswQjggNUtK2t9l7DwCFzBTt/BvZ3Hed7JbS
         01WbxSx+AERck5U4pG3q+2Zh0FAryO1S//6DP9HRrWgEa8/wjs8DOM4aGwF+HZ0KfH/J
         T+vOc0MaW1I37t0/qaZLY3e2a6RgJDhOVqrxCiM1WzaPmaINtCRJyR8hiFDdGrmSHW0J
         5pbPx2B2yFUrBwNoH1NOBYzhRJCaGYhKxXygvGXPMF+TRwwtoY7wt6c5iiLDOvbQl5tB
         80Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3MBhx1ORlPHZ9G4+h8YaWQcZ6SFmshxeCeN90vs+Vg=;
        b=tT23HSxY1nmTtC6pnOjShCRPiTkBDZfAmJ4M0RPrhUeTdxOKzKUf0ZUybE3xvjNGKp
         3rUGupjJLFuDsabN9Z19p86JtTVYne8MIIx9OxO5AmgGOicywHXYgJdnCD3vJr/+m2Z8
         9d0/esmhFrdFAtapZmdDvhJ3wu4wXFoH456FlJ7CZH/K1hvCXAT+jr2LYzWjXFztinNN
         4LtJNovvVwR4cInUOC1K3fDJ5ybZeH4HmbEh/oJXnaCOYAvjS1+NKWsShXauR4sQ6NFN
         F/Gb5CpRNALFjp0dpMCNhjznkTSCYdalwEMSojQ4HxTA28gzbpE7RQa2lauKcbzesHso
         hu7g==
X-Gm-Message-State: AJIora9/2PYiVi1LfQ3UsX9XcaMEvm0qY0/uCr8M1NqaK5duZmSmsM9Z
        B5Q3hTjljmgetDV5VuJbA/M=
X-Google-Smtp-Source: AGRyM1uftWZ7uUb2RAX1JiED29UVN81QgJ+i9XK4890u80u5UWT4LYY7hJr9VUBrTSDO3BmPWgydmQ==
X-Received: by 2002:a17:907:968f:b0:726:9f9b:ab0f with SMTP id hd15-20020a170907968f00b007269f9bab0fmr35971875ejc.237.1657044421330;
        Tue, 05 Jul 2022 11:07:01 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b00435a08a3557sm23880887edw.27.2022.07.05.11.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 11:07:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Tue, 05 Jul 2022 20:06:59 +0200
Message-ID: <2562485.k3LOHGUjKi@kista>
In-Reply-To: <CAGphcd=O-BQRJwQbUbbFMt29jxHf+KpJWrrm5SmMhumkCBam0Q@mail.gmail.com>
References: <20220705075226.359475-1-r.stratiienko@gmail.com> <5580615.DvuYhMxLoT@kista> <CAGphcd=O-BQRJwQbUbbFMt29jxHf+KpJWrrm5SmMhumkCBam0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 05. julij 2022 ob 18:29:39 CEST je Roman Stratiienko napisal(a):
> Hi Jernej,
>=20
> =D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 19:07, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
> > Hi Roman,
> >=20
> > Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko=20
napisal(a):
> > > Using simple bash script it was discovered that not all CCU registers
> > >=20
> > > can be safely used for DFS, e.g.:
> > >     while true
> > >     do
> > >    =20
> > >         devmem 0x3001030 4 0xb0003e02
> > >         devmem 0x3001030 4 0xb0001e02
> > >    =20
> > >     done
> > >=20
> > > Script above changes the GPU_PLL multiplier register value. While the
> > > script is running, the user should interact with the user interface.
> > >=20
> > > Using this method the following results were obtained:
> > > | Register  | Name           | Bits  | Values | Result |
> > > | --        | --             | --    | --     | --     |
> > > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> > >=20
> > > DVFS started to work seamlessly once dividers which caused the
> > > glitches were set to fixed values.
> > >=20
> > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > >=20
> > > ---
> > >=20
> > > Changelog:
> > >=20
> > > V2:
> > > - Drop changes related to mux
> > > - Drop frequency limiting
> > > - Add unused dividers initialization
> > >=20
> > > V3:
> > > - Adjust comments
> >=20
> > I don't see any comment fixed, at least not to "1", as we discussed. Di=
d I
> > miss anything?
>=20
> I've added the "bits" word, so now it should sound correct.

Technically it's correct, but this would be third form of comments for fixe=
d=20
bits. Let's stick to the form which is most informative ("Force PLL_GPU out=
put=20
divider to 1"). Ideally, comment would also point to gpu_clk comment for=20
reason why, like it's done for video PLL block already.

>=20
> > Also, please add min and max.
>=20
> What is the rationale for additional limits?

If limits are specified in whatever form, they should be added. As I said=20
several times already, vendor code limits PLL frequency to 288 MHz minimum =
and=20
lists maximum. As experienced a few times before with video PLLs, these are=
=20
important, otherwise PLL is unstable. For example, OPP table in vendor DT h=
as=20
two operating points lower than 288 MHz, which means it would either lock u=
p=20
or be unstable. In such cases, vendor code actually sets GPU_CLK divider to=
 2,=20
but we can skip them, because GPU_CLK divider will be hardcoded to 1 with t=
his=20
patch.

> CPU_PLL doesn't have these limits. I don't want to make them different.

Why CPU_PLL? Why not video PLL? In any case, it doesn't matter if struct lo=
oks=20
similar to some other or is unique. Only important thing is that struct=20
describes PLL as best as possible.

>=20
> > I also consent to R-B, which you
> > didn't include.
>=20
> I was expecting an explicit 'review-by' line. Anyway I can add it and
> resend v4 if it's necessary.

If you at least add min and max limits, you can add following tag:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

If you send it before Friday, it will be in 5.20.

Best regards,
Jernej

>=20
> Regards,
> Roman
>=20
> > Did you resend v2 instead of v3?
> >=20
> > Best regards,
> > Jernej
> >=20
> > > ---
> > >=20
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index
> > > 2ddf0a0da526f..068d1a6b2ebf3
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > >=20
> > >       },
> > > =20
> > >  };
> > >=20
> > > +/* For GPU PLL, using an output divider for DFS causes system to fail
> > > */
> > >=20
> > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > > =20
> > >       .enable         =3D BIT(31),
> > >       .lock           =3D BIT(28),
> > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > >=20
> > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> >=20
> > */
> >=20
> > >       .common         =3D {
> > >      =20
> > >               .reg            =3D 0x030,
> > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > >=20
> > > @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > >=20
> > > +/* Keep GPU_CLK divider const to avoid DFS instability. */
> > >=20
> > >  static const char * const gpu_parents[] =3D { "pll-gpu" };
> > >=20
> > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > > -                                    0, 3,    /* M */
> > > +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > >=20
> > >                                      24, 1,   /* mux */
> > >                                      BIT(31), /* gate */
> > >                                      CLK_SET_RATE_PARENT);
> > >=20
> > > @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct
> > > platform_device *pdev) if (IS_ERR(reg))
> > >=20
> > >               return PTR_ERR(reg);
> > >=20
> > > +     /* Force PLL_GPU output divider bits to 0 */
> > > +     val =3D readl(reg + SUN50I_H6_PLL_GPU_REG);
> > > +     val &=3D ~BIT(0);
> > > +     writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> > > +
> > > +     /* Force GPU_CLK divider bits to 0 */
> > > +     val =3D readl(reg + gpu_clk.common.reg);
> > > +     val &=3D ~GENMASK(3, 0);
> > > +     writel(val, reg + gpu_clk.common.reg);
> > > +
> > >=20
> > >       /* Enable the lock bits on all PLLs */
> > >       for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > >      =20
> > >               val =3D readl(reg + pll_regs[i]);
> > >=20
> > > --
> > > 2.34.1


