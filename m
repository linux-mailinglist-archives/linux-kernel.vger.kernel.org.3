Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9D4D58EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbiCKD3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbiCKD3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:29:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B9EBAFF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f21-20020a633815000000b0038105768c61so843560pga.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hJz/U0EAMBA7hYzNPif94y/Uhe0d5y5BugBJH8WNWPE=;
        b=Ab1H9iK7AkwPOn659Y0mAICwHVK27uCNKEq4SJiBiViWfsXmL+AeWTP+udLFsapkGk
         iBMGFENjhztxgpeulA/SuDPfrChb1laLmdIRjJTeddb/tuUFbpuikOHcA5uoYNim5/BB
         vg8gSNHOT5w4ilpSaYM0YLA1ON7XkjhPVbPtjMC2EJh7odTILfukaJvpnyL8MZhO5V42
         TnVTrp2ymjJEDBEzCDESloSHqq4/JDlfahEoERiTwBDJWfElijUj2LUOEUKsGNPTyoTC
         KYg0gdm1KF04ACmzpbo5VBkGaoJitqExBhOT6rtSOb2g5rNSimdc0ZY6myVakQKXdouf
         uNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hJz/U0EAMBA7hYzNPif94y/Uhe0d5y5BugBJH8WNWPE=;
        b=qK03ra+lDfl4VpQCyWJ0nYaB5JTJKQh932f9OcL+R102/w/C/vF6ob9R7Se6nxSg3m
         R6Pizi18ZCCk5q2lhAgkVIxgdIvhqaDvox5x0wWtH10/l4/EAt2rce/eGnOqIgBltI+G
         Ghs0Le1P5cPuMZwDZVxqTHtaeJfSvYeqe62QbvBhp4BfD/y9+BnMmPan6SuF2LnffMPn
         pI/cFuRc7BG41WiagiHcp4SZmsgz4JhnB0CyAyb8bKMqBWAvlZSCzOIpFEXrU8ifbMRf
         ZTakeaMMQiIncaO2gSfDGKmGz9DyenS4Eei6XXe5hx9stLKioaIoU57zNiwcvLt/1LlA
         1qgw==
X-Gm-Message-State: AOAM533Gdg14k6dnGIJJxzAm1lsGQTcU5clY+FRCp+BkOyBD2lm8l6Sw
        xlrHocSTFEXDmYmv5Zy6F0IwUHx8MiM=
X-Google-Smtp-Source: ABdhPJzDbKAqjDDIl60ryX/NXrLw4lH1FufiQZPBvFXxRtaKm5Hc8HXYLgEz9j7cNsAqHJIrpUR2yJEcZoA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2348:b0:151:ff4f:e6b2 with SMTP id
 c8-20020a170903234800b00151ff4fe6b2mr8464100plh.51.1646969295202; Thu, 10 Mar
 2022 19:28:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:47 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-8-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 07/21] KVM: x86: Treat #DBs from the emulator as fault-like
 (code and DR7.GD=1)
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dedicated "exception type" for #DBs, as #DBs can be fault-like or
trap-like depending the sub-type of #DB, and effectively defer the
decision of what to do with the #DB to the caller.

For the emulator's two calls to exception_type(), treat the #DB as
fault-like, as the emulator handles only code breakpoint and general
detect #DBs, both of which are fault-like.

For event injection, which uses exception_type() to determine whether to
set EFLAGS.RF=1 on the stack, keep the current behavior of not setting
RF=1 for #DBs.  Intel and AMD explicitly state RF isn't set on code #DBs,
so exempting by failing the "== EXCPT_FAULT" check is correct.  The only
other fault-like #DB is General Detect, and despite Intel and AMD both
strongly implying (through omission) that General Detect #DBs should set
RF=1, hardware (multiple generations of both Intel and AMD), in fact does
not.  Through insider knowledge, extreme foresight, sheer dumb luck, or
some combination thereof, KVM correctly handled RF for General Detect #DBs.

Fixes: 38827dbd3fb8 ("KVM: x86: Do not update EFLAGS on faulting emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3636206ed3e4..507e5f26ebbf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -535,6 +535,7 @@ static int exception_class(int vector)
 #define EXCPT_TRAP		1
 #define EXCPT_ABORT		2
 #define EXCPT_INTERRUPT		3
+#define EXCPT_DB		4
 
 static int exception_type(int vector)
 {
@@ -545,8 +546,14 @@ static int exception_type(int vector)
 
 	mask = 1 << vector;
 
-	/* #DB is trap, as instruction watchpoints are handled elsewhere */
-	if (mask & ((1 << DB_VECTOR) | (1 << BP_VECTOR) | (1 << OF_VECTOR)))
+	/*
+	 * #DBs can be trap-like or fault-like, the caller must check other CPU
+	 * state, e.g. DR6, to determine whether a #DB is a trap or fault.
+	 */
+	if (mask & (1 << DB_VECTOR))
+		return EXCPT_DB;
+
+	if (mask & ((1 << BP_VECTOR) | (1 << OF_VECTOR)))
 		return EXCPT_TRAP;
 
 	if (mask & ((1 << DF_VECTOR) | (1 << MC_VECTOR)))
@@ -8480,6 +8487,12 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		unsigned long rflags = static_call(kvm_x86_get_rflags)(vcpu);
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
+
+		/*
+		 * Note, EXCPT_DB is assumed to be fault-like as the emulator
+		 * only supports code breakpoints and general detect #DB, both
+		 * of which are fault-like.
+		 */
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
 			kvm_pmu_trigger_event(vcpu, PERF_COUNT_HW_INSTRUCTIONS);
@@ -9361,6 +9374,16 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 		vcpu->arch.exception.pending = false;
 		vcpu->arch.exception.injected = true;
 
+		/*
+		 * Fault-class exceptions, except #DBs, set RF=1 in the RFLAGS
+		 * value pushed on the stack.  Trap-like exception and all #DBs
+		 * leave RF as-is (KVM follows Intel's behavior in this regard;
+		 * AMD states that code breakpoint #DBs excplitly clear RF=0).
+		 *
+		 * Note, most versions of Intel's SDM and AMD's APM incorrectly
+		 * describe the behavior of General Detect #DBs, which are
+		 * fault-like.  They do _not_ set RF, a la code breakpoints.
+		 */
 		if (exception_type(vcpu->arch.exception.nr) == EXCPT_FAULT)
 			__kvm_set_rflags(vcpu, kvm_get_rflags(vcpu) |
 					     X86_EFLAGS_RF);
-- 
2.35.1.723.g4982287a31-goog

