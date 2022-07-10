Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5D56D0FC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGJTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:09:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB51411C3E;
        Sun, 10 Jul 2022 12:09:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31c9b70c382so30626777b3.6;
        Sun, 10 Jul 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8uBrLbWc94Zt3/5+ItReRZraOQhpXiAxYkcJ2+dIok=;
        b=YvHdS0dcpg797mdkhiGVt5EYXBki+VqxBmuaZtbSw/FuLBBGfXBkeEFpMyGUeCoeOZ
         tkN4QAWerGT9YiJHy9rhnaldPXCG1SAmfWff89/ppYzAKuvVpWFLjzvYudlRJvBkcgq3
         29kKJgs7KrfCsqID+Oap4Xo7rbUTL1JG7rqcyCKolRHR/tpmysEwCwwMuRysEksm6ODA
         FkQjCGhKS+j4Xv6uaQM5cF/dnqrveBhpH7vwfdmZu6WHTLH///Yj+F0iAr1qaauC5IHH
         OzWOkmx465cLskT5lAxwt+Y8vjb6ugJV95myiv6v7NWz6rpuoo+oD5rxEZQYVQbEZA8e
         3QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8uBrLbWc94Zt3/5+ItReRZraOQhpXiAxYkcJ2+dIok=;
        b=ccAZDwKLkeXx7aEDAiXgCTlajVs3rnP/JurrKs6FhJHMp4ajLqNZD6dCs2D6Tlzm33
         3VxuDDs4jR0TuY5y0E9PaJZUi5bsxPzAPWggriFIuPsP73BEoQo+FnkETUzNFLnggWxJ
         Clx2Ou2zg5hbKZNKUeby7Euyd6RuDr3N2MOt8adsM+YPrzr7zneAnQKOCvWvA9lC9W8c
         xrfSq5GZ/qnJMkKtIYkGR3xyeDqErq2sQhcrOQw3gwf03S84ntY0dfqFDC03G9NGM1Fu
         spNT85I1iabwnCcoJBx2LpzSeSs/PfkurXlZ8ILwFKqaolusS9dxU0LwxZVAL8XOs/X2
         D/HA==
X-Gm-Message-State: AJIora/M1+tBEOnIjOCS+7h9Li1bZ5z7q6XvLwr3pogz2GrxNeGnjGS2
        YoXL7+AY9U5AS+EIXOTpdJfpnERyWPVCazoGid0=
X-Google-Smtp-Source: AGRyM1uQhf5F8te2uFSd0prGAFf6uTxYdIFIrz6w9GanRjKRI0AwDZInMAcv9znJU/AI6ZDy3jbdkzHSycFBE5OPSlE=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr15721393ywa.277.1657480141962; Sun, 10
 Jul 2022 12:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081853.1699028-1-uwu@icenowy.me> <20220710081853.1699028-4-uwu@icenowy.me>
In-Reply-To: <20220710081853.1699028-4-uwu@icenowy.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Jul 2022 21:08:24 +0200
Message-ID: <CAHp75VcK4nF6TxE2e3s-qTE5RKLuAeKykoKN3usXe+NiJX4Eng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pinctrl: sunxi: add support for R329 R-PIO pin controller
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
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

On Sun, Jul 10, 2022 at 10:28 AM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> Allwinner R320 SoC has a pin controller in the CPUS power domain.
>
> Add support for it.

> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/reset.h>

Same comment as per previous patch.
Also I forgot to mention kernel.h from which ARRAY_SIZE() is currently
available.

> +#include "pinctrl-sunxi.h"

-- 
With Best Regards,
Andy Shevchenko
