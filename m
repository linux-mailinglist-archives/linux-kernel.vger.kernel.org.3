Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D557EABC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGWAwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiGWAvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:51:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AD87C0C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c18-20020a170903235200b0016c37f6d48cso3421958plh.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=oN29UI/ppYkSTKD+t54Fsh7oXFE1JTy24JfG7uJwp+g=;
        b=P5Snt+Szs0btQEkwNsKlQsBsZ//yOjKpu3fFtCbh9Yf3WsVD9ZHIVH6Or1UVpU+GyU
         nzdx2XAWNf6mdZFLZE/sII4+aedz7LAnwRsVAwNwpAV77g0yOJ8Lm6orpeatUonvUZV6
         yIbkNjUab4SIyZsgAQSorUbUpcuEh3UsrDy3Cn+OudgcRlKe44g/nctkwQfgUFgF56oF
         6eSA54ruO1INLcVTC0PKJmAHe3Pm1Y9yFnYbJmsrlXu78yA6kQg70N+B9Y+3q31t25ES
         +DD1wG9/uzeJSp3ZxrD09FmlZzx+IZavN1XL5REiMNZMvJjL8ErNL9RvE0ph6sw908py
         N1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=oN29UI/ppYkSTKD+t54Fsh7oXFE1JTy24JfG7uJwp+g=;
        b=mvy7M6nlUcH884hBcrm44xX72RDZwuAjvv6QcSPol9U0ehusWYqYr10GS2ItJmWrKg
         2CCNesyJkIcI1X9HyNtqqh5jMl/buspPbEG74evFM0IjneYzIeRkevsBZclVzQ9iZo4r
         LjkC0qBDmX0qegVs9Rflsex6pkqFaFe6w3JN97ZINMiYqODDcbc/cZJqWKp9Xv/Lhp11
         VF3TfSHo6cmhoZnmKIMCya7BFBgulHkMsnFB8KhhwNzbNxbvFnUDo1NhrmltZ/pH54dH
         J6Z5yStwFVPKFjItilMriclvakQ1JvSoxbM/QBm+GZswFYGDWXiIof4vup52oVfMBy1q
         qj6w==
X-Gm-Message-State: AJIora9KgFvePXGGlqq/T/khFCTd5/84eeaPBkrnRIPgDTmardSL8esa
        ZN8NIAvkrdUkyFldzbqrA06bgVEo2zg=
X-Google-Smtp-Source: AGRyM1udBKVmz+vqWaGzV1DyeEBlePIMHNBrFBIejJQhx8uwLi9YR1FvxY1ALPVdpVOXoPzQsVWHTSkoWH4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1bcb:b0:1ef:a6c3:30c6 with SMTP id
 oa11-20020a17090b1bcb00b001efa6c330c6mr20541959pjb.37.1658537508651; Fri, 22
 Jul 2022 17:51:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:17 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 04/24] KVM: nVMX: Treat General Detect #DB (DR7.GD=1) as fault-like
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

Exclude General Detect #DBs, which have fault-like behavior but also have
a non-zero payload (DR6.BD=1), from nVMX's handling of pending debug
traps.  Opportunistically rewrite the comment to better document what is
being checked, i.e. "has a non-zero payload" vs. "has a payload", and to
call out the many caveats surrounding #DBs that KVM dodges one way or
another.

Cc: Oliver Upton <oupton@google.com>
Cc: Peter Shier <pshier@google.com>
Fixes: 684c0422da71 ("KVM: nVMX: Handle pending #DB when injecting INIT VM-exit")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c6f9fe0b6b33..456449778598 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3853,16 +3853,29 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu,
 }
 
 /*
- * Returns true if a debug trap is pending delivery.
+ * Returns true if a debug trap is (likely) pending delivery.  Infer the class
+ * of a #DB (trap-like vs. fault-like) from the exception payload (to-be-DR6).
+ * Using the payload is flawed because code breakpoints (fault-like) and data
+ * breakpoints (trap-like) set the same bits in DR6 (breakpoint detected), i.e.
+ * this will return false positives if a to-be-injected code breakpoint #DB is
+ * pending (from KVM's perspective, but not "pending" across an instruction
+ * boundary).  ICEBP, a.k.a. INT1, is also not reflected here even though it
+ * too is trap-like.
  *
- * In KVM, debug traps bear an exception payload. As such, the class of a #DB
- * exception may be inferred from the presence of an exception payload.
+ * KVM "works" despite these flaws as ICEBP isn't currently supported by the
+ * emulator, Monitor Trap Flag is not marked pending on intercepted #DBs (the
+ * #DB has already happened), and MTF isn't marked pending on code breakpoints
+ * from the emulator (because such #DBs are fault-like and thus don't trigger
+ * actions that fire on instruction retire).
  */
-static inline bool vmx_pending_dbg_trap(struct kvm_vcpu *vcpu)
+static inline unsigned long vmx_get_pending_dbg_trap(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.exception.pending &&
-			vcpu->arch.exception.nr == DB_VECTOR &&
-			vcpu->arch.exception.payload;
+	if (!vcpu->arch.exception.pending ||
+	    vcpu->arch.exception.nr != DB_VECTOR)
+		return 0;
+
+	/* General Detect #DBs are always fault-like. */
+	return vcpu->arch.exception.payload & ~DR6_BD;
 }
 
 /*
@@ -3874,9 +3887,10 @@ static inline bool vmx_pending_dbg_trap(struct kvm_vcpu *vcpu)
  */
 static void nested_vmx_update_pending_dbg(struct kvm_vcpu *vcpu)
 {
-	if (vmx_pending_dbg_trap(vcpu))
-		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-			    vcpu->arch.exception.payload);
+	unsigned long pending_dbg = vmx_get_pending_dbg_trap(vcpu);
+
+	if (pending_dbg)
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS, pending_dbg);
 }
 
 static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
@@ -3933,7 +3947,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * while delivering the pending exception.
 	 */
 
-	if (vcpu->arch.exception.pending && !vmx_pending_dbg_trap(vcpu)) {
+	if (vcpu->arch.exception.pending && !vmx_get_pending_dbg_trap(vcpu)) {
 		if (vmx->nested.nested_run_pending)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
-- 
2.37.1.359.gd136c6c3e2-goog

