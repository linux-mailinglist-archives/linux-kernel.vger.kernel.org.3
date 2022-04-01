Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEDE4EED5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiDAMom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiDAMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:44:41 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514026133B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:42:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e5e31c34bfso31115357b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wr+mFET+ztEiJpTYfAk9pLOZKM9Kx7FBprGkyZzhxS0=;
        b=KM0TJGBdcQQngOeNHboefqLI4uHbz6uV9J+uQy1zcNZfFR34k8gkutoi8XLXUTohHv
         1Z95jzkeHay1dm7TbPcx+gDcNbUlvz3f7lsRIQhkrRWFVrz0weE6IwJHpVDsML0uICUS
         692Qc5DoJOXPJ+Az3s+6Mip3gUbMd133dyCly6PW1Nzd0MFb2tgGakrWDJiY3fwHYIdP
         3r6EZ/o03HGN5zmxJkM/JdZj454m4fGERvYjmoAJVDS5+LqTYuVzTXro68p8w6pqsknw
         iamHYkpAOStzhn2JfC6uyU3706j26dZcdaKmpHNlQuyvQuX3mJvqU4IRVZ8URKrg5kgd
         jo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wr+mFET+ztEiJpTYfAk9pLOZKM9Kx7FBprGkyZzhxS0=;
        b=oFV8W9ddk+hkyi54iQPNSD4VMAtZA+mSL5MCCp0NdwZWp2Abzyp2gl8aFTM+0buqa/
         D4ptVuZvEsiW9MzjVjzstn4DyWtyUIb8P5x5xahWQIW54IEIom68p7Fg134p6tDD//NQ
         PpGxKpruXRawGG6TYs1yMf/7sBqoDufPeDyw4MeqRrBCfJ7VwpqMZREf89K8XFUgYcQc
         0XecdYy1FMZY1/6oUHCHx3DpEnFQIiyPGi5saeak9cxvj7Gf1MPc5uxzmdTuuvrr0e0J
         mtq1H3b0PjfJLyGNzNRX0cWCiqw1VDT88gPJLYCVMIz721OUc9beuB9lPnav/JUPKe09
         dxmg==
X-Gm-Message-State: AOAM530Yk+aDE+xDg4LGaqI13HTxRTza2AhHzM45JugtJqmlHAo9zU1z
        dN/4x2hmqW0AU5fSI84HGgPCr925AqW8iWbsg891mnrYdz+8Pg==
X-Google-Smtp-Source: ABdhPJw5Lf2dY4cBbTNOwmsSY9juu3wQscQ3aPtqvEuQGh8Q8VFuF9YD6PF38LZ4ttaWRJj/1l6Srm4bsJfUdsq5Nv0=
X-Received: by 2002:a0d:d84f:0:b0:2e5:f8f1:7272 with SMTP id
 a76-20020a0dd84f000000b002e5f8f17272mr9960403ywe.376.1648816970864; Fri, 01
 Apr 2022 05:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220329032913.8750-1-axe.yang@mediatek.com> <20220329032913.8750-3-axe.yang@mediatek.com>
In-Reply-To: <20220329032913.8750-3-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Apr 2022 14:42:14 +0200
Message-ID: <CAPDyKFqzNJxt8RhQ5ABLqqkVaJmRPDFu=QuSUvAr-eW9SK4fSw@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] mmc: core: Add support for SDIO wakeup interrupt
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
>
> If wakeup-source flag is set in host dts node, parse EAI information
> from SDIO CCCR interrupt externsion segment for in-band wakeup. If
> async interrupt is supported by SDIO card then enable it and set
> enable_async_irq flag in sdio_cccr structure to 1. The parse flow is
> implemented in sdio_read_cccr().
>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  drivers/mmc/core/sdio.c  | 17 +++++++++++++++++
>  include/linux/mmc/card.h |  8 +++++++-
>  include/linux/mmc/sdio.h |  5 +++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 25799accf8a0..4898c5e9a299 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -226,6 +226,23 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
>                                 card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_C;
>                         if (data & SDIO_DRIVE_SDTD)
>                                 card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_D;
> +
> +                       if (card->host->pm_caps & MMC_PM_WAKE_SDIO_IRQ) {

After a second thought, I think we can just skip this check. The
MMC_PM_WAKE_SDIO_IRQ indicates that the host supports SDIO IRQs as
*system wakeups*.

But, in fact, I think we want this feature to be enabled to allow
waking up for runtime_suspend (RPM_SUSPENDED) too.

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
> +                               }
> +                       }
>                 }

[...]

Other than the above, this looks good to me!

Kind regards
Uffe
