Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65B576865
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGOUoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiGOUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:43:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689789A9D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v19-20020a17090abb9300b001ef7bbd5a28so5795981pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BOGH4GvmHxus6mPQ/7QzuJK24eM8ulNZL4utCvx6mUs=;
        b=LgqtoB7hAC2fRABpFVFEFO1hUxy5pMxHtczA0EtEdSJCorSdZEGliS3FxVoNrR8JbW
         98Mzwc5AeSyLM3I60psdlT14GOzFDoYrZfo9nDtX9V07CkjsYIlJdlV1Aav0c8O+Xrap
         r7OXTkPcYudETUKQX9hNOw1Wov3J1b4wPaB9T3PF+QWloBJNdcG22IfJNaTJXiaIQV9V
         j3f1+PhjERQIDbBlEi7a0LarPsCKpDvXEvpaEjpn09evGxatKB4jw+vXtZK5Sva8hrhf
         YHXrBEBqnU2ZRy7kEYIxKYEdIYMKZ3CvicY6Tqx2YcNaVNFfJUQOdtUbXElgOXJulB/f
         lE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BOGH4GvmHxus6mPQ/7QzuJK24eM8ulNZL4utCvx6mUs=;
        b=iHXOQzfJThzinSsy1XdsBhECVmg+PBH05HRcB7Ya8ScGoOX5bgsPwXJd3d0pFM37E+
         L0qct15DRYvpJYiRgNFoyUEc6K0+t4Bl4bOn0UrfR6uGR5HWJ5frjA+1BzGGCrjwQr3S
         5PdzcIhDhmp3KslRaOoO5kVIuBy893givyGbujrMLfnBTwPRIvAFd3g9/lBTSoT5vBtF
         2jOQ+y3FLj9E6sdLVC0saiOlrv+WIC52Gaba4CUu0DEDWkkyv3yW9ot9phxORc5Fd6Iw
         FXyMFTw2BLn6dqii8KCWBu3CkiFhnCIe/T930WNxPb+Bjb7OMMVT9ORMjG6ReCjdnUsq
         8dYg==
X-Gm-Message-State: AJIora/hfNRf2Rxa/xKGCdYqy1nUzVQpKdpBk5AWS7a6H5XwKYJbdWjK
        w1/WCmIUxWR8QdZPkzBzLjxHrnzbuTc=
X-Google-Smtp-Source: AGRyM1vItnnzpzhnBiTpbOhAr4DfHL7mdh0QtBgJ65jrcgrqcbTIRade2nXss6DZvYwjfC7BMRfy4BrudIA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1802:b0:1f0:22f1:e1d3 with SMTP id
 lw2-20020a17090b180200b001f022f1e1d3mr17716536pjb.235.1657917784386; Fri, 15
 Jul 2022 13:43:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 20:42:20 +0000
In-Reply-To: <20220715204226.3655170-1-seanjc@google.com>
Message-Id: <20220715204226.3655170-19-seanjc@google.com>
Mime-Version: 1.0
References: <20220715204226.3655170-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 18/24] KVM: nVMX: Document priority of all known events on
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
---
 arch/x86/kvm/vmx/nested.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c3fc8b484785..981f98ef96f1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3901,6 +3901,89 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
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
2.37.0.170.g444d1eabd0-goog

