Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03420564960
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiGCSuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCSut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:50:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87192DCA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:50:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n15so8579516ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HodKenU2DqzSAsTr3GOaLCVqw1DOEowtMVHlqD3WUxM=;
        b=CVxzasIgMMg1pGWidgzNRAOOjqyXaih7Ino2F33/WtmphQ2G35DoChFRM2GMulF6qG
         RZeAkWgaTLNCKg04WDjgpCbQ20Rc+QdUSoL4H2KT/lPGaN3SWeahcaW/E92RnP/4/5mZ
         hEOElL2md1ExhXOjnTFhgp1nXv/pwQYqNUsr9glnz3YntmEndmlpmKHFSSgRXB9su2ed
         EHuUG7Cuba9c7Mhok5IO3HAh4jWKu2BLBrpxhwShteT5hzS4JqnHMj7tscuqtPZVBzu5
         BHoinNNJqzenJrVc2bLsA3h7Inj6bPR5xf0q3un0x/hCj1bUl/HihG7F6q+BmQ8veBuk
         uFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HodKenU2DqzSAsTr3GOaLCVqw1DOEowtMVHlqD3WUxM=;
        b=kiOLobjT959Y82KLxqt67immnPKGYSpdiQXuh80qHtf+61IFhpHD9q599CpmsjqJgs
         JVe1G0Y1jvUF/rIZG4DuxjUHlykdDSScwFKNJ81seFVNJg7uyc+whzU+P0kgwqKgyfOM
         VhTKqKK7Zf11n8dBGdC7nIvkLqAPHyC3P2OE1fJmo2NL3216QK/TlABEx4hL3s7Lgl2L
         ngd3tadctlh+OsGKvhxDgabnZQ52bg+QRug3nsxhnH7Pib+O8hXnP7XpRLhzRy/9o6vu
         nqPBPwIImQeK7d+naQldRSpbMYBYhjqrHxtXPMdMzf49ObIdW9iCPFsXwOWebvmif5kl
         2f3w==
X-Gm-Message-State: AJIora92M79I+DilpKoTv6FAo9RzFQ6w73EtRNL4uhilyX0Lt1mWhkq4
        yf5rlw/0UztpyxzoyurDESv0XAM0/Z4ts+hZKSU=
X-Google-Smtp-Source: AGRyM1txR24cjSx2T6SRyTgRrItDfRouegXb2R0VU95rLF87PA/vOL7GYszMuNNu6gRD1E1tnL2ZSA==
X-Received: by 2002:a05:651c:11c1:b0:25a:8968:b834 with SMTP id z1-20020a05651c11c100b0025a8968b834mr13980932ljo.212.1656874245240;
        Sun, 03 Jul 2022 11:50:45 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id p7-20020a05651238c700b0047f66294ff4sm4808396lft.151.2022.07.03.11.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 11:50:44 -0700 (PDT)
Message-ID: <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
Date:   Sun, 3 Jul 2022 20:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220702213724.3949-2-semen.protsenko@linaro.org>
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

On 02/07/2022 23:37, Sam Protsenko wrote:
> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
> of failed dma_capable() check.
> 
> The original code for this fix was suggested by Marek.
> 
> Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>

This is some tip specific tag, I don't think checkpatch allows it.
Either use suggesgted-by or co-developed-by + SoB.

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/iommu/exynos-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 71f2018e23fe..28f8c8d93aa3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (MMU_MAJ_VER(data->version) >= 5) {
> +		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
> +		if (ret) {
> +			dev_err(dev, "Unable to set DMA mask: %d\n", ret);

Missing cleanup: iommu_device_unregister
and probably also: iommu_device_sysfs_remove

> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * use the first registered sysmmu device for performing
>  	 * dma mapping operations on iommu page tables (cpu cache flush)


Best regards,
Krzysztof
