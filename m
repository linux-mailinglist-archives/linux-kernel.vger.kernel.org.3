Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581164695F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbhLFMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:51:51 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48205 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243376AbhLFMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:51:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UzdP5yc_1638794898;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UzdP5yc_1638794898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 20:48:20 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1] mm/damon: Modify damon_rand() macro to static inline
 function
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211206124523.6259-1-sj@kernel.org>
Message-ID: <08a13269-e3eb-219f-79bb-8d0153714c69@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 20:48:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206124523.6259-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/21 8:45 PM, SeongJae Park wrote:
> On Mon, 6 Dec 2021 20:41:29 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> The damon_rand() func can not be implemented as a macro.
>> Example:
>> 	damon_rand(a++, b);
>> The value of 'a' will be incremented twice, This is obviously
>> unreasonable, So there fix it.
>>
>> Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
>> Reported-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index c6df025d8704..bc9c8932b1e8 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -19,7 +19,10 @@
>>   #define DAMOS_MAX_SCORE		(99)
>>
>>   /* Get a random number in [l, r) */
>> -#define damon_rand(l, r) (l + prandom_u32_max(r - l))
>> +static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>> +{
>> +	return l + (r - l);
> Seems prandom_u32_max() is missed?

Sorry, my fault, i write a simple test case like this, but i forgot to 
correct in patch, i will send a new one.

#include <stdio.h>

#define damon_rand(l, r) (l + (r - l))
static inline long damon_rand1(int l, int r)
{
         return l + (r - l);
}

int main(void)
{

         int a = 0;
         int b = 0;
         damon_rand(a++, 4);
         damon_rand1(b++, 4);

         printf("a is %d \n", a);
         printf("b is %d \n", b);

         return 0;
}

>
>
> Thanks,
> SJ
>
>> +}
>>
>>   /**
>>    * struct damon_addr_range - Represents an address region of [@start, @end).
>> --
>> 2.31.0

-- 
Best Regards!
Xin Hao

