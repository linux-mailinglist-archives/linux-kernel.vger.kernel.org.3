Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9256351A16B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbiEDN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350879AbiEDN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:58:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1E3EAAF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:54:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v4so1739321ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6qBDyeH+xgHUpsPjtNSn4a+2fKviODgV+T0tGLuQ9A=;
        b=mCRJ1b3PXw/ulWo14ia9eEiZPHjm61FsyhyDgEVG4vvTVfpmqIAwbaoEFGAQ2zHE+h
         /9Sgv/8RW9fG0f0wO+mhs5Kik2TWTth5zKhfbzY5aa1ZRk0dkwkfO12awx9Z9TiwEimE
         7nySmI8yrqkVTl/r2L0h5OP1hYh2zITPxg1SA053LIkij5JTydHaB2+2b9sNdmllCrPZ
         GmYHC51j0U9cedgfK80PyEKmJZMUxuUfAFl51+XcL/eJCNyQfAJ8W9j9KQOkx8VBIywq
         VFdNV+wXI4J0MFVOlecSC3YT0HzbATVkhVdwWv0ZUHUMZFdE7YGNeJiO6RDaVBYMi4g2
         S1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6qBDyeH+xgHUpsPjtNSn4a+2fKviODgV+T0tGLuQ9A=;
        b=QBJN4UsQUSyAaWfpwwF6p19aO9x8Oe3Uo1AJGfAh/jKIlTHlF2ISJ9il2J/Zg32NE3
         MZ32+otU4HalkAyHWidAWQSjj8kndHOtPv4mkakpEZ0htKOuKbsqjkmicJPYlRT58cbf
         6MlR4b+P7H52MbmpaLvnik5q9igwotb9hZxCgLlcPYOm/n4LvvVIIIbPle0yP9jND5YC
         b91+N6pQPV6XpwDiWZrYhv0F/uAZR5q+lJYFr5SQ/9oxbQQo1vh2/YkokrZbezCOrWot
         bjFqLWUUwyLVqOBpsSoQ2UnXgfUEwCRJ/BXInYn4A2s7cfQMgXH3SPts+ghP2Ly4xEpQ
         6oFQ==
X-Gm-Message-State: AOAM533lE7JEMBT0FpEl+OOQugfs9AVBJZmbatsjuBaxCCmHy45Amr7g
        O0hnp6W0rr6jfERXmXgBtLHWzP2w/dg2XdQld7mUcw==
X-Google-Smtp-Source: ABdhPJxKhCPqCSviNHhQ8pe+/xyLvakb0eNhls2zQBTccZ5aI+9uMHMHOEZZc1iIBMBsL9xfWv5ofeR+hFcZrlCFMCI=
X-Received: by 2002:a05:651c:a12:b0:250:5abe:4ec4 with SMTP id
 k18-20020a05651c0a1200b002505abe4ec4mr7890315ljq.4.1651672473916; Wed, 04 May
 2022 06:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220422140902.1058101-1-icenowy@aosc.io> <BYAPR20MB2472BAA6CFEA5BD4B18D7D4EBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
In-Reply-To: <BYAPR20MB2472BAA6CFEA5BD4B18D7D4EBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 15:53:57 +0200
Message-ID: <CAPDyKFoE5oqGL9VqArskbZRa0u5F2AUYSaPmvcJCujZz4_pDTg@mail.gmail.com>
Subject: Re: [PATCH 08/12] mmc: sunxi: add support for R329 MMC controllers
To:     icenowy@outlook.com
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
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

On Fri, 22 Apr 2022 at 17:42, <icenowy@outlook.com> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The two MMC controllers in Allwinner R329 have a mixed feature set
> comparing to the previous SoCs' ordinary MMC and eMMC controllers.
>
> Add support for them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Please repost this (and the DT patch) to linux-mmc, so I can pick them
up from the patch-tracker.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 0e8fbf4957d8..06934eef8be5 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1207,6 +1207,15 @@ static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
>         .needs_new_timings = true,
>  };
>
> +static const struct sunxi_mmc_cfg sun50i_r329_cfg = {
> +       .idma_des_size_bits = 13,
> +       .idma_des_shift = 2,
> +       .clk_delays = NULL,
> +       .can_calibrate = true,
> +       .mask_data0 = true,
> +       .needs_new_timings = true,
> +};
> +
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
>         { .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
> @@ -1218,6 +1227,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
>         { .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
>         { .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
> +       { .compatible = "allwinner,sun50i-r329-mmc", .data = &sun50i_r329_cfg },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> --
> 2.35.1
>
