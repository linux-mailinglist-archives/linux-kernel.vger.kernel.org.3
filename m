Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB55A15E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiHYPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbiHYPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:34:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEB56BA0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:34:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x23so18840464pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=RBQv0dJPuw1Y2VpQfZmDAflRLO5NhOvzMay8jTL5e1g=;
        b=MMQhiAyHyEOzU4E/lLTRSEONOkgzxJOuf5AYTKThica7NPWa74BvsOdNNU9IXuNGJf
         HuvpOA14nK69CTXCxv1ErdqoLhZ0hGHvKXCYWbRHseKi8ZtdhkUQ6tiZ3AvSqNszFG7b
         fKhO0bMOjZN7TARlFQfEXXbrn96uF11x0CPh1gwayorQtGv6q2dtEruPsuaUid64s/zc
         n709rSnvS5SIJVdcwJUuu4D431J8SKw18Jpxi9wURLx1a69dW/BlZsDhMuB5mgihxQty
         /4qwyrrq1jWPM4Wx+lL6GeR+xoVFb0M2t89F3cC+X0GT5rYjYDWE6So0pQ8rEcaEgM8R
         x87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RBQv0dJPuw1Y2VpQfZmDAflRLO5NhOvzMay8jTL5e1g=;
        b=y+u78mPRTWI7VjHKqYiID04Zn0GImFXM+/l2G4w8puxwRFRxirTB1AqIvKDybSnlgM
         urGL5PJe18aMesap88j4nCrO0M0UHG7cPloT/1G7mhTeMjrDhtbSudZ9dKJ4e03ASPaS
         HNBn6Jj+L/rBN7yxIVheBV6wysP1Py9sql7VkcRF4vzwY2V/KZrtwjZtM2o7zIoRntep
         spwRXS++hFP1hycrH7Tf3+fW2YdXCxH0jb0udrs0jbMjaSbqfM0qYMN0/0+PIfOf4vch
         RzZAdyia4mfMmTp5vVeZgSbg1DiYOVjOcAwyV9/h7rYlV+gWKz4/uGcspa72FxeUxLn9
         tAvQ==
X-Gm-Message-State: ACgBeo2gQKaGvR4jSUcKYslXIGbbDpxIbBfO9FkHoMQW7TRjDYJkwBu+
        gWJZZ24BDuNbNz3H0nRBo59LXw==
X-Google-Smtp-Source: AA6agR7VmtpNIN9Xj1Jis6eHMtO8VSDT7S30Mt2iBEnCSaIEBMmtOdw2aw+vkp8W24qI2iQ2N/v8MQ==
X-Received: by 2002:a17:902:ca01:b0:172:bc42:be8e with SMTP id w1-20020a170902ca0100b00172bc42be8emr4357782pld.47.1661441692828;
        Thu, 25 Aug 2022 08:34:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c76-20020a624e4f000000b00535f2b5a23dsm14118512pfb.155.2022.08.25.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:34:52 -0700 (PDT)
Date:   Thu, 25 Aug 2022 15:34:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] KVM: VMX: Stop/resume host PT before/after VM
 entry when PT_MODE_HOST_GUEST
Message-ID: <YweWmF3wMPRnthIh@google.com>
References: <20220825085625.867763-1-xiaoyao.li@intel.com>
 <20220825085625.867763-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825085625.867763-3-xiaoyao.li@intel.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022, Xiaoyao Li wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d7f8331d6f7e..3e9ce8f600d2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -38,6 +38,7 @@
>  #include <asm/fpu/api.h>
>  #include <asm/fpu/xstate.h>
>  #include <asm/idtentry.h>
> +#include <asm/intel_pt.h>
>  #include <asm/io.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/kexec.h>
> @@ -1128,13 +1129,19 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
>  	if (vmx_pt_mode_is_system())
>  		return;
>  
> +	/*
> +	 * Stop Intel PT on host to avoid vm-entry failure since
> +	 * VM_ENTRY_LOAD_IA32_RTIT_CTL is set
> +	 */
> +	intel_pt_stop();
> +
>  	/*
>  	 * GUEST_IA32_RTIT_CTL is already set in the VMCS.
>  	 * Save host state before VM entry.
>  	 */
>  	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);

KVM's manual save/restore of MSR_IA32_RTIT_CTL should be dropped.  If PT/RTIT can
trace post-VMXON, then intel_pt_stop() will disable tracing and intel_pt_resume()
will restore the host's desired value.

>  	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> -		wrmsrl(MSR_IA32_RTIT_CTL, 0);
> +		/* intel_pt_stop() ensures RTIT_CTL.TraceEn is zero */
>  		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);

Isn't this at risk of the same corruption?  What prevents a PT NMI that arrives
after this point from changing other RTIT MSRs, thus causing KVM to restore the
wrong values?

>  		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
>  	}
> @@ -1156,6 +1163,8 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
>  	 */
>  	if (vmx->pt_desc.host.ctl)
>  		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> +
> +	intel_pt_resume();
>  }
>  
>  void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
> -- 
> 2.27.0
> 
