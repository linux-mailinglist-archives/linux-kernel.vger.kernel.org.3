Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099A2590DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiHLI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiHLI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:59:00 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E62A98CD;
        Fri, 12 Aug 2022 01:58:58 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id i4so163559qvv.7;
        Fri, 12 Aug 2022 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qUQqXez2MH5tt5jtUszuvPoxJdGU8zv9BWfe2y7uvjI=;
        b=CP3x4LHHnHdk2Dl1wue8BFTRTV6M00M4pRDXZ4CzWXTYAyQhjtUM1iirUutGY4qfAm
         0DL76FKrZ8lrYwBOzNQDzPZPzs9M2FJIEB27W7Q2f96wbUSXSm3z8h/+5f5a0TnoodZB
         L4VVIGNlhuoNNX0SSLhW/RxCecWA+lIM1Inwo4RHwCIjb7ceDmz0yQKyBU4Rwg2o61Ue
         UDWtrByASyFb9TtjeTtSRTIgi0Su94lGeMhi6qG6PJSJ/eHUaNkCb8wG+URSAogr5c4Q
         g5B0AjVyhvYg+84L6ItJ0W/rUae45wGw8p478XKISb+ZZzM9dNd7EZ6mIHbqCR+anpVq
         dETQ==
X-Gm-Message-State: ACgBeo3OyGSja7AwviNkIp6TIdBzNvtUDUJVV1MU39jywdnmZF1q3mjC
        A1m/7UE8CgTRjrIC5m0EPY4kRDEPP7ikSQ==
X-Google-Smtp-Source: AA6agR4l4Gnqa6AHWJaLiMRADT3+XdFR8RZiqzqdJv6UYhyHJVD0cHP3G21DXI+9fXTSXrqohlZGCw==
X-Received: by 2002:a05:6214:29ef:b0:476:f4e6:a326 with SMTP id jv15-20020a05621429ef00b00476f4e6a326mr2630985qvb.68.1660294737147;
        Fri, 12 Aug 2022 01:58:57 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id w7-20020a05620a424700b006b9593e2f68sm1350317qko.4.2022.08.12.01.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:58:56 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 21so528040ybf.4;
        Fri, 12 Aug 2022 01:58:56 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr2576326ybq.543.1660294736135; Fri, 12
 Aug 2022 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220804061133.4110734-1-victor.liu@nxp.com> <20220804061133.4110734-3-victor.liu@nxp.com>
 <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com> <9349e633a64a2275857b2c08731e40721e5af82b.camel@nxp.com>
In-Reply-To: <9349e633a64a2275857b2c08731e40721e5af82b.camel@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 10:58:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0pHm4QjHNvwADeJ3ngxcHv0k39hdDbZa+xUATAb2=9g@mail.gmail.com>
Message-ID: <CAMuHMdX0pHm4QjHNvwADeJ3ngxcHv0k39hdDbZa+xUATAb2=9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers: bus: simple-pm-bus: Use clocks
To:     Liu Ying <victor.liu@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
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

Hi Liu,

