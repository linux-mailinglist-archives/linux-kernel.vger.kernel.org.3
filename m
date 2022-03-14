Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50F4D808C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiCNLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbiCNLTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:19:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B81BE8C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:18:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w27so26482567lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XskhS1+ZejRwgAiU2pw1deIKGswy4V+5KYO2DeR1N9Y=;
        b=Uhu1Lwv+8VuFE5mRfF/1b2fiAHqmvUsgUhO0pXi5pyY4urvEINV6Z/m05yaTGcL5ZE
         +vLW4CEz2XJmayqkOZwg68/tGpAtHuZmQ18hMhr8SHNkm4H/Er1sDkW3fhVzF4bJp4VD
         t4GUQ30wmnGKjmoD9e7ylxfIYy7S+dnRcLwN2BAWwedlCqT01lOSr8m7LV8LVcNaIUjh
         OD7b6zeb/aNU4N99T50I0q8ffqS5qtDBfH0RYR6JetL+NbVtq48E/GQXd4m+a92tmr4b
         vqUI0gEaE7QWLqqos5eiSeey6RnrWI2pLhk0pXSQibJpGpu/eUTQPYb+Wx4tSOgjTFsn
         vASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XskhS1+ZejRwgAiU2pw1deIKGswy4V+5KYO2DeR1N9Y=;
        b=pTuPM4MmVuEUeMaiF67nQizyfBC33KY+X8zXH0MAUKrSnG0MU4d8kSSs7ccDSfmDg7
         qZQ/nG+F/OJMS61tr2d29LKW/2pU60ECgcLnDbVAU17QW5FX8Gjd96DqmMCKQNDsDuEw
         UQRzdVte+jtpzUXynZbKV1jGgMbBWSZ2xbq/ds0v/fXS4SbJBLYF/v4tCtiS1IS6yc6U
         i+RGwns/csAW18j1Tnlh/cus8z4tsG4oSCgl6dm+E3kKlxCKUqDjGP8FXwA3oIbSEk91
         rxfdEWCz3YHU9DOMU8TZpKHfRvriRTAkeNo1jnSxuLuWHSzAbxDddgU9cZUxwBtqknqz
         AP2A==
X-Gm-Message-State: AOAM531+VXV4Cas0sqvkSzIgaaGfmrUVzX2CPR90zJ3gDSz7eZgsWNFC
        T3eUBpRSrEqVy/TbqiiRcKohgzsX1YZyLC+qXmiNkw==
X-Google-Smtp-Source: ABdhPJzg/q9jjOR2SPQ2R16ySqzVp24+QtiJiQEJR73cAEQSY86tTlqPmMueae2ZtUIMfhCRek0+f4lyt/Me1eJarYw=
X-Received: by 2002:a05:6512:12c4:b0:448:6d12:4434 with SMTP id
 p4-20020a05651212c400b004486d124434mr9339397lfg.71.1647256705361; Mon, 14 Mar
 2022 04:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
In-Reply-To: <20220314095225.53563-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 12:17:49 +0100
Message-ID: <CAPDyKFqObiC2fwZJ_0JArbVhnFZHV6bA0XJg0diwPgmRx1Bntg@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
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

On Mon, 14 Mar 2022 at 10:53, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Add a disable_keep_power field in variant_data struct. The
> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
> It is only set to true for stm32_sdmmc variants.
>
> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> It doesn't correctly support low power, and we need to unbind the wifi
> driver before a suspend sequence. But the wifi chip firmware is then
> lost, and the communication with SDIO fails if MMC_PM_KEEP_POWER is
> enabled.

So the platform supports to maintain the power for the embedded wifi
chip during system suspend, but the SDIO func driver (for the WiFi
chip) doesn't implement its part correctly. Did I get that right?

In that case, it sounds to me like we should try to fix the support
for power management in the SDIO func driver instead, no?
I am happy to help with guidance/review if that is needed. What SDIO
func driver is this about?

Kind regards
Uffe

> The flag can still be enabled through DT property: keep-power-in-suspend.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> Resend the patch alone. It was previoulsy in a series [1] for which the
> other patches will be reworked.
>
> [1] https://lore.kernel.org/lkml/20220304135134.47827-1-yann.gautier@foss.st.com/
>
>  drivers/mmc/host/mmci.c | 5 ++++-
>  drivers/mmc/host/mmci.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 45b8608c935c..0e2f2f5d6a52 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -274,6 +274,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .busy_detect            = true,
>         .busy_detect_flag       = MCI_STM32_BUSYD0,
>         .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
> +       .disable_keep_power     = true,
>         .init                   = sdmmc_variant_init,
>  };
>
> @@ -301,6 +302,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>         .busy_detect            = true,
>         .busy_detect_flag       = MCI_STM32_BUSYD0,
>         .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
> +       .disable_keep_power     = true,
>         .init                   = sdmmc_variant_init,
>  };
>
> @@ -2172,7 +2174,8 @@ static int mmci_probe(struct amba_device *dev,
>         host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
>
>         /* We support these PM capabilities. */
> -       mmc->pm_caps |= MMC_PM_KEEP_POWER;
> +       if (!variant->disable_keep_power)
> +               mmc->pm_caps |= MMC_PM_KEEP_POWER;
>
>         /*
>          * We can do SGIO
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index e1a9b96a3396..2cad1ef9766a 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -361,6 +361,7 @@ struct variant_data {
>         u32                     opendrain;
>         u8                      dma_lli:1;
>         u32                     stm32_idmabsize_mask;
> +       u8                      disable_keep_power:1;
>         void (*init)(struct mmci_host *host);
>  };
>
> --
> 2.25.1
>
