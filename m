Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACD74937A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353123AbiASJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:47:18 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35852 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbiASJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:47:11 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jf14J6LXzzccZF;
        Wed, 19 Jan 2022 17:46:24 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 19 Jan 2022 17:47:09 +0800
Subject: Re: [PATCH] arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI
 is not set
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <marcan@marcan.st>,
        <maz@kernel.org>, <joey.gouly@arm.com>, <pcc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220107085536.214501-1-heying24@huawei.com>
 <20220112032410.29231-1-heying24@huawei.com>
 <e6293ec4-7c56-194a-95f9-98b102d80b31@huawei.com>
 <20220119093525.GB42546@C02TD0UTHF1T.local>
From:   He Ying <heying24@huawei.com>
Message-ID: <784a864e-e7e5-4ce5-ec78-850b523c23b0@huawei.com>
Date:   Wed, 19 Jan 2022 17:47:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220119093525.GB42546@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/19 17:35, Mark Rutland 写道:
> On Wed, Jan 19, 2022 at 02:40:58PM +0800, He Ying wrote:
>> Hi all,
>>
>> Ping. Any comments?
> The patch looks fine, but as it's the middle of the merge window people
> are busy and unlikely to look at this for the next few days.
>
> Generally it's a good idea to wait until rc1 or rc2, rebase atop that,
> and post the updated patch. Stuff like this usually gets queued around
> rc3/rc4 time.
OK. Thanks for your comment.
>
>> 锟斤拷 2022/1/12 11:24, He Ying 写锟斤拷:
>>> Arm64 pseudo-NMI feature code brings some additional nops
>>> when CONFIG_ARM64_PSEUDO_NMI is not set, which is not
>>> necessary. So add necessary ifdeffery to avoid it.
>>>
>>> Signed-off-by: He Ying <heying24@huawei.com>
> FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
>
>>> ---
>>>    arch/arm64/kernel/entry.S | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 2f69ae43941d..ffc32d3d909a 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -300,6 +300,7 @@ alternative_else_nop_endif
>>>    	str	w21, [sp, #S_SYSCALLNO]
>>>    	.endif
>>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>>>    	/* Save pmr */
>>>    alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>>>    	mrs_s	x20, SYS_ICC_PMR_EL1
>>> @@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>>>    	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
>>>    	msr_s	SYS_ICC_PMR_EL1, x20
>>>    alternative_else_nop_endif
>>> +#endif
>>>    	/* Re-enable tag checking (TCO set on exception entry) */
>>>    #ifdef CONFIG_ARM64_MTE
>>> @@ -330,6 +332,7 @@ alternative_else_nop_endif
>>>    	disable_daif
>>>    	.endif
>>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>>>    	/* Restore pmr */
>>>    alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>>>    	ldr	x20, [sp, #S_PMR_SAVE]
>>> @@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>>>    	dsb	sy				// Ensure priority change is seen by redistributor
>>>    .L__skip_pmr_sync\@:
>>>    alternative_else_nop_endif
>>> +#endif
>>>    	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
> .
