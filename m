Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DC571FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGLPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGLPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:40:28 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32773B9D86
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:40:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220712154026euoutp01a3f6efabc7bbb315a0016cf13cf0049f~BHy9ZSzJ81921719217euoutp01y
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220712154026euoutp01a3f6efabc7bbb315a0016cf13cf0049f~BHy9ZSzJ81921719217euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657640426;
        bh=TUO+DO9jnZzlF7cFIVzUSgXYJXa5dsygivVMaxzzNJo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=PVwrNQ78W35bb+hbLMMGs1CQcVWzBEF4ZDeIwAGiJV22P9pt6bBFfoV0Yc0fU9waG
         GVOhRMDaFfrFQxKbQhWcT5t1nqEO6BJGMRytZnji5bytoPZZLSQqzR8xMBmLRoX9M9
         bMl+Mxs94YSxG9Jks2Cka7QmGwLoYIZzfXPVu4YQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220712154025eucas1p1f1951ae93826a46cc9f7cad7021cc9d1~BHy88bDfo2470724707eucas1p1o;
        Tue, 12 Jul 2022 15:40:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.7E.10067.9E59DC26; Tue, 12
        Jul 2022 16:40:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220712154024eucas1p10429e06f93be2e3d19ebbb64e3e10419~BHy8QzS682469724697eucas1p1c;
        Tue, 12 Jul 2022 15:40:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712154024eusmtrp2218a7ea2efa085911d4fac60c77913a8~BHy8PvKIb0630506305eusmtrp2I;
        Tue, 12 Jul 2022 15:40:24 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-cc-62cd95e9ee98
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.9E.09038.8E59DC26; Tue, 12
        Jul 2022 16:40:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712154024eusmtip22427e078312d378ec38714a3663aee18~BHy7iCOyx3160031600eusmtip2Q;
        Tue, 12 Jul 2022 15:40:24 +0000 (GMT)
