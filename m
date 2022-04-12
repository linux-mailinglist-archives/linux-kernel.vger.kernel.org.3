Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410A4FE22C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355919AbiDLNUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357478AbiDLNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:19:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44B3C4A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:08:38 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kd5Zz5f6mzgYTs;
        Tue, 12 Apr 2022 21:06:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:08:24 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:08:24 +0800
Message-ID: <af6bd17a-d2ec-3d1a-8360-b51fe38ecdd9@huawei.com>
Date:   Tue, 12 Apr 2022 21:08:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC PATCH -next V3 3/6] arm64: add support for machine check
 error safe
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-4-tongtiangen@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220412072552.2526871-4-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/12 15:25, Tong Tiangen wrote:
> During the processing of arm64 kernel hardware memory errors(do_sea()), if
> the errors is consumed in the kernel, the current processing is panic.
> However, it is not optimal.
>
> Take uaccess for example, if the uaccess operation fails due to memory
> error, only the user process will be affected, kill the user process
> and isolate the user page with hardware memory errors is a better choice.
>
> This patch only enable machine error check framework, it add exception
> fixup before kernel panic in do_sea() and only limit the consumption of
> hardware memory errors in kernel mode triggered by user mode processes.
> If fixup successful, panic can be avoided.
>
> Consistent with PPC/x86, it is implemented by CONFIG_ARCH_HAS_COPY_MC.
>
> Also add copy_mc_to_user() in include/linux/uaccess.h, this helper is
> called when CONFIG_ARCH_HAS_COPOY_MC is open.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>   arch/arm64/Kconfig               |  1 +
>   arch/arm64/include/asm/extable.h |  1 +
>   arch/arm64/mm/extable.c          | 18 ++++++++++++++++++
>   arch/arm64/mm/fault.c            | 28 ++++++++++++++++++++++++++++
>   include/linux/uaccess.h          |  8 ++++++++
>   5 files changed, 56 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index d9325dd95eba..012e38309955 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -19,6 +19,7 @@ config ARM64
>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>   	select ARCH_HAS_CACHE_LINE_SIZE
> +	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
>   	select ARCH_HAS_CURRENT_STACK_POINTER
>   	select ARCH_HAS_DEBUG_VIRTUAL
>   	select ARCH_HAS_DEBUG_VM_PGTABLE
> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
> index 72b0e71cc3de..f80ebd0addfd 100644
> --- a/arch/arm64/include/asm/extable.h
> +++ b/arch/arm64/include/asm/extable.h
> @@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>   #endif /* !CONFIG_BPF_JIT */
>   
>   bool fixup_exception(struct pt_regs *regs);
> +bool fixup_exception_mc(struct pt_regs *regs);
>   #endif
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 489455309695..5de256a25464 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -9,6 +9,7 @@
>   
>   #include <asm/asm-extable.h>
>   #include <asm/ptrace.h>
> +#include <asm/esr.h>
>   
>   static inline unsigned long
>   get_ex_fixup(const struct exception_table_entry *ex)
> @@ -73,6 +74,7 @@ bool fixup_exception(struct pt_regs *regs)
>   
>   	switch (ex->type) {
>   	case EX_TYPE_FIXUP:
> +	case EX_TYPE_UACCESS_MC:
>   		return ex_handler_fixup(ex, regs);
>   	case EX_TYPE_BPF:
>   		return ex_handler_bpf(ex, regs);
> @@ -84,3 +86,19 @@ bool fixup_exception(struct pt_regs *regs)
>   
>   	BUG();
>   }
> +
> +bool fixup_exception_mc(struct pt_regs *regs)
> +{
> +	const struct exception_table_entry *ex;
> +
> +	ex = search_exception_tables(instruction_pointer(regs));
> +	if (!ex)
> +		return false;
> +
> +	switch (ex->type) {
> +	case EX_TYPE_UACCESS_MC:
> +		return ex_handler_fixup(ex, regs);
> +	}
> +
> +	return false;
> +}

The definition of EX_TYPE_UACCESS_MC is in patch4, please fix it, and if 
arm64 exception table

is sorted by exception type, we could drop fixup_exception_mc(), right?

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 77341b160aca..56b13cf8bf1d 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -695,6 +695,30 @@ static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
>   	return 1; /* "fault" */
>   }
>   
> +static bool arm64_process_kernel_sea(unsigned long addr, unsigned int esr,
> +				     struct pt_regs *regs, int sig, int code)
> +{
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
> +		return false;
> +
> +	if (user_mode(regs) || !current->mm)
> +		return false;
> +
> +	if (apei_claim_sea(regs) < 0)
> +		return false;
> +
> +	current->thread.fault_address = 0;
> +	current->thread.fault_code = esr;
> +
Use set_thread_esr(0, esr) and move it after fixup_exception_mc();
> +	if (!fixup_exception_mc(regs))
> +		return false;
> +
> +	arm64_force_sig_fault(sig, code, addr,
> +		"Uncorrected hardware memory error in kernel-access\n");
> +
> +	return true;
> +}
> +
>   static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
>   {
>   	const struct fault_info *inf;
> @@ -720,6 +744,10 @@ static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
>   		 */
>   		siaddr  = untagged_addr(far);
>   	}
> +
> +	if (arm64_process_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
> +		return 0;
> +

Rename arm64_process_kernel_sea() to arm64_do_kernel_sea() ?

if (!arm64_do_kernel_sea())

     arm64_notify_die();

>   	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>   
>   	return 0;
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 546179418ffa..dd952aeecdc1 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -174,6 +174,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
>   }
>   #endif
>   
> +#ifndef copy_mc_to_user
> +static inline unsigned long __must_check
> +copy_mc_to_user(void *dst, const void *src, size_t cnt)
> +{
Add check_object_size(cnt, src, true);  which could make 
HARDENED_USERCOPY works.
> +	return raw_copy_to_user(dst, src, cnt);
> +}
> +#endif
> +
>   static __always_inline void pagefault_disabled_inc(void)
>   {
>   	current->pagefault_disabled++;
