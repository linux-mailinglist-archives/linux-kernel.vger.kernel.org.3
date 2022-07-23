Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC057EADC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiGWAxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiGWAxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:53:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93847C19AE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a17-20020a170902ecd100b0016c012c4cf3so3447552plh.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fEpVGwQvu7cHsTd3X/MiBjAxI2NyMtEZka/ZEp33tvI=;
        b=bJVxa3OHd3htR9dyeudy/xCHRr9hgtMFgTYXVuLp4J+J3F2GGkyVWQezMy1/EeiBR2
         1fUdG7yBcEsBakSXYe230z2ppIYhwvaxq5W+V3KIpwQIE9rmEKM1geIhPROO9p2nn/VG
         LhZP8xknWzZibZamSvQkxWdZ4za3ZNFJp4U68I2zOYzEhaqEzEMb9iUAgnOtSQZS++qV
         7OtlxEMfQB4U7FIBPKZfwqOlpaBq1iC5SjBee0PGlGoeGhRLnXFMNm0bEx5D/kIBNkO6
         UNq8tZe+ayaMbzg4pBTmMocHe/3ZXse0v2IWIK6SYFXFJTXyFlxy6t25xYPFgwVwckd1
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fEpVGwQvu7cHsTd3X/MiBjAxI2NyMtEZka/ZEp33tvI=;
        b=kFt6ls8j9tziogmhCfpqpy/Wi6Mnhli0oew0tNEmUxXvEACmNX9TCxz7OrA6/tYIP1
         RnQRsgNxuzT5hXK5xyn+HJAdPaKvMJ0+Okw5bEgDCFh8pYLx6exEKE2eUk+e+rb208zp
         xsGO667q5yzNsUiW54pre9RflQt7jE1Cq/gAnzjmLDHf5bDtBNZwZ9QdLQuAZ0MpiXXr
         CFIQVUHbM1sGotswoXyIWQAjmOXTOCxgaPt2qUX6AkO96o/qGsfnE/aiHsxoM//xogiB
         h2vMT+QzI9DmksqwdXvHbITtLRyV3DZ+99xOfbiDRVSpUOEAxp0indAqvhVLXk5cn/s1
         kTZg==
X-Gm-Message-State: AJIora8SXJxs5YlwE0QotFLADypeDANl3lvlCkQUE8+tm5FGKM6qUjCV
        cKsaKg+2abxUxHx4ngV1ZHVMNYOpy9k=
X-Google-Smtp-Source: AGRyM1tCrxMu7u3LPVftX0y+EK7JzAc5x7hnJepesw+/YWe1P06hyyDCNR979cMoFcpmvEdyVHYFLTFSskY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1b57:0:b0:52a:d646:de3c with SMTP id
 b84-20020a621b57000000b0052ad646de3cmr2514471pfb.60.1658537530646; Fri, 22
 Jul 2022 17:52:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:31 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-19-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 18/24] KVM: nVMX: Document priority of all known events on
 Intel CPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a gigantic comment above vmx_check_nested_events() to document the
priorities of all known events on Intel CPUs.  Intel's SDM doesn't
include VMX-specific events in its "Priority Among Concurrent Events",
which makes it painfully difficult to suss out the correct priority
between things like Monitor Trap Flag VM-Exits and pending #DBs.

Kudos to Jim Mattson for doing the hard work of collecting and
interpreting the priorities from various locations throughtout the SDM
(because putting them all in one place in the SDM would be too easy).

Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 379a7b647ac7..3f6617cbf5d9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3908,6 +3908,89 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 	       to_vmx(vcpu)->nested.preemption_timer_expired;
 }
 
+/*
+ * Per the Intel SDM's table "Priority Among Concurrent Events", with minor
+ * edits to fill in missing examples, e.g. #DB due to split-lock accesses,
+ * and less minor edits to splice in the priority of VMX Non-Root specific
+ * events, e.g. MTF and NMI/INTR-window exiting.
+ *
+ * 1 Hardware Reset and Machine Checks
+ *	- RESET
+ *	- Machine Check
+ *
+ * 2 Trap on Task Switch
+ *	- T flag in TSS is set (on task switch)
+ *
+ * 3 External Hardware Interventions
+ *	- FLUSH
+ *	- STOPCLK
+ *	- SMI
+ *	- INIT
+ *
+ * 3.5 Monitor Trap Flag (MTF) VM-exit[1]
+ *
+ * 4 Traps on Previous Instruction
+ *	- Breakpoints
+ *	- Trap-class Debug Exceptions (#DB due to TF flag set, data/I-O
+ *	  breakpoint, or #DB due to a split-lock access)
+ *
+ * 4.3	VMX-preemption timer expired VM-exit
+ *
+ * 4.6	NMI-window exiting VM-exit[2]
+ *
+ * 5 Nonmaskable Interrupts (NMI)
+ *
+ * 5.5 Interrupt-window exiting VM-exit and Virtual-interrupt delivery
+ *
+ * 6 Maskable Hardware Interrupts
+ *
+ * 7 Code Breakpoint Fault
+ *
+ * 8 Faults from Fetching Next Instruction
+ *	- Code-Segment Limit Violation
+ *	- Code Page Fault
+ *	- Control protection exception (missing ENDBRANCH at target of indirect
+ *					call or jump)
+ *
+ * 9 Faults from Decoding Next Instruction
+ *	- Instruction length > 15 bytes
+ *	- Invalid Opcode
+ *	- Coprocessor Not Available
+ *
+ *10 Faults on Executing Instruction
+ *	- Overflow
+ *	- Bound error
+ *	- Invalid TSS
+ *	- Segment Not Present
+ *	- Stack fault
+ *	- General Protection
+ *	- Data Page Fault
+ *	- Alignment Check
+ *	- x86 FPU Floating-point exception
+ *	- SIMD floating-point exception
+ *	- Virtualization exception
+ *	- Control protection exception
+ *
+ * [1] Per the "Monitor Trap Flag" section: System-management interrupts (SMIs),
+ *     INIT signals, and higher priority events take priority over MTF VM exits.
+ *     MTF VM exits take priority over debug-trap exceptions and lower priority
+ *     events.
+ *
+ * [2] Debug-trap exceptions and higher priority events take priority over VM exits
+ *     caused by the VMX-preemption timer.  VM exits caused by the VMX-preemption
+ *     timer take priority over VM exits caused by the "NMI-window exiting"
+ *     VM-execution control and lower priority events.
+ *
+ * [3] Debug-trap exceptions and higher priority events take priority over VM exits
+ *     caused by "NMI-window exiting".  VM exits caused by this control take
+ *     priority over non-maskable interrupts (NMIs) and lower priority events.
+ *
+ * [4] Virtual-interrupt delivery has the same priority as that of VM exits due to
+ *     the 1-setting of the "interrupt-window exiting" VM-execution control.  Thus,
+ *     non-maskable interrupts (NMIs) and higher priority events take priority over
+ *     delivery of a virtual interrupt; delivery of a virtual interrupt takes
+ *     priority over external interrupts and lower priority events.
+ */
 static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-- 
2.37.1.359.gd136c6c3e2-goog

