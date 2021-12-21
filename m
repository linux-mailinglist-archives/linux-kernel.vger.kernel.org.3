Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5847C18B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhLUObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:31:44 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60399 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238478AbhLUObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:31:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.LJeir_1640097099;
Received: from 30.39.136.247(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.LJeir_1640097099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 22:31:41 +0800
Message-ID: <7d3e57ec-8344-bbc9-6a2e-052707aec760@linux.alibaba.com>
Date:   Tue, 21 Dec 2021 22:32:24 +0800
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
References: <20211221132617.15064-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211221132617.15064-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2021 9:26 PM, SeongJae Park wrote:
> Hi Baolin,
> 
> On Tue, 21 Dec 2021 17:18:02 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Hi,
>>
>> Now on tiered memory system with different memory types, the reclaim path in
>> shrink_page_list() already support demoting pages to slow memory node instead
>> of discarding the pages. However, at that time the fast memory node memory
>> wartermark is already tense, which will increase the memory allocation latency
>> during page demotion. So a new method from user space demoting cold pages
>> proactively will be more helpful.
>>
>> We can rely on the DAMON in user space to help to monitor the cold memory on
>> fast memory node, and demote the cold pages to slow memory node proactively to
>> keep the fast memory node in a healthy state.
>>
>> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
>> and works well from my testing. Any comments are welcome. Thanks.
> 
> I like the idea, thank you for these patches!  If possible, could you share
> some details about your tests?

Sure, sorry for not adding more information about my tests.

My machine contains 64G DRAM + 256G AEP(persistent memory), and you 
should enable the demotion firstly by:
echo "true" > /sys/kernel/mm/numa/demotion_enabled

Then I just write a simple test case like below to mmap some anon 
memory, and then just read and write half of the mmap buffer to let 
another half to be cold enough to demote.

int main()
{
         int len = 50 * 1024 * 1024;
         int scan_len = len / 2;
         int i, ret, j;
         unsigned long *p;

         p = mmap(NULL, len, PROT_READ | PROT_WRITE,
                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
                 printf("failed to get memory\n");
                 return -1;
         }

         for (i = 0; i < len / sizeof(*p); i++)
                 p[i] = 0x55aa;

         /* Let another half of buffer to be cold */
         do {
                 for (i = 0; i < scan_len / sizeof(*p); i++)
                         p[i] = 0x55aa;

                 sleep(2);

                 for (i = 0; i < scan_len / sizeof(*p); i++)
                         j +=  p[i] >> 2;
         } while (1);

         munmap(p, len);
         return 0;
}

After setting the atts/schemes/target_ids, then start monitoring:
echo 100000 1000000 1000000 10 1000 > /sys/kernel/debug/damon/attrs
echo 4096 8192000 0 5 10 2000 5 1000 2097152 5000 0 0 0 0 0 3 2 1 > 
/sys/kernel/debug/damon/schemes

After a while, you can check the demote statictics by below command, and 
you can find the demote scheme is applied by demoting some cold pages to 
slow memory (AEP) node.

cat /proc/vmstat | grep "demote"
pgdemote_direct 6881
