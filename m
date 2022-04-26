Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EAC50FFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351304AbiDZN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbiDZN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:58:48 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A815F393
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ebf4b91212so183071037b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vnAxl9/6m01Rp7k898UysKn+D7uwIp07j9FOdL8K08=;
        b=tKoudsGaU3jACLFNweKVC1FxDvCj1EKUnpHd1WVFMlq2ZJqDHrIccJNy2IpQmvfGNE
         nWzuTY2RIX7HeRb6Ew9wEQ3jVbRHnFiYIBeE+IUdpoRtPK3UR+OP4SfcKMr56nugmsDA
         T5FmzucJMSZpZhSG118zaEhcrFdeyLQJSBz0yZkif12Hzc17tf+utn7rJtjJm3rU8am9
         qqfzL3ARG+RI4RPjuIfjMn5PzGBZQ1u3c8wIzZQcQJwVhuvgDi6nWOWRkOOCgWGr2atp
         aNUm3TVZs2iTHbzxFAiDIyenddPgISE3lMOORLLtWlLJyp7hW4isLItOD/G96HFMu5lg
         /zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vnAxl9/6m01Rp7k898UysKn+D7uwIp07j9FOdL8K08=;
        b=hdMypS0V0aslY0YyJRgvxcNEiq2ijQk4jQ7EF3IqY8pdBbJ7Ve/asirCUofoBxu8UG
         zxraO4IXxR/KTo19ObdYvhgl/Vvxqg72Gg/vPAnOFVd01KfczOSEdQFWgWhiSnn9RXqx
         kX6VD2Fv2QcI/3i+d1h3fVjpfeucp72YUngE3LFaPwhbZY08hb2hYqVRKYQMg9JBu0Mx
         oKCmfrnWPtALTVIU+QTc2fI6QrpuIRenBUnewmfcqfRCjlfKTQ5zNbazbLyeAOZNg4yo
         X0k2jhyygLkWIFQT1ys5U04Np53kTc6x9lj8rj5dmwLvq3IWuUypgkgcfad2SNgGdXXg
         ztrg==
X-Gm-Message-State: AOAM530sffeVIvM7kaFDx2TCMoqHu4Zfdw9edXClQLwN0hdBz9dGoD5b
        iJbVsa9ZfBZE+MfeyBFFcIqxMO68ssp88Yy9yjJu2Q1z9TE=
X-Google-Smtp-Source: ABdhPJwXP4TdwcxWnUNBNkwDbTV3dLBtvpt2L3DjaLE74Wt1O6h1Rzd9M2lvWXt7y67o8B8B3IM+kwYDJXvx3UbsQoM=
X-Received: by 2002:a81:998e:0:b0:2f4:e2a0:f30f with SMTP id
 q136-20020a81998e000000b002f4e2a0f30fmr21422325ywg.376.1650981340479; Tue, 26
 Apr 2022 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-2-huobean@gmail.com>
In-Reply-To: <20220423221623.1074556-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:55:03 +0200
Message-ID: <CAPDyKFqHVxqz8ZSJYeZkjyLxEiCk-xpPuqOj69AkeJ=ZUYgvow@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-omap: Use of_device_get_match_data() helper
To:     Bean Huo <huobean@gmail.com>
Cc:     adrian.hunter@intel.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 00:16, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Only the device data is needed, not the entire struct of_device_id.
> Use of_device_get_match_data() instead of open coding of_match_device().
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 64e27c2821f9..86e867ffbb10 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1219,16 +1219,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_omap_host *omap_host;
>         struct mmc_host *mmc;
> -       const struct of_device_id *match;
> -       struct sdhci_omap_data *data;
> +       const struct sdhci_omap_data *data;
>         const struct soc_device_attribute *soc;
>         struct resource *regs;
>
> -       match = of_match_device(omap_sdhci_match, dev);
> -       if (!match)
> -               return -EINVAL;
> -
> -       data = (struct sdhci_omap_data *)match->data;
> +       data = of_device_get_match_data(&pdev->dev);
>         if (!data) {
>                 dev_err(dev, "no sdhci omap data\n");
>                 return -EINVAL;
> --
> 2.34.1
>
