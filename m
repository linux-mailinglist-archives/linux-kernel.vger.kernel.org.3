Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03CB50B3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445888AbiDVJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445889AbiDVJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:14:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3B51E73
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:11:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w1so13185777lfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfgkrfURJKwhnI2/O7vdqPyYaGN5+mF6L9gQd890Ir0=;
        b=kdqGeyrRYGT3n4ywR9Tojfe9wJIKYW3OZQoxPqApj85B56My8aN7tsB5C87A/kD2xO
         o8oxqlkGI0Jl5s35e1uvwGpbUnBS0QF4iVgqe2E58vRGe7nNGdBTf6oKrqa6HuBD/z5z
         80UB3Lr0/v2kbHxykgw4rph62BrOWDrG2jivAOXdyKrUI357N2kYPhPA4vzHsOJXnTHa
         tZYsj+QEcfK6apJTGlL0gJ0MNTCtmKO1wwsGby+HpW71FlyG3HrWjdIj3O20GSAtkoWX
         9dvokVBex3F4Q7TVkBhcOCeKSJ+n9glUBDi0LINhpkDXs9T6E3N0S87B1gc6SNBBznMS
         niDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfgkrfURJKwhnI2/O7vdqPyYaGN5+mF6L9gQd890Ir0=;
        b=x79m1ZEQEDiK7ylqAk97xVjWD4zF9SPV33H1wK+MZSqrEX6CMeXSZegXCT9g5tEj5g
         e7jfByHfB+OEOs/dbnWjwfLK5VBr40cgCpUw4rsE2EAhU/n0qKFya7txDM5YR/V2SR7X
         upt1nMZWdQgpRjD3mxHXh6duF5mw+FvVcLOFc8ym6lFnQPO3BLdOwod6x0uJF8fIEusy
         9R7Um+5Zbqf11/LQkW6YmlAruYOfOywUJn8tP/AB3tdzj8KwnelhaTomn/HGwxYA9C6X
         MY9VkUqyCaw+0OtBVa8lRg7IoLFF5oUWjE/IH7Uh5sgF6I6uA3Ff2q15jkGbBpnEojTc
         ldSg==
X-Gm-Message-State: AOAM530JIx1q55NDH2As89poel4wApOABNSd/VLMOgGKdaFQvovDy7rk
        utAz6msvCrEpaqFuwMiHt9SN5+ebDTK0vnEfxzFoOA==
X-Google-Smtp-Source: ABdhPJyRJGWde6pW3x5AhbWnlvDZuG+mM35K5paxOFe+8Xdj01CyYDkCOg6E/xYU08VmG2hIu2QHAFIgIpZGVV+S4C8=
X-Received: by 2002:a05:6512:c12:b0:471:a932:cfe1 with SMTP id
 z18-20020a0565120c1200b00471a932cfe1mr2449495lfu.358.1650618668972; Fri, 22
 Apr 2022 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220422002318.3587413-1-briannorris@chromium.org>
In-Reply-To: <20220422002318.3587413-1-briannorris@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Apr 2022 11:10:32 +0200
Message-ID: <CAPDyKFqhqNn1ZDQxshRidN=Odv6sTEcRz54=radQhknfx60Ovw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Don't set HS200 clock rate prematurely
To:     Brian Norris <briannorris@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 02:23, Brian Norris <briannorris@chromium.org> wrote:
>
> Commit 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS
> CMD13") fixes problems with certain eMMC, but introduced new ones with
> others:
>
>   qcom-msm8974-fairphone-fp2:
>
>   [    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA 64-bit
>   [    1.925220] mmc0: mmc_select_hs200 failed, error -110
>   [    1.925285] mmc0: error -110 whilst initialising MMC card
>
> It appears we've overshot the acceptable clock rate here; while JESD84
> suggests that we can bump to 52 MHz before switching (CMD6) to HS400, it
> does *not* say we can switch to 200 MHz before switching to HS200 (see
> page 45 / table 28). Use the HS bounds (typically 52 MHz) instead of the
> HS200 bounds (which are only applicable after we successfully switch).
>
> Link: https://lore.kernel.org/lkml/11962455.O9o76ZdvQC@g550jk/
> Fixes: 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS CMD13")
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Rather than applying this incremental patch, I decided to drop the
offending commit from my branch. Please submit a new version of that
patch and make sure to incorporate credits and information provided by
Luca, as a part of the new commit message.

The main reason for this step is that I think we want a clean patch
that we can use for stable kernels too.

Moreover, this also means you can drop the changes in mmc_set_clock()
that was introduced in 1c7ec586fe55().

Kind regards
Uffe

> ---
> Apologies for the quick resend; I fumbled the commit/send, even though I
> had already updated the comments...
>
> Changes in v2:
>  * Updated comments
>
>  drivers/mmc/core/mmc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9ab915b5737a..82ca62c8669c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1485,13 +1485,15 @@ static int mmc_select_hs200(struct mmc_card *card)
>                         goto err;
>
>                 /*
> -                * Bump to HS200 timing and frequency. Some cards don't
> -                * handle SEND_STATUS reliably at the initial frequency.
> +                * Bump to HS timing and frequency. Some cards don't handle
> +                * SEND_STATUS reliably at the initial frequency.
> +                * NB: We can't move to full (HS200) speeds until after we've
> +                * successfully switched over.
>                  */
>                 old_timing = host->ios.timing;
>                 old_clock = host->ios.clock;
>                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -               mmc_set_bus_speed(card);
> +               mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
>
>                 /*
>                  * For HS200, CRC errors are not a reliable way to know the
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>
