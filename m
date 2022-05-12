Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80CB524802
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351537AbiELIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351557AbiELIiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A1B611D47B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652344668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkIXUkBDrNt6gkclimZnecKQlrFAMYowusbdeJJW6fc=;
        b=OVOVn4V4VhKL9LG6lRWmT9StS8thsuDJDbNSteBDFxYnd7ozM6aoKC5VZZi8Bs4S46kr56
        hasQSESulaU7lZlCtwrP2ovxFXmE2UynO7lgJgNVYcJoGTcz5sc04fMpzaS+2wlMs9MXoK
        bIc3QSFsTeL+i/zMqhfM97nq0vfZuPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-I2ZINpajNrCOk0Mr0hAMFw-1; Thu, 12 May 2022 04:37:47 -0400
X-MC-Unique: I2ZINpajNrCOk0Mr0hAMFw-1
Received: by mail-wm1-f72.google.com with SMTP id i18-20020a1c5412000000b0039491a8298cso1395828wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OkIXUkBDrNt6gkclimZnecKQlrFAMYowusbdeJJW6fc=;
        b=q72lNa7W5fROS0jhNsVhYqet0ctNTz9E0dE77WaCNCv4nzFJXWk6QcCxb9KJXv7qjN
         nRnwDlCAh76xcijWXHDswkg5KCntyWYFIVh8BrI0podfcnCbS0YXNJisAall19cn9JRP
         xNfP8HSMmUx6yLBWZcC3gIAqPKGCSXXvHDd2AlLJsQ/YGbS1OuOkdubb2Vfl580GYqv4
         RT/IIOnmlT0x+dXD9r/OOKEvIgJxy7M7VQG7pANUL6JI9bHDE+6uHOVxjd0ORmYEfJdn
         1JMiCS8rTeQZRR2anL0DWqlG7PDM5jQFnC1TUrjuOW1bMq/x/dF68pkhHcCIY7wuHzhk
         Xkgw==
X-Gm-Message-State: AOAM532qIGA8ZsXoVUOMoQwT8nKrQhPAZNUBot01fUX5VA60Xy5kkqW7
        7MxZX9b00JDNJDpF9c4q6EKixVMEuhCYGACGRz6Q9qOZQbhbKCkeZyYeh+4TPPtbjcpFEYbZ2sv
        HFvHHZpggpNyDnl997q1MTmLt
X-Received: by 2002:a1c:a101:0:b0:392:942f:3aa with SMTP id k1-20020a1ca101000000b00392942f03aamr8816044wme.1.1652344666110;
        Thu, 12 May 2022 01:37:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgf711/RFrj05nYXdhIx+rCvhiA/Ah1yBm1xcLQHu4NExlITaxfpFeBNlbx9hzj5nysIHkzA==
X-Received: by 2002:a1c:a101:0:b0:392:942f:3aa with SMTP id k1-20020a1ca101000000b00392942f03aamr8816024wme.1.1652344665892;
        Thu, 12 May 2022 01:37:45 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b003949dbc3790sm2035834wml.18.2022.05.12.01.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:37:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] x86/reboot: Disable virtualization in an emergency
 if SVM is supported
In-Reply-To: <20220511234332.3654455-3-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-3-seanjc@google.com>
Date:   Thu, 12 May 2022 10:37:44 +0200
Message-ID: <87ee0zxi1z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
> Like VMX, SVM can block INIT and thus prevent bringing up other CPUs via
> INIT-SIPI-SIPI.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/reboot.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index f9543a4e9b09..33c1f4883b27 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -533,27 +533,29 @@ static void nmi_shootdown_nop(int cpu, struct pt_regs *regs)
>  	/* Nothing to do, the NMI shootdown handler disables virtualization. */
>  }
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
> +	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
> +		/* Safely force _this_ CPU out of VMX/SVM operation. */
> +		if (cpu_has_vmx())
> +			__cpu_emergency_vmxoff();
> +		else
> +			cpu_emergency_svm_disable();
>  
> -		/* Halt and exit VMX root operation on the other CPUs. */
> +		/* Disable VMX/SVM and halt on other CPUs. */
>  		nmi_shootdown_cpus(nmi_shootdown_nop);
>  	}

Nitpicking: we can get rid of the second cpu_has_vmx() if we write this
as:

	if (cpu_has_vmx())
		__cpu_emergency_vmxoff();
	else if (cpu_has_svm(NULL))
		cpu_emergency_svm_disable();
	else 
		return;

	nmi_shootdown_cpus(nmi_shootdown_nop);

>  }
> @@ -590,7 +592,7 @@ static void native_machine_emergency_restart(void)
>  	unsigned short mode;
>  
>  	if (reboot_emergency)
> -		emergency_vmx_disable_all();
> +		emergency_reboot_disable_virtualization();
>  
>  	tboot_shutdown(TB_SHUTDOWN_REBOOT);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

