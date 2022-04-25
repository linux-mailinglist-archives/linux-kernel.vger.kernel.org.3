Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD450DE15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiDYKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiDYKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:44:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB726AD7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:40:59 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kn1kk0nPlzhYnf;
        Mon, 25 Apr 2022 18:40:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 18:40:57 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 18:40:57 +0800
Message-ID: <22536b1c-f38d-45b1-8187-636c158b8e4b@huawei.com>
Date:   Mon, 25 Apr 2022 18:40:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm: use pgprot_val to get value of pgprot
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        liusongtang <liusongtang@huawei.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <young.liuyang@huawei.com>,
        <trivial@kernel.org>
References: <20220425081736.249130-1-liusongtang@huawei.com>
 <f9e48ed2-0e90-1a2d-c62e-739c33c4cc53@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <f9e48ed2-0e90-1a2d-c62e-739c33c4cc53@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/25 18:29, Anshuman Khandual wrote:
> Should have added 'memory_hotplug' in the subject line. Otherwise
> this does not specify where the change is (neither does the commit
> message below).
>
> mm/memory_hotplug: use pgprot_val to get value of pgprot


$ git grep "pgprot\.pgprot"
arch/ia64/mm/init.c:    if (WARN_ON_ONCE(params->pgprot.pgprot != 
PAGE_KERNEL.pgprot))
arch/s390/mm/init.c:    if (WARN_ON_ONCE(params->pgprot.pgprot != 
PAGE_KERNEL.pgprot))
arch/sh/mm/init.c:      if (WARN_ON_ONCE(params->pgprot.pgprot != 
PAGE_KERNEL.pgprot))
mm/memory_hotplug.c:    if (WARN_ON_ONCE(!params->pgprot.pgprot))

You can change other's codes too.

>
> On 4/25/22 13:47, liusongtang wrote:
>> pgprot.pgprot is a non-portable code, it should be replaced by
>> portable macro pgprot_val.
>>
>> Signed-off-by: liusongtang <liusongtang@huawei.com>
>> ---
>>   mm/memory_hotplug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 416b38c..bf7d181 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -303,7 +303,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>   	int err;
>>   	struct vmem_altmap *altmap = params->altmap;
>>   
>> -	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>> +	if (WARN_ON_ONCE(!pgprot_val(params->pgprot)))
>>   		return -EINVAL;
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
> Otherwise LGTM.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> .
