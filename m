Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC2511797
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiD0Mfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiD0Mfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:35:41 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C04C42C;
        Wed, 27 Apr 2022 05:32:29 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id hf18so1000591qtb.0;
        Wed, 27 Apr 2022 05:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wctzDfDylFmLP2RkMiHxbhLA3WY20vXxkJqi8oigFwE=;
        b=DIa18UYBpi7afZ9y32eMycTmAj7LpAs0ADmQV4lIt6i+8F+XcWYBriZhTxxkNJm9bx
         pUt6q06/5z8PciFHjdD/ujhbGct4L4is+yDeZh74btgliUJ0qeLX3LZuN/d6zQbXGzVT
         y91KVGp9MGLhR4voViM4hK74qnvrr5qhL5a40N3LJB3VQ+c4o+lNv6/3a1YpBYN0gF74
         SoZ/xp8/dnVxS9NJzQmWP2y+tK1kdYVWAUVPQrmbcfBZtEP6l6lhHKE+iuqmxLwUh5FZ
         y5zDo6BrLJ4tnCMWpoNKkMFVLS3DFyRi35iV1E6WT/QdZUMcUg62Y+zlL7obElQ/Gz2a
         6vbQ==
X-Gm-Message-State: AOAM533Chzzz/scVLGY6b38T2WKpIr7q0IYVLdKkrYim3zLiBGcx+Uxs
        shGvW9opo0IZxagXLebZDA6nQKqwA7aGJg==
X-Google-Smtp-Source: ABdhPJxkn6pOj+SI3AIPM2hdprWq5NY/NU8IpVTLl2apJuPjeGdQNoTpaAf8CdJtY7nWfJ+gY6R1vg==
X-Received: by 2002:a05:622a:589:b0:2f3:5971:80c with SMTP id c9-20020a05622a058900b002f35971080cmr17410085qtb.270.1651062748186;
        Wed, 27 Apr 2022 05:32:28 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id bq37-20020a05620a46a500b0069f67110f37sm3997353qkb.117.2022.04.27.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:32:28 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j2so3162567ybu.0;
        Wed, 27 Apr 2022 05:32:27 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr26233812ybq.393.1651062747550; Wed, 27
 Apr 2022 05:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220413082527.155740-1-jjhiblot@traphandler.com> <20220413082527.155740-3-jjhiblot@traphandler.com>
In-Reply-To: <20220413082527.155740-3-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 14:32:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLpuoTiOn7yDwTTnjkqWJ4PXuhdCLiLcOP2uyzyV6==A@mail.gmail.com>
Message-ID: <CAMuHMdXLpuoTiOn7yDwTTnjkqWJ4PXuhdCLiLcOP2uyzyV6==A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        tzungbi@kernel.org,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

On Wed, Apr 13, 2022 at 10:25 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
> very limited timeout capabilities. However, it can reset the device.
> To do so, the corresponding bits in the SysCtrl RSTEN register need to
> be enabled. This is not done by this driver.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/watchdog/rzn1_wdt.c

> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rzn1_watchdog *wdt;
> +       struct device_node *np = dev->of_node;
> +       struct clk *clk;
> +       int ret;
> +       int irq;
> +
> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +       if (!wdt)
> +               return -ENOMEM;
> +
> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(wdt->base))
> +               return PTR_ERR(wdt->base);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
> +                              np->name, wdt);
> +       if (ret) {
> +               dev_err(dev, "failed to request irq %d\n", irq);
> +               return ret;
> +       }
> +
> +       clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(dev, "failed to get the clock\n");
> +               return PTR_ERR(clk);
> +       }
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(dev, "failed to prepare/enable the clock\n");
> +               return ret;
> +       }
> +
> +       ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
> +                                      clk);
> +       if (ret) {
> +               dev_err(dev, "failed to register clock unprepare callback\n");

Please remove this error message.
devm_add_action_or_reset() only fails when running out of memory,
in which case the memory allocation core has already printed an
error message.

> +               return ret;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
