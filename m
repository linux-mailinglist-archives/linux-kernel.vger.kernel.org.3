Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08354AA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiFNH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFNH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:29:51 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3823DDF4;
        Tue, 14 Jun 2022 00:29:46 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id a184so5784631qkg.5;
        Tue, 14 Jun 2022 00:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvW5zYgeysNwbbiYui7u/VFeyen3fLSMqOoOSFvD7qE=;
        b=p/NmW/KUxEn/9IyPlauN4nJ74m8YgE7F55HNN0YdeQjyqFG1jCWySyBukZPVgjFA02
         lIXbCvW7igDGW6c/ODagf3jRxcDENNztJzK+FgSlm3+N76+AfbGGa4Vv4jp/IoEg9dzo
         IoeetpL7eI90mIX3irENQj7PfzAtMAOjztSyRw5elpkwhY9WksVK8gmkDZPLfvNfp9QX
         MeUuH7OM4lT9tJhEvyPZYzVTo2Gx8u0N/xz49IHGlIKtPwh7lCt+8zq61Z3gQKhEHBYJ
         pD7ul8Bb4S3UzY8moEiXj5zQeRgLadX2xX5ZjTXDsB204YspzNYh0S3K+4xwqOmKKvs3
         g9Gw==
X-Gm-Message-State: AOAM533syv9ET2RYrtKM1rlReWZESO9vJN83vcoj15UPJxeAJzp8tr8Y
        L0Af9q5nW+naxRLDPZGwVAK0fNpaWhHrqQ==
X-Google-Smtp-Source: ABdhPJwRn7o3U2yNsa5XhXzCXRo4NcYzcye0arUTc2gDDtiq4izGD20gUcJgtMQnRnfLX9yDGXO5pA==
X-Received: by 2002:a05:620a:2621:b0:6a7:1dc:175b with SMTP id z33-20020a05620a262100b006a701dc175bmr2807004qko.683.1655191785519;
        Tue, 14 Jun 2022 00:29:45 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a27c100b006a691904891sm8083144qkp.16.2022.06.14.00.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:29:45 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id l204so13707751ybf.10;
        Tue, 14 Jun 2022 00:29:45 -0700 (PDT)
X-Received: by 2002:a25:cc53:0:b0:65c:b19c:fac1 with SMTP id
 l80-20020a25cc53000000b0065cb19cfac1mr3399500ybf.89.1655191784829; Tue, 14
 Jun 2022 00:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-6-max.oss.09@gmail.com>
In-Reply-To: <20220609150851.23084-6-max.oss.09@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 09:29:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf=VnqePKB=0eJC4GxZipQLD8BKMiv5PBW8Fz+zUv6-Q@mail.gmail.com>
Message-ID: <CAMuHMdUf=VnqePKB=0eJC4GxZipQLD8BKMiv5PBW8Fz+zUv6-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/5] ARM64: verdin-imx8mm: use regulator power
 domain to model sleep-moci
To:     Max Krummenacher <max.oss.09@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Thu, Jun 9, 2022 at 5:16 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> The Verdin CTRL_SLEEP_MOCI# pin signals the carrier board that the module
> is in sleep and it may switch off unneeded power.
>
> Control this pin with a regulator power domain controller which uses a
> fixed regulator with a gpio enable.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
> @@ -92,6 +92,7 @@
>
>  /* Verdin PCIE_1 */
>  &pcie0 {
> +       power-domains = <&pd_sleep_moci>;

This overrides "power-domains = <&pgc_pcie>;" from imx8mm.dtsi...

>         status = "okay";
>  };

> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -53,6 +53,14 @@
>                 };
>         };
>
> +       pd_sleep_moci: power-domain-sleep-moci {
> +               compatible = "regulator-pm-pd";
> +               label = "pd_sleep_moci";
> +               power-domains = <&pgc_pcie>;

... and here you work around that by re-binding <&pgc_pcie>.

I think you:
  1. must not override the power-domains property for pcie0, as
     conceptually, the PCIe bus is still in the on-SoC power
     domain. What if some lanes are connected to devices in
     pd_sleep_moci, but other lanes are not?
  2. should only use pd_sleep_moci for the off-chip devices that
      are actually controlled by the corresponding regulator.

> +               power-supply = <&reg_sleep_moci>;
> +               #power-domain-cells = <0>;
> +       };
> +
>         /* Carrier Board Supplies */
>         reg_1p8v: regulator-1p8v {
>                 compatible = "regulator-fixed";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
