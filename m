Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE55A1FED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiHZEfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHZEfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8CBBFE91
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661488529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9JK9kQIbyb3rduBmI+mCucUnsl1FVro3S5i3XE8VBU=;
        b=D4PN9+2hb91hBf2XAWjAGAMRdg15Bl5zD6cKJt4P26ztTpWqixcZ5I1f+oIOWqJZqijHvD
        Jn2l9B1fwDDsbs2mVqGGtDtHe+WMEP2mfLZ5PpQVK6gPGXGXln8ZsriTYv11cJ1xNQY8BM
        k6hShrE8L10lQmf4ZWozB8kqamithlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-921cXJffMYabm40UmuGCGQ-1; Fri, 26 Aug 2022 00:35:24 -0400
X-MC-Unique: 921cXJffMYabm40UmuGCGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1BD98032F6;
        Fri, 26 Aug 2022 04:35:23 +0000 (UTC)
Received: from localhost (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B62E6945DD;
        Fri, 26 Aug 2022 04:35:22 +0000 (UTC)
Date:   Fri, 26 Aug 2022 12:35:18 +0800
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
Subject: Re: [PATCH v10 8/8] x86/crash: Add x86 crash hotplug support
Message-ID: <YwhNhrlmFH6ps3BN@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-9-eric.devolder@oracle.com>
 <Yvbxgvk+5HqEl7J2@MiWiFi-R3L-srv>
 <0395a745-edbb-275a-f37f-c6e799388da1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0395a745-edbb-275a-f37f-c6e799388da1@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 at 10:23am, Eric DeVolder wrote:
> 
> 
> On 8/12/22 19:34, Baoquan He wrote:
> > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> > ...snip....
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index e58798f636d4..bb59596c8bea 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2065,6 +2065,17 @@ config CRASH_DUMP
> > >   	  (CONFIG_RELOCATABLE=y).
> > >   	  For more details see Documentation/admin-guide/kdump/kdump.rst
> > > +config CRASH_MAX_MEMORY_RANGES
> > > +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> > > +	int
> > > +	default 32768
> > 
> > Do we need to enforce the value with page align and minimal size? I
> 
> Are you asking about the value CRASH_MAX_MEMORY_RANGES? This value represents
> the maximum number of memory ranges, and there Elf64_Phdrs, that we need to
> allow for elfcorehdr memory. So I'm not sure what the concern for alignment
> is. I suppose we could also institute a minimum size for this value, say 1024.
> 
> > checked crash_load_segments() in arch/x86/kernel/crash.c, it does the
> > page size aligning in kexec_add_buffer(). And in
> > load_crashdump_segments() of
> > kexec-tools/kexec/arch/i386/crashdump-x86.c, it creates elfcorehdr at
> > below code, the align is 1024, and in generic add_buffer()
> > implementation, it enforces the memsz page aligned, and changes the
> > passed align as page alignment.
> > 
> > 
> > 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
> >                                                          max_addr, -1);
> > 
> > Maybe we should at least mention this in the help text to notice people.
> 
> Unfortunately I do not yet understand the concern being raised.

Oops, never mind, I misunderstood CRASH_MAX_MEMORY_RANGES. Thought it's
the range vlaue of buffer containing elfcorehdr, I must be dizzy when
reading this part.

> 
> > 
...snip...
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index 9ceb93c176a6..55dda4fcde6e 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -25,6 +25,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/vmalloc.h>
> > >   #include <linux/memblock.h>
> > > +#include <linux/highmem.h>
> > >   #include <asm/processor.h>
> > >   #include <asm/hardirq.h>
> > > @@ -397,7 +398,17 @@ int crash_load_segments(struct kimage *image)
> > >   	image->elf_headers = kbuf.buffer;
> > >   	image->elf_headers_sz = kbuf.bufsz;
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> > > +	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> > 
> > Do we need to break the line to 80 chars?
> 
> Sure, I will do so.
> 
> > 
> > > +	/* For marking as usable to crash kernel */
> > > +	image->elf_headers_sz = kbuf.memsz;
> > 
> > Do we need this code comment?
> 
> Well, it did take me a while to figure this particular item out in order for all
> this code to work right (else the crash kernel would fail at boot time). So I
> think it best to keep this comment.
> 
> > 
> > > +	/* Record the index of the elfcorehdr segment */
> > > +	image->elfcorehdr_index = image->nr_segments;
> > 
> > And this place?
> 
> Not necessarily needed, but I've found it useful.
> 
> > 
> > > +	image->elfcorehdr_index_valid = true;
> > > +#else
> > >   	kbuf.memsz = kbuf.bufsz;
> > > +#endif
> > >   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> > >   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > >   	ret = kexec_add_buffer(&kbuf);
> > > @@ -412,3 +423,107 @@ int crash_load_segments(struct kimage *image)
> > >   	return ret;
> > >   }
> > >   #endif /* CONFIG_KEXEC_FILE */
> > > +
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> > > +{
> > > +	/*
> > > +	 * NOTE: The addresses and sizes passed to this routine have
> > > +	 * already been fully aligned on page boundaries. There is no
> > > +	 * need for massaging the address or size.
> > > +	 */
> > 
> > Can we move the code comment above function interface?
> 
> Yes
> 
> > 
> > > +	void *ptr = NULL;
> > > +
> > > +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> > 
> > Do we need this code comment? On ARCH where proctionion is made, we
> > surely need to the protect/unprotect.
> 
> I will remove this; I've mentioned this in handle_hotplug_event() where these
> protect/unprotect functions are called.
> 
> > 
> > > +	if (size > 0) {
> > > +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> > > +
> > > +		ptr = kmap_local_page(page);
> > > +	}
> > > +
> > > +	return ptr;
> > > +}
> > > +
> > > +void arch_unmap_crash_pages(void **ptr)
> > > +{
> > > +	if (ptr) {
> > > +		if (*ptr)
> > > +			kunmap_local(*ptr);
> > > +		*ptr = NULL;
> > > +	}
> > > +}
> > > +
> > > +/**
> > > + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> > > + * @image: the active struct kimage
> > > + * @hp_action: the hot un/plug action being handled
> > > + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
> > > + *
> > > + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> > > + * is passed to the crash kernel via the elfcorehdr= parameter)
> > > + * must be updated with the new list of CPUs and memories. The new
> > > + * elfcorehdr is prepared in a kernel buffer, and then it is
> > > + * written on top of the existing/old elfcorehdr.
> > > + *
> > > + * For hotplug changes to elfcorehdr to work, two conditions are
> > > + * needed:
> > > + * First, the segment containing the elfcorehdr must be large enough
> > > + * to permit a growing number of resources. See the
> > > + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
> > > + * Second, purgatory must explicitly exclude the elfcorehdr from the
> > > + * list of segments it checks (since the elfcorehdr changes and thus
> > > + * would require an update to purgatory itself to update the digest).
> > 
> > Isn't this generic concept to crash hotplug? Should we move it out to
> > some generic place?
> 
> Yes, so I will relocate this.
> 
> > 
> > > + *
> > > + */
> > > +void arch_crash_handle_hotplug_event(struct kimage *image,
> > > +	unsigned int hp_action, unsigned int cpu)
> > 
> > The passed in 'cpu' is not used at all, what is it added for? I didn't
> > see explanation about it.
> 
> Well its not used for x86, but as I recall, Sourabh Jain needed it for the PowerPC handler.

Then better mention this in log or add code comment, otherwise confusion
could be caused.

