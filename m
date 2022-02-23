Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5994C0AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiBWELd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiBWELc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFBB66FAB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645589464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Af9+WWK+R5EImF9noLlIgQ4gYNRPHI7xgUiLn28faM4=;
        b=jDyQ5GuB5eqUTChTo71Zydqtoq9sQXCOjjM2hzwZXKjZIm9n3Eb/4RqvwuF2zc/pigOHWI
        3nemmyZLZdQ8tbf18uYXWdArdwo3nELdFQ7SkzzhqzsyFetKA6gZMxv9MvCIapf4dpXqnR
        Fj9gmb2ZTmxuJSJhY+/Uv8M7DBxYyhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-tQcaiPVSPLqMj1_ldGcNoA-1; Tue, 22 Feb 2022 23:11:02 -0500
X-MC-Unique: tQcaiPVSPLqMj1_ldGcNoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8889824FA7;
        Wed, 23 Feb 2022 04:11:00 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C91D4CEF9;
        Wed, 23 Feb 2022 04:10:55 +0000 (UTC)
Date:   Wed, 23 Feb 2022 12:10:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 09/10] crash hp: Add x86 crash hotplug support for
 kexec_file_load
Message-ID: <YhWzy87O4Y66LHH1@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-10-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-10-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.

Please mark the patch as X86 related by adding:

x86/kexec: Add x86 crash hotplug support for kexec_file_load

And also update other subject to reflect under which component the
changes are made, crash hp is the feature name.

Otherwise, this looks good to me.

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
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/kernel/crash.c | 92 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9db41cce8d97..6215c51919db 100644
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
> @@ -413,3 +424,84 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
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
> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
> +		/* The crash image is now valid once again */
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

