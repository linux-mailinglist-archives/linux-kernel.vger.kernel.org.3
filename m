Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D34557DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiFWOW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiFWOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:22:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BDA443DA;
        Thu, 23 Jun 2022 07:22:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w20so33607026lfa.11;
        Thu, 23 Jun 2022 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jddTL9QD/ReUBIK8e7DEu/2c3B2sdMOmbz7ylbgg8uU=;
        b=UdndNViC1lHdJAjcXSRoDDIr6TN77FcLRu+YCKR3eVBxGgsbZ7lJbxmF8KPVWNx+1k
         7SuvoW4pKqtAMSvuflg3/QAzVcBMXxFRrpe9z0LDJE5XYqiGUW0/ZhciCi7cZHXqdMIm
         WtBSFpKwEsrGROx1aIl5mwHlb3ljWGXW9TQVTJSF1j8gz978P10jgp15xv9+3T6PAXcF
         8YUzukpaLKNliwihcO2ao/HizK8M1pEh39tjovB95oIGDgrp7QRpLER0KZKhSMmjhwLk
         QJW4g4T/c+5QvzwShprF9WYbQE6hpfq7wijajKSj8RgnS+NDXv3u6BXvKuzDJfsJ2VvA
         bOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jddTL9QD/ReUBIK8e7DEu/2c3B2sdMOmbz7ylbgg8uU=;
        b=4weovZTlBeOhfnhNuEV+i8uoGcOCvN40Z+bHu031TV55pQYgkRmyUg/QWEBXXw0DTD
         7U19vHFPdq0+Dy0PL2G4/7XTbKfuGH53cdTnsn99gcN8anLcsCiTyCsViCEoJjLlsIH8
         xwv2LP3kQkllo+E/EW1xdN8g1nasr2i64vW70k/HjmKhW4yn/LRBwOPgMLlxUnkHYca0
         D9IStkf8Ir8g+8j7/bGTn7oGSC7A7FrNSDI4l2Fucg9VAKHV6P23TNzNBCbNw300BBLS
         MgZN+SbJQmMq31YZUxZkcN/qGnH9I2c4Um6WfYm03cvi31pzZX1kAWl+dmarpbOPXo1G
         JlsA==
X-Gm-Message-State: AJIora8jYCb9xMviuUyPDia21jdPYin7qkRWZr6Ac8Aopg/hdqu8anWZ
        GTZVa4f87DtXKFvWscED/8dMRji+sTQtAdY89Sc=
X-Google-Smtp-Source: AGRyM1u4kTKF1M/+gcdpRyS3zlRbZrXYLNTyR21rReGGI/adWyMDVQRkBDvMt3c2QttvOyzZECBuIq4aM0VQ7Nr0Q7k=
X-Received: by 2002:a05:6512:15a1:b0:47f:933e:a865 with SMTP id
 bp33-20020a05651215a100b0047f933ea865mr5336686lfb.200.1655994167914; Thu, 23
 Jun 2022 07:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220621131424.162355-1-tmaimon77@gmail.com> <20220621131424.162355-7-tmaimon77@gmail.com>
 <9a320833-e951-7a0f-e2bd-3f8deb7e705b@wanadoo.fr>
In-Reply-To: <9a320833-e951-7a0f-e2bd-3f8deb7e705b@wanadoo.fr>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 23 Jun 2022 17:22:36 +0300
Message-ID: <CAP6Zq1iaAyhwY9biRCAXr7nbgPwZdyeUV9YU0w3fNmraC6ToPw@mail.gmail.com>
Subject: Re: [PATCH v4 06/18] clk: npcm8xx: add clock controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for your comments

