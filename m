Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223758C577
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiHHJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiHHJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:21:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2292701
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:21:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so11813336lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KbDeu52KPmgVgu/lw0Cv2B69kyTMziYKw+U1DuKuJDs=;
        b=WqwLYVk0xB8vhuj0dKOaK4G9IX3Xl8gM7IWXOndZUKRgBU619KUKKu1j+YI4WEv5z+
         KSha6lUp3LOO7XAEdX7FIAG8HGUftfNq7Yh5ijqv7QmKgpSP+lfBTj8EC4Dx6bJtS1Cr
         CKqvY9FJOuTXBkrHnbwN6nj2wZ/3RoaAbjEn7JCrMy9wd3V/OKHGF6J+leCEqTNR/8Bg
         YGqwLYSVq9QgUr05wdH9BBMIOAKF7Ppc70v4W76iD/9lTSLRb5v1gVSD/gjVxJt/cFuf
         uQeVaLIb/L2HxojDLZNenprZAlMKg+RvTHkJpAb4NEPQlQeGMj6OLhihgOnkOh4lmEYu
         QMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KbDeu52KPmgVgu/lw0Cv2B69kyTMziYKw+U1DuKuJDs=;
        b=PYsFm8g3ZYOZu6SgugNmoGBBYEE2URRwfRyDCd05LyETpsytUk2fk8h/t7E5R4MHhH
         pg8FUtqVfGqWubV51TDCcwad8t4lquVgGtFArpI3CR157bPOzIJkmYRpc5zV3v0u8rPl
         zIxlZ1Y1iVGPCAJ+p1pn+JEXgZsyGXngmwLXz11OwGeArzqBv+9S1i2HIuIOXSpGr8aq
         caXTVQe3c+KGERdVGhZsPUFtlZQ0KXYbmONRm6n6OXWBzk7RY0dSLYo111ngVOq8aLZP
         0PvudNKbnDOqY3MBraiW2OC1lCBo2qiAFKnrogWG2vVayYF5NPViyhw9VOnUVW0W2ZwI
         k4Iw==
X-Gm-Message-State: ACgBeo03PU8/f5Ca4AIenkHUVk2O8TJG81XIm/0+ZO/+2hhsaf/VwpjF
        Wh0LFYMSD5tysWr1/4ATwq8eJA==
X-Google-Smtp-Source: AA6agR4fDMob8SbCSrNCdZBei8wfMJcs9MEi4sll4cCqXkEGDBLdssLAhUGAwm8qqaga/vUu4R3NFQ==
X-Received: by 2002:ac2:5324:0:b0:48b:9643:3838 with SMTP id f4-20020ac25324000000b0048b96433838mr3907673lfh.373.1659950458721;
        Mon, 08 Aug 2022 02:20:58 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8249000000b0025e66a771efsm1294660ljh.136.2022.08.08.02.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:20:57 -0700 (PDT)
Message-ID: <9fd7fcfd-16fb-0f3a-238d-bd6f97026277@linaro.org>
Date:   Mon, 8 Aug 2022 12:20:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] mmc: sdhci-xenon: Try to fix 2G address limitation on
 AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
 <20220806085818.9873-3-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806085818.9873-3-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 11:58, Vadym Kochan wrote:
> There is a limitation on AC5 SoC that Xenon SDHC can address only
> first 2GB of memory. Turning to the SDMA mode to use the bounce_buffer
> causes ext_csd recognition to fail on init.
> 
> Using of swiotlb=force also does not help as it is allocated at the
> end of the memory.
> 
> So it was decided to use reserved-memory as a bounce buffer in case
> if the board has more than 2G of memory, or turn on the PIO
> mode if such memory region does not exist in the device-tree.
> 
> It was tested that this approach is 1.5 times faster than PIO.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 08e838400b52..fbbd1a045002 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -14,8 +14,10 @@
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -486,6 +488,31 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>  	xenon_disable_sdhc(host, sdhc_id);
>  }
>  
> +static int xenon_ac5_probe(struct sdhci_host *host)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct sysinfo si;
> +	int err;
> +
> +	si_meminfo(&si);
> +
> +	if ((si.totalram * si.mem_unit) > SZ_2G) {
> +		struct device_node *dma_bounce_np;
> +
> +		dma_bounce_np = of_parse_phandle(dev->of_node,
> +						 "marvell,ac5-sdhci-dma-bounce-pool", 0);

No. Undocumented property. Please document all bindings, not only pieces.

> +		err = of_reserved_mem_device_init_by_idx(dev, dma_bounce_np, 0);
> +		of_node_put(dma_bounce_np);
> +		if (err) {
> +			dev_warn(dev, "Disabling DMA because of 2GB DMA access limit and missing DMA bounce region\n");
> +			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -531,6 +558,12 @@ static int xenon_probe(struct platform_device *pdev)
>  			if (err)
>  				goto err_clk;
>  		}
> +
> +		if (of_device_is_compatible(dev->of_node, "marvell,ac5-sdhci")) {

Don't code compatible comparing in the driver. This is done by matching,
only once. You should use driver data/variant type.

> +			err = xenon_ac5_probe(host);
> +			if (err)
> +				goto err_clk_axi;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
> @@ -570,6 +603,7 @@ static int xenon_probe(struct platform_device *pdev)
>  	pm_runtime_put_noidle(&pdev->dev);
>  	xenon_sdhc_unprepare(host);
>  err_clk_axi:
> +	of_reserved_mem_device_release(&pdev->dev);
>  	clk_disable_unprepare(priv->axi_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> @@ -591,6 +625,7 @@ static int xenon_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 0);
>  
>  	xenon_sdhc_unprepare(host);
> +	of_reserved_mem_device_release(&pdev->dev);
>  	clk_disable_unprepare(priv->axi_clk);
>  	clk_disable_unprepare(pltfm_host->clk);
>  
> @@ -682,6 +717,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},

It's not the same.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);


Best regards,
Krzysztof
