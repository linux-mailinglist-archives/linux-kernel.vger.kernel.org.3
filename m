Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA347DC75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhLWBA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:00:26 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36489 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238387AbhLWBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:00:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V.TB1Hv_1640221220;
Received: from 30.21.164.23(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.TB1Hv_1640221220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 09:00:21 +0800
Message-ID: <362fb4fe-34c8-d83d-b8be-a4140e19b244@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 09:01:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sj@kernel.org, ying.huang@intel.com, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
 <20211222160105.a267eaacefae77ae094c050e@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211222160105.a267eaacefae77ae094c050e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2021 8:01 AM, Andrew Morton wrote:
> On Wed, 22 Dec 2021 19:14:39 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
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
> This is interesting.
> 
> I think it would be helpful if we could have some example scenarios in
> this changelog, help people understand how to use DAMOS_DEMOTE and what
> effects it has.

Sure.

> 
> Documentation/admin-guide/mm/damon/usage.rst would like an update?

Ah, I missed updating de Doc, and will do in v3.

> And the DAMON user space tool?

Yes. Thanks for your comments.
