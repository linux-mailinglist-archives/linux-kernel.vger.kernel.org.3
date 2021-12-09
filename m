Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA47646E0B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhLICKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:10:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16348 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLICJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:09:59 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J8cnj5tNWz91gw;
        Thu,  9 Dec 2021 10:05:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 10:06:24 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 10:06:23 +0800
Subject: Re: [PATCH v16 08/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL
 config
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-9-thunder.leizhen@huawei.com> <YbDmxIPdk7TKIKAU@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <092fd3d7-240a-da47-f252-c3c570cb8389@huawei.com>
Date:   Thu, 9 Dec 2021 10:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YbDmxIPdk7TKIKAU@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/9 1:09, Catalin Marinas wrote:
> On Tue, Nov 23, 2021 at 08:46:43PM +0800, Zhen Lei wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 26b8ed11639da46..19256aa924c3b2c 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -24,6 +24,9 @@ config KEXEC_ELF
>>  config HAVE_IMA_KEXEC
>>  	bool
>>  
>> +config ARCH_WANT_RESERVE_CRASH_KERNEL
>> +	bool
>> +
>>  config SET_FS
>>  	bool
>>  
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index c4207cf9bb17ffb..4b99efa36da3793 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -95,6 +95,7 @@ config ARM64
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>  	select ARCH_WANT_LD_ORPHAN_WARN
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select ARCH_WANTS_NO_INSTR
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>  	select ARM_AMBA
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7399327d1eff79d..528034b4276ecf8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -12,6 +12,7 @@ config X86_32
>>  	depends on !64BIT
>>  	# Options that are inherently 32-bit kernel only:
>>  	select ARCH_WANT_IPC_PARSE_VERSION
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select CLKSRC_I8253
>>  	select CLONE_BACKWARDS
>>  	select GENERIC_VDSO_32
>> @@ -28,6 +29,7 @@ config X86_64
>>  	select ARCH_HAS_GIGANTIC_PAGE
>>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select HAVE_ARCH_SOFT_DIRTY
>>  	select MODULES_USE_ELF_RELA
>>  	select NEED_DMA_MAP_STATE
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 4dc2643fcbccf99..b23cfc0ca8905fd 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -321,9 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
>>   * --------- Crashkernel reservation ------------------------------
>>   */
>>  
>> -#ifdef CONFIG_KEXEC_CORE
>> -
>> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>> +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
>>  static int __init reserve_crashkernel_low(void)
>>  {
>>  #ifdef CONFIG_64BIT
>> @@ -451,8 +449,7 @@ void __init reserve_crashkernel(void)
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end   = crash_base + crash_size - 1;
>>  }
>> -#endif
>> -#endif /* CONFIG_KEXEC_CORE */
>> +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
> 
> Nitpick mostly but it may simplify the patches if the x86, arch/Kconfig
> and crash_core.c changes here could be moved to patch 5. The remaining
> select for arm64 should be moved to patch 7 and drop the #if change in
> that patch.
> 
> This way we can keep the x86 patches on a separate branch.

That's a good suggestion. I will do it.

> 
> Thanks.
> 
