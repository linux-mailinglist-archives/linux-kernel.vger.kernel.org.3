Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30A56B1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiGHE5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGHE5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:57:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC676E89;
        Thu,  7 Jul 2022 21:57:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dn9so30519862ejc.7;
        Thu, 07 Jul 2022 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8fQU4B1VYv6gYeOF0+DboUyub0Jgur6jpw9VLuvZLc=;
        b=U+QK06ak6c3yoHF0diiJe6mM6YJAqv4ly7xM7b3y7THF4unwcNKjwA2xdmwP7JAWMR
         SQuxjIVHnhMs4QIBeuL1jqKoV8wnWoS9HTSQYCrdwYcdR1FwUK7EWls8XADk7aysw+f5
         ZcLTjVKaPZC6ncpaCqQvTLenyjqnu9TAVcvWG75bMYW833gA2QkGJkxHzXKa4GcUobQA
         mPPOpyh8/9RmxkDQfa7oBQZdctqnJ0DvJV5ZKVSImi120k2XsbMb09OjZQ/qF5YS4OPM
         b6gnRt0s8WXURRU1GY58NcAVP5zLQKKU0/ly0JgNXiYMvWWViqcoftXH2lP+rtZWAr+5
         UFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8fQU4B1VYv6gYeOF0+DboUyub0Jgur6jpw9VLuvZLc=;
        b=il3QQbmzW4um8nNbDnmiD3Ad/37oekZgs9xoNRqJxJfYpHlaK7pp2YIqSSR/JkhUp9
         uOg9E5sA9683QrOvYdlBNuiu4shqSch6wMLTNsVEzH2rqLTs852dGsNfgKf0GpQfztJv
         ++svgZF1ZXTWV8dSlZgwls14U1b1722ECGK+x2qt2V48hvuuFGasx7IujSX0PC6+41Dg
         aJijNxROsFWd40s6hC4NGPcD438U8qXsOII9aR4v0tU6XTeCdODSYp9kDLSW0rgXpPNW
         zHbg5D3s/A19cWBBSw9HpOvmXq7xl07JewLZZDjwmHMblXXntpggw+CQMY+/eN99ZFOk
         Lvxg==
X-Gm-Message-State: AJIora9G5BorVHTuBRYz3h7DIxOKrS0UjaEa5bsC8xhoJzfJcp9Gdrrb
        1M92DyIKD703fvFHknspVkweUSayh1ZQpQ==
X-Google-Smtp-Source: AGRyM1s+YcMW+irQo4Mgyxf2lZ+uk+g5ag5Ce6sUSXJiKASfue6qTWGlJV1dSGKo71FWvcb3IhWRrg==
X-Received: by 2002:a17:907:2ccc:b0:72b:2f1:f157 with SMTP id hg12-20020a1709072ccc00b0072b02f1f157mr1659330ejc.265.1657256236231;
        Thu, 07 Jul 2022 21:57:16 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170907774c00b0072b02f99e55sm2570899ejc.197.2022.07.07.21.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:57:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Fri, 08 Jul 2022 06:57:14 +0200
Message-ID: <4408347.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <CAGphcdnw3+E9cHZGUOLnroo7wTR4HRjiKJXdmihSK40jsga9Qw@mail.gmail.com>
References: <20220705075226.359475-1-r.stratiienko@gmail.com> <2562485.k3LOHGUjKi@kista> <CAGphcdnw3+E9cHZGUOLnroo7wTR4HRjiKJXdmihSK40jsga9Qw@mail.gmail.com>
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

Hi Roman,

Dne sreda, 06. julij 2022 ob 11:46:13 CEST je Roman Stratiienko napisal(a):
> =D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 21:07, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
> > Dne torek, 05. julij 2022 ob 18:29:39 CEST je Roman Stratiienko=20
napisal(a):
> > > Hi Jernej,
> > >=20
> > > =D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 19:07, Jernej=
 =C5=A0krabec <jernej.skrabec@gmail.com>:
> > > > Hi Roman,
> > > >=20
> > > > Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko
> >=20
> > napisal(a):
> > > > > Using simple bash script it was discovered that not all CCU
> > > > > registers
> > > > >=20
> > > > > can be safely used for DFS, e.g.:
> > > > >     while true
> > > > >     do
> > > > >    =20
> > > > >         devmem 0x3001030 4 0xb0003e02
> > > > >         devmem 0x3001030 4 0xb0001e02
> > > > >    =20
> > > > >     done
> > > > >=20
> > > > > Script above changes the GPU_PLL multiplier register value. While
> > > > > the
> > > > > script is running, the user should interact with the user interfa=
ce.
> > > > >=20
> > > > > Using this method the following results were obtained:
> > > > > | Register  | Name           | Bits  | Values | Result |
> > > > > | --        | --             | --    | --     | --     |
> > > > > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > > > > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > > > > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > > > > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> > > > >=20
> > > > > DVFS started to work seamlessly once dividers which caused the
> > > > > glitches were set to fixed values.
> > > > >=20
> > > > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > > > >=20
> > > > > ---
> > > > >=20
> > > > > Changelog:
> > > > >=20
> > > > > V2:
> > > > > - Drop changes related to mux
> > > > > - Drop frequency limiting
> > > > > - Add unused dividers initialization
> > > > >=20
> > > > > V3:
> > > > > - Adjust comments
> > > >=20
> > > > I don't see any comment fixed, at least not to "1", as we discussed.
> > > > Did I
> > > > miss anything?
> > >=20
> > > I've added the "bits" word, so now it should sound correct.
> >=20
> > Technically it's correct, but this would be third form of comments for
> > fixed bits. Let's stick to the form which is most informative ("Force
> > PLL_GPU output divider to 1"). Ideally, comment would also point to
> > gpu_clk comment for reason why, like it's done for video PLL block
> > already.
> >=20
> > > > Also, please add min and max.
> > >=20
> > > What is the rationale for additional limits?
> >=20
> > If limits are specified in whatever form, they should be added. As I sa=
id
> > several times already, vendor code limits PLL frequency to 288 MHz mini=
mum
> > and lists maximum. As experienced a few times before with video PLLs,
> > these are important, otherwise PLL is unstable. For example, OPP table =
in
> > vendor DT has two operating points lower than 288 MHz, which means it
> > would either lock up or be unstable. In such cases, vendor code actually
> > sets GPU_CLK divider to 2, but we can skip them, because GPU_CLK divider
> > will be hardcoded to 1 with this patch.
>=20
> What is the rationale behind vendor's freq limitation?

