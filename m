Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AD53FB73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiFGKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiFGKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:36:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090AEC3C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:36:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c2so8200127lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCgtiLUZSuHTz5IK2x7L4YWF9E3UmFqw0nwv703neGE=;
        b=VtxwY0WZ4gkosObf0GXqVeyMNqRlH34rx43Ljv2zwfm9wXOGkVEOzangTkLbA30Nk7
         4UMUr0ZoLYZQ7bdEc5LpD6XTrk30gR13z02xc8euG+tKqiaYXML6EwNBRfxpwm2m9s20
         P6944BEiYjl8YMV9ooXTkk23s2eXj7MkdO6zKRh4Rp9O1TMIguL6jXZU8N47a7pBde5T
         i2LTOARUkYBcLR8cdvmESeUp6CR4WdNOAm5JHzJHMuZFUttkYSybDMAFxEubMx7//b2f
         3ro6kFTn0b/WQwl8yC1YJYXIO5vQyKdm5i+HnYfZJe+lnVhhek0bVdONcecNNduutPqv
         xwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCgtiLUZSuHTz5IK2x7L4YWF9E3UmFqw0nwv703neGE=;
        b=gvI5nbCou7llB8CS7e5caaTtxpLGkwzxwY3rHymNAoFVEyAAM/pgWwWJpBFNknItVo
         p7x8nQ3hP8aGqxkxtffIFYfIRT5EGViFmOMagDXHKjBED7iL6g3TV/Dat5b+Q5Z6Bx4t
         2nlSWQIN7Q/OdQV8KCk4Lbva859MvfqPK36SzwHvu5zWyVK6roUWm/vrHRUlfOdhBntr
         2DzL/RjuIQK5TJoBwrBn+75Rzr1S3FTkcAMlq8ETGAO2QDVdSGvbqtzzEvy49JHdK93f
         PqMu/XH12sloel1Lojat54X+Jad4FPO9aqaR+FLddgXx78431yPdLM60sNk+pBAP/bnI
         1YaA==
X-Gm-Message-State: AOAM531wH5mOdrXHF8Hf37URBBbjN1ZtM+h2SwG1Pdf2+29ihDt1qLXi
        8mS0qQFw4Satw0WjrNGvlPcwioaIOGov63YWX4cXIg==
X-Google-Smtp-Source: ABdhPJxfsW6DVMMdTLuCpQREFHXfOUnR2FOXxYSOcFvFjAWB2Vboe2sXi8WL4FurxlVmPtwGId9RZuQa8KMbjhiOAl8=
X-Received: by 2002:a19:ac42:0:b0:478:593c:e6fe with SMTP id
 r2-20020a19ac42000000b00478593ce6femr17792413lfc.254.1654598189364; Tue, 07
 Jun 2022 03:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220606142051.20350-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20220606142051.20350-1-mengqi.zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:35:53 +0200
Message-ID: <CAPDyKFruh_t3uR3-u-_wH9LmZo77Ra-LumKe808jDfbGGM+04Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: wait dma stop bit reset to 0
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, 6 Jun 2022 at 16:21, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> MediaTek IP requires that after dma stop, it need to wait this dma stop
> bit auto-reset to 0. When bus is in high loading state, it will take a
> while for the dma stop complete. If there is no waiting operation here,
> when program runs to clear fifo and reset, bus will hang.
>
> In addition, there should be no return in msdc_data_xfer_next, because no
> matter what error occurs here, it should continue to excute to the
> following mmc_request_done. Otherwise the core layer may wait complete
> forever.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Is there a certain commit this fixes? In that case, we should add a fixes tag.

> ---
>  drivers/mmc/host/mtk-sd.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..c925f45786c2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
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

Looks like msdc_data_xfer_done() should be turned into a void
function, as it would always return true beyond this change.

> -               }
> +               if (ret)
> +                       dev_dbg(host->dev, "DMA inactive timed out\n");
>
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
>                 dev_dbg(host->dev, "DMA stop\n");
> @@ -2416,6 +2419,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CTRL, val,
> +                       !(val & MSDC_DMA_CTRL_STOP), 1, 3000)))
> +                       return;
>                 if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
>                         !(val & MSDC_DMA_CFG_STS), 1, 3000)))
>                         return;

Kind regards
Uffe
