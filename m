Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACA498176
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiAXNxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbiAXNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80PN3FZqYIDiwCGKibet4P3dRAAuNtvhNVGs0KCYiwg=;
        b=hZf6spWgo4SSkgVdRAzL1QODdK0EyqnWPz+12btZ4QPu3xx4x5D6GNAAQKz1XLZtrDKfqs
        bOVLtsSRaoH+AJjQWfonFQ0kPQYhgQSm3GhmQg4wrzx/onPKymkPKuCjAL7zDyb+xVnch1
        GyQpeHaXEO/SfrPz/I2P1wCU2SjcOFs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-P2EHtevDNAq8G7DMMb1hvg-1; Mon, 24 Jan 2022 08:53:19 -0500
X-MC-Unique: P2EHtevDNAq8G7DMMb1hvg-1
Received: by mail-ej1-f70.google.com with SMTP id q19-20020a1709064c9300b006b39291ff3eso2092832eju.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=80PN3FZqYIDiwCGKibet4P3dRAAuNtvhNVGs0KCYiwg=;
        b=RssA1t0ZIyNtaIOJexOqCbzSTaXX5ctYi58Mi5cG2DH8TQ2OsNT4GCiYEnV3uKvBe/
         TS7h+bLjBJKZ7mTkzK4zFu1ZIv6B2+IJ2hW/K7bU+I9mGMywJsu40uzRIuZ/3FK93Ugj
         mIPGjT7iwqYkScWkdu7iItwcXSJDSeAf3EYp4TnQ1N2UzQZqAOvQan8kAC04mcILVRSs
         uBpW52zspcw7XYVYnHgQZXKradjE3WL2MTknPENtOWCIB1WUn7cjmq4yYZtd4GXSKXd4
         jP9DNiOKrLb5qrpSkIe0vQ6vM8upYrtcsVjkuoU7VTevhCFAiFOpqRCksPUOvJ9nh6gv
         BKbA==
X-Gm-Message-State: AOAM533Qb027OS0YLCCCGc9zhmfxcHqWY7+YrNOqjMudy41Cglcw7cfC
        20VSRbp1R2atPq+AhHHUt0p8Wj6atY17ZiM7t4PWvxrt9114YNfrXnxMPOijgfZuY1xBjelUVBN
        LH2xQpYbgCcEfWIusB3SPGOHi
X-Received: by 2002:a17:906:5042:: with SMTP id e2mr13045584ejk.647.1643032398068;
        Mon, 24 Jan 2022 05:53:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMFEJnPeFJQe9fJt/4yoYnF/i8vdSWkjc2hPGS4KJtr8s+OJbRB+dfmh8aN/jrrBItbZANNg==
X-Received: by 2002:a17:906:5042:: with SMTP id e2mr13045568ejk.647.1643032397884;
        Mon, 24 Jan 2022 05:53:17 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id g27sm6679685edj.79.2022.01.24.05.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 05:53:16 -0800 (PST)
Message-ID: <ca66ba8d-63dd-7087-7d5b-b42ccf8debd7@redhat.com>
Date:   Mon, 24 Jan 2022 14:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] x86,kvm/xen: Remove superfluous .fixup usage
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     dwmw@amazon.co.uk, linux-kernel@vger.kernel.org
References: <20220123124219.GH20638@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220123124219.GH20638@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 13:42, Peter Zijlstra wrote:
> 
> Commit 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and
> event channel delivery") adds superfluous .fixup usage after the whole
> .fixup section was removed in commit e5eefda5aa51 ("x86: Remove .fixup
> section").
> 
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/kvm/xen.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 0e3f7d6e9fd7..bad57535fad0 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -316,10 +316,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
>   				     "\tnotq %0\n"
>   				     "\t" LOCK_PREFIX "andq %0, %2\n"
>   				     "2:\n"
> -				     "\t.section .fixup,\"ax\"\n"
> -				     "3:\tjmp\t2b\n"
> -				     "\t.previous\n"
> -				     _ASM_EXTABLE_UA(1b, 3b)
> +				     _ASM_EXTABLE_UA(1b, 2b)
>   				     : "=r" (evtchn_pending_sel),
>   				       "+m" (vi->evtchn_pending_sel),
>   				       "+m" (v->arch.xen.evtchn_pending_sel)
> @@ -335,10 +332,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
>   				     "\tnotl %0\n"
>   				     "\t" LOCK_PREFIX "andl %0, %2\n"
>   				     "2:\n"
> -				     "\t.section .fixup,\"ax\"\n"
> -				     "3:\tjmp\t2b\n"
> -				     "\t.previous\n"
> -				     _ASM_EXTABLE_UA(1b, 3b)
> +				     _ASM_EXTABLE_UA(1b, 2b)
>   				     : "=r" (evtchn_pending_sel32),
>   				       "+m" (vi->evtchn_pending_sel),
>   				       "+m" (v->arch.xen.evtchn_pending_sel)
> 

Queued, thanks.

Paolo

