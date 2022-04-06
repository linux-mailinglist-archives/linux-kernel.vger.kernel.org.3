Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB54F662A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiDFQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiDFQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF821F7603
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:56:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so3572003ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrX5+3NSO7cX6LZIAP8IbX/CZ5OTBMW3MX39IShm3Vg=;
        b=o7m1AgKMtmgjDXAFJkL3y545PvdKHto8ymJXW7Xcze2OOXCoECU48E8KjgfDbXvSZE
         YKp5OqU+lzVJnZdgMxWK3eLkp4/6H6WE2HC6ZrlKZJ/BTHvNMD32zSBWokPWfCg0+l3G
         jPKhxupVDqg7qPj49Y3yDG+ET6T1rqBCOodTw83NNJX3ReSJUS4ko/T1FbDIF9vygxuE
         tjkyCyzk6lOFraOB0moVuIk/J8V+2JfdnqAZgCkN1FpscpgUzDbxl8ZBEqDkhEOwN952
         dvFmIJu9J+lxOejc24Ywal6CVMKTdvqVPD+sM8husEKe5piOj2Bf8FipIBts62gXiV+/
         jOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrX5+3NSO7cX6LZIAP8IbX/CZ5OTBMW3MX39IShm3Vg=;
        b=iuAAPuXyYoSk3p+Ydm3QKs4HvH0VZvj2H8WQ4OwveTQn5FIErwDa9LRFWHGqH/hPAy
         vPPCETkJOeYBweq/eFO1ax9ZaS0OxkXH2mBjrw7xKBY/OYBPTEZvjb08zeE7T2gVVIuy
         gnuS7GUMcw9dZ/TDh5yJLFkDkU4Ntf0lCVTscFrddn0JYu/QxP2dFm+MQA94QJ7LEwTf
         +c/ORXoVyq/6wgJM5we4FIhu8DFafcNsGKXV+eLozOd1x/udS11CPiMkLBblyKn0QLAU
         8D5iz47nx1Fhe9w3B4CRlM5dA6E7mCsRMmJuewMOIf5QzUt2q1WAuEazc7OoUC0eBvb8
         tjEQ==
X-Gm-Message-State: AOAM533hEO6xZYAlz0vX4KlrNS6WYf1BdPRQzTUUsZw0ec6IGQ9qDeLV
        EE9szaPTxuflyvP4Y4WRxSncu45jrV5Haua6LSZ8AQ==
X-Google-Smtp-Source: ABdhPJyhlfyzr0p9f1s4DciUSEnKObAqgAOniWVeISRYAoapY3CJxefz+BUrvDUc796Jf3B1YqXnjIc1N6Bg4qBHoQM=
X-Received: by 2002:a2e:3615:0:b0:24a:fc28:f0b3 with SMTP id
 d21-20020a2e3615000000b0024afc28f0b3mr5606482lja.4.1649256977123; Wed, 06 Apr
 2022 07:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
