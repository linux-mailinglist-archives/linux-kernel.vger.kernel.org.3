Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD64D8F90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbiCNW3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiCNW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:29:37 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB9FD1C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:28:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so22322857oot.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQWuqg+ddOw1oV88Ty6v00QRPKt0GAj8NU+qEDYWO1I=;
        b=DWIDuPdANPxggwyxysS41MKFKbgxS7fkRxBrxcq4WZhLsEOVoC/190qUjKO0WrcEz2
         HiK0siER3AD5sgCRTQNgQ8/N5EX2OLxSNRG5cZ0leQS9KUP9kapFMG+dof6VDruanClL
         hh8qFFy6AiVYFXWrs6N4xXfPTWx6g5ZU1zLrOgwulN+/ejxqi1Pv/GF3zKo/R1ZmghSX
         yPFU8OfhQva/95dcbXAVEdH9oDcVDxRUT02RDoqZa2FGx3TcjyjRG8U7wOki+KQLldGY
         XdcI2t/BkHas1esRbgo4ySE9bY98ZY1WelKEct+9PpPijyvyMOujB6o3CErj58wtXgEK
         C3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQWuqg+ddOw1oV88Ty6v00QRPKt0GAj8NU+qEDYWO1I=;
        b=RktqM66Wl09Buiiu+AB1Q/z4RO/ScKKoJTuYrOSVkQu4/U3iPRxQGbe3faMfAKCQbP
         Q+EI2ahYlQ2ctNBjM54OPPTf8nNm9PnFT1i7qOIxxxyJKb9GAYOzQvRsWfrBweM5P+dF
         AN+XNTveZg1reyM0QsT+RttVCfF0pG8CFIwPk/a8dzeKkRwzpGwYycGEy7FVYZmthjXq
         YJOmsVeBA4S2Mcjh5CdIC/1VOJ6y3ovohMiJOuC5g/1alRx3y64mT2SSaDQZemuBLF/2
         QWBHex9c8GieilnKeN82QJ9wiHw3ddaBUKVg5JcfyowDRw557eNapvNgy3FDyQutvMWe
         JIHQ==
X-Gm-Message-State: AOAM531VBTUBb1VtdTvPUZ0PZMN8QO/0DjSa0n2FWJW85z32poNcs7Ei
        q3CJ6m5JnGkIpAQ6NMfP9jy7Mw==
X-Google-Smtp-Source: ABdhPJwfNTLqkeOQnK1jvXc3XDq+dTSGGjbe07ZUKsKBp7CCf9AnvWDHI5pE6GufZ1uel/pwlnBIow==
X-Received: by 2002:a05:6870:17a1:b0:da:b3f:3258 with SMTP id r33-20020a05687017a100b000da0b3f3258mr512703oae.264.1647296905949;
        Mon, 14 Mar 2022 15:28:25 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id n128-20020a4a4086000000b0032118eda64bsm7991304ooa.38.2022.03.14.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:28:25 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:28:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org, robh+dt@kernel.or,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Julien STEPHAN <jstephan@baylibre.com>
Subject: Re: [PATCH v4 6/7] remoteproc: mtk-apu: Add support of MT8365
Message-ID: <Yi/Bh8CsB2bnE9Ca@builder.lan>
References: <20220304161514.994128-1-abailon@baylibre.com>
 <20220304161514.994128-7-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161514.994128-7-abailon@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Mar 10:15 CST 2022, Alexandre Bailon wrote:

> From: Julien STEPHAN <jstephan@baylibre.com>
> 
> This adds support of APU available in the MT8365.
> 
> Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/mtk_apu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
> index deec51b86ba5..57dd73c63d3f 100644
> --- a/drivers/remoteproc/mtk_apu.c
> +++ b/drivers/remoteproc/mtk_apu.c
> @@ -96,6 +96,24 @@ static const struct mtk_apu_conf mt8183_conf = {
>  	.clk_names = mt8183_clk_names
>  };
>  
> +static const char * const mt8365_clk_names[] = {
> +	"if_ck",
> +	"edma",
> +	"ahb",
> +	"axi",
> +	"ipu",
> +	"jtag",
> +	"smi_cam",
> +	"ifr_apu_axi",
> +};
> +
> +static const struct mtk_apu_conf mt8365_conf = {
> +	.core_default0 = BIT(26) | BIT(20),
> +	.core_default1 = BIT(3) | BIT(7),

Would it be possible to get some defines for these bits as well?

Thanks,
Bjorn

> +	.num_clks = ARRAY_SIZE(mt8365_clk_names),
> +	.clk_names = mt8365_clk_names
> +};
> +
>  static int mtk_apu_iommu_map(struct rproc *rproc, struct rproc_mem_entry *entry)
>  {
>  	struct mtk_apu_rproc *apu_rproc = rproc->priv;
> @@ -633,6 +651,7 @@ static int mtk_apu_rproc_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id mtk_apu_rproc_of_match[] = {
>  	{ .compatible = "mediatek,mt8183-apu", .data = &mt8183_conf },
> +	{ .compatible = "mediatek,mt8365-apu", .data = &mt8365_conf },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_apu_rproc_of_match);
> -- 
> 2.34.1
> 
