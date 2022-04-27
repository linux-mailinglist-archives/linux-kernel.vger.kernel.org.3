Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A806E511136
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358138AbiD0Ghj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiD0Ghg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:37:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE610175D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:34:25 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kp84H4ttkzCsPr;
        Wed, 27 Apr 2022 14:29:51 +0800 (CST)
Received: from [10.67.110.243] (10.67.110.243) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 14:34:24 +0800
Message-ID: <1f5966cf-d40f-4a49-c2d0-e2c90eb5a124@huawei.com>
Date:   Wed, 27 Apr 2022 14:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] mm/mprotect: reduce Committed_AS if memory protection is
 changed to PROT_NONE
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <young.liuyang@huawei.com>,
        <wangkefeng@huawei.com>
References: <20220426112705.3323-1-liusongtang@huawei.com>
 <20220426133401.9404190c5a5c6ff58b694c59@linux-foundation.org>
From:   liusongtang <liusongtang@huawei.com>
In-Reply-To: <20220426133401.9404190c5a5c6ff58b694c59@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/27 4:34, Andrew Morton wrote:

> On Tue, 26 Apr 2022 19:27:05 +0800 liusongtang <liusongtang@huawei.com> wrote:
>
>> If PROT_WRITE is set, the size of vm area will be added to Committed_AS.
>> However, if memory protection is changed to PROT_NONE,
>> the corresponding physical memory will not be used, but Committed_AS still
>> count the size of the PROT_NONE memory.
>>
>> This patch reduce Committed_AS and free the corresponding memory if
>> memory protection is changed to PROT_NONE.
>>
>> ...
>>
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -497,6 +497,12 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>>   	}
>>   
>>   success:
>> +	if ((newflags & (VM_READ | VM_WRITE | VM_EXEC | VM_LOCKED | VM_ACCOUNT)) == VM_ACCOUNT) {
>> +		zap_page_range(vma, start, end - start);
>> +		newflags &= ~VM_ACCOUNT;
>> +		vm_unacct_memory((end - start) >> PAGE_SHIFT);
>> +	}
>> +
>>   	/*
>>   	 * vm_flags and vm_page_prot are protected by the mmap_lock
>>   	 * held in write mode.
> Surprised.  If userspace does mprotect(addr, len.  PROT_NONE) then
> mprotect(addr, len.  PROT_READ), what is now at *addr?  Zeroes?
> .

1. In the case mentioned above, I think data in *addr is invalid after
mprotect(addr, len.  PROT_NONE), so clear it will not cause a problem.
2. Another idea is we can check if this vm area is populated before reduce Committed_AS.

