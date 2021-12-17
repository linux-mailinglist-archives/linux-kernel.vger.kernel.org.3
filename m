Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC247886A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhLQKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234703AbhLQKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639735752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiO8/750dIeYUlPIOySt7/Jo4nrDH4lIW+Uor+cZRRI=;
        b=DuJsLSfU5isbvePcKNNTec5p3XeopV3JELafLFLhZlbH193T6EyJws0TuWnrdbiUliQ8CB
        f0tUusubdu0XK9EgTFQD1uuRdEiZ88Y0mqC6HJ/s6qK8RNL2GG0Y/y7J1BTuARthT//S4W
        UnqJcbvtxBKHkNlh00jJ+Yy+9cR9ESg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-iuobUBIXMcOOA8GvneTd4w-1; Fri, 17 Dec 2021 05:09:11 -0500
X-MC-Unique: iuobUBIXMcOOA8GvneTd4w-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2728075wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiO8/750dIeYUlPIOySt7/Jo4nrDH4lIW+Uor+cZRRI=;
        b=AzB17paWiVA1GnXiSwqVGhO+QUQfcZfRRIZV5mLZyLcmvCsG2gAublRUEG5CeY2VyP
         A5VbBMNxLZT6mv2mh4zW+jU15LEmyRSklpZHMc2T401LJR7LfaLBfeYzHX/jgyvaJDP9
         nauxBbP8rZrZXB1BXTzVDhqJeke0eOyxQSvt2xRRvRTthxmBFtpvX0gViN6ThOi5DIAI
         PQw2XWzEq/zntDwRgMw0XZzR3MH1hQLGbnruUiuGJXkYROGy6izJYSZ8yq9A048Ea9Rx
         o4KorPlfG6NcOY5ocnuo58OFJQZGJDF4atY+qdE/Z4lv30XGakOQvQ4UdWcI/n5/Opkv
         nLEg==
X-Gm-Message-State: AOAM531qr319lZdWmHxXVYQzfz4s4PhmSw0XAVPevyRUjD5A0dEYbibL
        3Bm15kq7YRcrz6TrndHRC8NwWMx8m7bcBEsBCcBMRSFE1tAZgP26GrAWBWDzjjAQg3VLgLWoCo5
        JwaWwoXrDGHPOjFhD6s++pmJC
X-Received: by 2002:adf:816b:: with SMTP id 98mr1903370wrm.201.1639735750620;
        Fri, 17 Dec 2021 02:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnMCBR0ChztBhWJF+GToHnOoeqht0P0K2oSavfsU5qWdGzTcG193jzbmFvqJkOUIP+XtKORQ==
X-Received: by 2002:adf:816b:: with SMTP id 98mr1903353wrm.201.1639735750357;
        Fri, 17 Dec 2021 02:09:10 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o12sm6560547wrv.76.2021.12.17.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 02:09:09 -0800 (PST)
Date:   Fri, 17 Dec 2021 11:09:06 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mimoja@mimoja.de" <mimoja@mimoja.de>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "luolongjun@huawei.com" <luolongjun@huawei.com>,
        "hejingxian@huawei.com" <hejingxian@huawei.com>
Subject: Re: [PATCH v3 0/9] Parallel CPU bringup for x86_64
Message-ID: <20211217110906.5c38fe7b@redhat.com>
In-Reply-To: <721484e0fa719e99f9b8f13e67de05033dd7cc86.camel@infradead.org>
References: <20211215145633.5238-1-dwmw2@infradead.org>
        <761c1552-0ca0-403b-3461-8426198180d0@amd.com>
        <ca0751c864570015ffe4d8cccdc94e0a5ef3086d.camel@infradead.org>
        <b13eac6c-ea87-aef9-437f-7266be2e2031@amd.com>
        <721484e0fa719e99f9b8f13e67de05033dd7cc86.camel@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 00:13:16 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2021-12-16 at 16:52 -0600, Tom Lendacky wrote:
> > On baremetal, I haven't seen an issue. This only seems to have a problem 
> > with Qemu/KVM.
> > 
> > With 191f08997577 I could boot without issues with and without the 
> > no_parallel_bringup. Only after I applied e78fa57dd642 did the failure happen.
> > 
> > With e78fa57dd642 I could boot 64 vCPUs pretty consistently, but when I 
> > jumped to 128 vCPUs it failed again. When I moved the series to 
> > df9726cb7178, then 64 vCPUs also failed pretty consistently.
> > 
> > Strange thing is it is random. Sometimes (rarely) it works on the first 
> > boot and then sometimes it doesn't, at which point it will reset and 
> > reboot 3 or 4 times and then make it past the failure and fully boot.  
> 
> Hm, some of that is just artifacts of timing, I'm sure. But now I'm
that's most likely the case (there is a race somewhere left).
To trigger CPU bringup (hotplug) races, I used to run QEMU guest with
heavy vCPU overcommit. It helps to induce unexpected delays at CPU bringup
time.


> staring at the way that early_setup_idt() can run in parallel on all
> CPUs, rewriting bringup_idt_descr and loading it.
> 
> To start with, let's try unlocking the trampoline_lock much later,
> after cpu_init_exception_handling() has loaded the real IDT. 
> 
> I think we can probably make secondaries load the real IDT early and
> never use bringup_idt_descr at all, can't we? But let's see if this
> makes it go away, to start with...
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 0cd6373bc3f2..2307f7575ab4 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -59,7 +59,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/uv/uv.h>
>  #include <asm/sigframe.h>
> -
> +#include <asm/realmode.h>
>  #include "cpu.h"
>  
>  u32 elf_hwcap2 __read_mostly;
> @@ -2060,6 +2060,7 @@ void cpu_init_secondary(void)
>  	 * on this CPU in cpu_init_exception_handling().
>  	 */
>  	cpu_init_exception_handling();
> +	clear_bit(0, (unsigned long *)trampoline_lock);
>  	cpu_init();
>  }
>  #endif
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 3e4c3c416bce..db01b56574cd 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -273,14 +273,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	 */
>  	movq initial_stack(%rip), %rsp
>  
> -	/* Drop the realmode protection. For the boot CPU the pointer is NULL! */
> -	movq	trampoline_lock(%rip), %rax
> -	testq	%rax, %rax
> -	jz	.Lsetup_idt
> -	lock
> -	btrl	$0, (%rax)
> -
> -.Lsetup_idt:
>  	/* Setup and Load IDT */
>  	pushq	%rsi
>  	call	early_setup_idt

