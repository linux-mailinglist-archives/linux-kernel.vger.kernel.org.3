Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD164EEFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbiDAOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347199AbiDAOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:30:45 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9228B103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:27:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2e5827a76f4so34889837b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yBHZSAzaOdetcg5JOmc7KTk+gATLVEE7qyh+p2yR08=;
        b=lKu8NVYdkB8B4FroUiZcqglGUjmayIjnAOxS557eZB9iqUw3yVgKqog4K+ulQTQ+IE
         dGPqkKVHNvB8Z66V9QC1ctGMwsdDl+sjxyfxv1LzkIpf1x0vIHymXnQf90klHyoIBEFC
         3lO2PXxv38FQyWHytdRHlqzlH/2VtTwj55GQjGASLOj2e3jyp55+RK2PhMTaDZTn67bD
         SEeuFZ3xVp057vNLwm90J76+e1spNghFZ4EDTSa0QALnENZrk8xB2IE5+62aku3NWBNv
         G87AuYYt9jUuab8e7NS5+dT96N0ujvuRf8pDdMcpWYDArq2ZsLf4L2ox5mrfQetYRxFz
         ioBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yBHZSAzaOdetcg5JOmc7KTk+gATLVEE7qyh+p2yR08=;
        b=47l6rKSUeG4iK3hmn1i3VA6jlglWTCHaF7uhkuzR8qPNwspsQeEvybopc7WfP3HtqA
         3umzK9TubXcDE+gigmT57VAITdtMr8gEdxGubaQs3wL68+jnvlW4w2WiLHoORQ3dxwMi
         /mbt06ptEvw+SoOQRM87VSNSCLjVfn0yoakYMhyv0u8XSzwJpT1++uO3TPsgCxrUOlUx
         KovEUIzZmYkcKcbdAwqRbpH4FnJObIKjDlaVnxa+hFXeEG8h6xv4rwsvxvKocb3w96p3
         EyvR9ziCEOgKKYJEchgXSjQpAB1ccv+LxBEDxno9OUxQw/Njn1EYlhYt1oFhJwO7VccU
         /QEw==
X-Gm-Message-State: AOAM531DemkTWl8o/X5xs92eoLVPvuB7bh65Ku1Ecekl+b/1Ae242JTq
        6w2iRLZCdo31ILP6OxkOl8xASb9aTbQSXFkVxF0Oqw==
X-Google-Smtp-Source: ABdhPJx/s4Sf3KYRYdEDYCncQP39/k+7eSFZl8peNL0nvO6jLLB+GW3oMlL+R1l/6d7d2z75kLYO4MEE8GYJ3vTrAuI=
X-Received: by 2002:a81:d4b:0:b0:2e5:91f2:ddc6 with SMTP id
 72-20020a810d4b000000b002e591f2ddc6mr10255853ywn.362.1648823260326; Fri, 01
 Apr 2022 07:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220328145114.334577-1-yann.gautier@foss.st.com>
