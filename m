Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932505AC907
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiIEDTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiIEDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0C2CCB7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662347954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJDDIimosi3B8c3BT1SCh9Tw4PhjFttJOuZMYJFM+vM=;
        b=PfHNFzQ9rCBlVIO63OVqH47rvQEgXn8oCSbJfxKNQ89md4y1zGBWHxhXb10Dr4RB3IH8D3
        kUq0ona/p75B9QgwRngG5sfd0tb0WRKQtyeu8AH+WXgCCYCC/PN0OHtt5PTlr03wDGtyq3
        ccByb69WBbZeKqpcF6gelsTciZAv1Sc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-CBWU-I71PTmksMhS8Bk3tA-1; Sun, 04 Sep 2022 23:19:10 -0400
X-MC-Unique: CBWU-I71PTmksMhS8Bk3tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D14EC29AA2F5;
        Mon,  5 Sep 2022 03:19:09 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 810A44010E4D;
        Mon,  5 Sep 2022 03:19:08 +0000 (UTC)
Date:   Mon, 5 Sep 2022 11:19:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v11 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <YxVqqUICujTHnzsM@MiWiFi-R3L-srv>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826173704.1895-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/26/22 at 01:37pm, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> When loading the crash kernel via kexec_load or kexec_file_load,
> the elfcorehdr is identified at run time in
> crash_core:handle_hotplug_event().
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and then installed over the top of
> the existing elfcorehdr.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
> 
> With this change, crash hotplug for kexec_file_load syscall
> is supported. The kexec_load is also supported, but also
> requires a corresponding change to userspace kexec-tools.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig             |  11 ++++
>  arch/x86/include/asm/kexec.h |  20 +++++++
>  arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..cdfc9b2fdf98 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	int
> +	default 32768
> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> +	  size to determine the final buffer size.
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index a3760ca796aa..432073385b2d 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>  extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>  extern void kdump_nmi_shootdown_cpus(void);
>  
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
> +#define arch_map_crash_pages arch_map_crash_pages
> +
> +void arch_unmap_crash_pages(void **ptr);
> +#define arch_unmap_crash_pages arch_unmap_crash_pages
> +
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action);
> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static inline int crash_hotplug_cpu_support(void) { return 1; }
> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static inline int crash_hotplug_memory_support(void) { return 1; }
> +#define crash_hotplug_memory_support crash_hotplug_memory_support
> +#endif

Check these two functions again, wonder whether this is a common usage
to show support of a feature. I don't remember where we do like this. We
usually define a global variable to mark it? Anyway, it works. See if
other people have comments, I could be ignorant.

Other than this tiny concern, this patch looks good to me:

Acked-by: Baoquan He <bhe@redhat.com>

> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_KEXEC_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..8fc7d678ac72 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers = kbuf.buffer;
>  	image->elf_headers_sz = kbuf.bufsz;
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz =
> +		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
> +			sizeof(Elf64_Phdr);
> +	/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +	image->elf_headers_sz = kbuf.memsz;
> +	image->elfcorehdr_index = image->nr_segments;
> +	image->elfcorehdr_index_valid = true;
> +#else
>  	kbuf.memsz = kbuf.bufsz;
> +#endif
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	void *ptr = NULL;
> +
> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap_local_page(page);
> +	}
> +
> +	return ptr;
> +}
> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap_local(*ptr);
> +		*ptr = NULL;
> +	}
> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + *
> + * To accurately reflect hot un/plug changes, the new elfcorehdr
> + * is prepared in a kernel buffer, and then it is written on top
> + * of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +	unsigned int hp_action)
> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;
> +
> +	/*
> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
> +	 */
> +	ksegment = &image->segment[image->elfcorehdr_index];
> +	mem = ksegment->mem;
> +	memsz = ksegment->memsz;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("crash hp: unable to prepare elfcore headers");
> +		goto out;
> +	}
> +	if (elfsz > memsz) {
> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * At this point, we are all but assured of success.
> +	 * Copy new elfcorehdr into destination.
> +	 */
> +	ptr = arch_map_crash_pages(mem, memsz);
> +	if (ptr) {
> +		/*
> +		 * Temporarily invalidate the crash image while the
> +		 * elfcorehdr is updated.
> +		 */
> +		xchg(&kexec_crash_image, NULL);
> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
> +		xchg(&kexec_crash_image, image);
> +	}
> +	arch_unmap_crash_pages((void **)&ptr);
> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
> +
> +out:
> +	if (elfbuf)
> +		vfree(elfbuf);
> +}
> +#endif
> -- 
> 2.31.1
> 

