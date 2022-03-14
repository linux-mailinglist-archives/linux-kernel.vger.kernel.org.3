Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A14D8DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiCNUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiCNUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:07:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490A403CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j5-20020a056902020500b00628ab64be30so14696352ybs.16
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=8f0s79ka6K+xZLjhEa6v9OQwM+zc/G84NFUgH0amXtY=;
        b=oWMxFcmEuQa7Oz8Msf5z2d2F/+cxSvJeY2AkshA00cCwmDongR92lT++R6u+2wswp/
         KeHuRfDuIINh7QuVpmgim0OtP9TVidSBRd8VA4FhF9ErV1otSCPmz+AkktixGdSZwzT8
         LCfWw99uiLBPTLjaM7e2GesV6Vr95aJhEjo56x1iSRDgcy1Pi4qC604b7DxcZjF0+c7w
         /2K0o8E7BBCgilr6vRGvf156M3tc+fnB8epOT0a5sLqt3zWx7hzNiJnGvxaWsM5waXja
         J6OMDvqIkNbTk3t3YyDVaC5Q3RlFOFXcGH/fE9ejjisH84XYUlCL+8IflYOkwpId7Erp
         aQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=8f0s79ka6K+xZLjhEa6v9OQwM+zc/G84NFUgH0amXtY=;
        b=v824qqGiz8hub6LukDtpjGbn/W4h8tL/oLpwbeBQn1V9g582bRsDasHwGJo8SBBrj9
         Nh6Ri34F0ksqag0tP2zGCl/CkM+kLFnVSAr+XkvDZbU54KW5tEKjWwwW7N0YpwJTqbX2
         VypCdCndQpqztUfnRQvzphe024AxuNJHpdGBudZfZIm3//3leKJ+xobcUNBMA2XNpthT
         3lGKO+0kXo8VLL60C3HQ8bZGdGxtnX2qtWfHS0eJ31re/Bz0x2j6inYnDstESr3+DVmS
         FQ+wg8RDZHIx9HY7vpzBjQ4DdQ2soAoqU0Qi64qdNFj8reL4hSvCHsezM6OtiOxqXGe2
         Ym7w==
X-Gm-Message-State: AOAM530PN4gBGuctm5XB9205ZMwO4el6FODnnOev/KtZT/L/Bl7F9Zxt
        EMHrlr1z/1Lx38x4WlezZRiqN2feaZi9pZ1Axg==
X-Google-Smtp-Source: ABdhPJxeJ4ERpyXJrRQxcj/bYJNsQODEu20+d8yn9qPL1N8ZlV6KyQDHbDeVHPvOyZo+/DauOEQQySrLcRIvNw+kpA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:712:0:b0:629:5d03:4b1b with SMTP
 id g18-20020a5b0712000000b006295d034b1bmr19139174ybq.380.1647288351094; Mon,
 14 Mar 2022 13:05:51 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:15 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 6/8] KVM: arm64: Add hypervisor overflow stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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

Allocate and switch to 16-byte aligned secondary stack on overflow. This
provides us stack space to better handle overflows; and is used in
a subsequent patch to dump the hypervisor stacktrace. The overflow stack
is only allocated if CONFIG_NVHE_EL2_DEBUG is enabled, as hypervisor
stacktraces is a debug feature dependent on CONFIG_NVHE_EL2_DEBUG.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
  - Update comment to clarify resetting the SP to the top of the stack
    only happens if CONFIG_NVHE_EL2_DEBUG is disabled, per Fuad


 arch/arm64/kvm/hyp/nvhe/host.S   | 11 ++++++++---
 arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index be6d844279b1..a0c4b4f1549f 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -179,13 +179,18 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
+#else
 	/*
-	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
-	 * This corrupts the stack but is ok, since we won't be attempting
-	 * any unwinding here.
+	 * If !CONFIG_NVHE_EL2_DEBUG, reset SP to the top of the stack, to
+	 * allow handling the hyp_panic. This corrupts the stack but is ok,
+	 * since we won't be attempting any unwinding here.
 	 */
 	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
 	mov	sp, x0
+#endif
 
 	bl	hyp_panic_bad_stack
 	ASM_BUG()
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 703a5d3f611b..efc20273a352 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,6 +34,11 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
+	__aligned(16);
+#endif
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.35.1.723.g4982287a31-goog

