Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA09571F96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiGLPjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiGLPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:39:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83CB93FA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:39:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712153907euoutp0299b40403788443093e6c30e52647042b~BHx0jITJI3017630176euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:39:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712153907euoutp0299b40403788443093e6c30e52647042b~BHx0jITJI3017630176euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657640347;
        bh=d0eRr0tejRZv6hF5ccPDmr9RC5rKrMnTUtD6fgci4PM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=uqK4sMEcJPKvKh1EVxIiA2fUc8LnAIYfCLY5DEFWWD338nT4OJXMpLyPz6F7v8z9M
         nR+fYSatxkuCKwZDwn573AZuZtn3kvrFlTLk+x1L9GxSp5aVwTLNLF5UO2Liyz/cse
         ObL3tmgX4A/tStuJ+6BM/kofSbavG1nSVx5fRQ9A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712153907eucas1p296c57de710aeacbbf5215b3629e004d7~BHx0RcGjL0332103321eucas1p2q;
        Tue, 12 Jul 2022 15:39:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 55.4E.10067.B959DC26; Tue, 12
        Jul 2022 16:39:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712153907eucas1p286b90f05f585c68c4779756b8aaac69d~BHxz5PuQ70334303343eucas1p21;
        Tue, 12 Jul 2022 15:39:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712153907eusmtrp178f3a10f86a5f32085f0ed115339583c~BHxz4UgsJ1145811458eusmtrp1T;
        Tue, 12 Jul 2022 15:39:07 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-18-62cd959b647b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FB.0F.09095.B959DC26; Tue, 12
        Jul 2022 16:39:07 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220712153906eusmtip15175d2da5d6dad91e6452c72bea42a97~BHxzJ49az2817228172eusmtip19;
        Tue, 12 Jul 2022 15:39:06 +0000 (GMT)
Message-ID: <f847f665-f374-9b28-124a-abc6f0372db7@samsung.com>
Date:   Tue, 12 Jul 2022 17:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/7] iommu/exynos: Reuse SysMMU constants for page
 size and order
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220710230603.13526-2-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87qzp55NMli1Ss5iQkcrk8WvLxYW
        m+cUW3TO3sBusff1VnaLTY+vsVpc3jWHzWLG+X1MFv96DzJaHPzwhNXieR+Qe+ruZ3aL4+8f
        M1q03DF14PN4cnAek8eaeWsYPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uPF5pmMHn1bVjF6
        fN4kF8AVxWWTkpqTWZZapG+XwJVx78cxxoId/BXNW6ewNDAe5Oli5OSQEDCR2Nj/l72LkYtD
        SGAFo0TT+sVsEM4XRomGD29YIJzPjBIX+58xw7QsObcCKrGcUWLJ8uOsEM5HRoktUy+wgVTx
        CthJrL/dyw5iswioShyb95oJIi4ocXLmExYQW1QgWeLc2atg9cICURJXn38Hq2EWEJe49WQ+
        mC0ikCZx9d99sAXMAjuYJb7OuQnWzCZgKNH1tgusmVPAQWLmxQ3sEM3yEtvfzmEGaZAQWM0p
        sbhtLhPE3S4S0y70skLYwhKvjm9hh7BlJE5P7gEaygFk50v8nWEMEa6QuPZ6DdTL1hJ3zv1i
        AylhFtCUWL9LHyLsKPHgyA92iE4+iRtvBSEu4JOYtG06M0SYV6KjTQiiWk1i1vF1cDsPXrjE
        PIFRaRZSoMxC8vwsJL/MQti7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmDCO/3v
        +JcdjMtffdQ7xMjEwXiIUYKDWUmE98/ZU0lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQK
        CaQnlqRmp6YWpBbBZJk4OKUamDzqPCRnNMdZHdpmIWfoYHbKeHX/0+M6bZ47Lhtkrsvymb9Z
        +GTZ/2efH6mU/5n57Vko86PJZdVWNpzsJzPu9MrWhk/ifP1rRZL48Yv7pSOV9K1/nDu5IiWC
        adHLKYJThaXb/Jmb1+3MyhNjej33HW/6smNTL3xf2L1tSa19m+/MC6tLoyJmepXdZTLU2uXH
        viSI2egLP+fLRGc/hxveDxsm7m2eEXFla6zv7ccrcpdxGk7Xea35bF+o36c9rOvk98tMWba/
        f4JMCd/3NhH9JafY0yxadpXyaU3mm2ZyJ72b4XtDsG+A96xXVjdbah4I7p/tw3ii7VJqZ6jr
        m41STIGXnrRfqtvGmTn3mbRmhBJLcUaioRZzUXEiAPAYzdfnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7qzp55NMpjdw2IxoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Mu49+MYY8EO/ormrVNYGhgP8nQxcnJICJhILDm3gqWLkYtDSGApo8Sfp+dZIBIyEienNbBC
        2MISf651sUEUvWeUeDKngx0kwStgJ7H+di+YzSKgKnFs3msmiLigxMmZT8AGiQokSzRvOQQW
        FxaIkpj7ZycbiM0sIC5x68l8sLiIQJrEvkmvGUEWMAvsYpboaXsFddJJRonfO9vANrAJGEp0
        ve0C6+YUcJCYeXEDO8QkM4murV2MELa8xPa3c5gnMArNQnLILCQLZyFpmYWkZQEjyypGkdTS
        4tz03GJDveLE3OLSvHS95PzcTYzAON927OfmHYzzXn3UO8TIxMF4iFGCg1lJhPfP2VNJQrwp
        iZVVqUX58UWlOanFhxhNgaExkVlKNDkfmGjySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
        UrNTUwtSi2D6mDg4pRqYekN06z7sZPgVePbkBKYt4ic49j4O+3n143SjtujPq3l/MVuVtjbe
        sDoz27Se8fzNFfLLzJ3c2w4HG2QdeCi9dwoX444Nilc8b0e/Tzj10fmKTubPD3qBPKaty9fJ
        mNnnifbc2sHwlsFx/r02rdP3WY5a9rL5Pv3Xu9XnccGcQvMww8Smddxb7WJ2hZl+XTd/z4Vj
        D/fGHpa9vfTClzq38LLLjouO5ilHuKzNeWOppDn7ydy/27SXfNLSW8Kzo4CdJ/V2UcHvh6b1
        EV1PPIzVOTpT/7Pz5kRwhl70mH5v+4K30Ye/uFd91QjdonBG8Crn/J6SbG5e1obUPu+nX11i
        U/jOXl/byr791uKqxHm9SizFGYmGWsxFxYkAwQf4BXwDAAA=
