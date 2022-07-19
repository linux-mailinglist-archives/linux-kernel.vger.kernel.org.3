Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9D57974C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiGSKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiGSKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:05:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B9371A2;
        Tue, 19 Jul 2022 03:04:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so23908847lfs.6;
        Tue, 19 Jul 2022 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GApYuODHUDs3CE90CSIjjOS6jRW77WagBvXinmA8qU=;
        b=KQmNfyPhsTvSvjwdQbD8JTcqU7pEe9tvikXIqvmoSs88yW53JSouuzKkza3wNEzh5+
         G7482R78kiVbRKQTkj/KjfGux4emVMzeHhffpqD5cRPw3Myiq3US5fkqifYyhmZOOyWm
         ATKNY5PRmvlxWCLk+SYM3MhxAv1tGqXxi3C7IV7Frzzchr2OO6Qby11+0ir1W+957vkS
         /SitCSqUj5runQlVT67Dcgqmv65P37JADtidyJk1/5KNIHo28EkXkqATKKKxaiV7Z/UU
         wpz4ZTNESduDnyrGVoL78KgvZ5qNcXbq7T5GSnlDr4ui/2PUj8Gh7c7HCjVhJ51DuC2r
         O9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GApYuODHUDs3CE90CSIjjOS6jRW77WagBvXinmA8qU=;
        b=jBvQorjSyuUDwIJlfXhe6wIE19cLMYuuuJwvQqiUxmINSwLcFbK1xp5t7CQ5eTJp7m
         JjDLR4u60wb2c+TZW1hhqhzWdBnUV05Eiz4rNuiUp/QdxwU+eiR6MpcQEI6or4IdL2UU
         RTdRHNSiGaE0lncRmgq12KxfoOsiFdM+zr4xttPhG+tRloelbNMX8TfPGEMLFpUj8fR5
         f8mZ0DxO/lS2MEhzk8nvZR2rex2lXLc7RByNFxhjm8uvGX+z4FifgCJsEynOZvvxZfeJ
         QlB72Wf6oJAoLlv9aBFxgG/ig9UEVmZycZxzuFtwZ8VEYcvHD7Pc+DMxbm99t8Twq1Wu
         X9DQ==
X-Gm-Message-State: AJIora8oOlPEI/5gQNphisZjVd/DhsdOUWdcoo6WS3Zq/k6BCdQyyv8W
        0lSXrMQHlAIrlbyMSMEY3xunWKtffi8DH0ZfPJA=
X-Google-Smtp-Source: AGRyM1sgr8JRt7Kk6TVn01IdbCihA6OHE2+EjDPnhHWfldIFCoteszLFfDAZvIlPhkV0tjO0MOsXXrY2pPys7gOl0L0=
X-Received: by 2002:a05:6512:22d2:b0:48a:1ec7:2220 with SMTP id
 g18-20020a05651222d200b0048a1ec72220mr11163639lfu.668.1658225094652; Tue, 19
 Jul 2022 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com>
 <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
 <20220718191454.5B5D3C341C0@smtp.kernel.org>
In-Reply-To: <20220718191454.5B5D3C341C0@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 19 Jul 2022 13:04:43 +0300
Message-ID: <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for your reply.

On Mon, 18 Jul 2022 at 22:14, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-07-12 00:28:30)
> > On Mon, 11 Jul 2022 at 22:55, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Tomer Maimon (2022-07-11 05:35:07)
> > > > +        */
> > > > +       int onecell_idx;
> > > > +};
> > > > +
> > > > +struct npcm8xx_clk_pll_data {
> > > > +       u32 reg;
> > > > +       const char *name;
> > > > +       const char *parent_name;
> > >
> > > Any reason why we're not using clk_parent_data or direct clk_hw
> > > pointers?
> > For more historical reasons, I did the same method as done in the
> > NPCM7XX driver.
> > The clk_init_data struct can use * const *parent_names,
> > https://elixir.bootlin.com/linux/v5.19-rc6/source/include/linux/clk-provider.h#L289
> > Is it problematic?
>
> It will need to be changed to not use global string matching. Ideally
> new drivers use clk_parent_data or clk_hw pointers directly. It's faster
> and preferred.
Will be modified V10.
>
> > >
> > > > +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0},
> > > > +       /* bit 10-6 SPI0CKDV*/
> > > > +       {NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
> > > > +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX},
> > > > +       /* bit 5-1 SPIXCKDV*/
> > > > +
> > > > +       {NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, NPCM8XX_CLK_S_RG_MUX,
> > > > +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG},
> > > > +       /* bit 31-28 RGREFDIV*/
> > > > +       {NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, NPCM8XX_CLK_S_RCP_MUX,
> > > > +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP},
> > > > +       /* bit 15-12 RCPREFDIV*/
> > > > +       {NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, NPCM8XX_CLK_S_CPU_MUX,
> > > > +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH},
> > > > +       /* bit 1-0 TH_DIV*/
> > > > +};
> > > > +
> > > > +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> > > > +
> > > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > > +       struct device *dev = &pdev->dev;
> > > > +       struct device_node *np = dev->of_node;
> > > > +       void __iomem *clk_base;
> > > > +       struct resource res;
> > > > +       struct clk_hw *hw;
> > > > +       int i, err;
> > > > +
> > > > +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> > > > +                                                        NPCM8XX_NUM_CLOCKS),
> > > > +                                       GFP_KERNEL);
> > > > +       if (!npcm8xx_clk_data)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       err = of_address_to_resource(np, 0, &res);
> > >
> > > Why can't we use platform_get_resource()?
> > >
> > > > +       if (err) {
> > > > +               dev_err(dev, "Failed to get resource, ret %d\n", err);
> > > > +               return err;
> > > > +       }
> > > > +
> > > > +       clk_base = ioremap(res.start, resource_size(&res));
> > >
> > > And use devm_platform_ioremap_resource()?
> > Clock and reset driver use the same memory register map 0xF0801000 - 0xF0801FFF.
> > For historical reasons the registers of both modules are mixed in the
> > memory range 0xF0801000 - 0xF0801FFF this is why we can't have a
> > separate region for each module.
> > In case I will use devm_platform_ioremap_resource function the reset
> > ioremap will fail so the driver using the method above.
>
> So the clk and reset driver should be the same driver, or one driver
> should register the other and use the auxiliary bus to express the
> relationship. That way we know that the drivers are tightly coupled and
> aren't going to stomp over each other.
I think it is very problematic to use the same driver for the reset
and the clocks also because The NPCM reset driver is an old driver
that was used also to the older NPCM BMC SoC so it will be problematic
to use the clock and reset driver in the same space.
indeed the reset and clocks are using the same memory region but they
are not using the same registers, is it not enough?
Please be aware that the NPCM reset driver is checking that it is
using the reset registers before calling I/O functions.
> > >
> > > > +       if (!clk_base) {
> > > > +               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> > > > +               return -ENOMEM;
> > > > +       }
> > > > +
> > > > +       npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
> > > > +
> > > > +       for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
> > > > +               npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> > > > +
> > > > +       /* Reference 25MHz clock */
> > >
> > > Does this exist on the board? If so, I'd make a fixed rate clk in the
> > > dts and have 'refclk' be an input in the binding for this clk controller.
> > No, it is an internal clock in the SoC, this is why it is in the driver.
>
> Ok. I suppose that could be inside the 'soc' node for this device as a
> fixed rate clk but registering it here is also fine.

Best regards,

Tomer
