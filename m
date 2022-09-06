Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF75AE5F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbiIFKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiIFKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:52:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75184BA6C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:50:29 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMMWP5jc8z688r1;
        Tue,  6 Sep 2022 18:46:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:50:27 +0200
Received: from [10.126.175.248] (10.126.175.248) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 11:50:26 +0100
Message-ID: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Date:   Tue, 6 Sep 2022 11:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
In-Reply-To: <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.175.248]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 10:28, Ethan Zhao wrote:

Hi Ethan,

>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iova.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 47d1983dfa2a..580fdf669922 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, 
>> struct iova_domain *iovad)
>>       unsigned long flags;
>>       int i;
>> -    if (!mag)
>> -        return;
>> -
> 
> iommu_probe_device
>    ops->probe_finalize(dev);
>      intel_iommu_probe_finalize
>         iommu_setup_dma_ops
>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>             iova_domain_init_rcaches
>               {
>               ...
>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>                  ret = -ENOMEM;
>                        goto out_err;
> 
> Do you mean iova_magazine_alloc() is impossible to fail ?

No, iova_magazine_alloc() may fail and return NULL. But if it does then 
we set iovad rcache pointer = NULL in the error path and don't use the 
rcache.

However we have a !iovad->rcache check on the "fast" alloc but not 
"insert". I need to check why that is again.

Thanks,
john
