Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666684B54E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355904AbiBNPft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:35:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbiBNPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:35:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451F4AE3C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:35:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id e5so1572619lfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRYhE5QfFh6N5neui9jc14hYBWThUe6VRAPVyILvtvI=;
        b=hVYAEeUsZHwDztmlTeFxSWpRg3De/fjl/iZo3DZ2HN/sZNhxgJWdjODwGlfVs9GWuU
         T3hUgy3RLKCaGk9U+pUc/FqmBoayO/BRpiaL6rXDMNEN2pfnVc5uDV/fY0Vq00k3eVFQ
         WNoIuJIsnPKJ1ofvs7c4qiM3qaKtT9+qNSf+wOnunJUN7upd3HcRF4zlh/SS3q87GUua
         zhsvo/z5wl3fUazBjwE1KzKcjTW/x/lWiRht9v8ZiDfJovHGYnsOL+Dr5+DgskHtYJ5S
         eXitXaIvPefLnFP7E+OIOZya1VCZlRA+61zHOWQDq/Hp5It9wGjcz2t0Q0O22yF9Lpkq
         YMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRYhE5QfFh6N5neui9jc14hYBWThUe6VRAPVyILvtvI=;
        b=z/2R/BmgIPHRXzHOMIpkrtNztMQ+pQwb7ijSi0yJd+Br+KXLM+vLVeLtTW6qlNzsTs
         4LCY7nfOhAAD0Dx4AS4471Xhxmm6OBmGoNU1eGhumM7AC9g7fvx61WXAEgNPeuIoWTaN
         tM0FMJg3wIklEDwCHy94/Ei4nmSks7/QukTMQDCoyxDHoNmhCkmSrU8T/8JxpfACdvd5
         TZ1QRSwAT0TSJrXSqwgESMTmcFj6tdGZa9z1Njp/54zjjXQndtVg0fkG0dHDptawM4wX
         jZFYO1K/PtHcJm1gfWcag/YlkHw8BPEarZaLmsI5T9SVGqOSH+74rN/RhvAUvCuCpSpV
         jPuQ==
X-Gm-Message-State: AOAM531/2D//OC6+p4XfcswHVUda7a/LoMtAZxi7szq8bVV9RXnKdJWc
        8bJZr7xU1Zq9WOu7uoqAaPyBrpbni9P9n807FGCL/A==
X-Google-Smtp-Source: ABdhPJx9g6QNumI+cxbYO4D4/KGsV3uSlDR9miwSvQwPmYjPvhAAf0dojPsqo48saytOTLx1auETX9CyWKvOARPGSgs=
X-Received: by 2002:a05:6512:3e10:: with SMTP id i16mr160939lfv.184.1644852926808;
 Mon, 14 Feb 2022 07:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20220121071942.11601-1-axe.yang@mediatek.com> <20220121071942.11601-3-axe.yang@mediatek.com>
In-Reply-To: <20220121071942.11601-3-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 16:34:50 +0100
Message-ID: <CAPDyKFqd+H6F4+gBd4CEigaOTC5TtjtT75B3G0B6qexFi6XqKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: core: Add support for SDIO async interrupt
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Fri, 21 Jan 2022 at 08:19, Axe Yang <axe.yang@mediatek.com> wrote:
>
> If cap-sdio-async-irq flag is set in host dts node, parse EAI
> information from SDIO CCCR interrupt externsion segment. If async
> interrupt is supported by SDIO card then send command to card to
> enable it and set enable_async_irq flag in sdio_cccr structure to 1.
> The parse flow is implemented in sdio_read_cccr().
>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  drivers/mmc/core/host.c  |  2 ++
>  drivers/mmc/core/sdio.c  | 17 +++++++++++++++++
>  include/linux/mmc/card.h |  3 ++-
>  include/linux/mmc/host.h |  1 +
>  include/linux/mmc/sdio.h |  5 +++++
>  5 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf140f4ec864..a972241548b4 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -410,6 +410,8 @@ int mmc_of_parse(struct mmc_host *host)
>         if (device_property_read_bool(dev, "no-mmc-hs400"))
>                 host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
>                                  MMC_CAP2_HS400_ES);
> +       if (device_property_read_bool(dev, "cap-sdio-async-irq"))
> +               host->caps2 |= MMC_CAP2_SDIO_ASYNC_IRQ;
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 41164748723d..771fb5d18585 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -225,6 +225,23 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
>                                 card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_C;
>                         if (data & SDIO_DRIVE_SDTD)
>                                 card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_D;
> +
> +                       if (card->host->caps2 & MMC_CAP2_SDIO_ASYNC_IRQ) {

We can probably check host->pm_caps & MMC_PM_WAKE_SDIO_IRQ here,
instead of MMC_CAP2_SDIO_ASYNC_IRQ.

> +                               ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTERRUPT_EXT, 0,
> +                                                      &data);
> +                               if (ret)
> +                                       goto out;
> +
> +                               if (data & SDIO_INTERRUPT_EXT_SAI) {
> +                                       data |= SDIO_INTERRUPT_EXT_EAI;
> +                                       ret = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_INTERRUPT_EXT,
> +                                                              data, NULL);
> +                                       if (ret)
> +                                               goto out;
> +
> +                                       card->cccr.enable_async_irq = 1;

As you show in the next patch(3), this flag is useful to read for the
host driver.

However, rather than accessing this flag directly in the host driver,
can you please add a helper function that takes a struct mmc_card* as
in-parameter instead?

> +                               }
> +                       }
>                 }
>
>                 /* if no uhs mode ensure we check for high speed */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 37f975875102..4df9182bc0e6 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -219,7 +219,8 @@ struct sdio_cccr {
>                                 wide_bus:1,
>                                 high_power:1,
>                                 high_speed:1,
> -                               disable_cd:1;
> +                               disable_cd:1,
> +                               enable_async_irq:1;
>  };
>
>  struct sdio_cis {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7afb57cab00b..502a5418264c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -402,6 +402,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
> +#define MMC_CAP2_SDIO_ASYNC_IRQ        (1 << 29)       /* SDIO host supports asynchronous interrupt */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
> diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> index 2a05d1ac4f0e..1ef400f28642 100644
> --- a/include/linux/mmc/sdio.h
> +++ b/include/linux/mmc/sdio.h
> @@ -159,6 +159,11 @@
>  #define  SDIO_DTSx_SET_TYPE_A  (1 << SDIO_DRIVE_DTSx_SHIFT)
>  #define  SDIO_DTSx_SET_TYPE_C  (2 << SDIO_DRIVE_DTSx_SHIFT)
>  #define  SDIO_DTSx_SET_TYPE_D  (3 << SDIO_DRIVE_DTSx_SHIFT)
> +
> +#define SDIO_CCCR_INTERRUPT_EXT        0x16
> +#define SDIO_INTERRUPT_EXT_SAI (1 << 0)
> +#define SDIO_INTERRUPT_EXT_EAI (1 << 1)
> +
>  /*
>   * Function Basic Registers (FBR)
>   */

Kind regards
Uffe