Message-ID: <6ec2aa42-2470-5f16-0017-485771d80d20@samsung.com>
Date:   Tue, 12 Jul 2022 17:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/7] iommu/exynos: Handle failed IOMMU device
 registration properly
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
In-Reply-To: <20220710230603.13526-3-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87ovp55NMuj7IW0xoaOVyeLXFwuL
        zXOKLTpnb2C32Pt6K7vFpsfXWC0u75rDZjHj/D4mi3+9BxktDn54wmrxvA/IPXX3M7vF8feP
        GS1a7pg68Hk8OTiPyWPNvDWMHjtn3WX3WLCp1GPTqk42jzvX9rB5bF5S7/Fi80xGj74tqxg9
        Pm+SC+CK4rJJSc3JLEst0rdL4Mr4/3cZc0E3d8Xzrd3sDYzNnF2MnBwSAiYSXyb0MXUxcnEI
        CaxglPg/dzcrhPOFUWLHhe/MEM5nRonpf9+ydTFygLV0tgqDdAsJLGeUeL5CH6LmI6PEtq3n
        WUESvAJ2EhsOXGcHsVkEVCWeHTgEFReUODnzCQuILSqQLHHu7FU2EFtYIEZiy7peZhCbWUBc
        4taT+UwgtohAmsTVf/fBLmIW2MEs8XXOTbBmNgFDia63XWDNnAIOElePvIdqlpfY/nYO2NUS
        Aus5JR7sm8cE8aiLxOUHfWwQtrDEq+Nb2CFsGYn/O0G2gXyWL/F3hjFEuELi2us1zBC2tcSd
        c7/AnmcW0JRYv0sfotpRYkJHAITJJ3HjrSDEAXwSk7ZNZ4YI80p0tAlBzFCTmHV8HdzKgxcu
        MU9gVJqFFCazkPw+C8krsxDWLmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY6k7/
        O/5lB+PyVx/1DjEycTAeYpTgYFYS4f1z9lSSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2J
        QgLpiSWp2ampBalFMFkmDk6pBqbI/+2pR0VWq5Z1ap1JXq3KLJoYk+dsn5Bt9Hv/rCe3Ojy+
        i2u/8Zy2UuzOh9rpvgl88j8PXJ9ht4FzSf7tRPlV2ZOtbS4l8r54c3yGRuQZy165ig3T+Zy3
        czD/vVd7d35ZSYsN8wbDCSz2pZu8T01nfDvx6PeAXVsPdSnH3d904ZZdZvY00UlzI/Zs8Pw+
        qaHos2vL4Uvek9izHdTEtLSErzH8K38eGDHr9S2peTP+xTVI5D7d5lCvZT3X7J4S20Mpf6tJ
        vPe++ohqfbkyT3LN2kDtqc4Gk/54fPs9ebXC5rzs+oOfJz8T1LHruTdd+MMlmfez1b+Xmymr
        TxR5K3Yy/UBa4GPt3mKDz3n7rd8qsRRnJBpqMRcVJwIANzRk+OQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7ovpp5NMnh7Rd9iQkcrk8WvLxYW
        m+cUW3TO3sBusff1VnaLTY+vsVpc3jWHzWLG+X1MFv96DzJaHPzwhNXieR+Qe+ruZ3aL4+8f
        M1q03DF14PN4cnAek8eaeWsYPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uPF5pmMHn1bVjF6
        fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJfx/+8y5oJu7ornW7vZGxibObsYOTgkBEwkOluFuxi5OIQEljJKHG3cztbFyAkUl5E4Oa2B
        FcIWlvhzrYsNoug9o8TWnbPBErwCdhIbDlxnB7FZBFQlnh04BBUXlDg58wkLiC0qkCzRvOUQ
        E4gtLBAjsWVdLzOIzSwgLnHryXywuIhAmsS+Sa8ZQRYwC+xiluhpe8UCse0ko8Spz5fBNrAJ
        GEp0ve0CO49TwEHi6pH3UJPMJLq2djFC2PIS29/OYZ7AKDQLySGzkCychaRlFpKWBYwsqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQKjfNuxn1t2MK589VHvECMTB+MhRgkOZiUR3j9nTyUJ
        8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5HxgmskriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamCyq721+neqtseEhzYTO59s0rf8LmTxwVL/7roCwfVs1WLmOz9L
        tH6yZjzk96XZy+6Ab5SBhbaYp1VxcNeqvIifvY+3W3DuLHwY9dh32adS/csn1l1yXNCxxGJ+
        ZMSE6YERjQc95rLHFLjGKE8+xs++jv9U1uk83dbkTLnyPMlfc18WC99rql41eX+ELfutkqdr
        bn7Y1fb3aobMY94ISX+Lby8NHLb3uGQoztz40rf/y3Ym1a+79x9yXbhyScjhnotLZh7yes+1
        Pi9IeJ4x0475F2uSI/1btmzS3BnDzlWgpHnawno7z5F5pzP4jl7l/91gp3dWNiFhe+ynO0sk
        5lbPZLhwUaPizb2XD+uzL91SYinOSDTUYi4qTgQAJEG5KXsDAAA=
X-CMS-MailID: 20220712154024eucas1p10429e06f93be2e3d19ebbb64e3e10419
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220710230613eucas1p14dafab5ac0b7c2e8e69d7b60e98c9d14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220710230613eucas1p14dafab5ac0b7c2e8e69d7b60e98c9d14
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
        <CGME20220710230613eucas1p14dafab5ac0b7c2e8e69d7b60e98c9d14@eucas1p1.samsung.com>
        <20220710230603.13526-3-semen.protsenko@linaro.org>
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
> If iommu_device_register() fails in exynos_sysmmu_probe(), the previous
> calls have to be cleaned up. In this case, the iommu_device_sysfs_add()
> should be cleaned up, by calling its remove counterpart call.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changes in v2:
>    - (none) This patch is new and added in v2
>
>   drivers/iommu/exynos-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 8f80aaa35092..c85db9dab851 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -629,7 +629,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   
>   	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
>   	if (ret)
> -		return ret;
> +		goto err_iommu_register;
>   
>   	platform_set_drvdata(pdev, data);
>   
> @@ -656,6 +656,10 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	pm_runtime_enable(dev);
>   
>   	return 0;
> +
> +err_iommu_register:
> +	iommu_device_sysfs_remove(&data->iommu);
> +	return ret;
>   }
>   
>   static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

