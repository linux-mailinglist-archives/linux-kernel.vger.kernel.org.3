Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE8595BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiHPMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiHPMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:40:03 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216298A45
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:40:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816123959euoutp01875ba28ff5209928866b4ca472643d2f~L06ZuXQqE2526825268euoutp013
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:39:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816123959euoutp01875ba28ff5209928866b4ca472643d2f~L06ZuXQqE2526825268euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660653599;
        bh=5Rklz+Aute3hqx8i9JUavBWc7HnAFeM5FiWnv6pEVdg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=CIS+s34lgzY/fd9kZDBZZEAqbwOQizV49RR0a3OOF5k4qFv1rIBd2J9dAaT/Axhp3
         dRUS0bxvM/JESBA7JP4E72TeGRLM1bhF1Q1ii7ecbt1O4i+60HG0pW4flrJABrD24t
         ssVCaHd2fGoLD7dhL+nwlctaIZOyuPwBzNsfMHgw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816123959eucas1p27dbd1f66b04507065a9213a255969fff~L06Zf3JHx0995209952eucas1p2K;
        Tue, 16 Aug 2022 12:39:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.ED.09580.F109BF26; Tue, 16
        Aug 2022 13:39:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015~L06ZORZ7g2879328793eucas1p1I;
        Tue, 16 Aug 2022 12:39:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816123958eusmtrp16689812fd9270d5ad8ed84b9a51fee6b~L06ZNiCMu1484914849eusmtrp1J;
        Tue, 16 Aug 2022 12:39:58 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-a9-62fb901fd29c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.4B.09038.E109BF26; Tue, 16
        Aug 2022 13:39:58 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220816123958eusmtip17a3d72aeec46d253ca3c2a73a978774b~L06Y0Az600837908379eusmtip1G;
        Tue, 16 Aug 2022 12:39:58 +0000 (GMT)
Message-ID: <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com>
Date:   Tue, 16 Aug 2022 14:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>, akpm@linux-foundation.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzneV35Cb+TDBb3s1nMWb+GzWLT42us
        Fpd3zWGzuLfmP6vF/oULGR1YPTZ9msTucWLGbxaPnQ8tPTYvqff4vEkugDWKyyYlNSezLLVI
        3y6BK2PxyW7mgoNSFV93nmBpYLwp2sXIySEhYCJxfeFG9i5GLg4hgRWMEodO3GMHSQgJfGGU
        WHLVCiLxmVHiybGPrF2MHGAdTd+VIOLLGSUaJvQwQzgfGSX2f77BCNLNK2AnsWLFA2YQm0VA
        VWLH5BtMEHFBiZMzn7CA2KICyRLP/i8G2yYsECJxZX4PWA2zgLjErSfzmUCGighMY5T4fHo2
        G0TCROJ+60NWEJtNwFCi620XWJxTwEvi88xnjBA18hLb384Bu0hC4AyHRPex46wQj7pILPr9
        jg3CFpZ4dXwLO4QtI3F6cg8LxGv5En9nGEOEKySuvV7DDGFbS9w594sNpIRZQFNi/S59iGpH
        iU/H5CFMPokbbwUhDuCTmLRtOjNEmFeio00IYoaaxKzj6+BWHrxwiXkCo9IspDCZheT3WUhe
        mYWwdgEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAJHP63/GvOxhXvPqod4iRiYPx
        EKMEB7OSCK/gix9JQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZ
        ODilGpiiL2ueXauqMUnCSl+9srKYdUudE2Pu+nlv3Xata2RjenKf59vac+yvyo6pFrZvdzS8
        q3W+fKGX8JTfsedyOa+y3LM85tRz45OXr3CiYp5RJ8/yNXsr1I5+tA5S+nY5fqKk8xx77938
        wmcz0qZkTdKXrtNYpfbr1eH9lbyPMnKre+/wf+FO26B8vGFH3twdvxyqW/15jZXNQ8Pqjx15
        eUDL+/RSo4Bq+wdSp+08p7/7ZZPP1fBtlsSR4Ge7XJ8mv+pamNa62cyH7/nEe1uaVH89Frwl
        GFc1qad3/aT6lIMK7/W05z6fafHVWPr2t9afv51cPnVxMonM9Hr+Qj2q6ueJ7Xa5dw2r/zVV
        8hvdnabEUpyRaKjFXFScCAAwnHoloQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7pyE34nGby4om0xZ/0aNotNj6+x
        WlzeNYfN4t6a/6wW+xcuZHRg9dj0aRK7x4kZv1k8dj609Ni8pN7j8ya5ANYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzFJ7uZCw5KVXzdeYKl
        gfGmaBcjB4eEgIlE03elLkYuDiGBpYwSX1ZvYu5i5ASKy0icnNbACmELS/y51sUGUfSeUeLb
        pu1gRbwCdhIrVjwAs1kEVCV2TL7BBBEXlDg58wkLiC0qkCyx4NBSMFtYIETiyvwesBpmAXGJ
        W0/mM4EMFRGYwiixaMZ9doiEicT91odgm4UEPCV+dN0Ca2ATMJToegtyBScHp4CXxOeZzxgh
        6s0kurZ2QdnyEtvfzmGewCg0C8kds5Dsm4WkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECo2vbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV7BFz+ShHhTEiurUovy44tKc1KLDzGa
        AgNjIrOUaHI+ML7zSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY
        8s6eldt4TFJIXdhimftXzl1ShvxFmVJmppyBxrflFF/+vqxdfTspgFPLWUOHX1+F4cuR5W2y
        B19zZ4dK+/XOj7J3vLvhIUevM0PLY46sjRW/X81X/1FVJvbivOXjmclpHsI7Tjx8yrz5n1J5
        UaR9s6U8TytHctdVVfvTWecmLFAPrdv0V+DMI8Hdagt/HV3e/frJ25WhLZP5xbSjljRs/Swv
        b9rCe56doym34a3fgwfvMxU/v3v4YfOJPZK7f5w+VNNZKs65YVrFZ+sWp7/+117KLoj+P8dr
        zvaJojV97Z2NBt+SrkwzX+J22/3pQv2Vt+ZbRDEYZjQkl+S3yjcbeAdusVknzK8zSfXhwkdK
        LMUZiYZazEXFiQBV2GO+NwMAAA==