X-CMS-MailID: 20220712153907eucas1p286b90f05f585c68c4779756b8aaac69d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220710230612eucas1p1ccf9ad3301b653134479432dfb7c08fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220710230612eucas1p1ccf9ad3301b653134479432dfb7c08fa
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
        <CGME20220710230612eucas1p1ccf9ad3301b653134479432dfb7c08fa@eucas1p1.samsung.com>
        <20220710230603.13526-2-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.07.2022 01:05, Sam Protsenko wrote:
> Using SZ_4K in context of SysMMU driver is better than using PAGE_SIZE,
> as PAGE_SIZE might have different value on different platforms. Though
> it would be even better to use more specific constants, already existing
> in SysMMU driver. Make the code more strict by using SPAGE_ORDER and
> SPAGE_SIZE constants.
>
> It also makes sense, as __sysmmu_tlb_invalidate_entry() also uses
> SPAGE_* constants for further calculations with num_inv param, so it's
> logical that num_inv should be previously calculated using also SPAGE_*
> values.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Changes in v2:
>    - (none) This patch is new and added in v2
>
>   drivers/iommu/exynos-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 79729892eb48..8f80aaa35092 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -340,7 +340,7 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
>   	if (MMU_MAJ_VER(data->version) < 5)
>   		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
>   	else
> -		writel(pgd / SZ_4K, data->sfrbase + REG_V5_PT_BASE_PFN);
> +		writel(pgd >> SPAGE_ORDER, data->sfrbase + REG_V5_PT_BASE_PFN);
>   
>   	__sysmmu_tlb_invalidate(data);
>   }
> @@ -550,7 +550,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
>   		 * 64KB page can be one of 16 consecutive sets.
>   		 */
>   		if (MMU_MAJ_VER(data->version) == 2)
> -			num_inv = min_t(unsigned int, size / SZ_4K, 64);
> +			num_inv = min_t(unsigned int, size / SPAGE_SIZE, 64);
>   
>   		if (sysmmu_block(data)) {
>   			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

