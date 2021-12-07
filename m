Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEFE46B08A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhLGCZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:25:09 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29093 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhLGCZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:25:09 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J7P9j2ykzz1DHwx;
        Tue,  7 Dec 2021 10:18:49 +0800 (CST)
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:21:37 +0800
Subject: Re: [PATCH] arm64: mm: Use asid2idx() and asid feature macro for
 cleanup
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wuxu.wu@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <4aaabf1b-00c3-3365-e371-9d97dc0c06ab@huawei.com>
 <Ya44+GAmeGBFVAad@arm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <8f4ec1cd-fbb7-10f8-b515-500400308492@huawei.com>
Date:   Tue, 7 Dec 2021 10:21:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Ya44+GAmeGBFVAad@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/7 0:23, Catalin Marinas wrote:
> On Thu, Oct 28, 2021 at 08:27:23PM +0800, Yunfeng Ye wrote:
>> Use asid2idx() and asid feature macro for cleanup.
>>
>> No functional change.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  arch/arm64/mm/context.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>> index cd72576ae2b7..076f14a75bd5 100644
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -50,10 +50,10 @@ static u32 get_cpu_asid_bits(void)
>>  		pr_warn("CPU%d: Unknown ASID size (%d); assuming 8-bit\n",
>>  					smp_processor_id(),  fld);
>>  		fallthrough;
>> -	case 0:
>> +	case ID_AA64MMFR0_ASID_8:
>>  		asid = 8;
>>  		break;
>> -	case 2:
>> +	case ID_AA64MMFR0_ASID_16:
>>  		asid = 16;
>>  	}
> 
> I think this change is fine.
> 
>> @@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
>>  	u64 generation = atomic64_read(&asid_generation);
>>
>>  	if (asid != 0) {
>> -		u64 newasid = generation | (asid & ~ASID_MASK);
>> +		u64 newasid = generation | asid2idx(asid);
>>
>>  		/*
>>  		 * If our current ASID was active during a rollover, we
>> @@ -306,7 +306,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
>>  out_unlock:
>>  	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
>>
>> -	asid &= ~ASID_MASK;
>> +	asid = asid2idx(asid);
> 
> While functionally the code is the same, I don't think this was the
> intention of asid2idx(). It's meant to provide an index into asid_map,
> while the ASID_MASK lines isolate the asid number and add a new
> generation to it.
> 
The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce the
asid2idx and idx2asid macro, but these macros is not really useful after the
commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if KPTI is not in use").

I think "(asid & ~ASID_MASK)" can be instead by a macro, it is the same code with
asid2idx(). Can it be renamed?  (eg, ctxid2asid)

Thanks.