On Thu, 23 Jun 2022 at 11:08, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 21/06/2022 =C3=A0 15:14, Tomer Maimon a =C3=A9crit :
> > Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
> > generates and supplies clocks to all modules within the BMC.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >   drivers/clk/Kconfig       |   6 +
> >   drivers/clk/Makefile      |   1 +
> >   drivers/clk/clk-npcm8xx.c | 594 +++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 601 insertions(+)
> >   create mode 100644 drivers/clk/clk-npcm8xx.c
> >
>
> [...]
>
> > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > +{
> > +     struct clk_hw_onecell_data *npcm8xx_clk_data;
> > +     struct device *dev =3D &pdev->dev;
> > +     void __iomem *clk_base;
> > +     struct clk_hw *hw;
> > +     int i;
> > +
> > +     npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_da=
ta, hws,
> > +                                                      NPCM8XX_NUM_CLOC=
KS),
> > +                                     GFP_KERNEL);
> > +     if (!npcm8xx_clk_data)
> > +             return -ENOMEM;
> > +
> > +     clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(clk_base))
> > +             return PTR_ERR(clk_base);
> > +
> > +     npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> > +
> > +     for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> > +             npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> > +
> > +     /* Reference 25MHz clock */
> > +     hw =3D clk_hw_register_fixed_rate(dev, "refclk", NULL, 0, NPCM8XX=
_REF_CLK);
> > +     if (IS_ERR(hw))
> > +             return PTR_ERR(hw);
> > +     npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] =3D hw;
> > +
> > +     /* Register plls */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
> > +             const struct npcm8xx_clk_pll_data *pll_data =3D &npcm8xx_=
plls[i];
> > +
> > +             hw =3D npcm8xx_clk_register_pll(dev, clk_base + pll_data-=
>reg,
> > +                                           pll_data->name,
> > +                                           pll_data->parent_name,
> > +                                           pll_data->flags);
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register pll\n")=
;
> > +                     goto unregister_refclk;
>
> goto err_mux_clk?
>
> (so that we unregister what has already been registered in the loop ;
> and unregister_refclk becomes useless)
The err_mux_clk related only to npcm8xx_muxes,
npcm8xx_clk_register_pll calling devm_clk_hw_register function in case
it fails it will unregister.
>
> > +             }
> > +
> > +             if (pll_data->onecell_idx >=3D 0)
> > +                     npcm8xx_clk_data->hws[pll_data->onecell_idx] =3D =
hw;
> > +     }
> > +
> > +     /* Register fixed dividers */
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_=
DIV2,
> > +                                            NPCM8XX_CLK_S_PLL1, 0, 1, =
2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
> > +             goto unregister_refclk;
> > +     }
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_=
DIV2,
> > +                                            NPCM8XX_CLK_S_PLL2, 0, 1, =
2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
> > +             goto unregister_refclk;
> > +     }
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_C=
LK,
> > +                                            NPCM8XX_CLK_S_CPU_MUX, 0, =
1, 2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
> > +             goto unregister_refclk;
> > +     }
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
> > +                                            NPCM8XX_CLK_S_TH, 0, 1, 2)=
;
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> > +             goto unregister_refclk;
> > +     }
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
> > +                                            NPCM8XX_CLK_S_AXI, 0, 1, 2=
);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> > +             goto unregister_refclk;
> > +     }
> > +
> > +     /* Register clock dividers specified in npcm8xx_divs */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> > +             const struct npcm8xx_clk_div_data *div_data =3D &npcm8xx_=
divs[i];
> > +
> > +             hw =3D devm_clk_hw_register_divider(dev, div_data->name,
> > +                                               div_data->parent_name,
> > +                                               div_data->flags,
> > +                                               clk_base + div_data->re=
g,
> > +                                               div_data->shift,
> > +                                               div_data->width,
> > +                                               div_data->clk_divider_f=
lags,
> > +                                               &npcm8xx_clk_lock);
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register div tab=
le\n");
> > +                     goto unregister_refclk;
> > +             }
> > +
> > +             if (div_data->onecell_idx >=3D 0)
> > +                     npcm8xx_clk_data->hws[div_data->onecell_idx] =3D =
hw;
> > +     }
> > +
> > +     /* Register muxes */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> > +             const struct npcm8xx_clk_mux_data *mux_data =3D &npcm8xx_=
muxes[i];
> > +
> > +             hw =3D clk_hw_register_mux_table(dev, mux_data->name,
> > +                                            mux_data->parent_names,
> > +                                            mux_data->num_parents,
> > +                                            mux_data->flags,
> > +                                            clk_base + NPCM8XX_CLKSEL,
> > +                                            mux_data->shift,
> > +                                            mux_data->mask, 0,
> > +                                            mux_data->table,
> > +                                            &npcm8xx_clk_lock);
> > +
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register mux\n")=
;
> > +                     goto err_mux_clk;
> > +             }
> > +
> > +             if (mux_data->onecell_idx >=3D 0)
> > +                     npcm8xx_clk_data->hws[mux_data->onecell_idx] =3D =
hw;
> > +     }
> > +
> > +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                        npcm8xx_clk_data);
>
> If this fails, I think we should also "goto err_mux_clk;"
Will be fix in V6
>
> > +
> > +err_mux_clk:
> > +     while (i--) {
> > +             if (npcm8xx_muxes[i].onecell_idx >=3D 0)
> > +                     clk_hw_unregister_mux(npcm8xx_clk_data->hws[npcm8=
xx_muxes[i].onecell_idx]);
> > +     }
> > +unregister_refclk:
> > +     clk_hw_unregister(npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK]);
> > +     return PTR_ERR(hw);
> > +}
>
> Does a .remove() function is needed to match this error handling path?
> (or use devm_add_action_or_reset())?
I am not sure that the remove driver function is needed in the clock
driver because the clock driver is a service driver for other driver
modules (same as the Pin controller).
>
> CJ
> > +
> > +static const struct of_device_id npcm8xx_clk_dt_ids[] =3D {
> > +     { .compatible =3D "nuvoton,npcm845-clk", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
> > +
> > +static struct platform_driver npcm8xx_clk_driver =3D {
> > +     .probe  =3D npcm8xx_clk_probe,
> > +     .driver =3D {
> > +             .name =3D "npcm8xx_clk",
> > +             .of_match_table =3D npcm8xx_clk_dt_ids,
> > +     },
> > +};
> > +
> > +static int __init npcm8xx_clk_driver_init(void)
> > +{
> > +     return platform_driver_register(&npcm8xx_clk_driver);
> > +}
> > +arch_initcall(npcm8xx_clk_driver_init);
> > +
>

Best regards,

Tomer
