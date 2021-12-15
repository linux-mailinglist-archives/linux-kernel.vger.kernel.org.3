Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5B47666C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhLOXTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231785AbhLOXTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639610350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OOPK/Ce0evNRkG0OJR8FLC2lDA2PsoUnUOFS75jzZ4=;
        b=Jl6+qKN8qzEGJ28d5I2vVrHmhik+bJogZFV0zXhknLOTn+CBgy5/3sZzaYnsMJUN9RMJbD
        0BIyVTb2Og2Ik1sSb5TaN6xkxB6LCOlLjtTbq93Glr2Q5kJsJJU928a+p976INrEFBYTZw
        58TIgs8zqKIqiyqznsszFaXq7zUEihA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-uMMnd2xLO4GPXJJnGLtdsw-1; Wed, 15 Dec 2021 18:19:09 -0500
X-MC-Unique: uMMnd2xLO4GPXJJnGLtdsw-1
Received: by mail-oi1-f199.google.com with SMTP id u197-20020acaabce000000b002a820308b14so14844649oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2OOPK/Ce0evNRkG0OJR8FLC2lDA2PsoUnUOFS75jzZ4=;
        b=j5Dh5RhIRyUK8ba9PIVjF4qqcG4e8QGNn2Wn/q8AxJtKPb0JutfYqrlFpC+Nned9rD
         SX1JdBcwor0MUiFYm0y06FVSxAh9shFb7jbNbIfNrJ5Y+wDn8Rsi7bDlWvUEpiA+BspE
         qmesGEUyWCrzCi+6zV1ykXZ5LLJlGY1PYIq9VzOCcfG70uPG83dOj3kzYQahgthSINJX
         wuGD6NkbFXAXXyzZrHryaUpDcMESJ55ia9PDG7MaN/zTf8dHnTLBIPmM+600MiyJO4LX
         j9JdIlIE1gT0Iqpaf3i9hOVHL7G/nwsrXxhZD0yhh1g6iIP8aP4gvJMsJ0LT2aTH3a1Y
         D9Bg==
X-Gm-Message-State: AOAM5321UxwBBE2y89e8Ez/vkljFhZVkecryVdogSnQH+LoC9MiUp4Y5
        Id5joAH476MsXR9AXkmyJ9rhJ9Js4WJ4I9kWJiA4CLVk9S9WFCtO5Cb7ot4P2wsgZ+OQ45QgIeC
        Cfs8KyXh+JOI2andgzmC3ZoTA
X-Received: by 2002:a4a:85cf:: with SMTP id u15mr9291257ooh.45.1639610349144;
        Wed, 15 Dec 2021 15:19:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWT59yjlt9+OHKDg79RgNUibbSSzVT+tGjGqp8u7d1P4JyMOqCTvZHToywtQd7kwx5jWcoPQ==
X-Received: by 2002:a4a:85cf:: with SMTP id u15mr9291221ooh.45.1639610348924;
        Wed, 15 Dec 2021 15:19:08 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id e21sm713148ote.72.2021.12.15.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:19:08 -0800 (PST)
Date:   Wed, 15 Dec 2021 15:19:04 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] x86/tdx: Extend the cc_platform_has() API to
 support TDX guests
Message-ID: <20211215231904.rpakxlrp64zmxhhg@treble>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:40PM +0300, Kirill A. Shutemov wrote:
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -22,6 +22,7 @@ CFLAGS_REMOVE_early_printk.o = -pg
>  CFLAGS_REMOVE_head64.o = -pg
>  CFLAGS_REMOVE_sev.o = -pg
>  CFLAGS_REMOVE_cc_platform.o = -pg
> +CFLAGS_REMOVE_tdx.o = -pg
>  endif
>  
>  KASAN_SANITIZE_head$(BITS).o				:= n
> @@ -31,6 +32,7 @@ KASAN_SANITIZE_stacktrace.o				:= n
>  KASAN_SANITIZE_paravirt.o				:= n
>  KASAN_SANITIZE_sev.o					:= n
>  KASAN_SANITIZE_cc_platform.o				:= n
> +KASAN_SANITIZE_tdx.o					:= n
>  
>  # With some compiler versions the generated code results in boot hangs, caused
>  # by several compilation units. To be safe, disable all instrumentation.
> @@ -50,6 +52,7 @@ KCOV_INSTRUMENT		:= n
>  
>  CFLAGS_head$(BITS).o	+= -fno-stack-protector
>  CFLAGS_cc_platform.o	+= -fno-stack-protector
> +CFLAGS_tdx.o		+= -fno-stack-protector
>  
>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace

Don't these Makefile changes belong in patch 1, which adds tdx.c?

-- 
Josh

