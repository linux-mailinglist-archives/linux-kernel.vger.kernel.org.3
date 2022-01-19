Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE526493856
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353599AbiASKXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345318AbiASKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642587825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mD6FCNsAesJULpYT9e8tBBQB62xpNJ5X6eOIuJGkGOA=;
        b=MRWMeLc6iP2meyPlFU1KICpH34RKpBNSKhU8YFlhmlniHPKgEItYSTlbQwlidj0sSVthwO
        eHjWmOZewxwXF1N8Eu8a7s8+yQ3dolCwGvtDbtRy2QaGhI5gMvnl7jE9+wPURA6cim/jUE
        wBVO0KgAJIezaqoS3oU1/XQTPuq7h4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-tqV51VgSNOm-FRku1u20cg-1; Wed, 19 Jan 2022 05:23:41 -0500
X-MC-Unique: tqV51VgSNOm-FRku1u20cg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F4E46409C;
        Wed, 19 Jan 2022 10:23:39 +0000 (UTC)
Received: from localhost (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF92D752A7;
        Wed, 19 Jan 2022 10:23:25 +0000 (UTC)
Date:   Wed, 19 Jan 2022 18:23:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
Message-ID: <20220119102323.GB6349@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110195727.1682-7-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/22 at 02:57pm, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and if no errors occur, it is
> installed over the top of the existing elfcorehdr.
> 
> In the patch 'crash hp: kexec_file changes for crash hotplug support'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
> 
> NOTE that this supports both kexec_load and kexec_file_load. Support
> for kexec_load is made possible by identifying the elfcorehdr segment
> at load time and updating it as previously described. However, it is
> the responsibility of the userspace kexec utility to ensure that:
>  - the elfcorehdr segment is sufficiently large enough to accommodate
>    hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>  - provides a purgatory that excludes the elfcorehdr from its list of
>    run-time segments to check.
> These changes to the userspace kexec utility are not yet available.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9730c88530fc..d185137b33d4 100644
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
> @@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>  		goto out;
>  
>  	/* By default prepare 64bit headers */
> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> +	ret =  crash_prepare_elf64_headers(image, cmem,
> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>  
>  out:
>  	vfree(cmem);
> @@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers = kbuf.buffer;
>  	image->elf_headers_sz = kbuf.bufsz;
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;

I would define a default value for the size, meantime provide a Kconfig
option to allow user to customize.

> +	/* For marking as usable to crash kernel */
> +	image->elf_headers_sz = kbuf.memsz;
> +	/* Record the index of the elfcorehdr segment */
> +	image->elf_index = image->nr_segments;
> +	image->elf_index_valid = true;
> +#else
>  	kbuf.memsz = kbuf.bufsz;
> +#endif
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#ifdef CONFIG_CRASH_HOTPLUG

These two helper function should be carved out into a separate patch as
a preparatory one. I am considering how to rearrange and split the
patches, will reply to cover letter.

> +void *map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	/*
> +	 * NOTE: The addresses and sizes passed to this routine have
> +	 * already been fully aligned on page boundaries. There is no
> +	 * need for massaging the address or size.
> +	 */
> +	void *ptr = NULL;
> +
> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap(page);
> +	}
> +
> +	return ptr;
> +}
> +
> +void unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap(*ptr);
> +		*ptr = NULL;
> +	}
> +}
> +
> +void arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b)
> +{
> +	/*
> +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
> +	 * is passed to the crash kernel via the elfcorehdr= parameter)
> +	 * must be updated with the new list of CPUs and memories. The new
> +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
> +	 * then it is written on top of the existing/old elfcorehdr.
> +	 *
> +	 * Due to the change to the elfcorehdr, purgatory must explicitly
> +	 * exclude the elfcorehdr from the list of segments it checks.
> +	 */

Please move this code comment to above function as kernel-doc if you
this it benefits the entire function. Otherwise should move them above
the code block they are explaining. For this place, I think moving them
to above arch_crash_hotplug_handler() is better.

> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;
> +	unsigned int n;
> +
> +	/*
> +	 * When the struct kimage is alloced, it is wiped to zero, so
> +	 * the elf_index_valid defaults to false. It is set on the
> +	 * kexec_file_load path, or here for kexec_load.
> +	 */

I think this kexec loading part should be taken out and post after this
whole patchset being accepted. At least, it's worth to put them in a
separate patch.

> +	if (!image->elf_index_valid) {
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = map_crash_pages(mem, memsz);
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if ((ptr[0] == 0x7F) &&
> +					(ptr[1] == 'E') &&
> +					(ptr[2] == 'L') &&
> +					(ptr[3] == 'F')) {

                                      Is this for safety checking later?

> +					image->elf_index = (int)n;
> +					image->elf_index_valid = true;
> +				}
> +			}
> +			unmap_crash_pages((void **)&ptr);
> +		}
> +	}
> +
> +	/* Must have valid elfcorehdr index */
> +	if (!image->elf_index_valid) {
> +		pr_err("crash hp: unable to locate elfcorehdr segment");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources. The elfcorehdr segment memsz must be
> +	 * sufficiently large to accommodate increases due to hotplug
> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("crash hp: unable to prepare elfcore headers");
> +		goto out;
> +	}
> +	ksegment = &image->segment[image->elf_index];
> +	memsz = ksegment->memsz;
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
> +	ksegment = &image->segment[image->elf_index];
> +	mem = ksegment->mem;
> +	memsz = ksegment->memsz;

The ksegment and memsz have repeated assignment.

> +	ptr = map_crash_pages(mem, memsz);
> +	if (ptr) {
> +		/* Temporarily invalidate the crash image while it is replaced */
> +		xchg(&kexec_crash_image, NULL);
> +		/* Write the new elfcorehdr into memory */
> +		memcpy((void *)ptr, elfbuf, elfsz);
> +		/* The crash image is now valid once again */
> +		xchg(&kexec_crash_image, image);
> +	}
> +	unmap_crash_pages((void **)&ptr);
> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
> +
> +//FIX??? somekind of cache flush perhaps?

You might mean memcpy_flushcache() on x86.


> +
> +out:
> +	if (elfbuf)
> +		vfree(elfbuf);
> +}
> +#endif /* CONFIG_CRASH_HOTPLUG */
> -- 
> 2.27.0
> 

