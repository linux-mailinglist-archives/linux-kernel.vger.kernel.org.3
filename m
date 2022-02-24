Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A054C2352
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiBXFVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiBXFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:21:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283B189A81
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:21:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso11322037b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=v7H+YHEXea4IIqGySI7aLREzIvLtpBuCKjmvH1cIeXQ=;
        b=NulZA7w/XH6Ovox3Z8EPA5m/C/4Cu5qNglcuNmoAQGiwk4ZsQUEDaqrrza3kj0/rO1
         4AIBYeKLpSv0/Y0kyPuD0iIaYP+rfQjHEEPqR6hATVEXSiEGw1puhIgCf0xl4KrRv9Ze
         bf3X6bGXRtPd3AVhIvpnfTipQKZ7kaRoy2V22FK420mGJNxu4NBXNZkGrPE31FXO18uL
         p5giufi9NXloDjTBFhB+FZiUOIrIvZ5VdVoH+krscvWKPlnWpw3VycB1f6vXmcZ/3Bcy
         kQgU10gE8FIBPttAIaRsih5zbrOFWZVcM3EhGsNnh5UyKz3q6san4735fgWDpsuyGnfD
         vTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=v7H+YHEXea4IIqGySI7aLREzIvLtpBuCKjmvH1cIeXQ=;
        b=nj+Dn9KYSq0InJwzQQdljNl9WvqfGgf3mzeiaNXQdQrWUaMvHGts56s+CgK/NQ6cSF
         1cbOfnLRZdIpBgkr07EYqrqIRScoMMz4Bvbh7Sxy8q2thuI2ET9BGSMAoV+QnjTgwuIj
         7RUuOAeMtFkFXdmniD+9ALkRY699ha+ZsCn6RxcstSjQDpRYbnUNhPDQzI+QYVzbFky6
         bK4sgFcGlF0r82on//gxsXX6pVDNAvfL3T9BSKH4Fx46l5DnBcNwpaHe+ycvB5H64V+z
         LhbMoJry0709Ek19RD4PkgWgZZ6lq3VABw7zVAVLAbfRGlQ4CDWxoBcf8XEE2Qg8vZvs
         Kc/w==
X-Gm-Message-State: AOAM533sg4s4npNM2HtH/PaMXPeNmBBaQXpi/m4Hgmja2DoXiSTTJwf/
        uzkV0mFWshdHBsl/dLoANCkTU67zW5/zY2oQ4Q==
X-Google-Smtp-Source: ABdhPJyGTlGm+C/X/WYwJEpFuocVcINp/xR0sgVssDAtD0IXfiwn+elCX3UtU0cHn8Y6Lskq6uXxQyXVu8faJREUXQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:415c:9be0:c461:440a])
 (user=kaleshsingh job=sendgmr) by 2002:a25:9108:0:b0:61e:329:700 with SMTP id
 v8-20020a259108000000b0061e03290700mr976530ybl.369.1645680080321; Wed, 23 Feb
 2022 21:21:20 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:13:41 -0800
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
Message-Id: <20220224051439.640768-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 6/8] KVM: arm64: Add hypervisor overflow stack
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
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
 arch/arm64/kvm/hyp/nvhe/host.S   | 5 +++++
 arch/arm64/kvm/hyp/nvhe/switch.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 749961bfa5ba..367a01e8abed 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -179,6 +179,10 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
+#else
 	/*
 	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
 	 * This corrupts the stack but is ok, since we won't be attempting
@@ -186,6 +190,7 @@ SYM_FUNC_END(__host_hvc)
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
2.35.1.473.g83b2b277ed-goog

