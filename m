Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC26550FFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351292AbiDZN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiDZN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:58:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0817046
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso69631137b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGb9Kt8AH5aNBFxy8L0wzzfH24PrkpFaR6PHUXJ9s3U=;
        b=P2nxavfy10RavW78dOVC/zldX9BafkzKV/yzcdH9nE7JiDbGd6OsAcb8sZ/ukuCaXM
         oA9/cfp56009pkJfyrh/2drn00lp+QHAx8kdjBoziPbPU6BIfAf7l2goxNQkDSZxLFbT
         CQGI1Jk7lD9ENLHzjTdVIRHx3Diwo8n00mMiwq0MuvKTEh5IRNPO5CqeNkL4/huY/KhY
         eoVLIy2FtxsaLlUVL78jXKNMF3UUKhGK+kr8V68NmmZPWsFcPFRksQKIO9ojLhU/jVgW
         pQsV4kbHGA8uNJQmJDe5+msa2oB7kzCszWKXPUsSoTRRe020kw/b6gxpONsxpx0TglwK
         rUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGb9Kt8AH5aNBFxy8L0wzzfH24PrkpFaR6PHUXJ9s3U=;
        b=WyFZZDole1a/iZzwMXEomePfaTJL/n5xhX6JKBvCdcMj/MFDyjuWoenQED6cpHb2oI
         0sqRerQsJERC6sMeD9XbUSKhVUpkzXNTHanq0/dPIMFepm2HDGXjk3z8BhDuAn9uRDzo
         idGFeJ3u66RU2E8K2TPjRM0CGaaMHzDH1EfRaFR5l9q6vWNKJ90TT0/lm9wYs/SGbemW
         kQl2r3fYQPnAh8swWsd4/hMErPWa1nuStq1dpDIMdPc6R8p+YXQn5dLYtn9F/RAFEMmf
         5KmnRs2RJZU3mNvHcqBAQcCdQQTagYpre0KGUke6LUAKkoR9Hzdu+lpFRxEJHI7qnF91
         TuPg==
X-Gm-Message-State: AOAM533Di6ox+nJOxls4eEgTYf2Fsuj6pdYSAmrcZIpjXXQF3dRI/owT
        aT8of3yIS2GZkrWsjrfesOWlxkXnnXh/HnbLIORog/ABxVg=
X-Google-Smtp-Source: ABdhPJwD4q0Ce6eSfEREOsHyrBrbaYcKoo/SHzS3LMqx4cnu/ARBu1YiEJErTtgKJSfWBiODKDTzOvsLrlq3dBb+UzI=
X-Received: by 2002:a81:32c9:0:b0:2f7:c11b:ac90 with SMTP id
 y192-20020a8132c9000000b002f7c11bac90mr17348302ywy.37.1650981325253; Tue, 26
 Apr 2022 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220422100824.v4.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
In-Reply-To: <20220422100824.v4.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:54:48 +0200
Message-ID: <CAPDyKFqcwtfN+=6CFGROZHMOzs4XXC_k1++H+hMweDKmPd4txQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Set HS clock speed before sending HS CMD13
To:     Brian Norris <briannorris@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 19:09, Brian Norris <briannorris@chromium.org> wrote:
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
> Ealier versions of this patch bumped to 200MHz/HS200 speeds too early,
> which caused issues on, e.g., qcom-msm8974-fairphone-fp2. (Thanks for
> the report Luca!) After a second look, it appears that aligns with
> JESD84 / page 45 / table 28, so we need to keep to lower (HS / 52 MHz)
> rates first.
>
> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
> Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
> Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Link: https://lore.kernel.org/linux-mmc/11962455.O9o76ZdvQC@g550jk/
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> Changes in v4:
>  * Revert to hs_max_dtr for HS200, due to issues reported by Luca Weiss
>    <luca@z3ntu.xyz>; Luca, feel free to provide a "Tested-by: ..." reply
>    if you'd like that included
>  * Drop the "redundant clock rate" changes, as they aren't needed any
>    more
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
>  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5d8d9f72476f..82ca62c8669c 100644
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
> @@ -1479,8 +1483,17 @@ static int mmc_select_hs200(struct mmc_card *card)
>                                    false, true, MMC_CMD_RETRIES);
>                 if (err)
>                         goto err;
> +
> +               /*
> +                * Bump to HS timing and frequency. Some cards don't handle
> +                * SEND_STATUS reliably at the initial frequency.
> +                * NB: We can't move to full (HS200) speeds until after we've
> +                * successfully switched over.
> +                */
>                 old_timing = host->ios.timing;
> +               old_clock = host->ios.clock;
>                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> +               mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
>
>                 /*
>                  * For HS200, CRC errors are not a reliable way to know the
> @@ -1493,8 +1506,10 @@ static int mmc_select_hs200(struct mmc_card *card)
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
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>
