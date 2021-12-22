Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B947CF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbhLVJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:56:29 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28031 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231487AbhLVJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:56:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.Pf4oC_1640166985;
Received: from 30.21.164.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.Pf4oC_1640166985)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 17:56:25 +0800
Message-ID: <f62fa69b-300e-e6f9-e3c0-077243ce654d@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 17:57:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/2] Add a new scheme to support demotion on tiered memory
 system
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211222085455.15996-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211222085455.15996-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2021 4:54 PM, SeongJae Park wrote:
[snip]

>>
>> My machine contains 64G DRAM + 256G AEP(persistent memory), and you
>> should enable the demotion firstly by:
>> echo "true" > /sys/kernel/mm/numa/demotion_enabled
>>
>> Then I just write a simple test case like below to mmap some anon
>> memory, and then just read and write half of the mmap buffer to let
>> another half to be cold enough to demote.
>>
>> int main()
>> {
>>           int len = 50 * 1024 * 1024;
>>           int scan_len = len / 2;
>>           int i, ret, j;
>>           unsigned long *p;
>>
>>           p = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>           if (p == MAP_FAILED) {
>>                   printf("failed to get memory\n");
>>                   return -1;
>>           }
>>
>>           for (i = 0; i < len / sizeof(*p); i++)
>>                   p[i] = 0x55aa;
>>
>>           /* Let another half of buffer to be cold */
>>           do {
>>                   for (i = 0; i < scan_len / sizeof(*p); i++)
>>                           p[i] = 0x55aa;
>>
>>                   sleep(2);
>>
>>                   for (i = 0; i < scan_len / sizeof(*p); i++)
>>                           j +=  p[i] >> 2;
>>           } while (1);
>>
>>           munmap(p, len);
>>           return 0;
>> }
>>
>> After setting the atts/schemes/target_ids, then start monitoring:
>> echo 100000 1000000 1000000 10 1000 > /sys/kernel/debug/damon/attrs
>> echo 4096 8192000 0 5 10 2000 5 1000 2097152 5000 0 0 0 0 0 3 2 1 >
>> /sys/kernel/debug/damon/schemes
>>
>> After a while, you can check the demote statictics by below command, and
>> you can find the demote scheme is applied by demoting some cold pages to
>> slow memory (AEP) node.
>>
>> cat /proc/vmstat | grep "demote"
>> pgdemote_direct 6881
> 
> Thank you for sharing this great details!
> 
> I was just wondering if you have tested and measured the effects of the memory
> allocation latency increase during the page demotion, which invoked by
> shrink_page_list(), and also if you have measured how much improvement can be
> achieved with DAMON-based demotion in the scenario.  Seems that's not the case,

Not yet testing on the real workload with DAMON demote scheme now, and I 
think DAMON is lack of some functions to tune performance on tiered 
memory system. At least I think we also need add a new promotion scheme 
for DAMON to promote hot memory from slow memory node to the fast memory 
node, which is on my TODO list.

> and I personally think that information is not essential for this patch, so I
> see no problem here.  But, if you have tested or have a plan to do that, and if
> you could, I think sharing the results on this cover letter would make this
> even greater.

Sure, will do if we find some funny results with DAMON on tiered memory 
system in future. Thanks.
