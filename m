Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154AA46EB27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbhLIPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhLIPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:31:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB8C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:27:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so6337165pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBx+S5GngzaGdJX3AUjJESnSwLSaHTKCh0KKuf7Qe2c=;
        b=IJoGnRreNblCJ+V0+KgplbieDObvR1W755jrxwS7nFuMS4PPU/TOhKWSRjM6XWDRtw
         pCQkbaVcWpT2o6JS7UE/qotzn092YPKTpjP7NMEwxAf8zbi9cfsXSdSsU927cku3Ew6y
         07BdSHG5te9CCiTvq4wjeB7yipIQBQ+RzsryNgV37PDrDXptby0JTp3JZ5AEFGjW5wCO
         JJ+vNr+NzZ2XiVZsrMdsE2l+anNzpsi9qv4cDZDdkiUtuq0taQ1E6pCS/HX3wyI8auZD
         egT/Xsa2bD+gBNkTyTsNnArpUmU2iN4nxtv2kqmc1BgHPF7LcKloPLe/53Rwls31+efI
         OnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBx+S5GngzaGdJX3AUjJESnSwLSaHTKCh0KKuf7Qe2c=;
        b=pEeEYN+E0kTSnI1iZ5F9MSsxJndyIqgr6W+rfiSwhM4M5Z4+6eXPvx+nURzAcri42b
         jWbEbmOjQwrFpnwcluaiYWzB6A0jC74Qu5Z7tMlBb/Xs5H2jaWDLn6ae0BlXF53MI7b3
         wHcZG/aGdLFwO7XMFerqmuIvvmjzVAUYvxArLoRFLrkTLSXy7sFj+Sg4RPRhUZmqID1L
         oAQ9p4a4Lqhb5YnSHjUfurSHV7tGOJro2zeaEV3jDHkhb37MApWbGYPyOq4l65555jTf
         IxXlKxpHFfQ1uZSOyrUllQyrlOuHbSVLTIQQNqkJy3uoIlXPY/66f3C8undy1R69KfJt
         h3MQ==
X-Gm-Message-State: AOAM531JZ8lJ5UIgJMEtjgKpvSqqORESRTx3ORXJRhO32Y/ShB1Dx2OQ
        jeYnLMxpa00q+ddszIVYZqQobQ==
X-Google-Smtp-Source: ABdhPJzIuXLkcaquxXTpx2fvwP2yLLgDRMNCp+I52bY+fsCWoHp+7Dz+l4ldzVI+ChCSG0YGpVABpg==
X-Received: by 2002:a17:903:124e:b0:143:a388:a5de with SMTP id u14-20020a170903124e00b00143a388a5demr68334252plh.73.1639063667744;
        Thu, 09 Dec 2021 07:27:47 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g19sm71678pgi.10.2021.12.09.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:27:47 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:27:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 3/6] KVM: SVM: fix AVIC race of host->guest IPI delivery
 vs AVIC inhibition
Message-ID: <YbIgb4V7jcx2tZ0R@google.com>
References: <20211209115440.394441-1-mlevitsk@redhat.com>
 <20211209115440.394441-4-mlevitsk@redhat.com>
 <4d723b07-e626-190d-63f4-fd0b5497dd9b@redhat.com>
 <bcf9f9e5922cce979cc11ced8ccda992e22b290a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf9f9e5922cce979cc11ced8ccda992e22b290a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> On Thu, 2021-12-09 at 15:11 +0100, Paolo Bonzini wrote:
> > On 12/9/21 12:54, Maxim Levitsky wrote:
> > > If svm_deliver_avic_intr is called just after the target vcpu's AVIC got
> > > inhibited, it might read a stale value of vcpu->arch.apicv_active
> > > which can lead to the target vCPU not noticing the interrupt.
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >   arch/x86/kvm/svm/avic.c | 16 +++++++++++++---
> > >   1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > > index 859ad2dc50f1..8c1b934bfa9b 100644
> > > --- a/arch/x86/kvm/svm/avic.c
> > > +++ b/arch/x86/kvm/svm/avic.c
> > > @@ -691,6 +691,15 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
> > >   	 * automatically process AVIC interrupts at VMRUN.
> > >   	 */
> > >   	if (vcpu->mode == IN_GUEST_MODE) {
> > > +
> > > +		/*
> > > +		 * At this point we had read the vcpu->arch.apicv_active == true
> > > +		 * and the vcpu->mode == IN_GUEST_MODE.
> > > +		 * Since we have a memory barrier after setting IN_GUEST_MODE,
> > > +		 * it ensures that AVIC inhibition is complete and thus
> > > +		 * the target is really running with AVIC enabled.
> > > +		 */
> > > +
> > >   		int cpu = READ_ONCE(vcpu->cpu);
> > 
> > I don't think it's correct.  The vCPU has apicv_active written (in 
> > kvm_vcpu_update_apicv) before vcpu->mode.
> 
> I thought that we have a full memory barrier just prior to setting IN_GUEST_MODE
> thus if I see vcpu->mode == IN_GUEST_MODE then I'll see correct apicv_active value.
> But apparently the memory barrier is after setting vcpu->mode.
> 
> 
> > 
> > For the acquire/release pair to work properly you need to 1) read 
> > apicv_active *after* vcpu->mode here 2) use store_release and 
> > load_acquire for vcpu->mode, respectively in vcpu_enter_guest and here.
> 
> store_release for vcpu->mode in vcpu_enter_guest means a write barrier just before setting it,
> which I expected to be there.
> 
> And yes I see now, I need a read barrier here as well. I am still learning this.

Sans barriers and comments, can't this be written as returning an "error" if the
vCPU is not IN_GUEST_MODE?  Effectively the same thing, but a little more precise
and it avoids duplicating the lapic.c code.

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 26ed5325c593..cddf7a8da3ea 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -671,7 +671,7 @@ void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)

 int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 {
-       if (!vcpu->arch.apicv_active)
+       if (vcpu->mode != IN_GUEST_MODE || !vcpu->arch.apicv_active)
                return -1;

        kvm_lapic_set_irr(vec, vcpu->arch.apic);
@@ -706,8 +706,9 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
                put_cpu();
        } else {
                /*
-                * Wake the vCPU if it was blocking.  KVM will then detect the
-                * pending IRQ when checking if the vCPU has a wake event.
+                * Wake the vCPU if it is blocking.  If the vCPU exited the
+                * guest since the previous vcpu->mode check, it's guaranteed
+                * to see the event before re-enterring the guest.
                 */
                kvm_vcpu_wake_up(vcpu);
        }

