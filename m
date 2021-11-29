Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB44F462578
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhK2WkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:40:20 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43904 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhK2Wjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:39:36 -0500
Received: by mail-qk1-f174.google.com with SMTP id 193so24663495qkh.10;
        Mon, 29 Nov 2021 14:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYq4GIQm8QrcJcBYcEtsoL1OUQLtI2uaYWFL3tBum1w=;
        b=LbgBUqhNIy40wg1QUS1O3Fphc27umuphTHuXF3Vh3p1aXDpxMB8u1x0uBkoReEpCim
         Qws+MlUTR+44z5ZnZVEakENKrcwpLTdrfU6pwuCdhEuE6836/zJvFiv0hy41mtw4lmZY
         1YLN8tM5kVsTYc3cIzQP+cRTcOaYPlO8T+3OWsTzHWZrV97lVx4noL+mCOFlQM5/kb/e
         xtbk1IkPKi2J95tRlaAM1vZee91lCGFIz1G0UNuyid/iSgKkmcIGicP2EandWWCAfE0l
         7uRKUoXjM5Kdq43vLMRdIArpNpF15lLBKDwojgjufzkihBUzlfrXdJGQbOAFXSSB8sJh
         HP+w==
X-Gm-Message-State: AOAM5331ZxbkcQSMXFEsbKKOYHbqHyekgfiKxHLIJOBJGBNeYh9fEOy4
        V58Wg1UvjDtYEfnBxmUGGkPHwgK+q5yYNA==
X-Google-Smtp-Source: ABdhPJzJz5BEY0tJAESTBlt73gwvqVTS7JmG7hyL3hoGsSGW1neE0oIGr731XokwLH4ohx1EX356dw==
X-Received: by 2002:a05:620a:4092:: with SMTP id f18mr31107993qko.629.1638225377694;
        Mon, 29 Nov 2021 14:36:17 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id 9sm8636358qkm.5.2021.11.29.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:36:17 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:36:15 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     dennis@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
        gregkh@linuxfoundation.org, cl@linux.com, catalin.marinas@arm.com,
        will@kernel.org, tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 1/4] mm: percpu: Generalize percpu related config
Message-ID: <YaVV38QSn6LEBKH/@fedora>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
 <20211121093557.139034-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121093557.139034-2-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Nov 21, 2021 at 05:35:54PM +0800, Kefeng Wang wrote:
> The HAVE_SETUP_PER_CPU_AREA/NEED_PER_CPU_EMBED_FIRST_CHUNK/
> NEED_PER_CPU_PAGE_FIRST_CHUNK/USE_PERCPU_NUMA_NODE_ID configs,
> which has duplicate definitions on platforms that subscribe it.
> 
> Move them into mm, drop these redundant definitions and instead
> just select it on applicable platforms.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig   | 20 ++++----------------
>  arch/ia64/Kconfig    |  9 ++-------
>  arch/mips/Kconfig    | 10 ++--------
>  arch/powerpc/Kconfig | 17 ++++-------------
>  arch/riscv/Kconfig   | 10 ++--------
>  arch/sparc/Kconfig   | 12 +++---------
>  arch/x86/Kconfig     | 17 ++++-------------
>  mm/Kconfig           | 12 ++++++++++++
>  8 files changed, 33 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..4ff73299f8a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1135,6 +1135,10 @@ config NUMA
>  	select GENERIC_ARCH_NUMA
>  	select ACPI_NUMA if ACPI
>  	select OF_NUMA
> +	select HAVE_SETUP_PER_CPU_AREA
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -1151,22 +1155,6 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 1e33666fa679..703952819e10 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -32,6 +32,7 @@ config IA64
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_DYNAMIC_FTRACE if (!ITANIUM)
>  	select HAVE_FUNCTION_TRACER
> +	select HAVE_SETUP_PER_CPU_AREA
>  	select TTY
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_VIRT_CPU_ACCOUNTING
> @@ -88,9 +89,6 @@ config GENERIC_CALIBRATE_DELAY
>  	bool
>  	default y
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -
>  config DMI
>  	bool
>  	default y
> @@ -292,6 +290,7 @@ config NUMA
>  	bool "NUMA support"
>  	depends on !FLATMEM
>  	select SMP
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
>  	  Access).  This option is for configuring high-end multiprocessor
> @@ -311,10 +310,6 @@ config HAVE_ARCH_NODEDATA_EXTENSION
>  	def_bool y
>  	depends on NUMA
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
>  config HAVE_MEMORYLESS_NODES
>  	def_bool NUMA
>  
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index de60ad190057..c106a2080877 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2666,6 +2666,8 @@ config NUMA
>  	bool "NUMA Support"
>  	depends on SYS_SUPPORTS_NUMA
>  	select SMP
> +	select HAVE_SETUP_PER_CPU_AREA
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	help
>  	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
>  	  Access).  This option improves performance on systems with more
> @@ -2676,14 +2678,6 @@ config NUMA
>  config SYS_SUPPORTS_NUMA
>  	bool
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
>  config RELOCATABLE
>  	bool "Relocatable kernel"
>  	depends on SYS_SUPPORTS_RELOCATABLE
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index dea74d7717c0..8badd39854a0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -55,15 +55,6 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>  	default 9 if PPC_16K_PAGES	#  9 = 23 (8MB) - 14 (16K)
>  	default 11			# 11 = 23 (8MB) - 12 (4K)
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool PPC64
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y if PPC64
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y if PPC64
> -
>  config NR_IRQS
>  	int "Number of virtual interrupt numbers"
>  	range 32 1048576
> @@ -240,6 +231,7 @@ config PPC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RSEQ
> +	select HAVE_SETUP_PER_CPU_AREA		if PPC64
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
>  	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
> @@ -254,6 +246,8 @@ config PPC
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
> +	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
>  	select NEED_SG_DMA_LENGTH
>  	select OF
>  	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
> @@ -659,6 +653,7 @@ config NUMA
>  	bool "NUMA Memory Allocation and Scheduler Support"
>  	depends on PPC64 && SMP
>  	default y if PPC_PSERIES || PPC_POWERNV
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -672,10 +667,6 @@ config NODES_SHIFT
>  	default "4"
>  	depends on NUMA
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
>  config HAVE_MEMORYLESS_NODES
>  	def_bool y
>  	depends on NUMA
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 821252b65f89..bf66bcbc5a39 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -334,6 +334,8 @@ config NUMA
>  	select GENERIC_ARCH_NUMA
>  	select OF_NUMA
>  	select ARCH_SUPPORTS_NUMA_BALANCING
> +	select USE_PERCPU_NUMA_NODE_ID
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -349,14 +351,6 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
>  config RISCV_ISA_C
>  	bool "Emit compressed instructions when building Linux"
>  	default y
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 66fc08646be5..a6765e0fe6a8 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -97,6 +97,9 @@ config SPARC64
>  	select PCI_DOMAINS if PCI
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
> +	select HAVE_SETUP_PER_CPU_AREA
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	select NEED_PER_CPU_PAGE_FIRST_CHUUNK
>  
>  config ARCH_PROC_KCORE_TEXT
>  	def_bool y
> @@ -123,15 +126,6 @@ config AUDIT_ARCH
>  	bool
>  	default y
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y if SPARC64
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y if SPARC64
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y if SPARC64
> -
>  config MMU
>  	bool
>  	default y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7399327d1eff..ca120a1f5857 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -239,6 +239,7 @@ config X86
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
>  	select HAVE_FUNCTION_ARG_ACCESS_API
> +	select HAVE_SETUP_PER_CPU_AREA
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
>  	select HAVE_STACK_VALIDATION		if X86_64
> @@ -252,6 +253,8 @@ config X86
>  	select HAVE_GENERIC_VDSO
>  	select HOTPLUG_SMT			if SMP
>  	select IRQ_FORCED_THREADING
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	select NEED_PER_CPU_PAGE_FIRST_CHUNK
>  	select NEED_SG_DMA_LENGTH
>  	select PCI_DOMAINS			if PCI
>  	select PCI_LOCKLESS_CONFIG		if PCI
> @@ -331,15 +334,6 @@ config ARCH_HAS_CPU_RELAX
>  config ARCH_HAS_FILTER_PGPROT
>  	def_bool y
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y
> -
>  config ARCH_HIBERNATION_POSSIBLE
>  	def_bool y
>  
> @@ -1557,6 +1551,7 @@ config NUMA
>  	depends on SMP
>  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
>  	default y if X86_BIGSMP
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -2430,10 +2425,6 @@ config ARCH_HAS_ADD_PAGES
>  config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  	def_bool y
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
>  menu "Power management and ACPI options"
>  
>  config ARCH_HIBERNATION_HEADER
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 28edafc820ad..6bc5d780c51b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -432,6 +432,18 @@ config NEED_PER_CPU_KM
>  	bool
>  	default y
>  
> +config NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	bool
> +
> +config NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	bool
> +
> +config USE_PERCPU_NUMA_NODE_ID
> +	bool
> +
> +config HAVE_SETUP_PER_CPU_AREA
> +	bool
> +
>  config CLEANCACHE
>  	bool "Enable cleancache driver to cache clean pages if tmem is present"
>  	help
> -- 
> 2.26.2
> 

This makes sense and looks good. A series like this is a little tricky.
The latter patches change the contracts so it'd be easiest to run it
through my tree. We'd need to get explicit acks from each arch
maintainer to make sure they're fine with this.

Thanks,
Dennis