In-Reply-To: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:40 +0200
Message-ID: <CAPDyKFpQGR3ughi+6rCLUiK07Jxd5y20oK9HBjYiO-+TE8-o=Q@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Set HS clock speed before sending HS CMD13
To:     Brian Norris <briannorris@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 30 Mar 2022 at 22:30, Brian Norris <briannorris@chromium.org> wrote:
>
> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> some eMMC don't respond to SEND_STATUS commands very reliably if they're
> still running at a low initial frequency. As mentioned in that commit,
> JESD84-B51 P49 suggests a sequence in which the host:
> 1. sets HS_TIMING
> 2. bumps the clock ("<= 52 MHz")
> 3. sends further commands
>
> It doesn't exactly require that we don't use a lower-than-52MHz
> frequency, but in practice, these eMMC don't like it.
>
> The aforementioned commit tried to get that right for HS400ES, although
> it's unclear whether this ever truly worked as committed into mainline,
> as other changes/refactoring adjusted the sequence in conflicting ways:
>
> 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
> switch")
>
> 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
> for mmc")
>
> In any case, today we do step 3 before step 2. Let's fix that, and also
> apply the same logic to HS200/400, where this eMMC has problems too.
>
> Resolves errors like this seen when booting some RK3399 Gru/Scarlet
> systems:
>
> [    2.058881] mmc1: CQHCI version 5.10
> [    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
> [    2.209804] mmc1: mmc_select_hs400es failed, error -84
> [    2.215597] mmc1: error -84 whilst initialising MMC card
> [    2.417514] mmc1: mmc_select_hs400es failed, error -110
> [    2.423373] mmc1: error -110 whilst initialising MMC card
> [    2.605052] mmc1: mmc_select_hs400es failed, error -110
> [    2.617944] mmc1: error -110 whilst initialising MMC card
> [    2.835884] mmc1: mmc_select_hs400es failed, error -110
> [    2.841751] mmc1: error -110 whilst initialising MMC card
>
> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
> Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
> Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

To get this thoroughly tested, I have applied it to my next branch, for now.

If it turns out that there are no regressions being reported, I think
we should move the patch to the fixes branch (to get it included for
v5.18) and then also tag it for stable. So, I will get back to this in
a couple of weeks.

Thanks and kind regards
Uffe


> ---
>
> Changes in v3:
>  * Use mmc_set_bus_speed() to help choose the right clock rate
>  * Avoid redundant clock rate changes
>  * Restore clock rate on failed HS200 switch
>
> Changes in v2:
>  * Use ext_csd.hs200_max_dtr for HS200
>  * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
>    modes if eMMC HS200 fails")
>
>  drivers/mmc/core/core.c |  3 +++
>  drivers/mmc/core/mmc.c  | 21 +++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..61abae221623 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -914,6 +914,9 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
>         if (hz > host->f_max)
>                 hz = host->f_max;
>
> +       if (host->ios.clock == hz)
> +               return;
> +
>         host->ios.clock = hz;
>         mmc_set_ios(host);
>  }
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e7ea45386c22..1f22f1d2e9b8 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1384,13 +1384,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
>                 goto out_err;
>         }
>
> +       /*
> +        * Bump to HS timing and frequency. Some cards don't handle
> +        * SEND_STATUS reliably at the initial frequency.
> +        */
>         mmc_set_timing(host, MMC_TIMING_MMC_HS);
> +       mmc_set_bus_speed(card);
> +
>         err = mmc_switch_status(card, true);
>         if (err)
>                 goto out_err;
>
> -       mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> -
>         /* Switch card to DDR with strobe bit */
>         val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1448,7 +1452,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
>  static int mmc_select_hs200(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       unsigned int old_timing, old_signal_voltage;
> +       unsigned int old_timing, old_signal_voltage, old_clock;
>         int err = -EINVAL;
>         u8 val;
>
> @@ -1479,8 +1483,15 @@ static int mmc_select_hs200(struct mmc_card *card)
>                                    false, true, MMC_CMD_RETRIES);
>                 if (err)
>                         goto err;
> +
> +               /*
> +                * Bump to HS200 timing and frequency. Some cards don't
> +                * handle SEND_STATUS reliably at the initial frequency.
> +                */
>                 old_timing = host->ios.timing;
> +               old_clock = host->ios.clock;
>                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> +               mmc_set_bus_speed(card);
>
>                 /*
>                  * For HS200, CRC errors are not a reliable way to know the
> @@ -1493,8 +1504,10 @@ static int mmc_select_hs200(struct mmc_card *card)
>                  * mmc_select_timing() assumes timing has not changed if
>                  * it is a switch error.
>                  */
> -               if (err == -EBADMSG)
> +               if (err == -EBADMSG) {
> +                       mmc_set_clock(host, old_clock);
>                         mmc_set_timing(host, old_timing);
> +               }
>         }
>  err:
>         if (err) {
> --
> 2.35.1.1094.g7c7d902a7c-goog
>
