Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3A52C335
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiERTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiERTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:20:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBE129EDC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:20:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v11so3028839pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3uDgCM0jVOGXquSHgMCPA/5j3dmx9IRHCyrsQBhO1c=;
        b=bb9tCVFqsAEimtPT6qm810+MkGgrHagIESxzSiQSgzyMMDm39k45IVc2hsjyzsAfeC
         e+SiZs27Ya4KQXh7fxnX94I3JNtMbITC7ZbVUYXE1MdaFv/TzSoAB+qjO7SZ7prp9tdO
         OJE8aK2FbmwUd6Xx0H83g2AA2ci6bA/j5352O5yt7Dtv77uAkuWPNaojpEbJ73kLIayB
         PxZnZuaSaR2t5VgSI2BzxOJ8sV5sRpad0i1rmg8WZfsbNXThk72rQGFlNVuRl7+wQnN6
         Sk2YGfQS8+a+vxRGnL9mCt1qpWuZ3VgbMvmyIspbqRVf/5Duv31XyPxIJBoPwC9+Ku5w
         z2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3uDgCM0jVOGXquSHgMCPA/5j3dmx9IRHCyrsQBhO1c=;
        b=MPzuhquNHWilwDHR7Zua4SudKBHjr3B36WBXe9BI702JJ6oc2eQgPdMvHz4MOtbhXD
         EPlBujjbTrC5EGhrnIG4rQhNGpAjvYMSnjvibGh7KEIxQEr12+vppfz66J1CNGCleRy9
         q+NIoHVsDDus2C4JyB+/Gt1WrDbVAYPVelQTJtulRuTKYEpNx5RXfv+AmOS3brC9My8X
         Ui0pay/5ee1wu1ePLhR8c2Xc04OA27XCRuzlbSTI7KfWXKivm315nNLXPPeN2li5ZbHk
         my5g3MvFXBTpi03R47wR6Z+kxJJuqfLytaDAaaalbPH0dHPhLCD1ZSclcTefSUbRqwBt
         yuzg==
X-Gm-Message-State: AOAM5325cipDpMP2U9Ciwn2gzV5SwTXfoPbJrjMiaLlPHVC6Hq9mc10A
        wsKKtMPu+FPZUhSIJ9PUVo3kpw==
X-Google-Smtp-Source: ABdhPJyWiDcKl93jFXaSH4FmBKQJFJyRIoUqcosB1o6WLdxQEOIA4wa6qlJ5DPcm02fFlS154CSyvg==
X-Received: by 2002:aa7:8888:0:b0:50f:2e7a:76b7 with SMTP id z8-20020aa78888000000b0050f2e7a76b7mr1073149pfe.48.1652901636612;
        Wed, 18 May 2022 12:20:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n19-20020a056a00213300b0050dc7628159sm1438911pfj.51.2022.05.18.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:20:36 -0700 (PDT)
Date:   Wed, 18 May 2022 19:20:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] KVM: selftests: Add a test to get/set triple
 fault event
Message-ID: <YoVHAIGcFgJit1qp@google.com>
References: <20220421072958.16375-1-chenyi.qiang@intel.com>
 <20220421072958.16375-3-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421072958.16375-3-chenyi.qiang@intel.com>
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

On Thu, Apr 21, 2022, Chenyi Qiang wrote:
> +#ifndef __x86_64__
> +# error This test is 64-bit only

No need, all of KVM selftests are 64-bit only.

> +#endif
> +
> +#define VCPU_ID			0
> +#define ARBITRARY_IO_PORT	0x2000
> +
> +/* The virtual machine object. */
> +static struct kvm_vm *vm;
> +
> +static void l2_guest_code(void)
> +{
> +	/*
> +	 * Generate an exit to L0 userspace, i.e. main(), via I/O to an
> +	 * arbitrary port.
> +	 */

I think we can test a "real" triple fault without too much effort by abusing
vcpu->run->request_interrupt_window.  E.g. map the run struct into L2, clear
PIN_BASED_EXT_INTR_MASK in vmcs12, and then in l2_guest_code() do:

	asm volatile("cli");

	run->request_interrupt_window = true;

	asm volatile("sti; ud2");

	asm volatile("inb %%dx, %%al"                                           
		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax"); 	

The STI shadow will block the IRQ-window VM-Exit until after the ud2, i.e. until
after the triple fault is pending.

And then main() can

  1. verify it got KVM_EXIT_IRQ_WINDOW_OPEN with a pending triple fault
  2. clear the triple fault and re-enter L1+l2
  3. continue with the existing code, e.g. verify it got KVM_EXIT_IO, stuff a
     pending triple fault, etc...

That said, typing that out makes me think we should technically handle/prevent this
in KVM since triple fault / shutdown is kinda sorta just a special exception.

Heh, and a potentially bad/crazy idea would be to use a reserved/magic vector in
kvm_vcpu_events.exception to save/restore triple fault, e.g. we could steal
NMI_VECTOR.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f2d0ee9296b9..d58c0cfd3cd3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4743,7 +4743,8 @@ static int kvm_vcpu_ready_for_interrupt_injection(struct kvm_vcpu *vcpu)
        return (kvm_arch_interrupt_allowed(vcpu) &&
                kvm_cpu_accept_dm_intr(vcpu) &&
                !kvm_event_needs_reinjection(vcpu) &&
-               !vcpu->arch.exception.pending);
+               !vcpu->arch.exception.pending &&
+               !kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu));
 }

 static int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,



