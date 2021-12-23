Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6647DD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhLWBVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:21:15 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50046 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhLWBVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:21:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.TJOwV_1640222460;
Received: from 30.21.164.23(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.TJOwV_1640222460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 09:21:01 +0800
Message-ID: <90c5f31f-9e0a-df6d-8639-8a46ee02f9fa@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 09:21:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
 <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87a6gsceo6.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2021 9:07 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
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
> As a performance optimization patch, it's better to provide some test
> results.

Actually this is a functional patch, which adds a new scheme for DAMON. 
And I think it is too early to measure the performance for the real 
workload, and more work need to do for DAMON used on tiered memory 
system (like supporting promotion scheme later).

> Another question is why we shouldn't do this in user space?  With DAMON,
> it's possible to export cold memory regions information to the user
> space, then we can use move_pages() to migrate them from DRAM to PMEM.
> What's the problem of that?

IMO this is the purpose of introducing scheme for DAMON, and you can 
check more in the Documentation/admin-guide/mm/damon/usage.rst.

"
Schemes
-------

For usual DAMON-based data access aware memory management optimizations, 
users
would simply want the system to apply a memory management action to a memory
region of a specific access pattern.  DAMON receives such formalized 
operation
schemes from the user and applies those to the target processes.
"
