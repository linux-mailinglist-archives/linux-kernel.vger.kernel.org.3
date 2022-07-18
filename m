Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55667578319
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGRNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiGRNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9E50BE35
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658149491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qtz8QGl64kUBV3EWOme0wtZS/EtSpLd3+LsjwsxBYuo=;
        b=U8ho8UWR2AKxUpoYhkFxW3bqU9ylwjsQQm1dnoq8FAZZoBn/V3lg9vg03eq6CQ4SvCCKlx
        Sa8RwWzqJj8j+9zdGGU6IPOErJdWyyb2Ta58qDWbUCIaDiC0qUREzJOv4PqB8qVim7i8qJ
        UEoUUNwF38UnADY+owjjKZkRR8fVxxQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-DcMi4uK4Pn-GHxBqsnj8wQ-1; Mon, 18 Jul 2022 09:04:50 -0400
X-MC-Unique: DcMi4uK4Pn-GHxBqsnj8wQ-1
Received: by mail-qv1-f72.google.com with SMTP id q16-20020a0ce210000000b00472f361d6b1so5489477qvl.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Qtz8QGl64kUBV3EWOme0wtZS/EtSpLd3+LsjwsxBYuo=;
        b=KvtImUnnAlLnfR1QKsp5uZl4sYFIOo1MESKjAQpNDAuKJrsTXksreXk7gkBDTY2btD
         w+b93xTndzidm/kFQM4nQOhu8SxGf2rhcxCE6hW/NsMfFZnlWFr4XE8gcxvKZXvYUk2c
         ONcK5BcvvTbWQ1+qqWOhGGIWSsvmsqHGJTBnerP1zkAQWkU/bzTVZxZcGioSimcm4e2C
         6sEtrKYnwaEZdxnLeVRiB9CpMH9KK/t0swcg8gaXH/YjzHMa6lHG73EIH6ToCLVsMCqb
         +gbrY5elipuuyQ7dtD46HomNPZs/Kc7kBVcYLTX0b8mS/xJ9/IIS5MWbdA4p/w8oYY29
         XE8g==
X-Gm-Message-State: AJIora+Dgl+74TmRjaT6tAQG5unV8KaXBW+JUdygoThIGwMbOOTTNJjP
        ldiOzrBnOl0RuJMycwROeyVhoueQKMOa06WHqZ85I3UP24fXYUnGiEIOmG0OKOsuWOkWD68RZKB
        /JpQDGAOmrDCNJlwK8MooCBct
X-Received: by 2002:a05:620a:40c2:b0:6b5:e454:8315 with SMTP id g2-20020a05620a40c200b006b5e4548315mr3701462qko.639.1658149489641;
        Mon, 18 Jul 2022 06:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sYQIf1anxD1JsBQ3yaIkwNIBz8j7fWmI4CjazBj5gGX196CJAT3Mqn8x73DVq7GPTDBgJ+wA==
X-Received: by 2002:a05:620a:40c2:b0:6b5:e454:8315 with SMTP id g2-20020a05620a40c200b006b5e4548315mr3701439qko.639.1658149489337;
        Mon, 18 Jul 2022 06:04:49 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id i12-20020a37c20c000000b006a6a6f148e6sm11048229qkm.17.2022.07.18.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:04:48 -0700 (PDT)
Message-ID: <a4ac40386f48499f41915db1503650c30161e8be.camel@redhat.com>
Subject: Re: [PATCH v2 18/24] KVM: nVMX: Document priority of all known
 events on Intel CPUs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Date:   Mon, 18 Jul 2022 16:04:45 +0300
In-Reply-To: <20220715204226.3655170-19-seanjc@google.com>
References: <20220715204226.3655170-1-seanjc@google.com>
         <20220715204226.3655170-19-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 20:42 +0000, Sean Christopherson wrote:
> Add a gigantic comment above vmx_check_nested_events() to document the
> priorities of all known events on Intel CPUs.  Intel's SDM doesn't
> include VMX-specific events in its "Priority Among Concurrent Events",
> which makes it painfully difficult to suss out the correct priority
> between things like Monitor Trap Flag VM-Exits and pending #DBs.
> 
> Kudos to Jim Mattson for doing the hard work of collecting and
> interpreting the priorities from various locations throughtout the SDM
> (because putting them all in one place in the SDM would be too easy).
> 
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c3fc8b484785..981f98ef96f1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3901,6 +3901,89 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
>                to_vmx(vcpu)->nested.preemption_timer_expired;
>  }
>  
> +/*
> + * Per the Intel SDM's table "Priority Among Concurrent Events", with minor
> + * edits to fill in missing examples, e.g. #DB due to split-lock accesses,
> + * and less minor edits to splice in the priority of VMX Non-Root specific
> + * events, e.g. MTF and NMI/INTR-window exiting.
> + *
> + * 1 Hardware Reset and Machine Checks
> + *     - RESET
> + *     - Machine Check
> + *
> + * 2 Trap on Task Switch
> + *     - T flag in TSS is set (on task switch)
> + *
> + * 3 External Hardware Interventions
> + *     - FLUSH
> + *     - STOPCLK
> + *     - SMI
> + *     - INIT
> + *
> + * 3.5 Monitor Trap Flag (MTF) VM-exit[1]
> + *
> + * 4 Traps on Previous Instruction
> + *     - Breakpoints
> + *     - Trap-class Debug Exceptions (#DB due to TF flag set, data/I-O
> + *       breakpoint, or #DB due to a split-lock access)
> + *
> + * 4.3 VMX-preemption timer expired VM-exit
> + *
> + * 4.6 NMI-window exiting VM-exit[2]
> + *
> + * 5 Nonmaskable Interrupts (NMI)
> + *
> + * 5.5 Interrupt-window exiting VM-exit and Virtual-interrupt delivery
> + *
> + * 6 Maskable Hardware Interrupts
> + *
> + * 7 Code Breakpoint Fault
> + *
> + * 8 Faults from Fetching Next Instruction
> + *     - Code-Segment Limit Violation
> + *     - Code Page Fault
> + *     - Control protection exception (missing ENDBRANCH at target of indirect
> + *                                     call or jump)
> + *
> + * 9 Faults from Decoding Next Instruction
> + *     - Instruction length > 15 bytes
> + *     - Invalid Opcode
> + *     - Coprocessor Not Available
> + *
> + *10 Faults on Executing Instruction
> + *     - Overflow
> + *     - Bound error
> + *     - Invalid TSS
> + *     - Segment Not Present
> + *     - Stack fault
> + *     - General Protection
> + *     - Data Page Fault
> + *     - Alignment Check
> + *     - x86 FPU Floating-point exception
> + *     - SIMD floating-point exception
> + *     - Virtualization exception
> + *     - Control protection exception
> + *
> + * [1] Per the "Monitor Trap Flag" section: System-management interrupts (SMIs),
> + *     INIT signals, and higher priority events take priority over MTF VM exits.
> + *     MTF VM exits take priority over debug-trap exceptions and lower priority
> + *     events.
> + *
> + * [2] Debug-trap exceptions and higher priority events take priority over VM exits
> + *     caused by the VMX-preemption timer.  VM exits caused by the VMX-preemption
> + *     timer take priority over VM exits caused by the "NMI-window exiting"
> + *     VM-execution control and lower priority events.
> + *
> + * [3] Debug-trap exceptions and higher priority events take priority over VM exits
> + *     caused by "NMI-window exiting".  VM exits caused by this control take
> + *     priority over non-maskable interrupts (NMIs) and lower priority events.
> + *
> + * [4] Virtual-interrupt delivery has the same priority as that of VM exits due to
> + *     the 1-setting of the "interrupt-window exiting" VM-execution control.  Thus,
> + *     non-maskable interrupts (NMIs) and higher priority events take priority over
> + *     delivery of a virtual interrupt; delivery of a virtual interrupt takes
> + *     priority over external interrupts and lower priority events.
> + */
>  static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_lapic *apic = vcpu->arch.apic;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

