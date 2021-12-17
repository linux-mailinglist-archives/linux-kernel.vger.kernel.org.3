Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89CD478376
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhLQDD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhLQDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639710206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4QvTI7P9TvqWGOFx6RR2f9IccH2FkTz/UFPpGxuEGMo=;
        b=X/pnEsxtC8bMEQmEvD7M+sKVRoXvFpTAO2vLIQRkovB6YDUbUatLxLqoH0w2OECheOBR4l
        RyLgP+2BLdV/NUpQSwuoNveOPXumFwQKzibkIhMUrFuOOeSmE6rOcK4uByQCp/nADOotE1
        0mpsDArewN/BcarI2JK2BlJr6r4a9rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-maXxrriFNIKinULqb7Jkyw-1; Thu, 16 Dec 2021 22:03:23 -0500
X-MC-Unique: maXxrriFNIKinULqb7Jkyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC181800D50;
        Fri, 17 Dec 2021 03:03:21 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A0E984638;
        Fri, 17 Dec 2021 03:03:05 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:03:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
        bp@alien8.de, tglx@linutronix.de, ebiederm@xmission.com,
        dyoung@redhat.com, fam.zheng@bytedance.com
Subject: Re: [PATCH v3] x86/purgatory: convert
 CONFIG_ARCH_HAS_KEXEC_PURGATORY to be user selectable
Message-ID: <20211217030301.GC2970@MiWiFi-R3L-srv>
References: <20211206164724.2125489-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206164724.2125489-1-usama.arif@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/21 at 04:47pm, Usama Arif wrote:
> This patch converts the existing config option that only enabled
> purgatory for specific architectures in which it has been currently
> implemented (x86, powerpc and s390) to an option that allows purgatory
> to be disabled (with default enabled) and only provides code to disable
> purgatory for x86 only. This would give the option to make kexec operation
> on x86 similar to arm64 or riscv, i.e. skipping purgatory.
> 
> Disabling purgatory reduces the boot time if it is not needed
> as the sha256 digest of kexec segments is no longer calculated
> or verified. This helps reduce the downtime of servers when
> the host kernel managing multiple VMs needs to be updated via kexec.
> 
> The time taken from reboot to running init process was measured
> with both purgatory enabled and disabled over 20 runs and the
> averages are:
> Purgatory disabled:
> - TSC = 3908766161 cycles
> - ktime = 606.8 ms
> Purgatory enabled:
> - TSC = 5005811885 cycles (28.1% worse)
> - ktime = 843.1 ms (38.9% worse)

So the justifications you stated are as below, right?
1. arm64 and risc-v don't have purgatory
2. your host server will save 0.2s during bootup

For purgatory verification, I think Vivek and Eric have clearly shared
what it is and why it is needed. Kernel is loaded beforehand, then
later trigger jumping. The loaded kernel/initramfs could be stumped into
by any behaviour of running kernel. When this kind of stumping happend,
it's very difficult to position. Obviously the verification is necessary.
arm64 and risc-v skipping is a flaw we should fix, but not a shinning
point other ARCH need study on the contrary.

Knowing above, you will definitely feel the saved 0.2 is not worthy of
mentioning.

So I would say this is not convincing. Sorry about that.

