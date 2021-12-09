Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE446EBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhLIPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhLIPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:42:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43353C0698CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:38:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so6323959pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KRgjVkKi95KRmYQZO51YZ/hyLvmjeSEoU+P1R5ObJmQ=;
        b=kUC7Y0nX0pDX7m7Yt+7ygQiUU1wbPEAsZUiq3ghIfr9GnZERJrj8JmpZI9/9MBFygR
         oqQQ4aa14uG/BQ3qUVxC/3O67gutxuPCZ8AXLBe2JRnCVw11mgsDHO9CJrzlGP06ePM5
         n4kj6AuJFu5I4tMfGdC1jCDDBSBhTq35e5ueaZxfYyznLp58poXJ3iNGOZMt0OYlS1RD
         60ftn8MwxBkTFgPap25Qf0G+PBMrCGtWycVARHAprC+fF+9Ocg2nVlixquTNdMd2l1O+
         yPe+uUCWeNU5R2UM2qDbeLZwmpkeIeKF+TgnZ1ycecQWaV5ZGRd9+W6Kt8/e734QPe7s
         6gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KRgjVkKi95KRmYQZO51YZ/hyLvmjeSEoU+P1R5ObJmQ=;
        b=QG2DviW9LdrGApRcJKlnX5JDt/itsVfgNpHnZ5xTITBI620fPA/ooauAxv3KQMwvlu
         KOkqQqQkERNuEFLPT/uy9vwSU6v+MX6J3KbJvvLj/9g+IOqCPKTwAWalNih4XQBVvyTZ
         Kl0g4YE4pKqX2PGyuyBzNW5U3pQxAbogFpCPZ90ybMPIaZc5UbT0s2kgkStn2d0nGbms
         tMsPZ4IA+VStLFHgQXr6nhpAjYBJXLRO7+Z5qP5DbwQg6dfbqAx46dEgdmQwBPPDmQOK
         xFJSl03MBzIT5e18TJyHSrCtAc/Id40uIyOfONM/Vb4PKQpMy/6c/flaRIsbm6mNMK02
         2ovQ==
X-Gm-Message-State: AOAM530ukKU4GSa5utdZah3GlCccF/OKqItTCOdALY49WS0WyqK0al+B
        P4nVZy8l9xvM5Ci/VK8lyOXCCk2oM/dc8w==
X-Google-Smtp-Source: ABdhPJy6DgaR3sDOg/QQ8clnEdqj4oJcqzO+5eq9dxexRlzDKEys180588yu5HFJDIiWMd0OOCR3IQ==
X-Received: by 2002:a17:903:22c6:b0:141:fac1:b722 with SMTP id y6-20020a17090322c600b00141fac1b722mr69560300plg.23.1639064333371;
        Thu, 09 Dec 2021 07:38:53 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c3sm112265pfv.67.2021.12.09.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:38:52 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:38:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 4/6] KVM: SVM: fix races in the AVIC incomplete IPI
 delivery to vCPUs
Message-ID: <YbIjCUAECOyIbsYQ@google.com>
References: <20211209115440.394441-1-mlevitsk@redhat.com>
 <20211209115440.394441-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209115440.394441-5-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> If the target vCPU has AVIC inhibited while the source vCPU isn't,
> we need to set irr_pending, for the target to notice the interrupt.
> Do it always to be safe, the same as in svm_deliver_avic_intr.
> 
> Also if the target has AVIC inhibited, the same kind of races
> that happen in svm_deliver_avic_intr can happen here as well,
> so apply the same approach of kicking the target vCPUs.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/avic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 8c1b934bfa9b..bdfc37caa64a 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -304,8 +304,17 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
>  					GET_APIC_DEST_FIELD(icrh),
> -					icrl & APIC_DEST_MASK))
> -			kvm_vcpu_wake_up(vcpu);
> +					icrl & APIC_DEST_MASK)) {

What about leveraging svm_deliver_avic_intr() to handle this so that all the
logic to handle this mess is more or less contained in one location?  And if the
vCPU has made its way back to the guest with APICv=1, we'd avoid an unnecessary
kick.

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 26ed5325c593..cf9f5caa6e1b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -304,8 +304,12 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
        kvm_for_each_vcpu(i, vcpu, kvm) {
                if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
                                        GET_APIC_DEST_FIELD(icrh),
-                                       icrl & APIC_DEST_MASK))
-                       kvm_vcpu_wake_up(vcpu);
+                                       icrl & APIC_DEST_MASK)) {
+                       if (svm_deliver_avic_intr(vcpu, -1) {
+                               vcpu->arch.apic->irr_pending = true;
+                               kvm_make_request(KVM_REQ_EVENT, vcpu);
+                       }
+               }
        }
 }
 

And change svm_deliver_avic_intr() to ignore a negative vector, probably with a
comment saying that means the vector has already been set in the IRR.

	if (vec > 0) {
		kvm_lapic_set_irr(vec, vcpu->arch.apic);

		/*
		* Pairs with the smp_mb_*() after setting vcpu->guest_mode in
		* vcpu_enter_guest() to ensure the write to the vIRR is ordered before
		* the read of guest_mode, which guarantees that either VMRUN will see
		* and process the new vIRR entry, or that the below code will signal
		* the doorbell if the vCPU is already running in the guest.
		*/
		smp_mb__after_atomic();
	}

