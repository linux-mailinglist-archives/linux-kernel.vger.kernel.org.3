Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9715A94FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiIAKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiIAKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:46:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA457E831A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:46:01 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHkQ4j58z67Q1Y;
        Thu,  1 Sep 2022 18:45:18 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:45:59 +0200
Received: from [10.48.151.166] (10.48.151.166) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 11:45:59 +0100
Message-ID: <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
Date:   Thu, 1 Sep 2022 11:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
 <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
 <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
In-Reply-To: <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.151.166]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 11:28, Peng Zhang wrote:
> 
>> Though only 3-4 drivers use alloc_iova() directly, in my understanding
>>
>> your test has simulated the worst case, rcache doesn't work at all,
>>
>> "alloc_iova" +“remove_iova” number looks great for worst case.
> 
> There is another case, when the size to allocate greater to 2^5, even if 
> alloc_iova_fast() is used, alloc_iova() will always be called because 
> the maximum iova size that rcache supports to allocate is 32.
> IOVA_RANGE_CACHE_MAX_SIZE specifies the maximum size.
> 


If you really have a performance issue with alloc_iova_fast() -> 
alloc_iova() then I suggest that you consider trying to use 
dma_opt_mapping_size() to teach the DMA engine driver to not create 
requests whose overall size exceeds to the rcache limit.

Thanks,
John

