Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1B59D205
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiHWH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiHWH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551362A93;
        Tue, 23 Aug 2022 00:26:04 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N4QBw3023075;
        Tue, 23 Aug 2022 07:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wSeyxPigMB9+mzHDPYtNu5KFZQgVycg01gcDOmX3hxo=;
 b=iZeHSSCZ0DC92c6mNDFJRtwtgKc5RZVpQcCY1Id2nnB02yrHnlSmGGRBnZlqsaallc2e
 KgSM0t7blLlOM+HRNPGyJ1QuxjOYDtECHIQb8VHNAFX7bEGbv6Jef5FWeHEyHE5Jbzzd
 KirZ/oTr3x3+qAVLprNVJgxpDmxAu1u0Qc85DBEKLil7zMIjOP5BbFlI9SBykVyMIRdH
 IeknnNcd58r2a2Od3MD4rYTS3s//ljYw2yfLeSzgtAooRYS4ODh+G56c1HFc6gyB/fn2
 Acdsw8mU/7x4ORLK3k2N2jgX2GygR/wi4Ay7sCphhlExxB2sYkVvsuGvNQGyk34aekVd Pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4phb14yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 07:25:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27N7PtTG017543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 07:25:55 GMT
Received: from [10.50.0.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 00:25:49 -0700
Message-ID: <708d8c51-4cf5-50b7-ab07-8396b08563df@quicinc.com>
Date:   Tue, 23 Aug 2022 12:55:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/msm/iommu: optimize map/unmap
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220822184742.32076-1-robdclark@gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220822184742.32076-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RKdc_c_ZrECOpMOyQlDXX56WtKI6zpuh
X-Proofpoint-ORIG-GUID: RKdc_c_ZrECOpMOyQlDXX56WtKI6zpuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/23/2022 12:17 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Using map_pages/unmap_pages cuts down on the # of pgtable walks needed
> in the process of finding where to insert/remove an entry.  The end
> result is ~5-10x faster than mapping a single page at a time.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_iommu.c | 91 ++++++++++++++++++++++++++++-----
>   1 file changed, 79 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index a54ed354578b..0f3f60da3314 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -21,6 +21,7 @@ struct msm_iommu_pagetable {
>   	struct msm_mmu base;
>   	struct msm_mmu *parent;
>   	struct io_pgtable_ops *pgtbl_ops;
> +	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>   	phys_addr_t ttbr;
>   	u32 asid;
>   };
> @@ -29,23 +30,85 @@ static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
>   	return container_of(mmu, struct msm_iommu_pagetable, base);
>   }
>   
> +/* based on iommu_pgsize() in iommu.c: */
> +static size_t iommu_pgsize(struct msm_iommu_pagetable *pagetable,

Maybe call this msm_iommu_pgsize? There won't be any namespace conflict since it is static
in both places but still would be better.

> +			   unsigned long iova, phys_addr_t paddr,
> +			   size_t size, size_t *count)
> +{
> +	unsigned int pgsize_idx, pgsize_idx_next;
> +	unsigned long pgsizes;
> +	size_t offset, pgsize, pgsize_next;
> +	unsigned long addr_merge = paddr | iova;
> +
> +	/* Page sizes supported by the hardware and small enough for @size */
> +	pgsizes = pagetable->pgsize_bitmap & GENMASK(__fls(size), 0);
> +
> +	/* Constrain the page sizes further based on the maximum alignment */
> +	if (likely(addr_merge))
> +		pgsizes &= GENMASK(__ffs(addr_merge), 0);
> +
> +	/* Make sure we have at least one suitable page size */
> +	BUG_ON(!pgsizes);
> +
> +	/* Pick the biggest page size remaining */
> +	pgsize_idx = __fls(pgsizes);
> +	pgsize = BIT(pgsize_idx);
> +	if (!count)
> +		return pgsize;
> +
> +	/* Find the next biggest support page size, if it exists */
> +	pgsizes = pagetable->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
> +	if (!pgsizes)
> +		goto out_set_count;
> +
> +	pgsize_idx_next = __ffs(pgsizes);
> +	pgsize_next = BIT(pgsize_idx_next);
> +
> +	/*
> +	 * There's no point trying a bigger page size unless the virtual
> +	 * and physical addresses are similarly offset within the larger page.
> +	 */
> +	if ((iova ^ paddr) & (pgsize_next - 1))
> +		goto out_set_count;
> +
> +	/* Calculate the offset to the next page size alignment boundary */
> +	offset = pgsize_next - (addr_merge & (pgsize_next - 1));
> +
> +	/*
> +	 * If size is big enough to accommodate the larger page, reduce
> +	 * the number of smaller pages.
> +	 */
> +	if (offset + pgsize_next <= size)
> +		size = offset;
> +
> +out_set_count:
> +	*count = size >> pgsize_idx;
> +	return pgsize;
> +}
> +
>   static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
>   		size_t size)
>   {
>   	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
>   	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> -	size_t unmapped = 0;
>   
>   	/* Unmap the block one page at a time */

This comment will need an update.

>   	while (size) {
> -		unmapped += ops->unmap(ops, iova, 4096, NULL);
> -		iova += 4096;
> -		size -= 4096;
> +		size_t unmapped, pgsize, count;
> +
> +		pgsize = iommu_pgsize(pagetable, iova, iova, size, &count);
> +
> +		unmapped = ops->unmap_pages(ops, iova, pgsize, count, NULL);
> +		if (!unmapped)
> +			break;
> +
> +		iova += unmapped;
> +		size -= unmapped;
>   	}
>   
>   	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
>   
> -	return (unmapped == size) ? 0 : -EINVAL;
> +	return (size == 0) ? 0 : -EINVAL;
>   }
>   
>   static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> @@ -54,7 +117,6 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
>   	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
>   	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
>   	struct scatterlist *sg;
> -	size_t mapped = 0;
>   	u64 addr = iova;
>   	unsigned int i;
>   
> @@ -64,15 +126,19 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
>   
>   		/* Map the block one page at a time */

This comment will need an update.

>   		while (size) {
> -			if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
> -				msm_iommu_pagetable_unmap(mmu, iova, mapped);
> +			size_t pgsize, count, mapped;
> +
> +			pgsize = iommu_pgsize(pagetable, addr, phys, size, &count);
> +
> +			if (ops->map_pages(ops, addr, phys, pgsize, count,
> +					   prot, GFP_KERNEL, &mapped)) {
> +				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);

On ->map_pages failure, some pages can still be mapped and would need to be accounted for unmapping,
so maybe follow the logic in __iommu_map() to account for mapped size instead of addr - iova where
addr won't be updated in case of failure to map few pages.

Thanks,
Sai

>   				return -EINVAL;
>   			}
>   
> -			phys += 4096;
> -			addr += 4096;
> -			size -= 4096;
> -			mapped += 4096;
> +			phys += mapped;
> +			addr += mapped;
> +			size -= mapped;
>   		}
>   	}
>   
> @@ -207,6 +273,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
>   
>   	/* Needed later for TLB flush */
>   	pagetable->parent = parent;
> +	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
>   	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
>   
>   	/*
