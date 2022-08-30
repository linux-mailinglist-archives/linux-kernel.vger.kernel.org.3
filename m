Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807C65A5F84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiH3Jd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiH3Jcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8493A8CC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:32:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B83223A;
        Tue, 30 Aug 2022 02:32:36 -0700 (PDT)
Received: from [10.57.13.45] (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DDA3F766;
        Tue, 30 Aug 2022 02:32:28 -0700 (PDT)
Message-ID: <5f47c5b7-534d-5714-1f91-04005ada8b8f@arm.com>
Date:   Tue, 30 Aug 2022 10:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] iommu: use iommu_group_ref_get to hold group reference
Content-Language: en-GB
To:     Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        haifeng.zhao@linux.intel.com
References: <20220826024024.101553-1-yuancan@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220826024024.101553-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-26 03:40, Yuan Can wrote:
> Replace kobject_get with iommu_group_ref_get for better
> readability.

I disagree, sorry. iommu_group_ref_get() is meant as a helper for 
drivers, and the core code uses the raw kobject internally everywhere 
else, including several other times within this function. Especially the 
raw kobject_put() in the cleanup path - in terms of readability I'd say 
it's actively harmful to obfuscate what that pairs with.

Thanks,
Robin.

> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 780fb7071577..8e7f30f7188c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -903,7 +903,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   		goto err_free_name;
>   	}
>   
> -	kobject_get(group->devices_kobj);
> +	iommu_group_ref_get(group);
>   
>   	dev->iommu_group = group;
>   
