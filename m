Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB2495826
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378480AbiAUCOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:14:42 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35646 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378458AbiAUCOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:14:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V2PAjTC_1642731277;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V2PAjTC_1642731277)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 10:14:37 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH V1 2/2] mm/damon/dbgfs: Modify Damon dbfs interface
 dependency in Kconfig
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220120174630.26102-1-sj@kernel.org>
Message-ID: <3bc92242-63b0-283e-6dbf-412459d4a242@linux.alibaba.com>
Date:   Fri, 21 Jan 2022 10:14:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120174630.26102-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/22 1:46 AM, SeongJae Park wrote:
> Hi Xin,
>
>
> I guess this should be at least v3, as you posted v1[1] and v2[2] before.
> Could you please also summarize what changes are made from v2?
>
> On Fri, 21 Jan 2022 00:04:28 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> If you want to support "DAMON_DBGFS" in config file, it only depends on
>> any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
>> use damon virtual address function, but it is unreasonable to include
>> "DAMON_PADDR" in config file which cause the damon/paddr.c be compiled.
> My comment[3] to the v2 was,
>
>      So, unless you make me believe the benefit is big enough and all possible
>      corner cases are well handled and sufficiently tested, I'm sorry but I would
>      not be convinced with this change.

This has really bothered me for a long time. I don't send patches just 
for the sake of sending patches. I integrate DAMON patches into my 
kernel, and one obvious problem is that I don't use paddr at all. But my 
config had to select DAMON_PADDR so that my DAMON codes would compile 
and work. I wanted DAMON code to be as simple and clean as possible, 
which is why I sent the patch for three times.


I quite agree with what you said, it is necessary to conduct sufficient 
test and verification, which I have not done enough. However, I will 
conduct further test later. I don't think we should not modify the 
previous test case just because it will affect it. I can guarantee the 
tools/testing/selftests/Damon and kunit Damon test right before i send a 
new version.

>
> I don't find answers to the requests here.  Could you please add those if you
> have?
>
> [1] https://lore.kernel.org/linux-mm/fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@lin
> ux.alibaba.com/
> [2] https://lore.kernel.org/linux-mm/b6bd0063-efb2-62ce-53ee-0193f63262d8@linux.alibaba.com/
> [3] https://lore.kernel.org/linux-mm/20211123103855.12592-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
>> So there just do little change to fix it.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h | 16 ++++++++++++++++
>>   mm/damon/Kconfig      |  2 +-
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 794b5f453662..c83e4588aa45 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -501,12 +501,28 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>>   #ifdef CONFIG_DAMON_VADDR
>>   bool damon_va_target_valid(void *t);
>>   void damon_va_set_primitives(struct damon_ctx *ctx);
>> +#else
>> +static inline void damon_va_set_primitives(struct damon_ctx *ctx) { }
>> +static inline bool damon_va_target_valid(void *t)
>> +{
>> +	return false;
>> +}
>>   #endif	/* CONFIG_DAMON_VADDR */
>>
>>   #ifdef CONFIG_DAMON_PADDR
>>   bool damon_pa_check(char *buf, size_t count);
>>   bool damon_pa_target_valid(void *t);
>>   void damon_pa_set_primitives(struct damon_ctx *ctx);
>> +#else
>> +static inline bool damon_pa_check(char *buf, size_t count)
>> +{
>> +	return false;
>> +}
>> +static inline void damon_pa_set_primitives(struct damon_ctx *ctx) { }
>> +static inline bool damon_pa_target_valid(void *t)
>> +{
>> +	return false;
>> +}
>>   #endif	/* CONFIG_DAMON_PADDR */
>>
>>   #endif	/* _DAMON_H */
>> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
>> index 5bcf05851ad0..a8952af3c8bf 100644
>> --- a/mm/damon/Kconfig
>> +++ b/mm/damon/Kconfig
>> @@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
>>
>>   config DAMON_DBGFS
>>   	bool "DAMON debugfs interface"
>> -	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
>> +	depends on (DAMON_VADDR || DAMON_PADDR) && DEBUG_FS
>>   	help
>>   	  This builds the debugfs interface for DAMON.  The user space admins
>>   	  can use the interface for arbitrary data access monitoring.
>> --
>> 2.27.0
>>
-- 
Best Regards!
Xin Hao

