Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD6571797
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiGLKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiGLKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:52:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BFAE391
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:52:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so7575961ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvjl37PfjvotfuUJbfheqj7v+sZVTOGge3DQ+4pXsTM=;
        b=uv6uTUB+zDBLwMtNPmgLvhpkq4A9j6HneT7GysQvSn01RXoZeZiWR0qzq4EraUqrqd
         fOOboPFgPRxGCVLuofrYzSu/PgQe8oa8r5rk/zT/DswfiB/Q1YTH4J9cX73A3sKlHhbg
         Xy5LUY3N1y6T6IYxpxI8XVvi7msxdQ+Y/AdH9zbHjBfHIUWh3PICau7zcwj3OPiBjSmv
         KnI1+9HR/yjm4S3m+5cLrY0G0+AETSyfEitSy8vwrRCG6mqeoRBF8ahzxkIXQrnMZUZd
         2yaTJ+5JXH0FoN6JTscfKC6oNPpwAfyu4RF1N5EnJwYALjJQdmqvHXlr7KfdlAv2yY0y
         2YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvjl37PfjvotfuUJbfheqj7v+sZVTOGge3DQ+4pXsTM=;
        b=HgzHfcu7/uTGeo4GcCzFS1PwFw6Q+wfCcoQWpHUZoWk/cVMZ2ye6pavIEd7rtLPPbQ
         SlebaGTkmb+RMZAwl0PdUGXruAZEOPsCxLqD+sQfNb4xw3gSaFis4dmpuvn7eENzm9Ns
         c9gf6gzuQfP0bRwTNzm4vGZP0FvKKggbhIkmSzdd668q6qbpK2JukpR+Os/dGzmdSwGh
         L4N5IrfnjpdCxsliBCZy7Qde7YM+J9qHCDo/VrdNZw/KfR2qsR3fyAtEOyfb5cRPVfb2
         wHTaM2uWSQJvTbfcNAbVAc+Yz5q7B3ezfpSjWYSbYmnF8/kXbY1R48pfPLJ7tcJ6w3wS
         64tQ==
X-Gm-Message-State: AJIora9Nq5S9+OqAnNlEJZBeO6vsbjfOiqF5M4vsSfRt18UefkFy7U68
        4PnYcGRXY1FCHSGQRq18dvel7geRpTzC8UHmQz6JuA==
X-Google-Smtp-Source: AGRyM1uXvwQ1ihDOR9BJBTqYDFH4HjpJm8bCeGzRjsNDE5BCtOFejtRDnfGNAm9JyTfcKlgO2CqrywRQZYVGJKuZGP0=
X-Received: by 2002:a05:651c:10a3:b0:25d:66c5:ce4c with SMTP id
 k3-20020a05651c10a300b0025d66c5ce4cmr7169405ljn.463.1657623125755; Tue, 12
 Jul 2022 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310@epcas1p4.samsung.com>
 <20220705005035.14195-1-sh043.lee@samsung.com>
In-Reply-To: <20220705005035.14195-1-sh043.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 12:51:29 +0200
Message-ID: <CAPDyKFqzVJ+EQYZWJG3adYEWdr=9kAXunwyKESvWqT8-L84Q9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: print clock frequency with recognization
To:     Seunghui Lee <sh043.lee@samsung.com>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        linux@dominikbrodowski.net, alexandre.belloni@bootlin.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        seunghwan.hyun@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 02:18, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> It's easy to figure out how fast frequency it has from the log.
> e.g. mmc0: new ultra high speed SDR104 SDXC card
> at address aaaa(clk 202000000)

Well, this information is already available through debugfs and I
think that is sufficient.

Moreover, card->host->ios.clock doesn't necessarily contain that
actual clock rate, but rather the rate that is requested by the core.
To really know the rate the bus is running on,
card->host->ios.actual_clock needs to be checked too. This too is
available through debugfs.

Kind regards
Uffe

>
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 58a60afa650b..3623cc27a61c 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -348,7 +348,7 @@ int mmc_add_card(struct mmc_card *card)
>                         mmc_card_ddr52(card) ? "DDR " : "",
>                         type);
>         } else {
> -               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> +               pr_info("%s: new %s%s%s%s%s%s card at address %04x(clk %u)\n",
>                         mmc_hostname(card->host),
>                         mmc_card_uhs(card) ? "ultra high speed " :
>                         (mmc_card_hs(card) ? "high speed " : ""),
> @@ -356,7 +356,8 @@ int mmc_add_card(struct mmc_card *card)
>                         (mmc_card_hs200(card) ? "HS200 " : ""),
>                         mmc_card_hs400es(card) ? "Enhanced strobe " : "",
>                         mmc_card_ddr52(card) ? "DDR " : "",
> -                       uhs_bus_speed_mode, type, card->rca);
> +                       uhs_bus_speed_mode, type, card->rca,
> +                       card->host->ios.clock);
>         }
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.29.0
>
