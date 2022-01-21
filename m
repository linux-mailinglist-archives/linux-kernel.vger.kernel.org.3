Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4624960FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381156AbiAUOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381101AbiAUOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:32:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BDC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:32:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bu18so34285104lfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVXQn5fAWpM/u0IH/7wcDxKVyHbKmHs+xX1aq8s+H0A=;
        b=h9ux5v/Q50smb2C/ipPvXLW2MCeJvk3sKcHLgXJd/K0lrYohPEfG6WH2aScvQS4hFj
         IqihvUBvv1MJSadFUhk7bi+rk4RPq8pwsv1/nJZ11EZNuKx1IXQyjybMhOrmmTjL/diI
         gjGD9TjTRhf/hnQdKlkZyDjhS1PSFphn8tc7jSOiGuGLBcECDUaLdBeYpEi/9cBftbcw
         q7FHr8+MA8G+3FXbOmUSCFYnGOFgpVFZwzbs7lzS0R++GvVBYz6FmyPaZQ2U7Uif/3nE
         ByQmkZAPfXBgfeCBUJ3Ade4p13p+vOp03albJ7jTBzOzTUW3/qSQ3ylqS65B1w0higO1
         lvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVXQn5fAWpM/u0IH/7wcDxKVyHbKmHs+xX1aq8s+H0A=;
        b=22mjmHj5Sxdk/FNMYmwOY0MeYRmsd74JNyeRm1s0buBafzFKoSCTi22MnQEVDJswYI
         xNDV3er5X/+7Uzc7XSld9E9ndlkikdzIUre2N0jBvCfc1JguoufjZWYj0chXeaYp2qZW
         ZkjF/EqUkkInzmn+DWsR6C42Y9iKp5h0Qtn/m1MU5jE6GrIXdGMRxgwVVd59F+cR62kT
         lgX4VPTvc/z7+8nzJl/vcLH7f9BgNJCmcN3ScJ3zyCoVn0U7VGO5eEuoYCr4vEsrc46M
         EE4tCYJaLPaBgwlmSCuyXrX1IuYJJjOHnTCDS7oohbHWT22+ayPqX3/r4WLlTND/kHg7
         ICnw==
X-Gm-Message-State: AOAM530BD3h//DzPslGWmkyna0y+WqsOpSvCUMbznU1d6qBaBCl+dWLD
        t7aWmXif431MmRHBw/6tB8faJb4CZ35CdHOqwiiWhg==
X-Google-Smtp-Source: ABdhPJx7cPZiR9uIKFSqOq89pZPYFqJfbvkmzLzLKS+xgg66BXE3QXoe4FStijxRD9jE6I9RjOlvzYDTv+s+udcuQMk=
X-Received: by 2002:ac2:4193:: with SMTP id z19mr3831337lfh.358.1642775576413;
 Fri, 21 Jan 2022 06:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jan 2022 15:32:20 +0100
Message-ID: <CAPDyKFp=pn=yvEtur4rbQwweq2VNc8+2VniYV5ZVy8=re7VJXw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Wait for command setting 'Power Off
 Notification' bit to complete
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 at 13:15, Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> SD card is allowed to signal busy on DAT0 up to 1s after the
> CMD49. According to SD spec (version 6.0 section 5.8.1.3) first host
> waits until busy of CMD49 is released and only then polls Power
> Management Status register up to 1s until the card indicates ready to
> power off.
>
> Without waiting for busy before polling status register sometimes card
> becomes unresponsive and system fails to suspend:
>
>   [  205.907459] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>   [  206.421274] sunxi-mmc 1c0f000.mmc: data error, sending stop command
>   [  206.421321] sunxi-mmc 1c0f000.mmc: send stop command failed
>   [  206.421347] mmc0: error -110 reading status reg of PM func
>   [  206.421366] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x74 returns -110
>   [  206.421402] mmcblk mmc0:aaaa: PM: failed to suspend async: error -110
>   [  206.437064] PM: Some devices failed to suspend, or early wake event detected
>
> Tested with Sandisk Extreme PRO A2 64GB on Allwinner A64 system.
>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

I did some tests at my side too, using a Qcom platform and it worked
fine. However, I also used the same type of card as you, as I didn't
have any other try with at this moment.

So, applied for fixes and by adding a fixes/stable tag, thanks!

I also did a minor amendment to the patch, see below.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index e223275bbad1..842b886bdd4e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -66,7 +66,7 @@ static const unsigned int sd_au_size[] = {
>                 __res & __mask;                                         \
>         })
>
> -#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
> +#define SD_POWEROFF_NOTIFY_TIMEOUT_MS 1000
>  #define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
>
>  struct sd_busy_data {
> @@ -1663,6 +1663,13 @@ static int sd_poweroff_notify(struct mmc_card *card)
>                 goto out;
>         }
>
> +       /* Find out when the command is completed. */
> +       err = mmc_poll_for_busy(card, SD_POWEROFF_NOTIFY_TIMEOUT_MS, false,

/s/SD_POWEROFF_NOTIFY_TIMEOUT_MS/SD_WRITE_EXTR_SINGLE_TIMEOUT_MS

> +                               MMC_BUSY_EXTR_SINGLE);
> +
> +       if (err)
> +               goto out;
> +
>         cb_data.card = card;
>         cb_data.reg_buf = reg_buf;
>         err = __mmc_poll_for_busy(card->host, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
> --
> 2.34.1
>

Kind regards
Uffe