> 
> Hence disabling purgatory has a significant improvement in kexec
> time.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Reviewed-by: Fam Zheng <fam.zheng@bytedance.com>
> 
> ---
> v3 changes:
>  - Updated commit mesage to make the patch clearer.
> 
> v2 changes:
>  - Updated commit message to include timing and usecase.
>  - Fixed bug in v1 in which bootparam_load_addr was not passed when
>    purgatory was disabled.
> ---
>  arch/powerpc/Kbuild                  |  2 +-
>  arch/powerpc/Kconfig                 |  2 +-
>  arch/s390/Kbuild                     |  2 +-
>  arch/s390/Kconfig                    |  2 +-
>  arch/s390/purgatory/Makefile         |  2 +-
>  arch/x86/Kbuild                      |  2 +-
>  arch/x86/Kconfig                     |  6 ++-
>  arch/x86/include/asm/kexec.h         |  3 +-
>  arch/x86/kernel/kexec-bzimage64.c    | 70 ++++++++++++++++------------
>  arch/x86/kernel/machine_kexec_64.c   |  3 +-
>  arch/x86/kernel/relocate_kernel_64.S |  8 ++++
>  arch/x86/purgatory/Makefile          |  2 +-
>  include/linux/kexec.h                |  5 ++
>  kernel/kexec_file.c                  |  9 ++--
>  14 files changed, 73 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
> index 22cd0d55a892..072e62d7898e 100644
> --- a/arch/powerpc/Kbuild
> +++ b/arch/powerpc/Kbuild
> @@ -15,7 +15,7 @@ obj-$(CONFIG_KVM)  += kvm/
>  
>  obj-$(CONFIG_PERF_EVENTS) += perf/
>  obj-$(CONFIG_KEXEC_CORE)  += kexec/
> -obj-$(CONFIG_KEXEC_FILE)  += purgatory/
> +obj-$(CONFIG_KEXEC_PURGATORY)  += purgatory/
>  
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index dea74d7717c0..58bdfd1abb44 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -557,7 +557,7 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to a list of segments as is the
>  	  case for the older kexec call.
>  
> -config ARCH_HAS_KEXEC_PURGATORY
> +config KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  
>  config RELOCATABLE
> diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
> index 76e362277179..2ed4ee5cdf59 100644
> --- a/arch/s390/Kbuild
> +++ b/arch/s390/Kbuild
> @@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS_FS)	+= hypfs/
>  obj-$(CONFIG_APPLDATA_BASE)	+= appldata/
>  obj-y				+= net/
>  obj-$(CONFIG_PCI)		+= pci/
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
> +obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
>  
>  # for cleaning
>  subdir- += boot tools
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2a5bb4f29cfe..d15bdaa0e198 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -538,7 +538,7 @@ config KEXEC_FILE
>  	  kexec system call this system call takes file descriptors for the
>  	  kernel and initramfs as arguments.
>  
> -config ARCH_HAS_KEXEC_PURGATORY
> +config KEXEC_PURGATORY
>  	def_bool y
>  	depends on KEXEC_FILE
>  
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index 360ada80d20c..03cac6d7310a 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
>  $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
>  	$(call if_changed_rule,as_o_S)
>  
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
> +obj-$(CONFIG_KEXEC_PURGATORY) += kexec-purgatory.o
> diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
> index f384cb1a4f7a..9089438ed6d8 100644
> --- a/arch/x86/Kbuild
> +++ b/arch/x86/Kbuild
> @@ -24,7 +24,7 @@ obj-$(CONFIG_IA32_EMULATION) += ia32/
>  obj-y += platform/
>  obj-y += net/
>  
> -obj-$(CONFIG_KEXEC_FILE) += purgatory/
> +obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
>  
>  # for cleaning
>  subdir- += boot tools
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7399327d1eff..7efe6dbfdc67 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2000,8 +2000,10 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> -config ARCH_HAS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +config KEXEC_PURGATORY
> +	bool "A standalone relocatable object run between the 2 kernels during kexec"
> +	depends on KEXEC_FILE
> +	default y
>  
>  config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 11b7c06e2828..8c33bb32b593 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -129,7 +129,8 @@ relocate_kernel(unsigned long indirection_page,
>  		unsigned long page_list,
>  		unsigned long start_address,
>  		unsigned int preserve_context,
> -		unsigned int host_mem_enc_active);
> +		unsigned int host_mem_enc_active,
> +		unsigned long bootparam_load_addr);
>  #endif
>  
>  #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..dbaa0e8c7634 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -374,18 +374,19 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  			return ERR_PTR(ret);
>  	}
>  
> -	/*
> -	 * Load purgatory. For 64bit entry point, purgatory  code can be
> -	 * anywhere.
> -	 */
> -	ret = kexec_load_purgatory(image, &pbuf);
> -	if (ret) {
> -		pr_err("Loading purgatory failed\n");
> -		return ERR_PTR(ret);
> -	}
> -
> -	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
> +	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
> +		/*
> +		 * Load purgatory. For 64bit entry point, purgatory  code can be
> +		 * anywhere.
> +		 */
> +		ret = kexec_load_purgatory(image, &pbuf);
> +		if (ret) {
> +			pr_err("Loading purgatory failed\n");
> +			return ERR_PTR(ret);
> +		}
>  
> +		pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
> +	}
>  
>  	/*
>  	 * Load Bootparams and cmdline and space for efi stuff.
> @@ -466,28 +467,37 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	params->hdr.type_of_loader = 0x0D << 4;
>  	params->hdr.loadflags = 0;
>  
> -	/* Setup purgatory regs for entry */
> -	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
> -					     sizeof(regs64), 1);
> -	if (ret)
> -		goto out_free_params;
> +	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
> +		/* Setup purgatory regs for entry */
> +		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
> +						     sizeof(regs64), 1);
> +		if (ret)
> +			goto out_free_params;
>  
> -	regs64.rbx = 0; /* Bootstrap Processor */
> -	regs64.rsi = bootparam_load_addr;
> -	regs64.rip = kernel_load_addr + 0x200;
> -	stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
> -	if (IS_ERR(stack)) {
> -		pr_err("Could not find address of symbol stack_end\n");
> -		ret = -EINVAL;
> -		goto out_free_params;
> -	}
> +		regs64.rbx = 0; /* Bootstrap Processor */
> +		regs64.rsi = bootparam_load_addr;
> +		regs64.rip = kernel_load_addr + 0x200;
>  
> -	regs64.rsp = (unsigned long)stack;
> -	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
> -					     sizeof(regs64), 0);
> -	if (ret)
> -		goto out_free_params;
> +		stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
> +		if (IS_ERR(stack)) {
> +			pr_err("Could not find address of symbol stack_end\n");
> +			ret = -EINVAL;
> +			goto out_free_params;
> +		}
>  
> +		regs64.rsp = (unsigned long)stack;
> +		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
> +						     sizeof(regs64), 0);
> +		if (ret)
> +			goto out_free_params;
> +	} else {
> +		/*
> +		 * Pass kernel and bootparam load address to relocate_kernel
> +		 * if purgatory is disabled.
> +		 */
> +		image->start = kernel_load_addr + 0x200;
> +		image->bootparam_load_addr = bootparam_load_addr;
> +	}
>  	ret = setup_boot_parameters(image, params, bootparam_load_addr,
>  				    efi_map_offset, efi_map_sz,
>  				    efi_setup_data_offset);
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index f5da4a18070a..f7b009768652 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -359,7 +359,8 @@ void machine_kexec(struct kimage *image)
>  				       (unsigned long)page_list,
>  				       image->start,
>  				       image->preserve_context,
> -				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
> +				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT),
> +				       image->bootparam_load_addr);
>  
>  #ifdef CONFIG_KEXEC_JUMP
>  	if (image->preserve_context)
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index c8fe74a28143..12789c8eabe6 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -48,6 +48,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	 * %rdx start address
>  	 * %rcx preserve_context
>  	 * %r8  host_mem_enc_active
> +	 * %r9  bootparam_load_addr
>  	 */
>  
>  	/* Save the CPU context, used for jumping back */
> @@ -59,6 +60,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	pushq %r15
>  	pushf
>  
> +	/* Save bootparam_load_addr in %r14  */
> +	movq	%r9, %r14
> +
>  	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
>  	movq	%rsp, RSP(%r11)
>  	movq	%cr0, %rax
> @@ -179,7 +183,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	xorl	%ebx, %ebx
>  	xorl    %ecx, %ecx
>  	xorl    %edx, %edx
> +#ifdef CONFIG_KEXEC_PURGATORY
>  	xorl    %esi, %esi
> +#else
> +	movq    %r14, %rsi
> +#endif
>  	xorl    %edi, %edi
>  	xorl    %ebp, %ebp
>  	xorl	%r8d, %r8d
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..688b3f21be8f 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>  	$(call if_changed,bin2c)
>  
> -obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
> +obj-$(CONFIG_KEXEC_PURGATORY)	+= kexec-purgatory.o
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..818c3770158f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -313,6 +313,11 @@ struct kimage {
>  	void *elf_headers;
>  	unsigned long elf_headers_sz;
>  	unsigned long elf_load_addr;
> +
> +#ifndef CONFIG_PURGATORY
> +	unsigned long bootparam_load_addr;
> +#endif
> +
>  };
>  
>  /* kexec interface functions */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..ad3131880a37 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -108,6 +108,7 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  }
>  #endif
>  
> +#ifdef CONFIG_KEXEC_PURGATORY
>  /*
>   * arch_kexec_apply_relocations_add - apply relocations of type RELA
>   * @pi:		Purgatory to be relocated.
> @@ -141,7 +142,7 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  	pr_err("REL relocation unsupported.\n");
>  	return -ENOEXEC;
>  }
> -
> +#endif /* CONFIG_KEXEC_PURGATORY */
>  /*
>   * Free up memory used by kernel, initrd, and command line. This is temporary
>   * memory allocation which is not needed any more after these buffers have
> @@ -724,7 +725,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	struct kexec_sha_region *sha_regions;
>  	struct purgatory_info *pi = &image->purgatory_info;
>  
> -	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))
> +	if (!IS_ENABLED(CONFIG_KEXEC_PURGATORY))
>  		return 0;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> @@ -829,7 +830,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> +#ifdef CONFIG_KEXEC_PURGATORY
>  /*
>   * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
>   * @pi:		Purgatory to be loaded.
> @@ -1176,7 +1177,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  
>  	return 0;
>  }
> -#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
> +#endif /* CONFIG_KEXEC_PURGATORY */
>  
>  int crash_exclude_mem_range(struct crash_mem *mem,
>  			    unsigned long long mstart, unsigned long long mend)
> -- 
> 2.25.1
> 