X-CMS-MailID: 20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015
References: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com>
        <CGME20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015@eucas1p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.07.2022 08:28, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
>
> In "dma_alloc_from_dev_coherent" and "dma_direct_alloc",
> the allocated memory is explicitly set to 0.
>
> A helper function "use_dev_coherent_memory" is introduced here to
> determine whether the memory is allocated by "dma_alloc_from_dev_coherent".
>
> And use "get_dma_ops" to determine whether the memory is allocated by
> "dma_direct_alloc".
>
> After this modification, memory allocated using "dma_pool_zalloc" can avoid
> duplicate memset.
>
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>

This patch landed linux next-20220816. Unfortunately it causes serious 
issues on ARM 32bit systems. I've observed it on ARM 32bit Samsung 
Exynos 5422 based Odroid XU4 board with USB r8152 driver. After applying 
this patch and loading r8152 driver I only the following endless 
messages in the log:

xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?
xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?
xhci-hcd xhci-hcd.9.auto: WARN Event TRB for slot 1 ep 0 with no TDs queued?

It looks that there are drivers which rely on the fact that the dma 
coherent buffers are always zeroed.

> ---
>   include/linux/dma-map-ops.h | 5 +++++
>   mm/dmapool.c                | 5 ++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b..c29948d 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -171,6 +171,10 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>   int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>   int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, size_t size, int *ret);
> +static inline bool use_dev_coherent_memory(struct device *dev)
> +{
> +	return dev->dma_mem ? true : false;
> +}
>   #else
>   static inline int dma_declare_coherent_memory(struct device *dev,
>   		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
> @@ -180,6 +184,7 @@ static inline int dma_declare_coherent_memory(struct device *dev,
>   #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
>   #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>   #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
> +#define use_dev_coherent_memory(dev) (0)
>   #endif /* CONFIG_DMA_DECLARE_COHERENT */
>   
>   #ifdef CONFIG_DMA_GLOBAL_POOL
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index a7eb5d0..6e03530 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -21,6 +21,7 @@
>   
>   #include <linux/device.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
>   #include <linux/dmapool.h>
>   #include <linux/kernel.h>
>   #include <linux/list.h>
> @@ -372,7 +373,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>   #endif
>   	spin_unlock_irqrestore(&pool->lock, flags);
>   
> -	if (want_init_on_alloc(mem_flags))
> +	if (want_init_on_alloc(mem_flags) &&
> +		!use_dev_coherent_memory(pool->dev) &&
> +		get_dma_ops(pool->dev))
>   		memset(retval, 0, pool->size);
>   
>   	return retval;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

