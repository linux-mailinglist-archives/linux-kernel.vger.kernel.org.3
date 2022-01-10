Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248A048A355
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbiAJW77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiAJW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:59:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19137C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:59:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t18so4828532plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qoMX/T1Z59MwjCKSjEfCHHAb1HzRx5V+f6LaI4HdEBE=;
        b=AsU+PYhrmwnyPNww6FcgfIoDGSCDGeUZfXfSfWNFtuSnaxqZG7xZHyWAfYUdnEJrjP
         Hifjpo9udt9uVkeFVjAuC9uMYcYkiQ38334NnWVKchFayHryLFh8I8RoFwB4N82UjDEB
         mYlPV0z1rimp+zR8Ms6lAHMUlCg5DllOYJkslMewYwDxDgdqyR1hWqzqKlzzs8IMevDT
         bCTIWpiIlI9rIqf9qc9UoYpGMunQNwlOjRa5ZUdQhd7qqNZ417qfqG7KpasDR6l46dEX
         hdZ3A4S0jSo79Iqfs/HPABiFOVNS+jJcf8+d1NDN6H4Q1mG7ZGGSM38mY8v1xbzBlFLn
         wYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoMX/T1Z59MwjCKSjEfCHHAb1HzRx5V+f6LaI4HdEBE=;
        b=KbeRo5Ze6Oy9akLcm7mYcbZbH4CdDdvhBvQPVXKPeL/jKcK8bDxLaOcW0oI0OVL2XO
         TU8g+HdPjWj0/PEEP1HlP27pxSBGinishklbRZWBGjY8xSxNEpw3uU4PhHNP99cs+G2L
         G8qtC1Bkm9wTRHljHz8tH/9SP2HxE4kGrt2xJy/riYWi/q99XosOnW5/i9IHFjwq7kYB
         VmhlKwh3Jgo7QKzaytTyQDOoTAulrE7sr9ZuOXTJiviJfaZVjF53sBdOMcSFcDBNfWqN
         Tv1CBdhlHGNQkk4We/kWqc4HK+u+mrkS7NBdmFCYIyA/hTKWjpkIEzqQK8YcTRQlRZcP
         m/qg==
X-Gm-Message-State: AOAM530jaXG+q+YGZz5eejZIGqQrmKK435rF1WKaY0oD3gK0CnNOWxwn
        aOia4fc9v5Znxqmn39ejT+DiBw==
X-Google-Smtp-Source: ABdhPJzONdj7A48tNMZGn6Ga8mv/DYPuWwrGn7/9XflPnPZV/NHkhiRfAFuQeX5NPr7lWpg5idUNXQ==
X-Received: by 2002:a17:90a:c401:: with SMTP id i1mr37691pjt.180.1641855597331;
        Mon, 10 Jan 2022 14:59:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id kb1sm82954pjb.45.2022.01.10.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:59:56 -0800 (PST)
Date:   Mon, 10 Jan 2022 22:59:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: x86: Remove WARN_ON in
 kvm_arch_check_processor_compat
Message-ID: <Ydy6aIyI3jFQvF0O@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-6-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227081515.2088920-6-chao.gao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021, Chao Gao wrote:
> kvm_arch_check_processor_compat() needn't be called with interrupt
> disabled, as it only reads some CRs/MSRs which won't be clobbered
> by interrupt handlers or softirq.
> 
> What really needed is disabling preemption. No additional check is
> added because if CONFIG_DEBUG_PREEMPT is enabled, smp_processor_id()
> (right above the WARN_ON()) can help to detect any violation.

Hrm, IIRC, the assertion that IRQs are disabled was more about detecting improper
usage with respect to KVM doing hardware enabling than it was about ensuring the
current task isn't migrated.  E.g. as exhibited by patch 06, extra protections
(disabling of hotplug in that case) are needed if this helper is called outside
of the core KVM hardware enabling flow since hardware_enable_all() does its thing
via SMP function call.

Is there CPU onlining state/metadata that we could use to handle that specific case?
It'd be nice to preserve the paranoid check, but it's not a big deal if we can't.

If we can't preserve the WARN, can you rework the changelog to explain the motivation
for removing the WARN?

Thanks!

> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/kvm/x86.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aa09c8792134..a80e3b0c11a8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11384,8 +11384,6 @@ int kvm_arch_check_processor_compat(void)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
>  
> -	WARN_ON(!irqs_disabled());
> -
>  	if (__cr4_reserved_bits(cpu_has, c) !=
>  	    __cr4_reserved_bits(cpu_has, &boot_cpu_data))
>  		return -EIO;
> -- 
> 2.25.1
> 
