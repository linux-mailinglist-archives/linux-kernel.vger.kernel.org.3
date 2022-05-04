Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94704519D16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiEDKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348198AbiEDKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D2127B06
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:37:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x33so1608507lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+UK7a5jf0KZOl/DUtb1w9sbFadlObhTOJmpHWQdrpc=;
        b=hm2ua1HVcCJqnnAGwF5xo/rNEYAQhftBcLO3n4wSKHPKVExz4/ps2iF279WPGoLBOi
         U2RMBXyKqSHTq/iMqYJuaihXJyHGxfXMUoI6gK1wxi8kI9vXEbnR8PGYbZzf2WhO09kp
         k1h6Mz1WWZ6WZMtwi1Pf49wB1iKajJLIfzVcFWl5oc7BQN0JtmTELvuFDiiGwWtTnfeO
         lMp1bNf08nelacSsBTyAup8ZqotOBF7uKfj/MXiOACYrrxKJdGm3Hq2qfYRWBVX1uCmJ
         hiq3henLKfsJ9oxmGhuJ1Ld7u/gIFo3aBnCDxUuS7EQ66IUB+PXHY3Bylibvxsm03sZF
         tCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+UK7a5jf0KZOl/DUtb1w9sbFadlObhTOJmpHWQdrpc=;
        b=QdLWGlRd8Si2fOBJgPzqbsrx12hf4450CH11dtuCey77rN+xmCtxKXt9dF02uV4Dyb
         yZAwFelOLlAJjUljyP55euP3EF8j7tFiWPHyoJZDM93HGKfwpDLRJkvSqi0sDxdw5iVc
         CYAZIX5h/tMhagzsEx5hJRL6vmKKpNR1d/hZBXWR/BHSAVs7ZXpId39HaLb6QJN9mNhW
         XGO4XBH/8e1LC6wIzFP7PBE/gz4PD5rxMqpex4JLsnlrGnjIdaJMYOIq+oonCGB0a+qg
         98R152Vhk0eLpzH9dWoJTKdUa5TCzYxpZKZOhNAI170iljSPU4aAk4jVbz7SlUJaicug
         b1dg==
X-Gm-Message-State: AOAM533H8jmZ1llqmrLkjX54ky9Yn5msm6hp9DzQp1AgcgDzbb3hkVwa
        kOIiqOYdCWy23oNYi6LkQgs7LGzWFmNi9uUrLDTJ1w==
X-Google-Smtp-Source: ABdhPJwkwNV4rISj+UH7j2rCs0ZZC2RzQF+RxkG2Q4oc4buD17InzEKJpaRYTpbP38qZFRwCTAMNg/Ni/18erN3K+dw=
X-Received: by 2002:a05:6512:301:b0:471:ecd0:ea24 with SMTP id
 t1-20020a056512030100b00471ecd0ea24mr13515183lfp.71.1651660670573; Wed, 04
 May 2022 03:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220424231751.32053-1-samuel@sholland.org>
In-Reply-To: <20220424231751.32053-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:14 +0200
Message-ID: <CAPDyKFp8JRkMJxPP8g_83o4hqxu8FUARaT8fU0zPR7Yn26cYsQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
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

On Mon, 25 Apr 2022 at 01:17, Samuel Holland <samuel@sholland.org> wrote:
>
> Newer variants of the MMC controller support a 34-bit physical address
> space by using word addresses instead of byte addresses. However, the
> code truncates the DMA descriptor address to 32 bits before applying the
> shift. This breaks DMA for descriptors allocated above the 32-bit limit.
>
> Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sunxi-mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index c62afd212692..46f9e2923d86 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -377,8 +377,9 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                 pdes[i].buf_addr_ptr1 =
>                         cpu_to_le32(sg_dma_address(&data->sg[i]) >>
>                                     host->cfg->idma_des_shift);
> -               pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
> -                                                   host->cfg->idma_des_shift);
> +               pdes[i].buf_addr_ptr2 =
> +                       cpu_to_le32(next_desc >>
> +                                   host->cfg->idma_des_shift);
>         }
>
>         pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> --
> 2.35.1
>
