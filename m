Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC9592BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiHOKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHOKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:12:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3418140E4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:11:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u1so10022241lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gmr17YBDbHMvM932wEH6jhfSWFYGcnH6MbBcnQ/BW6g=;
        b=Ueh3RcrS+ZQZs8802jLuUeirUvPqjjFabWZ7YC0GkNrk5wxz+RpctVMgDZUGE+s6fn
         hpVH1scGxoKykqcH0g2XO3Bvxpb0D5nhO9zQx8Q+h4a6biDYR3A9bXXQs81Qo3quX8Ff
         I1axUXE4r/QhzDG5ELaF3MySkcDdUmIctOE80MSkhTk781Fr35lLe2NswQNwmanGqXID
         qYDTgxrM3jJoj3tz9YRrl8HwLBF61Sb0Pe6KSUD0kt74T1+k/CkAevXqHBD62dAe6Ls8
         herGn9gG0BqtVG0JFaJLmaLjV1ozeMS7EbnwWcVlgmpvOwquABXx5qHaFBnS06tGsFNp
         o6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gmr17YBDbHMvM932wEH6jhfSWFYGcnH6MbBcnQ/BW6g=;
        b=JI8UuqTzIkcRLlAjXEb3HoWyJ8S0+gJlg3qPH5UkJsedKz2x4BmQD5qQ/Pn52Td32z
         yz3Oas8lhee11PPxyY3DODMxqZqIfIKk+X+JmMR+XtPOaVk/8UfC8zie0bFFPrN5aEXx
         mB60rZvUFQz0h5R2F9NWijbynHPD63aWSUbeziG0eZIX0Hsv+LJ8i9Hap8i5VTch6Yo/
         LujWH9VWIGDlbHylGjixhzW8+0jDywGvKHTVpi0sq9Of2LWHcE8xyS8yh5iQZfnuha1j
         ndCsQ2roaEDt2hPD1y9DUYZrcmfs4r+k7fG1qENhcOg/Q/As36fBGu4MMTt5xmUzvjYh
         0T2w==
X-Gm-Message-State: ACgBeo3qVLurPYzvZEMvUnhEGqnMNH2Lo0OwjTTKz1BeaDwRM/dYMN0W
        ezn9bLC2hLaZNUYi8AhX28EEuHMFNY4w8SGFkmoiwg==
X-Google-Smtp-Source: AA6agR4C2IO/xQv/D2+AAUs0oCi5pATmLAwL9uiqdJ6839Bh59m6MRIwTdVE+PNLo/Hib6+NITjoDGusDIjIzbLy27k=
X-Received: by 2002:a05:6512:2306:b0:48b:2905:21a8 with SMTP id
 o6-20020a056512230600b0048b290521a8mr5795536lfu.167.1660558318027; Mon, 15
 Aug 2022 03:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220810022509.43743-1-samuel@sholland.org>
In-Reply-To: <20220810022509.43743-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 12:11:20 +0200
Message-ID: <CAPDyKFqg0BUbpQwKvZxuMrqoiwBKzZxbgP-e=50yLpKRhQ+zPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix clock refcount imbalance during unbind
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev
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

On Wed, 10 Aug 2022 at 04:25, Samuel Holland <samuel@sholland.org> wrote:
>
> If the controller is suspended by runtime PM, the clock is already
> disabled, so do not try to disable it again during removal. Use
> pm_runtime_disable() to flush any pending runtime PM transitions.
>
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  drivers/mmc/host/sunxi-mmc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index b16e12e62e72..3db9f32d6a7b 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1492,9 +1492,11 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>
>         mmc_remove_host(mmc);
> -       pm_runtime_force_suspend(&pdev->dev);
> -       disable_irq(host->irq);
> -       sunxi_mmc_disable(host);

Perhaps a better option than the below, would just be to drop the
above calls to disable_irq() and sunxi_mmc_disable(), as that is
already managed through the call to pm_runtime_force_suspend().

> +       pm_runtime_disable(&pdev->dev);
> +       if (!pm_runtime_status_suspended(&pdev->dev)) {
> +               disable_irq(host->irq);
> +               sunxi_mmc_disable(host);
> +       }
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>         mmc_free_host(mmc);
>

Kind regards
Uffe
