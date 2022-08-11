Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC458FC61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiHKMee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiHKMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:34:28 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D18980D;
        Thu, 11 Aug 2022 05:34:24 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id l8so8477062qvr.5;
        Thu, 11 Aug 2022 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PEPGje702ezhjjCZfls7Dsjq/zSNUB0yv54lftYBxpg=;
        b=KWMmt29e0oQf5OVzIBBYOPNxhJS0JCXkfMlC7DveN5ap14Fg1NWFRlYPjckvNIYPT5
         gffpHhysAsWaPqOSi3eP0IYS0eNdHHidd5MnhMV4D692qrRambxptxSSJm1zrHasX3xp
         2Qai/FYcDLvX0ho40BOfTn7pKKEzbKzQBTD9UYbkijHPaPUS5NfwSwcsppCxnErdIvq3
         6Tp49eFG8h9yTuK4uiALB20AuCPeUZl+HHKAXz5TA4Ncey88B+/T7Bfwk0FO4qGhTZyY
         cuOokvY41Nl5Dh/fH3Q01h7Pr1wEAFOA5sWUgHygujuaulmnz+CRf4/jtLHSUWnTUY8D
         Hr4A==
X-Gm-Message-State: ACgBeo1KP+MZ+MBm3ULK+nJ2VUkeie8rcFApCTStjrshI+EhN5Gk5Fs0
        jugUS7CXRYfK6hps1BIeBtlBxKuYLa75y7jC
X-Google-Smtp-Source: AA6agR7VwO70y8/WEzJg5hVLtSuCLorAqTrWmdNivK4a/+MT5nihJS1OpTnOKxTqAFAME1QvgvnhEQ==
X-Received: by 2002:a05:6214:4118:b0:476:aa1c:bbfe with SMTP id kc24-20020a056214411800b00476aa1cbbfemr26954721qvb.93.1660221263747;
        Thu, 11 Aug 2022 05:34:23 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006af3f3b385csm1904249qko.98.2022.08.11.05.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:34:22 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id i62so28019867yba.5;
        Thu, 11 Aug 2022 05:34:21 -0700 (PDT)
X-Received: by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr27769327ybp.380.1660221261538; Thu, 11
 Aug 2022 05:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220804061133.4110734-1-victor.liu@nxp.com> <20220804061133.4110734-3-victor.liu@nxp.com>
In-Reply-To: <20220804061133.4110734-3-victor.liu@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 14:34:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com>
Message-ID: <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com>
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

On Thu, Aug 4, 2022 at 8:10 AM Liu Ying <victor.liu@nxp.com> wrote:
> Simple Power-Managed bus controller may need functional clock(s)
> to be enabled before child devices connected to the bus can be
> accessed.  Get the clock(s) as a bulk and enable/disable the
> clock(s) when the bus is being power managed.
>
> One example is that Freescale i.MX8qxp pixel link MSI bus controller
> needs MSI clock and AHB clock to be enabled before accessing child
> devices.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Thanks for your patch!

> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -8,11 +8,17 @@
>   * for more details.
>   */
>
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> +struct simple_pm_bus {
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +};
> +
>  static const struct of_device_id simple_pm_bus_child_matches[] = {
>         { .compatible = "simple-mfd", },
>         {}
> @@ -24,6 +30,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>         const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
>         struct device_node *np = dev->of_node;
>         const struct of_device_id *match;
> +       struct simple_pm_bus *bus;
>
>         /*
>          * Allow user to use driver_override to bind this driver to a
> @@ -49,6 +56,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
>                         return -ENODEV;
>         }
>
> +       bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +       if (!bus)
> +               return -ENOMEM;
> +
> +       bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
> +       if (bus->num_clks < 0)
> +               return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
> +
> +       dev_set_drvdata(&pdev->dev, bus);
> +
>         dev_dbg(&pdev->dev, "%s\n", __func__);
>
>         pm_runtime_enable(&pdev->dev);

While I agree this patch has merits on its own[*], I am wondering
if you really need it for your use case.

In "[PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
link MSI bus binding", I see your bus has both "clocks" and
"power-domains" properties.  Perhaps your PM Domain can be a clock
domain, too (i.e. setting GENPD_FLAG_PM_CLK and providing
generic_pm_domain.{at,de}tach_dev() callbacks), thus handing clock
handling over to Runtime PM?

[*] The simple-pm-bus DT bindings state:

      clocks: true
        # Functional clocks
        # Required if power-domains is absent, optional otherwise

      power-domains:
        # Required if clocks is absent, optional otherwise
        minItems: 1

While "power-domains" (+ "clocks" in case of a clock domain) is
handled through Runtime PM, the current driver indeed does not handle
"clocks" in the absence of the "power-domains" property.  It looks
like all existing users that use "clocks" rely on the PM Domain being
a clock domain.

With your patch, the clocks might be controlled twice: once explicitly,
through clk_bulk_*(), and a second time implicitly, through Runtime PM.
While this works fine to do clock enable counters, it looks suboptimal
to me.  This could be avoided by making the new explicit clock code
depend on the absence of the "power-domains" property, but that would
break users that have both a PM Domain which is not a clock domain,
and clocks.  So we may have no other option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
