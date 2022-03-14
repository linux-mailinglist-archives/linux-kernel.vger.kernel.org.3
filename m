Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D24D859D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiCNNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiCNNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:05:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE16261
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:04:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w12so26944346lfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MfZZ8Z2VIRecHres2doKMiTPlkeNRdQVYI9Pur3LWg=;
        b=CAqEHUaj6AhkwwEV4fG53921rZDVLI25guUp4kKbZHYrGsnPdybb4SZap6GGfpchvN
         /N4S0TPHJoKhQUFT4m9ieSo5Y73BHV//gg6oKRUw2YR6TEhipbovxHI498M/MxD6rGry
         fh/HpovLgWCqKuL+GGb4U7PXl5Pwvq5INkaeTJngHLBd67MdbjEi8TjwhVwl3oJfmnwR
         mfE2hK7KnWfM5ze6g23N9XSaoJMYD8JBm0IHi2Mjxt3X2d3GfwjVlIaSWuCPykc4FMBY
         ZGojEFVRGc2Q2YBN9ELDzzHlRkWezpf8zBplgHdILSRDRt6Iu11yB0JGrEeOtYqxiKvl
         Gw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MfZZ8Z2VIRecHres2doKMiTPlkeNRdQVYI9Pur3LWg=;
        b=eCSxAyjTWmd1/aJcYHoLZIDR+FpnexHcL3dNebEmOhhebTocf8woCalymVciX2kg1k
         0O8Z9FpwtUaFlsPGC2iy6CmYxLSauXrUiXuZqyNNiBWhSJHJ//MYSGhNU9xpCv50WTwE
         kAPhF+coa/9rzMnyDCQC9eE4lPLQfJ3XwpvCYSYo/MjEgUZG7arLDjgZrFHlTffmYNee
         M37e9hFwS8bLb2vNrsDPh1IW07galZQG2Gr0EupcBRi7zfjxjuhhiduneqkqoXoXAz1F
         tIGZ2ek8iqn44pIoVD9c5lW3Rp8mCjhcB7aX+X3yBfjezA9w87qZ8wH71r2F9z0UwL5c
         Df1A==
X-Gm-Message-State: AOAM533wczQGD9j1G0pjQHAlWYymMkZ1kyarE+HxiXkZYBx/Dj9wP8Ha
        n54DebqrRBN2KmfA58DqJLPmADJ/eTyoXAzvZq7N1A==
X-Google-Smtp-Source: ABdhPJxLj7y2ByIROxvKKfiEeHzQZ63DiyPekwQpuNnd2iLxo6Vd9kVMmuxVeBkOcfokRikDVwLDYdTWQLK3uoV/k80=
X-Received: by 2002:a05:6512:3e0c:b0:448:3480:1fe5 with SMTP id
 i12-20020a0565123e0c00b0044834801fe5mr13437236lfv.358.1647263057083; Mon, 14
 Mar 2022 06:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220314095225.53563-1-yann.gautier@foss.st.com> <20220314125554.190574-1-yann.gautier@foss.st.com>
In-Reply-To: <20220314125554.190574-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 14:03:41 +0100
Message-ID: <CAPDyKFruN9Xwk4uqFumwBdcn4SjKQcSQVBbALa3kVxY4mVzOnQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
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

On Mon, 14 Mar 2022 at 13:56, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Add a disable_keep_power field in variant_data struct. The
> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
> It is only set to true for stm32_sdmmc variants.
>
> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> It doesn't correctly support low power on this board. The Wifi chip
> awaits an always-on regulator, but it was connected to v3v3 which is off
> in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.

Just to make sure I get this correct.

Why can't the regulator stay on during system suspend? The point is,
we don't need an always on regulator to cope with this.

Kind regards
Uffe

>
> The flag can still be enabled through DT property:
> keep-power-in-suspend.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> Update in v2:
> Reword commit message to better explain the issue.
>
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
