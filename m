Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D102581874
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGZRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:37:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E52AE18;
        Tue, 26 Jul 2022 10:37:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q16so13733472pgq.6;
        Tue, 26 Jul 2022 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AMZH1Bi4Qy5iLZG3QxNgW8QD2bR06SffT7rLHaWOqfM=;
        b=pUB6vuPwJAhe15bl2qYv7Xe9gsT4I6NmjqKg30xPjQtUWc4ooZjLa2JJWl4Y7JIF6S
         EA3DCBgEU/puzXFs6eoPhMIfcTW8PFY8tG+kvdgaDs89e/+V8IdEpGF9BhL81exLirmB
         7RVdZN4gjHEid05iU3H5JaAjtiCCWvM0RUCSV8fZOb3x3+baVNL1cSKY4/JkBXZ/+bG2
         aKW+3nXKlUU4CkmL7yGWs3YaSr+IvfdrBzGGTu8VuA5gVlG5vncgKCLz9/Ixeab/+GfG
         MKrRwysGOF6aOULNabsBAFcjrZw3QDX0CAIbgD+uYCzCbeU5KsfvmGnEcAugvDzanieC
         2ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AMZH1Bi4Qy5iLZG3QxNgW8QD2bR06SffT7rLHaWOqfM=;
        b=bFQaIRPpE0lK2WLdx83It1JKjiR3UqDp17cPBOVHi28QvBhI9T4hM5EovYhHTqkgqe
         YTTu/dkfrTn/ImmX8ndFBYp4y5HqGL8yzKdi9/bP8ooCVrtbIhEz2gLsxbg/pb1Xyr64
         zRup/w6pQ4k5Br9klak66dZc8HMNydrfPDESF3/F8cR0O9WvMu/CD0AShDncWU0st+By
         WhFlnujamwxelyJ0+8npdXUtirlcebYSc9RoAI1P7SN/cn9mrdhV2I6wIduk80Tqx9V/
         jnDyb1vpSMVsCbEZulHOSvTASGDozdQ9Bc8AVK70TtLMw8yq1LzhruI4mHt4QPRMQP6U
         444A==
X-Gm-Message-State: AJIora/mR4pRyjE3YWroX6y+RUMHC6rWh4JESGqjBIetSbe8XiSGs7xR
        VVtuOxXaUVe8x9krWW45K1U=
X-Google-Smtp-Source: AGRyM1tCFuqPdEnD+0ZwYrW/qrprDDsJmyK/Z1ehMdPDBhBhQx75Qv95gifiNh1V1RoRDQbTPAaVlA==
X-Received: by 2002:a63:d345:0:b0:419:d863:3c8d with SMTP id u5-20020a63d345000000b00419d8633c8dmr15250987pgi.168.1658857068482;
        Tue, 26 Jul 2022 10:37:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f17-20020a17090ace1100b001f0f132da9fsm11189030pju.5.2022.07.26.10.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:37:47 -0700 (PDT)
Message-ID: <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
Date:   Tue, 26 Jul 2022 10:37:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220726170711.30324-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 10:07, Vadym Kochan wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> There is a limitation on AC5 SoC that mmc controller
> can't have DMA access over 2G memory.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 08e838400b52..666d06b58564 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -18,6 +18,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/mm.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 sdhc_id, nr_sdhc;
>  	u32 tuning_count;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sysinfo si;
>  
>  	/* Disable HS200 on Armada AP806 */
>  	if (priv->hw_version == XENON_AP806)
> @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
>  	}
>  	priv->tuning_count = tuning_count;
>  
> +	si_meminfo(&si);
> +
> +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {

Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?

Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.



> +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> +	}
> +
>  	return xenon_phy_parse_params(dev, host);
>  }
>  
> @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);


-- 
Florian
