Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F957181B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiGLLKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiGLLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:10:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6EB1842
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p6so6642752ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMuN1KvNnz4BrVBB6d4HU6Nw1zknFBEn1R9EsX26fOI=;
        b=EZ7gyJOTdwlzvO8Ud7ZQaaE0wdpw1ZCfxNqpBIgLrqrSfyNNXt231FpeLQ6vIRrM3q
         Nx7BYZvoDFTzLKUKtWo7ceBCyGzGViDd/m9tiypUfdu5rZW8X8wf0vRf+o8AIwd8StDg
         +G6D3sk1d32JGPB74vtWu/wtYa2+JyWP6FGz0S4Zfw4XJIj/bCXCSfdVJq9m9pGaV6Kf
         /Seh0uoA+w+9HzCqm2EdhPpzUg7ULigyxtwxlblkak6CrzQJp5ecToSnW2Ys5yu+HC09
         GcmQncpF9tHLOYQ1iQHewcStGvCwpAKxGXlRyt53gjuvmc5YQYSvwWupqlqZoTl5gOTN
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMuN1KvNnz4BrVBB6d4HU6Nw1zknFBEn1R9EsX26fOI=;
        b=4fDESLVToxT7K88qIEgkOALtGBajQgOeeRaM5nzL1DpYpkFw72XfRuUntewo6jEu42
         CHAfDpsExg8BYMYD3HICWR12LSV15JqpKpL8Qe2UVj0Pm/CelCC6bhrPqAotKz6OhbiT
         AEgzEyHoLhtegBPS7RWQguOrVYZ71jgI7C5kzlLBMEM1g5wqMP1vnNDt2UGOPNAC+8yz
         swu+2xbphDyQy+bb+jESLw4TLhadNfoJM+K20NKlBkyBwRSI4V6/s+VLaRLx1S8BS5gv
         z+ghKH65GAYY95+VtLMn72hXT7a6tMxACtoCE5iRgwGV+VARiUG6uLbj76TaehwZKuTh
         Af0Q==
X-Gm-Message-State: AJIora9spkFvYfPVAWcT55Hse4p/Ck/1eNJsCGhomLxYG+5X7tdpXd1b
        grEr+vjIvlCfvJXkFlN1wp47ZQCgkvvPYsmhf8K26w==
X-Google-Smtp-Source: AGRyM1tIos9QwKkgJYgpyZPvWLGIscBdiV8ILrU+9gdWja+2sPZX0TL6Tt0r70dYd57E4qWcz1aDZxfoQQ4vgEsj0y8=
X-Received: by 2002:a2e:7019:0:b0:25d:4598:c827 with SMTP id
 l25-20020a2e7019000000b0025d4598c827mr13176731ljc.367.1657624203026; Tue, 12
 Jul 2022 04:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220630090926.15061-1-eugen.hristev@microchip.com>
In-Reply-To: <20220630090926.15061-1-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:26 +0200
Message-ID: <CAPDyKFo9fOYzS0Mugk2bf05-PanHhcdwMqG_PXPdVSr7A-rXmA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Karl Olsen <karl@micro-technic.com>
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

On Thu, 30 Jun 2022 at 11:09, Eugen Hristev <eugen.hristev@microchip.com> wrote:
>
> In set_uhs_signaling, the DDR bit is being set by fully writing the MC1R
> register.
> This can lead to accidental erase of certain bits in this register.
> Avoid this by doing a read-modify-write operation.
>
> Fixes: d0918764c17b ("mmc: sdhci-of-at91: fix MMC_DDR_52 timing selection")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Tested-by: Karl Olsen <karl@micro-technic.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 10fb4cb2c731..cd0134580a90 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -100,8 +100,13 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
>                                          unsigned int timing)
>  {
> -       if (timing == MMC_TIMING_MMC_DDR52)
> -               sdhci_writeb(host, SDMMC_MC1R_DDR, SDMMC_MC1R);
> +       u8 mc1r;
> +
> +       if (timing == MMC_TIMING_MMC_DDR52) {
> +               mc1r = sdhci_readb(host, SDMMC_MC1R);
> +               mc1r |= SDMMC_MC1R_DDR;
> +               sdhci_writeb(host, mc1r, SDMMC_MC1R);
> +       }
>         sdhci_set_uhs_signaling(host, timing);
>  }
>
> --
> 2.25.1
>