On Fri, Aug 12, 2022 at 10:13 AM Liu Ying <victor.liu@nxp.com> wrote:
> On Thu, 2022-08-11 at 14:34 +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 4, 2022 at 8:10 AM Liu Ying <victor.liu@nxp.com> wrote:
> > > Simple Power-Managed bus controller may need functional clock(s)
> > > to be enabled before child devices connected to the bus can be
> > > accessed.  Get the clock(s) as a bulk and enable/disable the
> > > clock(s) when the bus is being power managed.
> > >
> > > One example is that Freescale i.MX8qxp pixel link MSI bus
> > > controller
> > > needs MSI clock and AHB clock to be enabled before accessing child
> > > devices.
> > >
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >
> > Thanks for your patch!
>
> Thanks for the review.
>
> >
> > > --- a/drivers/bus/simple-pm-bus.c
> > > +++ b/drivers/bus/simple-pm-bus.c
> > > @@ -8,11 +8,17 @@
> > >   * for more details.
> > >   */
> > >
> > > +#include <linux/clk.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > >
> > > +struct simple_pm_bus {
> > > +       struct clk_bulk_data *clks;
> > > +       int num_clks;
> > > +};
> > > +
> > >  static const struct of_device_id simple_pm_bus_child_matches[] = {
> > >         { .compatible = "simple-mfd", },
> > >         {}
> > > @@ -24,6 +30,7 @@ static int simple_pm_bus_probe(struct
> > > platform_device *pdev)
> > >         const struct of_dev_auxdata *lookup =
> > > dev_get_platdata(dev);
> > >         struct device_node *np = dev->of_node;
> > >         const struct of_device_id *match;
> > > +       struct simple_pm_bus *bus;
> > >
> > >         /*
> > >          * Allow user to use driver_override to bind this driver to
> > > a
> > > @@ -49,6 +56,16 @@ static int simple_pm_bus_probe(struct
> > > platform_device *pdev)
> > >                         return -ENODEV;
> > >         }
> > >
> > > +       bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > > +       if (!bus)
> > > +               return -ENOMEM;
> > > +
> > > +       bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus-
> > > > clks);
> > >
> > > +       if (bus->num_clks < 0)
> > > +               return dev_err_probe(&pdev->dev, bus->num_clks,
> > > "failed to get clocks\n");
> > > +
> > > +       dev_set_drvdata(&pdev->dev, bus);
> > > +
> > >         dev_dbg(&pdev->dev, "%s\n", __func__);
> > >
> > >         pm_runtime_enable(&pdev->dev);
> >
> > While I agree this patch has merits on its own[*], I am wondering
> > if you really need it for your use case.
> >
> > In "[PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
> > link MSI bus binding", I see your bus has both "clocks" and
> > "power-domains" properties.  Perhaps your PM Domain can be a clock
> > domain, too (i.e. setting GENPD_FLAG_PM_CLK and providing
> > generic_pm_domain.{at,de}tach_dev() callbacks), thus handing clock
> > handling over to Runtime PM?
>
> It looks like most(if not all) PM domains can be clock domains with
> GENPD_FLAG_PM_CLK and generic_pm_domain.{at,de}tach_dev() callbacks
> set. So, technically, my PM domain(scu-pd.c) can be a clock domain with
> all those set and a special check for "simple-pm-bus" in the
> {at,de}tach_dev callbacks.  But, I'm not sure if it is appropriate to
> do that. How do we determine clocks should be managed by PM domains or
> device drivers? Technically, both would work...

It depends on the hardware topology: is there really a clock domain
(i.e. lots of consumer modules are clocked by a single clock
 controller and can be power-managed that way), or is it just a
 coincidence that your bus has clocks.

E.g. drivers/clk/renesas/renesas-cpg-mssr.c:cpg_mssr_attach_dev()
looks for clocks from the right clock provider and of the right type.

> > [*] The simple-pm-bus DT bindings state:
> >
> >       clocks: true
> >         # Functional clocks
> >         # Required if power-domains is absent, optional otherwise
> >
> >       power-domains:
> >         # Required if clocks is absent, optional otherwise
> >         minItems: 1
> >
> > While "power-domains" (+ "clocks" in case of a clock domain) is
> > handled through Runtime PM, the current driver indeed does not handle
> > "clocks" in the absence of the "power-domains" property.  It looks
>
> Right.
>
> > like all existing users that use "clocks" rely on the PM Domain being
> > a clock domain.
>
> "renesas,bsc" seems to be one of the users.

Yes it is. And it doesn't need a special driver, as it just relies
on Runtime PM controlling both the power area and the clocks through
the PM Domain.

> > With your patch, the clocks might be controlled twice: once
> > explicitly,
> > through clk_bulk_*(), and a second time implicitly, through Runtime
> > PM.
> > While this works fine to do clock enable counters, it looks
> > suboptimal
> > to me.  This could be avoided by making the new explicit clock code
> > depend on the absence of the "power-domains" property, but that would
> > break users that have both a PM Domain which is not a clock domain,
> > and clocks.  So we may have no other option.
>
> Hmm, I'm not sure if there are really users that have both a PM domain
> which is not a clock domain and clocks, given that a PM domain can sort
> of always be a clock domain by setting that GENPD flag and those
> callbacks.  So, what do you suggest? Keep the patch as-is? Or, maybe,
> make my PM domain additionally be a clock domain?

It depends. Is "dc0_disp_ctrl_link_mst0_lpcg" a clock controller that
controls the clock inputs to multiple modules? Based on the name, it
seems to be used only for display-related clocks, while "pd" controls
power to various modules, not limited to display?
Hence you may want to keep your patch as-is.

Renesas R-Car SoCs have separate power area and clock controllers,
too, but they apply to most/all devices.  Hence we moduled this as
a single PM Domain (also because "power-domains" (used to) support
only a single provider), through a close integration of the power
area and clock drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
