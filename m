Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17F4CFDFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiCGMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiCGMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:18:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A33150E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:17:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu29so25947005lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHRPAd2+BEPs+tfv+5iE/4Edpf3HwlV2J27uXAurHCw=;
        b=Gt/pfhSt7vkmHIdUh0loB83y1KE8tsxVv80EiMuPqBAb8kZiJzJwzVR9nFhrpOHKIE
         I5TAxDG01GvVFLXufXXY8sOnB/zJpP/TKWjcW9NWELJytqINrMzS+9TlUhEVgGiHDXQ6
         dsMiS6eMZ5pWQGCT2TmRU0YiDwII5udvqczVM2yK0dndL5UMTdoh12kVG9SFBec71NE6
         M7GE7ZhaEk/RRs3ttdqt3Q7eyqdEpEE5mnDaPpzi1+J7klFlyRnCNDl0lj0zvT0PEx/F
         CMGaY7NQ9A537QBBJ/fS+jhZt6mp9i8L9mnFekZWiUKULz9Ne6ynND6+xJjudOUAyN83
         wRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHRPAd2+BEPs+tfv+5iE/4Edpf3HwlV2J27uXAurHCw=;
        b=7RLL/xIdsrcF8h8fPZkRkyDjSOzhYN44PhKDlNsCynEwl6US4ubr1DavuPosq34YvH
         8mlw5Ld7bx7PerZVSDlhIrM+s+0w3c9dgvRBUDltNpQCKEEpaqjD9bZg72LM2EqQ9Tzh
         jH9y1ShiKBpFG+XLtvyfkjvUfycFQ2BFeYTkVmsOvqs2gGBY5LX20bIoA32N92lnvmeL
         UDUADcbx/RyVfCEJ4S7huD0e3g81kr6OcE5ij7akkmn4bsMdHDUJxmemz+5eXfKc33E7
         yvWrWPfs5JdRjSG4I2runVH5gjWvWll6PASVxLyl4Necng+M6/50rqdHoLFZCnG1KW9a
         1/+w==
X-Gm-Message-State: AOAM530dKNk8Rcdwah4oi6g3nm1hOphrIAEwvuw+/nZVBwSVQ8Ih5X8M
        K9g03bqK8zTUOGaTND4Axeg8r5KFjd6uzIuojKIeqhNUL0M=
X-Google-Smtp-Source: ABdhPJwaySlpCWxsw4Grc4xbUmRYaRcssHhnetYj9sDCid79k0y0rdWn6ULciiywCayAdCRGWIFgFbKG24qH2Kvm/NM=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr580070lfd.184.1646655471512; Mon, 07
 Mar 2022 04:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
In-Reply-To: <20220304105656.149281-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Mar 2022 13:17:15 +0100
Message-ID: <CAPDyKFr1PzSaiKqB4ZoqTS_8bGsEH=aB3ARhxyGu+cYeRqeBew@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Cc:     Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> significantly decreased the polling period from ~10-12ms into just a couple
> of us. The purpose was to decrease the total time spent in the busy polling
> loop, but unfortunate it has lead to problems, that causes eMMC cards to
> never gets out busy and thus fails to be initialized.
>
> To fix the problem, but also to try to keep some of the new improved
> behaviour, let's start by using a polling period of 1-2ms, which then
> increases for each loop, according to common polling loop in
> __mmc_poll_for_busy().
>
> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Huijin Park <huijin.park@samsung.com>
> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for fixes and by adding two tested-by tags from you, thanks!

Kind regards
Uffe


> ---
>
> Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> works.
>
> Kind regards
> Uffe
>
> ---
>  drivers/mmc/core/block.c   |  2 +-
>  drivers/mmc/core/mmc.c     |  2 +-
>  drivers/mmc/core/mmc_ops.c | 13 +++++++++----
>  drivers/mmc/core/mmc_ops.h |  3 ++-
>  drivers/mmc/core/sd.c      |  2 +-
>  5 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d718aa56d33..4e67c1403cc9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1908,7 +1908,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
>
>         cb_data.card = card;
>         cb_data.status = 0;
> -       err = __mmc_poll_for_busy(card->host, MMC_BLK_TIMEOUT_MS,
> +       err = __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,
>                                   &mmc_blk_busy_cb, &cb_data);
>
>         /*
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 13abfcd130a5..43d1b9b2fa49 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1962,7 +1962,7 @@ static int mmc_sleep(struct mmc_host *host)
>                 goto out_release;
>         }
>
> -       err = __mmc_poll_for_busy(host, timeout_ms, &mmc_sleep_busy_cb, host);
> +       err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
>
>  out_release:
>         mmc_retune_release(host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d63d1c735335..180d7e9d3400 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,6 +21,8 @@
>
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> +#define MMC_OP_COND_PERIOD_US          (1 * 1000) /* 1ms */
> +#define MMC_OP_COND_TIMEOUT_MS         1000 /* 1s */
>
>  static const u8 tuning_blk_pattern_4bit[] = {
>         0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> @@ -232,7 +234,9 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>
> -       err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
> +       err = __mmc_poll_for_busy(host, MMC_OP_COND_PERIOD_US,
> +                                 MMC_OP_COND_TIMEOUT_MS,
> +                                 &__mmc_send_op_cond_cb, &cb_data);
>         if (err)
>                 return err;
>
> @@ -495,13 +499,14 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>         return 0;
>  }
>
> -int __mmc_poll_for_busy(struct mmc_host *host, unsigned int timeout_ms,
> +int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
> +                       unsigned int timeout_ms,
>                         int (*busy_cb)(void *cb_data, bool *busy),
>                         void *cb_data)
>  {
>         int err;
>         unsigned long timeout;
> -       unsigned int udelay = 32, udelay_max = 32768;
> +       unsigned int udelay = period_us ? period_us : 32, udelay_max = 32768;
>         bool expired = false;
>         bool busy = false;
>
> @@ -546,7 +551,7 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>         cb_data.retry_crc_err = retry_crc_err;
>         cb_data.busy_cmd = busy_cmd;
>
> -       return __mmc_poll_for_busy(host, timeout_ms, &mmc_busy_cb, &cb_data);
> +       return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data);
>  }
>  EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
>
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 9c813b851d0b..09ffbc00908b 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -41,7 +41,8 @@ int mmc_can_ext_csd(struct mmc_card *card);
>  int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
>  bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                           unsigned int timeout_ms);
> -int __mmc_poll_for_busy(struct mmc_host *host, unsigned int timeout_ms,
> +int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
> +                       unsigned int timeout_ms,
>                         int (*busy_cb)(void *cb_data, bool *busy),
>                         void *cb_data);
>  int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 24b0418a24bb..68df6b2f49cc 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1671,7 +1671,7 @@ static int sd_poweroff_notify(struct mmc_card *card)
>
>         cb_data.card = card;
>         cb_data.reg_buf = reg_buf;
> -       err = __mmc_poll_for_busy(card->host, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
> +       err = __mmc_poll_for_busy(card->host, 0, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
>                                   &sd_busy_poweroff_notify_cb, &cb_data);
>
>  out:
> --
> 2.25.1
>
