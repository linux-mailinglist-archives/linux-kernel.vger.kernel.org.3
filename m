Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE54952BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbiATQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377067AbiATQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642697833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmS8L8fuOGkYvKFNmD68YPx7y9KPPBqF8b31jD22Rys=;
        b=fJZkzZ3qIUiRsdY8AAbks6aqAzzUN4K8oa+5oLuc+FRX5kLugceWfTjzEMKd/1iPC4MLIB
        dMN8mPDhuP4FYUAVr+DRVwPWplvXi4quMVSzdhmKS5L4haEAv8HPvdD2WSm+xVdY9Sdv9r
        ErcZrZ5d5yxvYLqaDFsNCEpnr5LkfRA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-OU_QU9z4N2en4SccgRePUQ-1; Thu, 20 Jan 2022 11:57:12 -0500
X-MC-Unique: OU_QU9z4N2en4SccgRePUQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso4448757wmb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rmS8L8fuOGkYvKFNmD68YPx7y9KPPBqF8b31jD22Rys=;
        b=Z1JtiBm96Oaed0wliTMp6U9x+5iG8ZiazhGMQt/HPsxCXUuI8X7GBZuF7Q8Pcm/pGH
         elgtcoG/dUVqERDX2SpNZuPrXUZib05qB6wkO4ZPL1But9Je0pWnMfwc8YNGuBTJkdGB
         11T1qdUCHYMIFoLh1PFm4/N5SMz4SwqwzcYDc1ogXJAPSX8B6jwehyYWRd/e2b5v3rk7
         bUKOEiTnKSVLD8M9C5Ayzpx2ZS+D9tj+tXvS6Xfy1L9psHdjJEV2bOZduzmqLzzwO8Gv
         65XG3R0b8xuuw3zOhOQct3yiIZNgvfZTCxrUJ2d1fgmLmrQyBGog59FE3NFGkhlr8iEd
         TA9Q==
X-Gm-Message-State: AOAM531GxYy1z9ZCwXlVZ3O8R38JO8+kAb8FBLDilAztgvHp4pSqBK26
        k1Nf9C28BYDVbdsZ/gRiiulggrJIPPXDIFlo2a09wnspwKuwR0NO+LJwXoXbbgpmo+klyHmdANC
        n45LXeNBUnB6/Lffb2OQ84Ev1
X-Received: by 2002:a5d:4451:: with SMTP id x17mr29521516wrr.505.1642697831275;
        Thu, 20 Jan 2022 08:57:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwthZUX4DlO+JHTQ7b16oYihnrgBNAZdegFIa39K3kVEawdJylqf0SothSMkpbm1DKzphY3fw==
X-Received: by 2002:a5d:4451:: with SMTP id x17mr29521478wrr.505.1642697831040;
        Thu, 20 Jan 2022 08:57:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id d6sm3209558wrs.85.2022.01.20.08.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:57:10 -0800 (PST)
Message-ID: <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
Date:   Thu, 20 Jan 2022 17:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <20220120164455.GA15464@C02TD0UTHF1T.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220120164455.GA15464@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 17:44, Mark Rutland wrote:
> On Wed, Jan 19, 2022 at 10:58:51AM +0000, Mark Rutland wrote:
>> In kvm_arch_vcpu_ioctl_run() we use guest_enter_irqoff() and
>> guest_exit_irqoff() directly, with interrupts masked between these. As
>> we don't handle any timer ticks during this window, we will not account
>> time spent within the guest as guest time, which is unfortunate.
>>
>> Additionally, we do not inform lockdep or tracing that interrupts will
>> be enabled during guest execution, which caan lead to misleading traces
>> and warnings that interrupts have been enabled for overly-long periods.
>>
>> This patch fixes these issues by using the new timing and context
>> entry/exit helpers to ensure that interrupts are handled during guest
>> vtime but with RCU watching, with a sequence:
>>
>> 	guest_timing_enter_irqoff();
>>
>> 	guest_state_enter_irqoff();
>> 	< run the vcpu >
>> 	guest_state_exit_irqoff();
>>
>> 	< take any pending IRQs >
>>
>> 	guest_timing_exit_irqoff();
> 
> Looking again, this patch isn't sufficient.
> 
> On MIPS a guest exit will be handled by kvm_mips_handle_exit() *before*
> returning into the "< run the vcpu >" step above, so we won't call
> guest_state_exit_irqoff() before using RCU, etc.

Indeed.  kvm_mips_handle_exit has a weird mutual recursion through runtime-assembled code, but then this is MIPS...

This should do it:

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e59cb6246f76..6f2291f017f5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1192,6 +1192,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
  	kvm_mips_set_c0_status();
  
  	local_irq_enable();
+	guest_timing_exit_irqoff();
  
  	kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n",
  			cause, opc, run, vcpu);
@@ -1325,6 +1326,7 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
  	}
  
  	if (ret == RESUME_GUEST) {
+		guest_timing_enter_irqoff();
  		trace_kvm_reenter(vcpu);
  
  		/*


Paolo

