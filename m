Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2711754CD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiFOPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiFOPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:32:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A243CE3C;
        Wed, 15 Jun 2022 08:32:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h23so19523304lfe.4;
        Wed, 15 Jun 2022 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDmJ/1hH1Y7P0JPg/pBSMltfD0etiGQmhyhqG4Y659s=;
        b=WZSiAgrTPdJWnSQsprhjOtMAW9x0/89CYUZm658X4gAh00Bgmui+kAIB5ifmDiTA4W
         4vkkITzB10/9xlS5pOdSjkEtSxghcrBwW1eojcx2cy0TUZEh7RiYzPM9VP2gss4IUtaq
         HO0+DfNgBCFDQIKxcsPxrn4OL0lIu3mM2I12t+1C17SzW1kOIW5hckqAmhss5xSXHWE9
         G/hNBehy6nd8SV+tGJl11bJhccW5JpDsANDa7DlCWmrrgelabJvmO2FPaa1v9M3gk8TL
         Zl5libbYG739FoWfQgfPt354GCW+ospzDSVi6r8JT+ena5yoeKNLDOjr5wz07fz++4Ir
         +MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDmJ/1hH1Y7P0JPg/pBSMltfD0etiGQmhyhqG4Y659s=;
        b=mix0XkGDRfofw6I/pOY+J5OJrVKnMzzo+0imAvnuh+SNbqtQTfbyhnncHjiQskN/NK
         dGuWuJtWJNLAgiM4ELabIa4K/2F9sym4awEepZs4RgY4U38WdC0IywvbFwzP18WSslvf
         mzG3y0N+dyQquuStJ5WZDL5GATHatgulzFXCJ4lpBpRvrCdQvFVmQGzECQX1XsMiZA5B
         BBWO00kT9ZcoCo7JDrCzZytaAKQWcU4mfYjD9Ly7nMbDTnECV6SqkHr5ZEfuMRWLdWhO
         fgvBp7lOpt95ueg2As3aafKGVO8wW1MJ0byIJCa5sb85scF9m9S53XdIE34cCQ09d9jy
         uFtA==
X-Gm-Message-State: AJIora+IZmkuWihSKQvw/xKN7OWU3AgPMRCheK8HXyouU1NlgxlvSQ2d
        2k/bMPgP+qjjATU3lsa4UetIDKjdhAso4eyhGEU=
X-Google-Smtp-Source: AGRyM1tG1+t0l4Tw3Ckll7X3C6ctah44JTSkdCmL6yK6uylgTgTXwvdzDr0mEdzwcTP3/GXA2CosJRFvobfIvlqak0c=
X-Received: by 2002:a05:6512:68b:b0:479:40e9:2940 with SMTP id
 t11-20020a056512068b00b0047940e92940mr30622lfe.381.1655307174922; Wed, 15 Jun
 2022 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-6-max.oss.09@gmail.com>
 <CAMuHMdUf=VnqePKB=0eJC4GxZipQLD8BKMiv5PBW8Fz+zUv6-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUf=VnqePKB=0eJC4GxZipQLD8BKMiv5PBW8Fz+zUv6-Q@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 15 Jun 2022 17:32:43 +0200
Message-ID: <CAEHkU3U+Ahk1eyw-dWYM2Egt8xvhyM6piEHbSSq=dyZstomHcg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/5] ARM64: verdin-imx8mm: use regulator power
 domain to model sleep-moci
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 14, 2022 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Max,
>
> On Thu, Jun 9, 2022 at 5:16 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > The Verdin CTRL_SLEEP_MOCI# pin signals the carrier board that the module
> > is in sleep and it may switch off unneeded power.
> >
> > Control this pin with a regulator power domain controller which uses a
> > fixed regulator with a gpio enable.
> >
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
> > @@ -92,6 +92,7 @@
> >
> >  /* Verdin PCIE_1 */
> >  &pcie0 {
> > +       power-domains = <&pd_sleep_moci>;
>
> This overrides "power-domains = <&pgc_pcie>;" from imx8mm.dtsi...
>
> >         status = "okay";
> >  };
>
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -53,6 +53,14 @@
> >                 };
> >         };
> >
> > +       pd_sleep_moci: power-domain-sleep-moci {
> > +               compatible = "regulator-pm-pd";
> > +               label = "pd_sleep_moci";
> > +               power-domains = <&pgc_pcie>;
>
> ... and here you work around that by re-binding <&pgc_pcie>.
>
> I think you:
>   1. must not override the power-domains property for pcie0, as
>      conceptually, the PCIe bus is still in the on-SoC power
>      domain. What if some lanes are connected to devices in
>      pd_sleep_moci, but other lanes are not?
>   2. should only use pd_sleep_moci for the off-chip devices that
>       are actually controlled by the corresponding regulator.

I fully agree.
I wanted to send along the implementation commits for the power
domain controller something which actually uses it and which
did work in my testing.
That is why I marked this as RFC and I know that more
work is needed.

Cheers
Max

>
> > +               power-supply = <&reg_sleep_moci>;
> > +               #power-domain-cells = <0>;
> > +       };
> > +
> >         /* Carrier Board Supplies */
> >         reg_1p8v: regulator-1p8v {
> >                 compatible = "regulator-fixed";
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
