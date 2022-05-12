Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4252504E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355477AbiELOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355453AbiELOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:39:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1A2618C8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:39:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x18so5063236plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1mAoedHqKCxbwiJhcTWVMyW7rs80mjXjW2wzN8EpSY=;
        b=hzs3wRnTcQy01CmqLlxG9g6xOizB2yWFw8y++j1vmsFHdynWNX5ubGCdvmz+gwaqE3
         dDz2aAUKb+oPO72jrcbsIIbxLB23+WildV3hJXC5DXrW1amv/REI49ycKi40b211THXa
         Mg79bqL6EzTg9xF0LU9V79cMXITgxHfrC0RqESuYKYYh2G9eCC5ggM4y0k5bfz+zmjo4
         wJAyqoa8yQKhG0s6M991iNRgPLs+CNykf31CIWFmy4FMUnliEuNw6TQmnqDYl8qLN+3E
         Fn8y9MytcYVwuFKQoceMFjysHF2aKrrCBmDOkja7SFGW9+1ISKPwGdtA2w0jSZz6mMcQ
         BJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1mAoedHqKCxbwiJhcTWVMyW7rs80mjXjW2wzN8EpSY=;
        b=JJtGe426bvPRtX701GCScWjvTbD4u7DjChnjKItxe04hYt6EWMDChkhob9MufRe/z2
         hlihwQVL1mHYBc8f9ScGViQXWIYrOJ2UEXUPvO6eGXYyjOUCrLJVM3uhw0Mw0I6g5vse
         jpOY6QX3U/31+MK8bL8MipfSsbnLc7NyeR0tKvwTcSaFcM4YFPrJjTblvRDwIWxKI6Co
         TBkJD+a+mgg4RIt7usidD51iwMGHoSX5cLZlaW8QCz5KzUBprJL1v4lzJa3V3ok0YBGV
         Tf8q/ZQ/wPPxA69OuQmLE4dlQeTY493Ms0QHS9QaA9DaOa1gJHRSW7hIllahhRnZUTZu
         zkzA==
X-Gm-Message-State: AOAM531eL7DxnLvpBRL4qtZTeIEIEUcEYnVeBcfFHymnqUtpbDf2rZDn
        43veEtUuSt317FhkiijrQ0Pjzw==
X-Google-Smtp-Source: ABdhPJxRjTzLDgFh6JYO5PiiNMAmNCpoVt4jax4zGuAU2+HWrHJi6Q6V17T+Uoqm8689YUhLvMg9eA==
X-Received: by 2002:a17:902:d482:b0:15e:a06a:db0a with SMTP id c2-20020a170902d48200b0015ea06adb0amr291573plg.38.1652366350327;
        Thu, 12 May 2022 07:39:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b003c619f3d086sm2070886pgc.2.2022.05.12.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:39:09 -0700 (PDT)
Date:   Thu, 12 May 2022 14:39:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] x86/reboot: Disable virtualization in an emergency
 if SVM is supported
Message-ID: <Yn0cCl+C+BE2yfPb@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-3-seanjc@google.com>
 <87tu9vvx19.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu9vvx19.ffs@tglx>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022, Thomas Gleixner wrote:
> On Wed, May 11 2022 at 23:43, Sean Christopherson wrote:
> > Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
> > Like VMX, SVM can block INIT and thus prevent bringing up other CPUs via
> > INIT-SIPI-SIPI.
> 
> With the delta patch applied, I'd make that:
> 
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -530,29 +530,25 @@ static inline void kb_wait(void)
>  
>  static inline void nmi_shootdown_cpus_on_restart(void);
>  
> -/* Use NMIs as IPIs to tell all CPUs to disable virtualization */
> -static void emergency_vmx_disable_all(void)
> +static void emergency_reboot_disable_virtualization(void)
>  {
>  	/* Just make sure we won't change CPUs while doing this */
>  	local_irq_disable();
>  
>  	/*
> -	 * Disable VMX on all CPUs before rebooting, otherwise we risk hanging
> -	 * the machine, because the CPU blocks INIT when it's in VMX root.
> +	 * Disable virtualization on all CPUs before rebooting to avoid hanging
> +	 * the system, as VMX and SVM block INIT when running in the host
>  	 *
>  	 * We can't take any locks and we may be on an inconsistent state, so
> -	 * use NMIs as IPIs to tell the other CPUs to exit VMX root and halt.
> +	 * use NMIs as IPIs to tell the other CPUs to disable VMX/SVM and halt.
>  	 *
> -	 * Do the NMI shootdown even if VMX if off on _this_ CPU, as that
> -	 * doesn't prevent a different CPU from being in VMX root operation.
> +	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
> +	 * other CPUs may have virtualization enabled.
>  	 */
> -	if (cpu_has_vmx()) {
> -		/* Safely force _this_ CPU out of VMX root operation. */
> -		__cpu_emergency_vmxoff();
> +	cpu_crash_disable_virtualization();
>  
> -		/* Halt and exit VMX root operation on the other CPUs. */
> +	if (cpu_has_vmx() || cpu_has_svm(NULL))
>  		nmi_shootdown_cpus_on_restart();
> -	}

What about leaving cpu_crash_disable_virtualization() inside the if-statement?
It feels wierd to "disable" virtualization on the current CPU but ignore others,
e.g. if there's some newfangled type of virtualization in the future, I would be
quite surprised if only the CPU doing the transfer needed to disable virtualization.

	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
		/* Safely force _this_ CPU out of VMX/SVM operation. */
		cpu_crash_disable_virtualization();

		/* Disable VMX/SVM and halt on other CPUs. */
		nmi_shootdown_cpus_on_restart()
	}


>  }
>  
>  
> @@ -587,7 +583,7 @@ static void native_machine_emergency_res
>  	unsigned short mode;
>  
>  	if (reboot_emergency)
> -		emergency_vmx_disable_all();
> +		emergency_reboot_disable_virtualization();
>  
>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
>  
