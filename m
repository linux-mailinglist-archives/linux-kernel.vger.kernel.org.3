Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4361C480B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhL1Q6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhL1Q6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCFC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x21so42645176lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJ2UCTOdHZ1mWOou8w5B04IVAeeeJIqBvX9nSk3ClqQ=;
        b=SWJ2Hna+Zx0qaSG8FksPVfe8GzT41+58Zl7EihJQ0yEGRg0IyryEJbQJwf7hx4ZSPO
         Mpr2QJGKNoZsF3zyxYbGZ6pRFlkekadHQsYzEe5ez4RV4K/OC0bwMXr71tSqjQlccOPv
         pe+AJLpJOQyKMtKH4hIN4SiDVHndl6zRGorQuwm/A0EVRa5LKHazQcnB7gtDJZry67M8
         PHTtoUMPo4W+brLzd9KwXP+vJH4rgmNdSKT/8QCnGrthpmzUszsXumlm8phWThohlwNy
         ixfhTCQjQG0a3V7YlALyI5hrZoYBX81wH01iO2yrK5Nk6aFm6sN23NfS2Bj7nSfT1DWi
         e8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJ2UCTOdHZ1mWOou8w5B04IVAeeeJIqBvX9nSk3ClqQ=;
        b=V819zzrzRBLg9qQaCjord/V3aAxZ/KmAP5tsoXmmUwILvmPU7OTIVY0N6I6m96YCfr
         /NB2l+OyFIK0SF7p2Vmjj1125w097XFMWcha7uSDnFo3tX4mWlRjSedzjYDmtAzlFssZ
         BLkvdxrV9O+dzo+NbzrPTuU0hJA/TJpG6/dBb7gO2r+aTM6/o4iRDODwBfHh6cyNVZF1
         mGoVsiBr1q7l6gYMVO24nJelbTkntvfbkuhrVyUj1+nZp+XGRRUdCJu4alK3VDloNk1y
         iTUhbl1kV+j0wmY6ZqOktDGuvWFDdc2BZk4qlaHlYwAbFCTAn+jB7mOt8XD9PiVC1Mvz
         +9Jg==
X-Gm-Message-State: AOAM533iwLcH3DKUCJe3ybfex5VajA/h8r94HQMuhZT7auxBBCehW4wB
        T9F9UZObGuC81aOEcq3MZViGHiXWMt53cVToGgxRXA==
X-Google-Smtp-Source: ABdhPJzYWvZcshY2MB9EFYsPiJxSD+LRfRy9Mzdvq2XmNz9OcxVwVMzoyqJJK4f3ZhxQaPfqf4O+91KOCSHNNQYSs/Q=
X-Received: by 2002:a19:5019:: with SMTP id e25mr20271955lfb.254.1640710698232;
 Tue, 28 Dec 2021 08:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com> <20211216125748.179602-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20211216125748.179602-5-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:57:41 +0100
Message-ID: <CAPDyKFpX7_EfnDup-ZvG=9H36Ok3tvnBdS_Q+e4RcAYMN1K_KQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mmc: mtk-sd: Assign src_clk parent to src_clk_cg for
 legacy DTs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 13:57, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In commit 3c1a88443698 ("mmc: mediatek: add support of source_cg clock")
> an independent cg was introduced to avoid a hardware hang issue during
> clock mode switches (subsequent commits will set that clock as optional).
>
> When this clock is not present in device-tree, any operation is being
> done on src_clk's parent (calling clk_get_parent()): to simplify this
> and avoid checking for src_clk_cg presence everytime, just assign the
> parent clock to src_clk_cg and remove the now useless checks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

The series applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 59d7decc3051..65037e1d7723 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -901,14 +901,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 }
>         }
>         sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
> -       /*
> -        * As src_clk/HCLK use the same bit to gate/ungate,
> -        * So if want to only gate src_clk, need gate its parent(mux).
> -        */
> -       if (host->src_clk_cg)
> -               clk_disable_unprepare(host->src_clk_cg);
> -       else
> -               clk_disable_unprepare(clk_get_parent(host->src_clk));
> +
> +       clk_disable_unprepare(host->src_clk_cg);
>         if (host->dev_comp->clk_div_bits == 8)
>                 sdr_set_field(host->base + MSDC_CFG,
>                               MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> @@ -917,11 +911,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 sdr_set_field(host->base + MSDC_CFG,
>                               MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
>                               (mode << 12) | div);
> -       if (host->src_clk_cg)
> -               clk_prepare_enable(host->src_clk_cg);
> -       else
> -               clk_prepare_enable(clk_get_parent(host->src_clk));
>
> +       clk_prepare_enable(host->src_clk_cg);
>         readl_poll_timeout(host->base + MSDC_CFG, val, (val & MSDC_CFG_CKSTB), 0, 0);
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>         mmc->actual_clock = sclk;
> @@ -2530,6 +2521,19 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
>         if (IS_ERR(host->src_clk_cg))
>                 return PTR_ERR(host->src_clk_cg);
>
> +       /*
> +        * Fallback for legacy device-trees: src_clk and HCLK use the same
> +        * bit to control gating but they are parented to a different mux,
> +        * hence if our intention is to gate only the source, required
> +        * during a clk mode switch to avoid hw hangs, we need to gate
> +        * its parent (specified as a different clock only on new DTs).
> +        */
> +       if (!host->src_clk_cg) {
> +               host->src_clk_cg = clk_get_parent(host->src_clk);
> +               if (IS_ERR(host->src_clk_cg))
> +                       return PTR_ERR(host->src_clk_cg);
> +       }
> +
>         host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
>         if (IS_ERR(host->sys_clk_cg))
>                 host->sys_clk_cg = NULL;
> --
> 2.33.1
>
