Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0217C49C5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiAZJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbiAZJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643188394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TbF5nBuKPMmTArNpLGRbqMvSQSqoxoYLQ8/fNj7LKlI=;
        b=BYV9CC5CKx4FARw5o1GZPBW3XyBlCYkmnChNfHQIyorQ7rqxPbkxrS738H/+2rYq+Qq4JX
        CeEKPME7VyDQexG3ZQQEFmHREnAM0RYAdCjawryz4ztzmHPthp5ht3IbfLJpwkrxBrDiTn
        p3CaWDvtHh217hn4zISqxtj5Dz87QS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-BJqPuhZBMwKpSQv1453c-A-1; Wed, 26 Jan 2022 04:13:09 -0500
X-MC-Unique: BJqPuhZBMwKpSQv1453c-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4424C8144E1;
        Wed, 26 Jan 2022 09:13:07 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFD6B60C45;
        Wed, 26 Jan 2022 09:12:46 +0000 (UTC)
Date:   Wed, 26 Jan 2022 17:12:43 +0800
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
Message-ID: <20220126091243.GB6588@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-7-eric.devolder@oracle.com>
 <20220119102323.GB6349@MiWiFi-R3L-srv>
 <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/22 at 08:06am, Eric DeVolder wrote:
......
> > >   arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 137 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index 9730c88530fc..d185137b33d4 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -25,6 +25,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/vmalloc.h>
> > >   #include <linux/memblock.h>
> > > +#include <linux/highmem.h>
> > >   #include <asm/processor.h>
> > >   #include <asm/hardirq.h>
> > > @@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
> > >   		goto out;
> > >   	/* By default prepare 64bit headers */
> > > -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> > > +	ret =  crash_prepare_elf64_headers(image, cmem,
> > > +				IS_ENABLED(CONFIG_X86_64), addr, sz);
> > >   out:
> > >   	vfree(cmem);
> > > @@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
> > >   	image->elf_headers = kbuf.buffer;
> > >   	image->elf_headers_sz = kbuf.bufsz;
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> > > +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
> > 
> > I would define a default value for the size, meantime provide a Kconfig
> > option to allow user to customize.
> 
> In patch 2/6 of this series, "crash hp: Introduce CRASH_HOTPLUG
> configuration options", I provide the following:
> 
> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> +   depends on CRASH_HOTPLUG
> +   int
> +   default 131072
> +   help
> +     Specify the maximum size of the elfcorehdr buffer/segment.
> 
> which defines a default value of 128KiB, and can be overriden at configure time.
> 
> Are you asking for a different technique?

I thought to define a global variable, like

/* Defaults to ahve 128K elfcorehdr buffer which contains 2048 entries.*/
unsigned long crash_hotplug_elfcorehdr_size = 0x20000;

Then initialize it in crash_hotplug_init() if CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ
is enabled.

Seems using the config directly is also OK. Let's keep it and see if
other people have comment.

> 
> > 
> > > +	/* For marking as usable to crash kernel */
> > > +	image->elf_headers_sz = kbuf.memsz;
> > > +	/* Record the index of the elfcorehdr segment */
> > > +	image->elf_index = image->nr_segments;
> > > +	image->elf_index_valid = true;
> > > +#else
> > >   	kbuf.memsz = kbuf.bufsz;
> > > +#endif
> > >   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> > >   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > >   	ret = kexec_add_buffer(&kbuf);
> > > @@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
> > >   	return ret;
> > >   }
> > >   #endif /* CONFIG_KEXEC_FILE */
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > 
> > These two helper function should be carved out into a separate patch as
> > a preparatory one. I am considering how to rearrange and split the
> > patches, will reply to cover letter.
> 
> OK, I look forward to that insight!
> 
> > 
> > > +void *map_crash_pages(unsigned long paddr, unsigned long size)
> > > +{
> > > +	/*
> > > +	 * NOTE: The addresses and sizes passed to this routine have
> > > +	 * already been fully aligned on page boundaries. There is no
> > > +	 * need for massaging the address or size.
> > > +	 */
> > > +	void *ptr = NULL;
> > > +
> > > +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> > > +	if (size > 0) {
> > > +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> > > +
> > > +		ptr = kmap(page);
> > > +	}
> > > +
> > > +	return ptr;
> > > +}
> > > +
> > > +void unmap_crash_pages(void **ptr)
> > > +{
> > > +	if (ptr) {
> > > +		if (*ptr)
> > > +			kunmap(*ptr);
> > > +		*ptr = NULL;
> > > +	}
> > > +}
> > > +
> > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > +	unsigned int hp_action, unsigned long a, unsigned long b)
> > > +{
> > > +	/*
> > > +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
> > > +	 * is passed to the crash kernel via the elfcorehdr= parameter)
> > > +	 * must be updated with the new list of CPUs and memories. The new
> > > +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
> > > +	 * then it is written on top of the existing/old elfcorehdr.
> > > +	 *
> > > +	 * Due to the change to the elfcorehdr, purgatory must explicitly
> > > +	 * exclude the elfcorehdr from the list of segments it checks.
> > > +	 */
> > 
> > Please move this code comment to above function as kernel-doc if you
> > this it benefits the entire function. Otherwise should move them above
> > the code block they are explaining. For this place, I think moving them
> > to above arch_crash_hotplug_handler() is better.
> 
> ok, I will do that!
> 
> > 
> > > +	struct kexec_segment *ksegment;
> > > +	unsigned char *ptr = NULL;
> > > +	unsigned long elfsz = 0;
> > > +	void *elfbuf = NULL;
> > > +	unsigned long mem, memsz;
> > > +	unsigned int n;
> > > +
> > > +	/*
> > > +	 * When the struct kimage is alloced, it is wiped to zero, so
> > > +	 * the elf_index_valid defaults to false. It is set on the
> > > +	 * kexec_file_load path, or here for kexec_load.
> > > +	 */
> > 
> > I think this kexec loading part should be taken out and post after this
> > whole patchset being accepted. At least, it's worth to put them in a
> > separate patch.
> 
> This little bit of code that identifies the incoming elfcorehdr is all that
> is needed to support kexec_load (and the userspace changes of course). I'm
> happy to split as a separate patch, but I would think that be maintaining it
> with this series, then when it is accepted, both the kexec_load and
> kexec_file_load paths would be supported? Your call.

Hmm, at first, let's split it out from this patch since it's an
independent action to kdump. I would suggest we don't carry it in this
series. After this series is done, you can post another patchset
including this part as kernel patch, and also the code change in
kexec_tools as user space patch.

......

