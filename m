Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C84C0AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiBWD7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBWD66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8192F4D250
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645588710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2NWvKFq0kOBrsfHRCwf6sKcBU7Oc5+YasdRQtJdd6I=;
        b=DdwXeBL1xa9iVrwJOdXSYogmg9HqucRwyLst3Bf/D7ZDhEgbIdg3n3GABUfpI505RwTMFk
        QVEg+KSeRyp7NJ9vSzFH4FTn6lgo8kdGC6B2FFUoRl0uJ5JSSy2H7fam8z7fvlNA5XF5oq
        Ai312RAk3bQasjCthwdufHHH9i6WT8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-Tx9NDDMAN861OlL5dVtAcA-1; Tue, 22 Feb 2022 22:58:27 -0500
X-MC-Unique: Tx9NDDMAN861OlL5dVtAcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882C51091DA0;
        Wed, 23 Feb 2022 03:58:24 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49992101E68B;
        Wed, 23 Feb 2022 03:58:04 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:58:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 05/10] crash hp: introduce helper functions
 un/map_crash_pages
Message-ID: <YhWwyTZuXxM4w+Fu@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-6-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-6-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> This change introduces two new functions un/map_crash_pages()
> which are used to enable/disable access to the segments in the
> crash memory region. (Upon loading of a crash kernel, the
> crash memory regions are made inaccessible for integrity purposes.)
> 
> For example, on x86_64, one of the segments is the elfcorehdr,
> which contains the list of CPUs and memories. This segment
> needs to be modified in response to hotplug events. These functions
> are used to obtain (and subsequenntly release) access to the crash
> memory region in order to make the modifications.
> 
> QUESTION: These might need to be in arch/x86 as I'm not certain
> the implementatin is valid for all archs?

Since only x86_64 uses them, I would suggest putting them into x86_64,
near the caller.

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  include/linux/kexec.h |  2 ++
>  kernel/crash_core.c   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index b11d75a6b2bc..e00c373c4095 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -324,6 +324,8 @@ struct kimage {
>  };
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
> +void *map_crash_pages(unsigned long paddr, unsigned long size);
> +void unmap_crash_pages(void **ptr);
>  void arch_crash_hotplug_handler(struct kimage *image,
>  	unsigned int hp_action, unsigned long a, unsigned long b);
>  #define KEXEC_CRASH_HP_REMOVE_CPU   0
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..0ff06d0698ad 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -491,3 +492,34 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
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
> +#endif
> +
> -- 
> 2.27.0
> 