In-Reply-To: <20220328145114.334577-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Apr 2022 16:27:02 +0200
Message-ID: <CAPDyKFqvZRangM1V_6d+iAPJ=1AG7_VFU8YVyp20a7d-9-OZGA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: stm32: use a buffer for unaligned DMA requests
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, 28 Mar 2022 at 16:51, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> In SDIO mode, the sg list for requests can be unaligned with what the
> STM32 SDMMC internal DMA can support. In that case, instead of failing,
> use a temporary bounce buffer to copy from/to the sg list.
> This buffer is limited to 1MB. But for that we need to also limit
> max_req_size to 1MB. It has not shown any throughput penalties for
> SD-cards or eMMC.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Queued up for v5.19 on the devel branch, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - allocate bounce buffer in sdmmc_idma_validate_data()
> - realign on top of mmc/devel branch
>   (25e14a52d35928a1831ca98889a8a25ac3017990)
>
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 88 +++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 4566d7fc9055..60bca78a72b1 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -43,6 +43,9 @@ struct sdmmc_lli_desc {
>  struct sdmmc_idma {
>         dma_addr_t sg_dma;
>         void *sg_cpu;
> +       dma_addr_t bounce_dma_addr;
> +       void *bounce_buf;
> +       bool use_bounce_buffer;
>  };
>
>  struct sdmmc_dlyb {
> @@ -54,6 +57,8 @@ struct sdmmc_dlyb {
>  static int sdmmc_idma_validate_data(struct mmci_host *host,
>                                     struct mmc_data *data)
>  {
> +       struct sdmmc_idma *idma = host->dma_priv;
> +       struct device *dev = mmc_dev(host->mmc);
>         struct scatterlist *sg;
>         int i;
>
> @@ -61,41 +66,69 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>          * idma has constraints on idmabase & idmasize for each element
>          * excepted the last element which has no constraint on idmasize
>          */
> +       idma->use_bounce_buffer = false;
>         for_each_sg(data->sg, sg, data->sg_len - 1, i) {
>                 if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
>                     !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
> -                       dev_err(mmc_dev(host->mmc),
> +                       dev_dbg(mmc_dev(host->mmc),
>                                 "unaligned scatterlist: ofst:%x length:%d\n",
>                                 data->sg->offset, data->sg->length);
> -                       return -EINVAL;
> +                       goto use_bounce_buffer;
>                 }
>         }
>
>         if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
> -               dev_err(mmc_dev(host->mmc),
> +               dev_dbg(mmc_dev(host->mmc),
>                         "unaligned last scatterlist: ofst:%x length:%d\n",
>                         data->sg->offset, data->sg->length);
> -               return -EINVAL;
> +               goto use_bounce_buffer;
>         }
>
> +       return 0;
> +
> +use_bounce_buffer:
> +       if (!idma->bounce_buf) {
> +               idma->bounce_buf = dmam_alloc_coherent(dev,
> +                                                      host->mmc->max_req_size,
> +                                                      &idma->bounce_dma_addr,
> +                                                      GFP_KERNEL);
> +               if (!idma->bounce_buf) {
> +                       dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       idma->use_bounce_buffer = true;
> +
>         return 0;
>  }
>
>  static int _sdmmc_idma_prep_data(struct mmci_host *host,
>                                  struct mmc_data *data)
>  {
> -       int n_elem;
> +       struct sdmmc_idma *idma = host->dma_priv;
>
> -       n_elem = dma_map_sg(mmc_dev(host->mmc),
> -                           data->sg,
> -                           data->sg_len,
> -                           mmc_get_dma_dir(data));
> +       if (idma->use_bounce_buffer) {
> +               if (data->flags & MMC_DATA_WRITE) {
> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
>
> -       if (!n_elem) {
> -               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> -               return -EINVAL;
> -       }
> +                       sg_copy_to_buffer(data->sg, data->sg_len,
> +                                         idma->bounce_buf, xfer_bytes);
> +                       dma_wmb();
> +               }
> +       } else {
> +               int n_elem;
> +
> +               n_elem = dma_map_sg(mmc_dev(host->mmc),
> +                                   data->sg,
> +                                   data->sg_len,
> +                                   mmc_get_dma_dir(data));
>
> +               if (!n_elem) {
> +                       dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> +                       return -EINVAL;
> +               }
> +       }
>         return 0;
>  }
>
> @@ -112,8 +145,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
>  static void sdmmc_idma_unprep_data(struct mmci_host *host,
>                                    struct mmc_data *data, int err)
>  {
> -       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> -                    mmc_get_dma_dir(data));
> +       struct sdmmc_idma *idma = host->dma_priv;
> +
> +       if (idma->use_bounce_buffer) {
> +               if (data->flags & MMC_DATA_READ) {
> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
> +
> +                       sg_copy_from_buffer(data->sg, data->sg_len,
> +                                           idma->bounce_buf, xfer_bytes);
> +               }
> +       } else {
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                            mmc_get_dma_dir(data));
> +       }
>  }
>
>  static int sdmmc_idma_setup(struct mmci_host *host)
> @@ -137,6 +181,8 @@ static int sdmmc_idma_setup(struct mmci_host *host)
>                 host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
>                         sizeof(struct sdmmc_lli_desc);
>                 host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
> +
> +               host->mmc->max_req_size = SZ_1M;
>         } else {
>                 host->mmc->max_segs = 1;
>                 host->mmc->max_seg_size = host->mmc->max_req_size;
> @@ -154,8 +200,16 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>         struct scatterlist *sg;
>         int i;
>
> -       if (!host->variant->dma_lli || data->sg_len == 1) {
> -               writel_relaxed(sg_dma_address(data->sg),
> +       if (!host->variant->dma_lli || data->sg_len == 1 ||
> +           idma->use_bounce_buffer) {
> +               u32 dma_addr;
> +
> +               if (idma->use_bounce_buffer)
> +                       dma_addr = idma->bounce_dma_addr;
> +               else
> +                       dma_addr = sg_dma_address(data->sg);
> +
> +               writel_relaxed(dma_addr,
>                                host->base + MMCI_STM32_IDMABASE0R);
>                 writel_relaxed(MMCI_STM32_IDMAEN,
>                                host->base + MMCI_STM32_IDMACTRLR);
> --
> 2.25.1
>
