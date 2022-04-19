Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C7507D17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358429AbiDSXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358421AbiDSXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:13:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433E2CC8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:10:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d9so168529qvm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqRJfE9wcxy/J31E/EGSuMmVa/+tMH9w0KWrjCNItEs=;
        b=Lq9P2L3c2nv2ArDspJSfMNUzfpZpnfo8tq6OIHQlEvfH4Tmd1hklwyZEJk/fF4JCyE
         L496nczWfywcca2n+zz298hZ2WpckS2BclllYcsf2Dwa1bUkxVpbafDTUdlNipAc0iAC
         ADWwmZ9lRQJ8DNlcruObZH7mt25t1VagS6bRJX3D18FJZ63KB4w5wtx4W5+AMakVV997
         s5qVrDO62GwSFXQ92AEHktII+39ta3oK0+WOrg0teoL/PPOsLofmcczCTZN2n3HL9jlW
         uzUTqJ5HFipcfZTYrYRviFRGHORfguhOrrSS4Jd/Z5Jxr1iWlZ8I8p/YufoX7NVASe8T
         mynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqRJfE9wcxy/J31E/EGSuMmVa/+tMH9w0KWrjCNItEs=;
        b=nWijrxQn7rK1LLbRx3VIpm07k4SnuKsEHwClNXMlFNQO4En/n49t3us1aV+Evg62vm
         LN6pk6w5uRVQwncN/69+JN+DTOYWoTtKS6N1Cd/AgWh5vor/55+jDSvsNdfSe1uQRyaY
         vy6jiwM1Nu5mR/hxhsgJ8A8luFUvRBlfD/WoTmvCPekDBvYki86pVEYoYO4Hu2NcHQwD
         LpSU8MWmvjCcPIAg+4wTsuGehBMow5iPh9G4pzggEUi8wfB9GgUrv5fhUTBmDXAwd2YK
         OGrsjqnmQr5BG8aRMfiEbCe1GvzupgqRJcTQyFFVozKWqCZvB/QsDhlZDloV5fBrBukM
         y1QQ==
X-Gm-Message-State: AOAM5317kRbUldOnMKOcs0QQHhC0TTMNUuUZnrSlhg4+WC24KKfYl/KO
        pGIAa29El7Do/VzphnXuBgRjWw==
X-Google-Smtp-Source: ABdhPJxjyWezaqzPwLzIfphtO9gz87De0TwN3le3tUOtbPKBMtK7d2Kl55kLcz08VPBnyPF7JgxmXA==
X-Received: by 2002:a05:6214:2aaf:b0:446:70be:8377 with SMTP id js15-20020a0562142aaf00b0044670be8377mr4632304qvb.105.1650409836152;
        Tue, 19 Apr 2022 16:10:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a152300b0069ec409e679sm673684qkk.48.2022.04.19.16.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 16:10:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ngwzS-005iPf-Hz; Tue, 19 Apr 2022 20:10:34 -0300
Date:   Tue, 19 Apr 2022 20:10:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
        baolu.lu@linux.intel.com, fenghua.yu@intel.com,
        rikard.falkeborn@gmail.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix size calculation in
 arm_smmu_mm_invalidate_range()
Message-ID: <20220419231034.GP64706@ziepe.ca>
References: <20220419210158.21320-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419210158.21320-1-nicolinc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:01:58PM -0700, Nicolin Chen wrote:
> The arm_smmu_mm_invalidate_range function is designed to be called
> by mm core for Shared Virtual Addressing purpose between IOMMU and
> CPU MMU. However, the ways of two subsystems defining their "end"
> addresses are slightly different. IOMMU defines its "end" address
> using the last address of an address range, while mm core defines
> that using the following address of an address range:
> 
> 	include/linux/mm_types.h:
> 		unsigned long vm_end;
> 		/* The first byte after our end address ...
> 
> This mismatch resulted in an incorrect calculation for size so it
> failed to be page-size aligned. Further, it caused a dead loop at
> "while (iova < end)" check in __arm_smmu_tlb_inv_range function.
> 
> This patch fixes the issue by doing the calculation correctly.
> 
> Fixes: 2f7e8c553e98d ("iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -	size_t size = end - start + 1;
> +	size_t size;
> +
> +	/*
> +	 * The mm_types defines vm_end as the first byte after the end address,
> +	 * different from IOMMU subsystem using the last address of an address
> +	 * range. So do a simple translation here by calculating size correctly.
> +	 */
> +	size = end - start;

I would skip the comment though

Jason
