Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814954D00C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356189AbiFOReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357880AbiFORdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:33:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F24F9D4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w20so19973032lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S72eeZ+Row01YghjpUmWYlpXnQzipZvAzNu3EG7dF00=;
        b=BR3qLXEgSSszCU9YWAmUJhaphZlQ5NrNHteiKYjbK+3eDpYdpbKiVLT1w/vldEp4pX
         +HF40JInhIku0OCm/pOdQei11tBJSd/sRQUSYNpM6UN/1BGD3idJgDsdLM4C0SRFCv6E
         HoNKUp07pwCmLjoXQeiU114Pm9YDXswIn+4NLoS5hgo/iZEL57b2eJBPA3PM/6xysOVY
         mMge2aJD8FyIUZWDSDDQish4QwCdUPY6yELRZnKF3XriuSWdtZviiqnIRlJQrWUdKyOF
         jaIQfrEi6tdUacNli3heJhT73rzaeOu0mQ2qGtRexeFU8mNVMfB8LBgSLG7kNKAA31DF
         RkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S72eeZ+Row01YghjpUmWYlpXnQzipZvAzNu3EG7dF00=;
        b=Awf4c4FN8F0uEipHD3NvfXTn5GTAcid8+xSXeMJLcHSkdjNf7NmIazN6TW5/4Wkq/M
         UzC9kPPNvQZuqKjDtzl8oqr5PQz3yD8gQoZYf5uoI5EI8Foz+GesDKDWOQq4Lh3geZP8
         RkmhXbDqIRnTD1SAEuvaZBJNOs/QMlpEhTACyIkwMJwXrYrozlrirYxTEGucaatE3Q4C
         kwBGGjObvGoNvHTPn8oFCKAQAgTgCAr4uPFmWtV6PpANFjNwGsfJU0v73R/f2UrcImoT
         7VZ6Zl0MXFob/Z8YawRHVlQQ5dKvh4fUdlGrOoQtwQ5OmCBUyHH8sKeb7yvgr5262J0b
         dRgw==
X-Gm-Message-State: AJIora8WWk1J2uIT2sEzINNkDgosERp1HAHYo5YIo3bHkD0xM6PZudX5
        r5qYKXTfNJVJ9TwGtQiax6ug0Ol3E7Mujk4oPde9DKL4ToztUA==
X-Google-Smtp-Source: AGRyM1sA46kWiGsTwyik4A+h6I0Rt4vExcza34+hBCc/jIKpPP4aUs4AgBut2tMlPe1cEUer3DeVSKylq48GsEqiYSw=
X-Received: by 2002:a05:6512:1047:b0:479:2308:ac0b with SMTP id
 c7-20020a056512104700b004792308ac0bmr349197lfb.167.1655314408139; Wed, 15 Jun
 2022 10:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220609112239.18911-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20220609112239.18911-1-mengqi.zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:52 -0700
Message-ID: <CAPDyKFrBWBKJvLZaZOgK9K3Td0ZNq_0vP=K5ERjja3OnQFCsNA@mail.gmail.com>
Subject: Re: [RESEND V2] mmc: mediatek: wait dma stop bit reset to 0
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenbin.mei@mediatek.com
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

On Thu, 9 Jun 2022 at 04:22, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> MediaTek IP requires that after dma stop, it need to wait this dma stop
> bit auto-reset to 0. When bus is in high loading state, it will take a
> while for the dma stop complete. If there is no waiting operation here,
> when program runs to clear fifo and reset, bus will hang.
>
> In addition, there should be no return in msdc_data_xfer_next() if
> there is data need be transferred, because no matter what error occurs
> here, it should continue to excute to the following mmc_request_done.
> Otherwise the core layer may wait complete forever.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..9da4489dc345 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1356,7 +1356,7 @@ static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
>                 msdc_request_done(host, mrq);
>  }
>
> -static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> +static void msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 struct mmc_request *mrq, struct mmc_data *data)
>  {
>         struct mmc_command *stop;
> @@ -1376,7 +1376,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (done)
> -               return true;
> +               return;
>         stop = data->stop;
>
>         if (check_data || (stop && stop->error)) {
> @@ -1385,12 +1385,15 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                 sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
>                                 1);
>
> +               ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CTRL, val,
> +                                               !(val & MSDC_DMA_CTRL_STOP), 1, 20000);
> +               if (ret)
> +                       dev_dbg(host->dev, "DMA stop timed out\n");
> +
>                 ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CFG, val,
>                                                 !(val & MSDC_DMA_CFG_STS), 1, 20000);
> -               if (ret) {
> -                       dev_dbg(host->dev, "DMA stop timed out\n");
> -                       return false;
> -               }
> +               if (ret)
> +                       dev_dbg(host->dev, "DMA inactive timed out\n");
>
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
>                 dev_dbg(host->dev, "DMA stop\n");
> @@ -1415,9 +1418,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                 }
>
>                 msdc_data_xfer_next(host, mrq);
> -               done = true;
>         }
> -       return done;
>  }
>
>  static void msdc_set_buswidth(struct msdc_host *host, u32 width)
> @@ -2416,6 +2417,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CTRL, val,
> +                       !(val & MSDC_DMA_CTRL_STOP), 1, 3000)))
> +                       return;
>                 if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
>                         !(val & MSDC_DMA_CFG_STS), 1, 3000)))
>                         return;
> --
> 2.25.1
>
