Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24452F0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351644AbiETQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiETQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:32:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BF34647
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:32:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a38so5295226pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SzItUW0RGTe8ShIv3stQK+W3HlY6O/3mA4zqLcRGqJc=;
        b=PzMJGGKM0liKfpSZu42fuPpNSgDQEt9yH+9w2C7yME17A4Xd6iyfNhJwoP7E3p363m
         3Sr2Ftd4UVbIX7L0sAfzhDR0UOClzzbQ0hxSbtTa6vipdUzBEKwb20DWi1QFoKXMbAGB
         FBvqJgzWqPZwZ3f7hqr194VOX3BvttIdDDqdu2FCX4GXGbtYywmAsxEtfLE+9P2KJ25f
         0b68NUFjWgP0i6gJ55P1eEEN/vKEBKzNnJ9opb0eiHUvBbfMdqbAs9yfdt7ZeNK+/BGx
         d3PBm/t0WyDU4t8pbCOBFl87PqVpDIhCoNfawihVuZrBhZCCSk7c8GakPsoordb+5fX4
         6dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzItUW0RGTe8ShIv3stQK+W3HlY6O/3mA4zqLcRGqJc=;
        b=o0VlqqzTvzksaOD6dSTaCR3nVOJXgXU7BduqOCuKrniMmrqJ9/mEpGCcGqn21J2Fyn
         ubdC20PufDWOTUNRr0nFd4jBFdTbRc1HZYDG1bjK4zydsKuk23oA/0YeAPIms6ehO1JO
         yFqCKcNrauyeLOGTeg4lM76cgfpCfAew0JgwFf37N0X4+zS9OWVSmvubXBHErgwowxwQ
         hTl8JHA0lPHEIpt/GtjpNe4RL6zCy0oF4E/ABcmj37pzMxJLbq8jXcRR7My/wZrw0VwD
         RfbLlPJ+KNWUH6HGTmhQs+Tib2w9Nd44TOQyPLjaN8Zo6FNKp/Q4RtO46Nf3MFPdlR2o
         Av4A==
X-Gm-Message-State: AOAM531aq3qNKa7KfMCktNIzM/ewyncmpCievhceu6PAqX/7xNLGeox1
        aX5Ud7Qbqcjbp7vsH/7iWXCCiA==
X-Google-Smtp-Source: ABdhPJwF5grmfxO4RF5xZ26433l2Q5OTsV92U+/XH0s8a/N4+jlSDTIfigkguDeqgETo44XtIyhtBA==
X-Received: by 2002:a63:d054:0:b0:3f2:50df:e008 with SMTP id s20-20020a63d054000000b003f250dfe008mr9132653pgi.317.1653064322022;
        Fri, 20 May 2022 09:32:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a4e8600b001d840f4eee0sm2077563pjh.20.2022.05.20.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:32:00 -0700 (PDT)
Date:   Fri, 20 May 2022 16:31:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Xu, Yanfei" <yanfei.xu@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH] KVM: x86: Fix the intel_pt PMI handling wrongly
 considered from guest
Message-ID: <YofCfNsl6O45hYr0@google.com>
References: <20220515171633.902901-1-yanfei.xu@intel.com>
 <YoJYah+Ct90aj1I5@google.com>
 <DM6PR11MB41380A9DD32D6542CBC3A90BF0D39@DM6PR11MB4138.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB41380A9DD32D6542CBC3A90BF0D39@DM6PR11MB4138.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't top-post.

On Fri, May 20, 2022, Xu, Yanfei wrote:
> From: Sean Christopherson <seanjc@google.com> 
> On Mon, May 16, 2022, Yanfei Xu wrote:
> > diff --git a/arch/x86/include/asm/kvm_host.h 
> > b/arch/x86/include/asm/kvm_host.h index 4ff36610af6a..308cf19f123d 
> > 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1582,8 +1582,14 @@ static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
> >  		return -ENOTSUPP;
> >  }
> >  
> > +enum kvm_intr_type {
> > +	/* Values are arbitrary, but must be non-zero. */
> > +	KVM_HANDLING_IRQ = 1,
> > +	KVM_HANDLING_NMI,
> > +};
> > +
> >  #define kvm_arch_pmi_in_guest(vcpu) \
> > -	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
> > +	((vcpu) && (vcpu)->arch.handling_intr_from_guest == 
> > +KVM_HANDLING_NMI)
> 
> My understanding is that this isn't correct as a general change, as perf
> events can use regular IRQs in some cases.  See commit dd60d217062f4 ("KVM:
> x86: Fix perf timer mode IP reporting").
> 
> I assume there's got to be a way to know which mode perf is using, e.g. we
> should be able to make this look something like:
> 
> 	((vcpu) && (vcpu)->arch.handling_intr_from_guest == kvm_pmi_vector)

> Hi Sean,
> You are right, the change of kvm_arch_pmi_in_guest is incorrect, because it should cover two cases of PMI. 
> For the PMI of intel pt, it certainly is the NMI PMI. So how about fixing it like below?

Yep, that works.  I did enough spelunking to figure out how we can fix the generic
issue, but it's per-event and requires a decent amount of plumbing in perf.

perf_guest_handle_intel_pt_intr() doesn't bother with perf_guest_state() since it's
such a specialized event, so fixing this in vmx_handle_intel_pt_intr() would likely
be the long-term solution even if/when the generic case is fixed.
