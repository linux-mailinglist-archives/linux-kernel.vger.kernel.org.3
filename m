Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90259376D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiHOSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiHOStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:49:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15042AC0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u14so9435441oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PAbaE2BPi2JfE0JMSsYw58hC/bDcDdFIaU6lrhJq/5I=;
        b=V0SfwLj2Yb74etrx6rZia7hwxnv4XkfBI0cZtG1ukS6nLDzSjJMyA1TvyG1buUgVla
         Jejov9nTjZs+kZUP5vQin6bWDO+v86jb6AaxTKWn9Jw1m2KXFY28/noXzobNQVfR3ms+
         1ZoWxmc7QQCiJbTs1VWn7hbPJYEqvN4rMMIAbkjM/xRtsltDcLhuBpD30bljR3kgQb6/
         7LmETzDf4cPdg8jUN2h4bpZL+/MtVjP4Qs2K3sM9gL8QCklk69cQN5/izcXp88d0LkOR
         9udl1jzq251uFJMR7lB/TUdfxUs9yKIglh/0wXZzqwbvy67Fuu76Q1Y4qEuqP8jFXwaf
         e4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PAbaE2BPi2JfE0JMSsYw58hC/bDcDdFIaU6lrhJq/5I=;
        b=0rkGsSqL9QyEJUx8OWisk7Jf3NhSJsTvT5QnfqUopFQm0u/v1BB/Tqhq5uqT+1P/c8
         ohNgBjbKZVUls/3VgWR4bxdH9kwz0BK/d80NaSovQj9ZM/KRz8o7UeFyKCFnq4OHQcJu
         41wMeYCUwufXb1vPKLKD9D3GEMmMJ4rCL6UOa3kwiiCHcylViY+LESHVy3w6Z75KZ+BC
         1EGROVwoqRuHRh1N9hwYxlwBWvlc3DbLh7hZpDRsBTKjY3OeQsPqNUaNae2qe1tHuwTx
         r2xfdL7E7Sg8zeRM9L5ClNjArr8LZm9F1icpgvAC9oD08isfSfe8syRfgHRSvu4244fK
         3QAg==
X-Gm-Message-State: ACgBeo2uNmIQ//TtehpyCL1FwhzdZ83+pf1JZPHlTgEUChtA1AR58RyG
        dBB+0exmRWsH0RoDxL8wCv4mL5GMt0JWM12guryNIw==
X-Google-Smtp-Source: AA6agR4APC8y0ObSdmVA8gIwBkVKlXdAxjrtt2Pcnsr06+bzyb2N1m7fW/tLBegFGxvYUCkF3SP49wRmVOtKuUNB12U=
X-Received: by 2002:aca:5e89:0:b0:344:80ab:1351 with SMTP id
 s131-20020aca5e89000000b0034480ab1351mr4590109oib.105.1660588124265; Mon, 15
 Aug 2022 11:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220728080048.21336-1-wenbin.mei@mediatek.com>
In-Reply-To: <20220728080048.21336-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:28:04 +0200
Message-ID: <CAPDyKFqg7gDXMKyDXa_oczfkjqEAcsyL-9YJWHE9wA2sY0BGfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Clear interrupts when cqe off/disable
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, 28 Jul 2022 at 10:01, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Currently we don't clear MSDC interrupts when cqe off/disable, which led
> to the data complete interrupt will be reserved for the next command.
> If the next command with data transfer after cqe off/disable, we process
> the CMD ready interrupt and trigger DMA start for data, but the data
> complete interrupt is already exists, then SW assume that the data transfer
> is complete, SW will trigger DMA stop, but the data may not be transmitted
> yet or is transmitting, so we may encounter the following error:
> mtk-msdc 11230000.mmc: CMD bus busy detected.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Applied for fixes and by adding the below tags, thanks!

Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
Cc: stable@vger.kernel.org

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4ff73d1883de..69d78604d1fc 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2446,6 +2446,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         /* disable busy check */
>         sdr_clr_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
>
> +       val = readl(host->base + MSDC_INT);
> +       writel(val, host->base + MSDC_INT);
> +
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> @@ -2932,11 +2935,14 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
>         int ret;
> +       u32 val;
>
>         if (mmc->caps2 & MMC_CAP2_CQE) {
>                 ret = cqhci_suspend(mmc);
>                 if (ret)
>                         return ret;
> +               val = readl(host->base + MSDC_INT);
> +               writel(val, host->base + MSDC_INT);
>         }
>
>         /*
> --
> 2.25.1
>
