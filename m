Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443CB49ABBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392351AbiAYFVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:21:11 -0500
Received: from foss.arm.com ([217.140.110.172]:43848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391262AbiAYFE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:04:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A0441FB;
        Mon, 24 Jan 2022 21:04:22 -0800 (PST)
Received: from [10.163.42.113] (unknown [10.163.42.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC593F7D8;
        Mon, 24 Jan 2022 21:04:17 -0800 (PST)
Subject: Re: [RFC V1 02/11] arm64/perf: Add register definitions for BRBE
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-3-git-send-email-anshuman.khandual@arm.com>
 <877dap8c0o.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <165b3f65-c92e-75e3-9485-548e1c862ec4@arm.com>
Date:   Tue, 25 Jan 2022 10:34:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <877dap8c0o.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 7:35 PM, Marc Zyngier wrote:
> On Mon, 24 Jan 2022 04:30:44 +0000,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver which is
>> being added later on.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 216 ++++++++++++++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 898bee0004ae..d8fd7e806a47 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -141,6 +141,218 @@
>>  #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
>>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
>>  
>> +/*
>> + * BRBINF<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
>> + *
>> + * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 0)
>> + */
>> +#define SYS_BRBINF0_EL1			sys_reg(2, 1, 8, 0, 0)
>> +#define SYS_BRBINF1_EL1			sys_reg(2, 1, 8, 1, 0)
>> +#define SYS_BRBINF2_EL1			sys_reg(2, 1, 8, 2, 0)
>> +#define SYS_BRBINF3_EL1			sys_reg(2, 1, 8, 3, 0)
>> +#define SYS_BRBINF4_EL1			sys_reg(2, 1, 8, 4, 0)
>> +#define SYS_BRBINF5_EL1			sys_reg(2, 1, 8, 5, 0)
>> +#define SYS_BRBINF6_EL1			sys_reg(2, 1, 8, 6, 0)
>> +#define SYS_BRBINF7_EL1			sys_reg(2, 1, 8, 7, 0)
>> +#define SYS_BRBINF8_EL1			sys_reg(2, 1, 8, 8, 0)
>> +#define SYS_BRBINF9_EL1			sys_reg(2, 1, 8, 9, 0)
> 
> [snip]
> 
> Since the architecture gives you the formula to build these, why do
> you enumerate each and every register encoding? I'd rather see
> something like:
> 
> #define __SYS_BRBINFO(n) sys_reg(2, 1, 8, ((n) & 0xf), (((n) & 0x10)) >> 2)
> #define SYS_BRBINF0_EL1	__SYS_BRBINFO(0)
> [...]
> 
> and something similar for all the new registers that come in packs of
> 32... We already have similar things for AMU, PMU, GIC and co.

Sure, above method seems like a better idea indeed. I will create these
constructs for BRBINF, BRBSRC and BRBTGT based registers set.

> 
> Thanks,
> 
> 	M.
> 
> 
