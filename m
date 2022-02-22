Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3549C4BFF80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiBVQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiBVQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:59:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE116C4D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:59:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6994a6942so144242377b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=kA1uHTXTZgvCDEwUv0Venj02VbjFVl5MyBDxltrhOyc=;
        b=NP6fnietNid07WODom2crvgVApuYNwyBc+vaQeT9ELb0Wby0y027V1WoutortBDdER
         6VKH2m5g/hhqE8jP+GV8Z52SXKndZFpGpqKGnvqTJ6saOgO9yiXq/Sl8KOE48ShXSFrf
         Yd/GQs7iTARZWcbcAbs2DZcziHvlIf4ws8th2T86PRoxGLRCAo79SHT5a0UzBseydVww
         c/kdTBUTDmKW4WhBmbRdCfs4Sm1ZyK65IyLMvKPqQFMBa2uiSRCXXe8ja7vMgkYdHVOd
         FDQ7AFIgQCuxZCe7VWKGtZS0vLPpQ4mLhJFEH4IE0gr/JO65ZVTSGIb2gzhuMTjBEe1w
         9t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=kA1uHTXTZgvCDEwUv0Venj02VbjFVl5MyBDxltrhOyc=;
        b=eDjOWfIo2bmmatAkxeRJT9A2HVV0AO7Djm8cCgheIbzbt7TOZVPEi9XYBJm6REpUgt
         kbrMz6/RJHDxAX6fswwzKSRv95B4Z35qH9RmNQqai9TZhxap59fs1ncu0OXFoZfOZS/o
         dFC7RbioUBJoBACrpXTklOzcRsgT4pVEPO6kW5628WREQOZH/MBP6gtwdx1DT5nT9HPn
         RepUzZPR7PN2AKd4AMuyW3dU7leenhgpcN4/T1Q0cM1AJQBN6GOB/Rce9141C3YDK4ts
         S1nXg6PvGgOdZhGGCfvSPHvew4m5toCtdGttMGMq1QM5wvVwuMwWhd2EmDZwgxqiJgrI
         i9sA==
X-Gm-Message-State: AOAM533x02fkjgpRA55wHW0ED00fQtHyveRM1S/kmK1RHqSb6Ue0uku2
        D8/h8lNid62yp1dve0BbwMqO5BaWOw2ADf9YTQ==
X-Google-Smtp-Source: ABdhPJw2THd1z2iAbfih7pFjkHmBG5AlQKbmEqgBiWlGmwrM/dGUOKWBoivdDJ4o6t47SOdmT8K0alB2LRMYcbGgbA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a81:138a:0:b0:2d6:b391:90cd with SMTP
 id 132-20020a81138a000000b002d6b39190cdmr23404107ywt.480.1645549171601; Tue,
 22 Feb 2022 08:59:31 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:07 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 6/9] KVM: arm64: Detect and handle hypervisor stack overflows
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
are aligned to twice their size (PAGE_SIZE), meaning that any valid stack
address has PAGE_SHIFT bit as 0. This allows us to conveniently check for
overflow in the exception entry without corrupting any GPRs. We won't
recover from a stack overflow so panic the hypervisor.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S   | 16 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..78e4b612ac06 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -153,6 +153,10 @@ SYM_FUNC_END(__host_hvc)
 
 .macro invalid_host_el2_vect
 	.align 7
+
+	/* Test stack overflow without corrupting GPRs */
+	test_sp_overflow PAGE_SHIFT, .L__hyp_sp_overflow\@
+
 	/* If a guest is loaded, panic out of it. */
 	stp	x0, x1, [sp, #-16]!
 	get_loaded_vcpu x0, x1
@@ -165,6 +169,18 @@ SYM_FUNC_END(__host_hvc)
 	 * been partially clobbered by __host_enter.
 	 */
 	b	hyp_panic
+
+.L__hyp_sp_overflow\@:
+	/*
+	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
+	 * This corrupts the stack but is ok, since we won't be attempting
+	 * any unwinding here.
+	 */
+	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
+	mov	sp, x0
+
+	bl	hyp_panic_bad_stack
+	ASM_BUG()
 .endm
 
 .macro invalid_host_el1_vect
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..5a2e1ab79913 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
 	unreachable();
 }
 
+void __noreturn hyp_panic_bad_stack(void)
+{
+	hyp_panic();
+}
+
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
 	return __kvm_unexpected_el2_exception();
-- 
2.35.1.473.g83b2b277ed-goog

