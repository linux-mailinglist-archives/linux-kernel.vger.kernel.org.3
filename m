Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE44FD7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389684AbiDLJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377707AbiDLHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:53:13 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83A50057
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:22 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id b189so13076065qkf.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPZwLQHFGbE+YddKPiwbAMBD+8+olRhnFPT9yzLHixE=;
        b=M2WEwWhsS5LUsL7JxqIMgLVWkxTd3CZbXf9y7CpyZ4uG0vD8865/ENv6Q1yBk619M9
         pfNgXIYH+Ob8Uve6sjvq7OLZqyOdUC1/AhXOkZ0EcKc583c/TO3gM4hUqqOFkxiBLgGx
         BXwdkKyyqgPnTZXQNkvouqe9FQZNMIKris5r1kfjxlRn0Oa3McUKzyQao6pl+gOTk9zp
         5YvQ5EohAPQOJPlulwAzLNTc2z/rawfx1PbfGfkDNfkSYboNee4Fnrhbj9EJd/Af5i10
         yjN6dCRxlm3GLk5MBahon+DuDdnqi4T7xnDf1APOY5/OVnEawrAwKqjMP35FXkIoe3oQ
         1r9A==
X-Gm-Message-State: AOAM531dttITz2aZpz6qU1kIvLV8HQfJAxksSAwhkzjPYWQZvZ4zbl1v
        2bg5c88Enf2ryD9ChcUm87++R4u/OFRxIzzO
X-Google-Smtp-Source: ABdhPJxdI6CnhoDqXHFEF6pMKo5b1kU2hJN1EbOPLOACfXGqo55I0QCiXPjvFHdq4Dw1nLU9MmEHMw==
X-Received: by 2002:a37:4349:0:b0:680:f1f5:23b0 with SMTP id q70-20020a374349000000b00680f1f523b0mr2096137qka.530.1649748681853;
        Tue, 12 Apr 2022 00:31:21 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id j21-20020ac85f95000000b002e1cde99863sm26257166qta.83.2022.04.12.00.31.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:31:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2edbd522c21so30953057b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:21 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr8100148ywb.256.1649748680829; Tue, 12
 Apr 2022 00:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-6-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-6-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:31:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWsmtBdcV=LL4yqprtbum4f9cSu8orjoPACECa5QENmsg@mail.gmail.com>
Message-ID: <CAMuHMdWsmtBdcV=LL4yqprtbum4f9cSu8orjoPACECa5QENmsg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/solomon: Add SSD130x OLED displays SPI support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
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

Hi Javier,

On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over SPI.
>
> There is a difference in the communication protocol when using 4-wire SPI
> instead of I2C. For the latter, a control byte that contains a D/C# field
> has to be sent. This field tells the controller whether the data has to be
> written to the command register or to the graphics display data memory.
>
> But for 4-wire SPI that control byte is not used, instead a real D/C# line
> must be pulled HIGH for commands data and LOW for graphics display data.
>
> For this reason the standard SPI regmap can't be used and a custom .write
> bus handler is needed.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c

> +static struct gpio_desc *ssd130x_spi_get_dc(struct device *dev)
> +{
> +       struct gpio_desc *dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
> +
> +       if (IS_ERR(dc))
> +               return ERR_PTR(dev_err_probe(dev, PTR_ERR(dc), "Failed to get dc gpio\n"));
> +
> +       return dc;
> +}
> +
> +static int ssd130x_spi_probe(struct spi_device *spi)
> +{
> +       struct ssd130x_spi_transport *t;
> +       struct ssd130x_device *ssd130x;
> +       struct regmap *regmap;
> +       struct device *dev = &spi->dev;
> +
> +       t = devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
> +       if (!t)
> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "Failed to allocate SPI transport data\n");
> +
> +       t->spi = spi;
> +
> +       t->dc = ssd130x_spi_get_dc(&spi->dev);
> +       if (IS_ERR(t->dc))
> +               return PTR_ERR(t->dc);

This can be simplified (no need for the PTR_ERR(ERR_PTR(...) dance)
by open-coding ssd130x_spi_get_dc() here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
