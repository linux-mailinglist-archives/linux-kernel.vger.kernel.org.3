Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4E4BA496
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbiBQPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiBQPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:40:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD72B2E27
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o2so35031lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RtYDADx4QQw3nzWuN70oIVG8nEMTl5DSCkcy5LhUkE=;
        b=QII7ZKn99paThcY5nBrDoRQ4DFbIageeAVtKvpe+UeTY/hcPuVE2V69G3kYeVBcjqg
         FpDph57yvjDFIAb4vvyvx/EB8NObDf6kK+pacX4hT5CuNKon/AG5ULZQHh8TY6XS9OOP
         /X4inNHe1rI//4TM0/8VKSQ/asjArtn0ltdWIIeKP1hkgFwgZ1tRMKt4PMuj5mT7F0xE
         XlDWC5MMm+kIW4DLDWm8Q9Ni9M0llxk2+dZR741HTB/51dYL2b3DHlptUyFuHrNziFUw
         vVYLS5fAEQOoLR51gNiMgqywUifJveAQmIlw1jk04xSryDjEPJz1nkSApyiNcY1KK0jk
         fQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RtYDADx4QQw3nzWuN70oIVG8nEMTl5DSCkcy5LhUkE=;
        b=RuPJ0PB3JqGvS4Qvda4C6BwFNzPDmwZgW8XP69Fi2usKgX37Y/lxfKNtRB+SDAqolM
         /t7sFr9l3n9FoRmucjmBjTOQC7HTP2DmsTmUcvFsLZdAjEMCyrrAfLMEz5YR1h9NrVLC
         YLkeJ0u3DZGumKZYLc+yt0wL9wle06ml3bDLAmcm9a5Kf+QGERJSSJAcofvIqU75A0l0
         MxGQyVAkulhGkK8IBe8nQu1kcybD6HVQToYmFIQgncvyOYx3pZ/n9YbKX7OFz8QJMZo3
         VBkRJRI5J2AzGxGCojVzQa20MgMmyDMrldBnI4KskuAhF9BaxxHtRMZ0X7mHHCDsVpRC
         Q8+g==
X-Gm-Message-State: AOAM533eTNZNB3uiVXGCO58PPYuzgYbwwqlsi76WVv6I2cPpaqPKoigw
        xLLsWImaE/E3ezIFNTdVtVVX8l0y1z6127hKH5OgHA==
X-Google-Smtp-Source: ABdhPJxx+WlNwrj3g8DmHHCXPTELFCPxQlK7IqCQ3NAlli3irDlMVGL1v6Gnap+Mi7IrIbGn91W64bziVKF4OQAMSk8=
X-Received: by 2002:a05:6512:3d2a:b0:443:3198:cb95 with SMTP id
 d42-20020a0565123d2a00b004433198cb95mr2461725lfv.233.1645112397989; Thu, 17
 Feb 2022 07:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20220211075056.26179-1-a-govindraju@ti.com>
In-Reply-To: <20220211075056.26179-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:21 +0100
Message-ID: <CAPDyKFpH4nnnzbFRfZ8p_vLSqh+m+fEd4yW2T2Z4rq6tRQS-Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Fix the driver data of AM64 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 11 Feb 2022 at 08:51, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The MMCSD IPs used in AM64 are the same as the ones used in J721E.
> Therefore, fix this by using the driver data from J721E for AM64 too, for
> both 8 and 4 bit instances.
>
> Fixes: 754b7f2f7d2a ("mmc: sdhci_am654: Add Support for TI's AM64 SoC")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index f654afbe8e83..b4891bb26648 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -514,26 +514,6 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>         .flags = IOMUX_PRESENT,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_am64_8bit_pdata = {
> -       .ops = &sdhci_j721e_8bit_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static const struct sdhci_am654_driver_data sdhci_am64_8bit_drvdata = {
> -       .pdata = &sdhci_am64_8bit_pdata,
> -       .flags = DLL_PRESENT | DLL_CALIB,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_am64_4bit_pdata = {
> -       .ops = &sdhci_j721e_4bit_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static const struct sdhci_am654_driver_data sdhci_am64_4bit_drvdata = {
> -       .pdata = &sdhci_am64_4bit_pdata,
> -       .flags = IOMUX_PRESENT,
> -};
> -
>  static const struct soc_device_attribute sdhci_am654_devices[] = {
>         { .family = "AM65X",
>           .revision = "SR1.0",
> @@ -759,11 +739,11 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>         },
>         {
>                 .compatible = "ti,am64-sdhci-8bit",
> -               .data = &sdhci_am64_8bit_drvdata,
> +               .data = &sdhci_j721e_8bit_drvdata,
>         },
>         {
>                 .compatible = "ti,am64-sdhci-4bit",
> -               .data = &sdhci_am64_4bit_drvdata,
> +               .data = &sdhci_j721e_4bit_drvdata,
>         },
>         { /* sentinel */ }
>  };
> --
> 2.17.1
>
