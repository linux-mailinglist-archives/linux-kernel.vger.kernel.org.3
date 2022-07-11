Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B056FF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGKKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGKKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BDCEB41BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657533455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4705b3O605hQms9a0r/rRAuyFE62gnfa/SJiHrJ15tU=;
        b=ejlKOh0sGEMW4JnAk7+XDa9nz9czr2+srWdTPIYT17WaUqnIYI/Aexy1C6UyayadmSduxp
        EN3GAEJTk6NJGAQvr3/wBSo87Mx5TC3ze5bWnFgCgAZG3l5qEEay+53dGPE2f93eXIFfY+
        bvg2w2JQjrTm7YzrLXH8ErDfqAtA6OA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-V-cREPW3Nguxdxphd5LsrQ-1; Mon, 11 Jul 2022 05:57:30 -0400
X-MC-Unique: V-cREPW3Nguxdxphd5LsrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C048985A581;
        Mon, 11 Jul 2022 09:57:29 +0000 (UTC)
Received: from localhost (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D4C0492CA4;
        Mon, 11 Jul 2022 09:57:28 +0000 (UTC)
Date:   Mon, 11 Jul 2022 17:57:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
 <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/22 at 07:55am, Eric DeVolder wrote:
> 
> 
> On 6/20/22 00:06, Sourabh Jain wrote:
> > Hello Eric,
> > 
> > On 14/06/22 04:12, Eric DeVolder wrote:
> > > For x86_64, when CPU or memory is hot un/plugged, the crash
> > > elfcorehdr, which describes the CPUs and memory in the system,
> > > must also be updated.
> > > 
> > > When loading the crash kernel via kexec_load or kexec_file_load,
> > > the elfcorehdr is identified at run time in
> > > crash_core:handle_hotplug_event().
> > > 
> > > To update the elfcorehdr for x86_64, a new elfcorehdr must be
> > > generated from the available CPUs and memory. The new elfcorehdr
> > > is prepared into a buffer, and then installed over the top of
> > > the existing elfcorehdr.
> > > 
> > > In the patch 'kexec: exclude elfcorehdr from the segment digest'
> > > the need to update purgatory due to the change in elfcorehdr was
> > > eliminated.  As a result, no changes to purgatory or boot_params
> > > (as the elfcorehdr= kernel command line parameter pointer
> > > remains unchanged and correct) are needed, just elfcorehdr.
> > > 
> > > To accommodate a growing number of resources via hotplug, the
> > > elfcorehdr segment must be sufficiently large enough to accommodate
> > > changes, see the CRASH_MAX_MEMORY_RANGES configure item.
> > > 
> > > With this change, crash hotplug for kexec_file_load syscall
> > > is supported. The kexec_load is also supported, but also
> > > requires a corresponding change to userspace kexec-tools.
> > > 
> > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > ---
> > >   arch/x86/Kconfig        |  11 ++++
> > >   arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 127 insertions(+)
> > > 
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 762a0b6ab8b6..e9eecff3b97d 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2082,6 +2082,17 @@ config CRASH_DUMP
> > >         (CONFIG_RELOCATABLE=y).
> > >         For more details see Documentation/admin-guide/kdump/kdump.rst
> > > +config CRASH_MAX_MEMORY_RANGES
> > > +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> > > +    int
> > > +    default 32768
> > > +    help
> > > +      For the kexec_file_load path, specify the maximum number of
> > > +      memory regions, eg. as represented by the 'System RAM' entries
> > > +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> > > +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> > > +      size to determine the final buffer size.
> > > +
> > >   config KEXEC_JUMP
> > >       bool "kexec jump"
> > >       depends on KEXEC && HIBERNATION
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index 9db41cce8d97..b9cdf7a0d868 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -25,6 +25,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/vmalloc.h>
> > >   #include <linux/memblock.h>
> > > +#include <linux/highmem.h>
> > >   #include <asm/processor.h>
> > >   #include <asm/hardirq.h>
> > > @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
> > >       image->elf_headers = kbuf.buffer;
> > >       image->elf_headers_sz = kbuf.bufsz;
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +    /* Ensure elfcorehdr segment large enough for hotplug changes */
> > > +    kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> > > +    /* For marking as usable to crash kernel */
> > > +    image->elf_headers_sz = kbuf.memsz;
> > > +    /* Record the index of the elfcorehdr segment */
> > > +    image->elfcorehdr_index = image->nr_segments;
> > > +    image->elfcorehdr_index_valid = true;
> > > +#else
> > >       kbuf.memsz = kbuf.bufsz;
> > > +#endif
> > >       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> > >       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > >       ret = kexec_add_buffer(&kbuf);
> > > @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
> > >       return ret;
> > >   }
> > >   #endif /* CONFIG_KEXEC_FILE */
> > > +
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +int crash_hotplug_support(void) { return 1; }
> > > +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> > > +{
> > > +    /*
> > > +     * NOTE: The addresses and sizes passed to this routine have
> > > +     * already been fully aligned on page boundaries. There is no
> > > +     * need for massaging the address or size.
> > > +     */
> > > +    void *ptr = NULL;
> > > +
> > > +    /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> > > +    if (size > 0) {
> > > +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> > > +
> > > +        ptr = kmap(page);
> > > +    }
> > > +
> > > +    return ptr;
> > > +}
> > > +
> > > +void arch_unmap_crash_pages(void **ptr)
> > > +{
> > > +    if (ptr) {
> > > +        if (*ptr)
> > > +            kunmap(*ptr);
> > > +        *ptr = NULL;
> > > +    }
> > > +}
> > 
> > Aren't arch will have build issue if arch_[un]map_crash_pages methods are not defined?
> Sourabh,
> Yes, you are correct. I'll add __weak versions of each in crash_core.c in the next patch.

Just a reminder, __weak is deprecated and has been cleaned up in
kernel/kexec*.c in below patch.

[PATCH 0/2] kexec: Drop __weak attributes from functions

