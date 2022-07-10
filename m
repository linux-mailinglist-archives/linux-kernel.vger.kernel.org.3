Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDD56D0F7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGJTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:07:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2A11C07;
        Sun, 10 Jul 2022 12:07:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p129so5642863yba.7;
        Sun, 10 Jul 2022 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pJ2mY4u3LGxMAcCpcPEWdZJC2DKdA33cpYfSaprjpk=;
        b=b6kLel3P40kfn9mtHJmNm3A1puIDxVDvFW+w5n8REW2Qr+jWiPzYUowghbkcalrq+u
         33xJ4rXHnbR1pUhKTvdompZTuFumz9ZG1Qtg9PkbxxzQyvFpmFBGU5a+ZlbpzrlBTP4O
         IQHGa00tcG5NDbi47W1nGe+3g6hNLh9EKDZrJYOcZr1Ma/QPqWhfinJATrT8mdWLWovO
         4atAiGuKR290iDhuftFvqzF7T6FOE9IXZpIg4l/zBFrP4D8a0mepbDWg6V2xikT6ya/K
         hq0aL93vMlXZeV6rukAJ93G609V73mJrSeH+JvTjQ4+PCbEhlBOst81Hi9Z9XLA4/zto
         +qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pJ2mY4u3LGxMAcCpcPEWdZJC2DKdA33cpYfSaprjpk=;
        b=sUOnD3UzejfLrVsYHNyVy2XlsNcv4MndUnyV/GMj1meDzodsS9k7xO5zPU944y9BXZ
         bdK1PnqQrOA2i4qXGkIPYB4td8xXEjCr+3juMIKynDOzJrzmNzQ9pi+MbSO1wuP8L7bz
         bDSibDDmiVUpLXBrMRBuXb0gsTQw4lmvYezY2JInCZDk2FykN8id9pBSNKLqfTP2w1xW
         wKO9ohURImRYG8KBrjDeKzZ7hQYQsvu8HWIDRIQZ/9/hzRajf2lWl0UI8it3hIevxvqw
         l+L1OHTqOy/vHhFRfUa9kgZKy5PiyjBEESVuF8FSOS6r6I2Q5pSVWU7tEAj7hy8oF0T1
         XWgw==
X-Gm-Message-State: AJIora8HJgHQCf84tlX8hOsKG6tOsFfhfxPKl0XJa3xUCoL/+UJYM6WR
        TodEpXXrIZgy1HJtn0wA/nYOSgPlB9yTCcKrmRs=
X-Google-Smtp-Source: AGRyM1usMvKd9f2/H5alDs+qjUrsqY+va9QV6ErxeZWmxYWH5zM60anQcdnlEiOVWdGy8L9IlScLjQt6eOQ+XffYNqY=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr14363105ybg.460.1657480037999; Sun, 10
 Jul 2022 12:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081853.1699028-1-uwu@icenowy.me> <20220710081853.1699028-3-uwu@icenowy.me>
In-Reply-To: <20220710081853.1699028-3-uwu@icenowy.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Jul 2022 21:06:41 +0200
Message-ID: <CAHp75Vdso_PGUomjmKaF1ytdUe4qLeAbpwkNmcRng9aNHs7g8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pinctrl: sunxi: add support for R329 CPUX pin controller
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

On Sun, Jul 10, 2022 at 10:22 AM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> Allwinner R329 SoC has two pin controllers similar to ones on previous
> SoCs, one in CPUX power domain and another in CPUS.
>
> This patch adds support for the CPUX domain pin controller.

...

> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +#include <linux/of.h>
> +#include <linux/of_device.h>

No use of these.

> +#include <linux/pinctrl/pinctrl.h>

Missed headers:
mod_devicetable.h

> +#include "pinctrl-sunxi.h"

-- 
With Best Regards,
Andy Shevchenko