You have to ask Allwinner. But usually it's a good reason, otherwise they=20
wouldn't bother to write such code.

>=20
> There's no min_rate field in ccu_nkmp. After I changed it to ccu_nm
> and set limits, the system started to behave unstable with a lot of
> messages in dmesg:
>=20
> [   40.089091] panfrost 1800000.gpu: _generic_set_opp_clk_only: failed
> to set clock rate: -22
> [   40.097698] devfreq 1800000.gpu: dvfs failed with (-22) error

Did you remove points below 288 MHz?

>=20
> From the other end I have no issues so far with the current version
> and I have a lot of other work to do.
> I think it's a good point to stop any further improvements until
> testing results show any issues with the current version.
>=20
> > > CPU_PLL doesn't have these limits. I don't want to make them differen=
t.
> >=20
> > Why CPU_PLL?
>=20
> According to the H6 usermanual only CPU and GPU PLLs support smooth
> clock transition during DFS.

This doesn't mean they have exactly the same limitations. Anyway, I'll merg=
e=20
this one. So:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Regards,
> Roman.
>=20
> > Why not video PLL? In any case, it doesn't matter if struct looks
> > similar to some other or is unique. Only important thing is that struct
> > describes PLL as best as possible.
> >=20
> > > > I also consent to R-B, which you
> > > > didn't include.
> > >=20
> > > I was expecting an explicit 'review-by' line. Anyway I can add it and
> > > resend v4 if it's necessary.
> >=20
> > If you at least add min and max limits, you can add following tag:
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > If you send it before Friday, it will be in 5.20.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Regards,
> > > Roman
> > >=20
> > > > Did you resend v2 instead of v3?
> > > >=20
> > > > Best regards,
> > > > Jernej
> > > >=20
> > > > > ---
> > > > >=20
> > > > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
> > > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index
> > > > > 2ddf0a0da526f..068d1a6b2ebf3
> > > > > 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > > @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > > > >=20
> > > > >       },
> > > > > =20
> > > > >  };
> > > > >=20
> > > > > +/* For GPU PLL, using an output divider for DFS causes system to
> > > > > fail
> > > > > */
> > > > >=20
> > > > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > > > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > > > > =20
> > > > >       .enable         =3D BIT(31),
> > > > >       .lock           =3D BIT(28),
> > > > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > > > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider =
*/
> > > > >=20
> > > > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> > > >=20
> > > > */
> > > >=20
> > > > >       .common         =3D {
> > > > >      =20
> > > > >               .reg            =3D 0x030,
> > > > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > > > >=20
> > > > > @@ -294,9 +294,9 @@ static
> > > > > SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> > > > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > > > >=20
> > > > > +/* Keep GPU_CLK divider const to avoid DFS instability. */
> > > > >=20
> > > > >  static const char * const gpu_parents[] =3D { "pll-gpu" };
> > > > >=20
> > > > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents,
> > > > > 0x670,
> > > > > -                                    0, 3,    /* M */
> > > > > +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x67=
0,
> > > > >=20
> > > > >                                      24, 1,   /* mux */
> > > > >                                      BIT(31), /* gate */
> > > > >                                      CLK_SET_RATE_PARENT);
> > > > >=20
> > > > > @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct
> > > > > platform_device *pdev) if (IS_ERR(reg))
> > > > >=20
> > > > >               return PTR_ERR(reg);
> > > > >=20
> > > > > +     /* Force PLL_GPU output divider bits to 0 */
> > > > > +     val =3D readl(reg + SUN50I_H6_PLL_GPU_REG);
> > > > > +     val &=3D ~BIT(0);
> > > > > +     writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> > > > > +
> > > > > +     /* Force GPU_CLK divider bits to 0 */
> > > > > +     val =3D readl(reg + gpu_clk.common.reg);
> > > > > +     val &=3D ~GENMASK(3, 0);
> > > > > +     writel(val, reg + gpu_clk.common.reg);
> > > > > +
> > > > >=20
> > > > >       /* Enable the lock bits on all PLLs */
> > > > >       for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > > > >      =20
> > > > >               val =3D readl(reg + pll_regs[i]);
> > > > >=20
> > > > > --
> > > > > 2.34.1




