Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93234484AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiADWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiADWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:25:06 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F9C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:25:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t19so33412768pfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+e0xqW2F0YeKJUlFeDl4DgUIfFWiqIClROiH7OcyebI=;
        b=Yc9mMQL0dzf6v2hLBQUf+fjtdfCAeAy/cFw+Qem0qOL8fpxmfdYM7RkiXPZD3LmaV8
         bZI+7s9bMC4kNdMnXrbPTmlLNa7JyQXk1rdP5OkskRjYuY75uzqE5A1myFHGs6Ok27wP
         iHpvITzvtzCYNlzsSaWiZqFUOLlebh/eHIPY2YezMfO4xeDJ3eS+/wkiVW77famX46xe
         K1nkRCXo1HgBAd56l46bvmUb0IlyVAuEqaVeRobelo0sECCchhTbdFrHh6jGETC8OC3b
         lihUDPAlJe5aTlLiM6mB4sg7mNQTf+WakbO8lzXW1NvPMvGzVlCXtE8nGWvP5joZ2AKb
         oUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+e0xqW2F0YeKJUlFeDl4DgUIfFWiqIClROiH7OcyebI=;
        b=YJjPZiIwFZjmrxhPlJ0FFQIpgavFgYagnjAZqyA+8/pcKSKXWZLXLC7vBlGWg8i4k+
         Incla4AyWXhBcSJKM4f1eF2wei/I/C4Er8L/BJaL50PwbFQBEXq7DbG+Y/gKP/L/zRMM
         4UTe2NrWnFw1N43clHgkpnvbpU7SXgRl4f9TZtRg4UJnVf6a+zO2MVTtTT7tS5zdYNBH
         H9CyjYJbHl9/HYPO4dfCD626Odq/uzysUuIgWB+P5tZP2PMi6cnjV8tfRrdlPpssiigU
         fem7D+G2B7kBzkFNNiXKcswLThfPXxoMWTeMfRfxVT+DLhF8DDA3ztZ1+p9/SsTddWjD
         fzMw==
X-Gm-Message-State: AOAM5338EzVOWAUysuQmRWNBHAbnpdT1Jd6w4uy+I+rpVoPN6AZjORQ2
        zKz72EWWgOTAGwuBWp50p54qbw==
X-Google-Smtp-Source: ABdhPJxV+D4ZlMhjLhwvzZs5kvYN6VOQ+UUGxuU9oEfE9DyCMoNEg+ysNMrsfCX+zw7nADJ7I/JE4Q==
X-Received: by 2002:a05:6a00:1502:b0:4ba:95a2:97a9 with SMTP id q2-20020a056a00150200b004ba95a297a9mr52543678pfu.48.1641335105382;
        Tue, 04 Jan 2022 14:25:05 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k70sm35258535pgd.19.2022.01.04.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:25:04 -0800 (PST)
Date:   Tue, 4 Jan 2022 22:25:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 2/5] KVM: SVM: allow to force AVIC to be enabled
Message-ID: <YdTJPTSsM1feVwt/@google.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213104634.199141-3-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021, Maxim Levitsky wrote:
> Apparently on some systems AVIC is disabled in CPUID but still usable.
> 
> Allow the user to override the CPUID if the user is willing to
> take the risk.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c9668a3b51011..468cc385c35f0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -206,6 +206,9 @@ module_param(tsc_scaling, int, 0444);
>  static bool avic;
>  module_param(avic, bool, 0444);
>  
> +static bool force_avic;
> +module_param_unsafe(force_avic, bool, 0444);
> +
>  bool __read_mostly dump_invalid_vmcb;
>  module_param(dump_invalid_vmcb, bool, 0644);
>  
> @@ -4656,10 +4659,14 @@ static __init int svm_hardware_setup(void)
>  			nrips = false;
>  	}
>  
> -	enable_apicv = avic = avic && npt_enabled && boot_cpu_has(X86_FEATURE_AVIC);
> +	enable_apicv = avic = avic && npt_enabled && (boot_cpu_has(X86_FEATURE_AVIC) || force_avic);
>  
>  	if (enable_apicv) {
> -		pr_info("AVIC enabled\n");
> +		if (!boot_cpu_has(X86_FEATURE_AVIC)) {
> +			pr_warn("AVIC is not supported in CPUID but force enabled");
> +			pr_warn("Your system might crash and burn");
> +		} else

Needs curly braces, though arguably the "AVIC enabled" part should be printed
regardless of boot_cpu_has(X86_FEATURE_AVIC).

> +			pr_info("AVIC enabled\n");

This is all more than a bit terrifying, though I can see the usefuless for a
developer.  At the very least, this should taint the kernel.  This should also
probably be buried behind a Kconfig that is itself buried behind EXPERT.
