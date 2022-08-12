Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0D590E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiHLJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:49:38 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BEDAA4DE;
        Fri, 12 Aug 2022 02:49:37 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id h22so385609qtu.2;
        Fri, 12 Aug 2022 02:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=84EvJYe5/gB9MvzhwVIbaAf2+0yNVDv4HY17IxGY5sE=;
        b=lXZSXclDVpiOxqb8zStNCMQn8pAjuw+YJ/Ov692WZMxsnAE2j9ZJBRRSn+Yb6qmHMw
         WkuPBpatUsT9A3uWh0S4oaWcW5d7fyssSvGOuwSwU/5zkx/1Qp1fNDAKvLq3aHhvEaLq
         RlQ/OshZ/BvthyAgciVYRUP6qDX2TEQ7r70rY4/G4GnQHi1X03b4oILhREgNgfDNhzOY
         1DgY19lIrY+Pdh8UbPkdQOeig4lbSiVY0Az66Xcdv3x0UAUBpbBB62roH3JisgxnPxut
         F1bIQA0cuROEbqV7OZ6yRv1nLWJ/OHp5jlq+RV6MtfOOnewqWEdrbWV0pFJM5f3k0fgI
         VD6A==
X-Gm-Message-State: ACgBeo3YI7Wo0RB0njpdXEZWeHfVQ/8UewZDek1u2ouQBKa8Zg0t5a0l
        /y5kAar9EeOWsKzaaIg50dFyMsYrt6D1PQ==
X-Google-Smtp-Source: AA6agR52P4Z1alayH6a8t1l9xheDMIINoCnoyQTX2jLfzRoWOqOI7vDenjSSgVZS3vT+BNxY20iueQ==
X-Received: by 2002:a05:622a:d:b0:31f:3fc:c5c7 with SMTP id x13-20020a05622a000d00b0031f03fcc5c7mr2719045qtw.411.1660297776357;
        Fri, 12 Aug 2022 02:49:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003430589dd34sm1450322qtx.57.2022.08.12.02.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:49:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 21so693635ybf.4;
        Fri, 12 Aug 2022 02:49:35 -0700 (PDT)
X-Received: by 2002:a25:2d4:0:b0:674:b112:4f37 with SMTP id
 203-20020a2502d4000000b00674b1124f37mr2830842ybc.202.1660297775213; Fri, 12
 Aug 2022 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220804061133.4110734-1-victor.liu@nxp.com> <20220804061133.4110734-3-victor.liu@nxp.com>
In-Reply-To: <20220804061133.4110734-3-victor.liu@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 11:49:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLJ4t0GVXNWONwcSWuEBV6EuGTm4a2fumA_8dpD7TQuA@mail.gmail.com>
Message-ID: <CAMuHMdWLJ4t0GVXNWONwcSWuEBV6EuGTm4a2fumA_8dpD7TQuA@mail.gmail.com>
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
> ---
> v1->v3:
> * No change.

Thanks for your patch!

> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c

> @@ -72,6 +89,42 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int simple_pm_bus_runtime_suspend(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;

Can this really happen?

> +
> +       clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
> +
> +       return 0;
> +}
> +
> +static int simple_pm_bus_runtime_resume(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (!bus)
> +               return 0;

Likewise.

> +
> +       ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
> +       if (ret) {
> +               dev_err(dev, "failed to enable clocks: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
