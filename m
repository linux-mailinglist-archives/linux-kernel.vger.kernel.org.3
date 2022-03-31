Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D84ED7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiCaKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiCaKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6E12042A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648722857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozBz5xX3/M+McvlsixTHsMYnNatIyrKEH4e0NxR73NM=;
        b=SClIeyHg4DYmfnGFE5ZVavYqWPxJV1Or0GPGlZ2QX1ZfCqZcLiM73L/5FMZ1gO0N5G0vVH
        688a5Sfo6hfHN5tL8CTEpcj2dGdEunWFco4XdKTvU8J2K29PLGAyY/NyWJqomDjZrcmLmW
        ob3lZ8QpfAEU7Y6U6TotHhw4zeFDCx8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-DYmwmN4pNKWxFbzr-7pX7A-1; Thu, 31 Mar 2022 06:34:15 -0400
X-MC-Unique: DYmwmN4pNKWxFbzr-7pX7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C57BC811E78;
        Thu, 31 Mar 2022 10:34:14 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB0DA41136E0;
        Thu, 31 Mar 2022 10:34:13 +0000 (UTC)
Date:   Thu, 31 Mar 2022 18:34:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
Message-ID: <YkWDnzQoR0CI2zc8@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303162725.49640-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/22 at 11:27am, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and if no errors occur, it is
> installed over the top of the existing elfcorehdr.
> 
> In the patch 'crash hp: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
> 
> With this change, the kexec_file_load syscall (not kexec_load)
> is supported. When loading the crash kernel via kexec_file_load,
> the elfcorehdr is identified at load time in crash_load_segments().

I tune the log a little, please check:

[PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr need be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, then installed over the top of the
existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest',
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

With this change, crash hotplug for kexec_file_load syscall 
is supported. When loading kdump kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/kernel/crash.c | 120 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9db41cce8d97..5da30e2bc780 100644
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
> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers = kbuf.buffer;
>  	image->elf_headers_sz = kbuf.bufsz;
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
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
> @@ -413,3 +424,112 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
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
> +static void unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap(*ptr);
> +		*ptr = NULL;
> +	}
> +}
> +
> +/**
> + * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + * @a: first parameter dependent upon hp_action
> + * @b: first parameter dependent upon hp_action
> + *
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories. The new
> + * elfcorehdr is prepared in a kernel buffer, and if no errors,
                                                 ~~~~~~~~~~~~~~~~~~
                                                 can be removed.
> + * then it is written on top of the existing/old elfcorehdr.
> + *
> + * For hotplug changes to elfcorehdr to work, two conditions are
> + * needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources. See
> + * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + *
> + */
> +void arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b)
> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;
> +
> +	/* Must have valid elfcorehdr index */
        Redundant code comment can be removed.

> +	if (!image->elf_index_valid) {
> +		pr_err("crash hp: unable to locate elfcorehdr segment");
> +		goto out;
> +	}
> +
> +	ksegment = &image->segment[image->elf_index];
> +	mem = ksegment->mem;
> +	memsz = ksegment->memsz;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources. The elfcorehdr segment memsz must be
> +	 * sufficiently large to accommodate increases due to hotplug
> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
> +	 */
        This paragraph could be duplicated with the part in kernel-doc.
        Considering to drop one?
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
> +	ptr = map_crash_pages(mem, memsz);
> +	if (ptr) {
> +		/* Temporarily invalidate the crash image while it is replaced */
> +		xchg(&kexec_crash_image, NULL);
> +		/* Write the new elfcorehdr into memory */
                No need, the code is self explanatory.
> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
> +		/* The crash image is now valid once again */

                ditto. Sometime over commenting is not suggested.

> +		xchg(&kexec_crash_image, image);
> +	}
> +	unmap_crash_pages((void **)&ptr);
> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
> +
> +out:
> +	if (elfbuf)
> +		vfree(elfbuf);
> +}
> +#endif /* CONFIG_CRASH_HOTPLUG */
> -- 
> 2.27.0
> 

