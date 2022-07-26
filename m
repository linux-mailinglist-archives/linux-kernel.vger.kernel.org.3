Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F9581593
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiGZOmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGZOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:42:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F7826AD9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:42:16 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsfgW57mhzjWvk;
        Tue, 26 Jul 2022 22:39:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 22:42:12 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 22:42:11 +0800
Message-ID: <ceefb6c0-fbed-447f-791f-c48d3a4c41cc@huawei.com>
Date:   Tue, 26 Jul 2022 22:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: add warning if __vm_enough_memory fails
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20220726072451.142427-1-wangkefeng.wang@huawei.com>
 <18dc0807-5596-3aad-350d-3673a033bca8@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <18dc0807-5596-3aad-350d-3673a033bca8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/26 21:45, David Hildenbrand wrote:
> On 26.07.22 09:24, Kefeng Wang wrote:
>> If a process has no enough memory to allocate a new virtual mapping, we
>> may meet kinds of error, eg, fork cannot allocate memory, SIGBUS error
>> in shmem, but it is difficult to confirm them, let's add some debug
>> information to easy to check this scenario if __vm_enough_memory fails.
>>
>> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/util.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 1266a33a49ea..19bfff8a0ad6 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -1020,6 +1020,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>>   	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>>   		return 0;
>>   error:
>> +	pr_warn("%s: pid: %d, comm: %s, no enough memory for the allocation\n",
>> +		__func__, current->pid, current->comm);
>>   	vm_unacct_memory(pages);
>>   
>>   	return -ENOMEM;
> Users can easily spam the kernel log, no? Maybe at least ratelimit.
pr_warn_ratelimited is better, will update, thanks.
>
