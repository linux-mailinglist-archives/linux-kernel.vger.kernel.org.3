Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5900E4C3C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiBYDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiBYDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:45:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89729DD7D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:45:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e129-20020a25d387000000b006245d830ca6so2021079ybf.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=53jTUHXN8pXhAmdBLdFZ3XwM5fVPq5Z9CpfRPZqZFCI=;
        b=Vuz84OwZMocSA83nvo8NZ4zxH6ccvGrHdYvieAWCrHxxrge7jQQG/OH1a8uFFGG4t0
         GAfASHstE4xtShS2AA7B5kso/iNl7ro+9oirqf1U0bSq+Uzf5hhssvO0GkISWMyybAeX
         7BvdyvbW02JKYDtiLwjM1HUgVDPHahEXe8LP8aQT3bDAE30D49aHNFHS+Gf9kmKHlfkT
         cdfOYW9WnT4/rtSTYaWkBZCFYQwYShrnDme/ddg8d8qh2GtFqPx74zGTMQnR1xpBFtEF
         Ladj1Ae/voJEATBIZ4vuWd/MgNnf6zMvOfwtSkER77HyC18caRCbFRIBen0IE3m2Ez3z
         pDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=53jTUHXN8pXhAmdBLdFZ3XwM5fVPq5Z9CpfRPZqZFCI=;
        b=Dkwx/Tn79IxViiDBdyjo//6F1TG3edwM2YEo0//Vg1Z72NEOpoDNMPIdsjKtCr8Qk1
         5JngLMJ0VttrtC71+Qi86YUjDyTsPrwm0byhbGvQMd+TjC2w4+pDsIyL8zsW1i3uqyIj
         AnOl6AZcRz9PohHARtfLADHbEk5GZl6KDND/2agygENNil4jMAf3D6fkkZ9Ji4zI9QTc
         Odj2fqVPe2DH8vosr73jnqagq8T52Q0c+ehZcySr0jsdOsWatqC5h/Iv+8gguoaOG86o
         OW9I9TU5E089b6rnYBeIdrD+Q8qKhp7Uv+IQ0QdsCjxs6FdwLJyOlXHYIxLef0mrfI1t
         5qKA==
X-Gm-Message-State: AOAM533xQpCutMwmYgn2lbAbSmuQtGNNnZIlo8wIMZ3CbM0ltnHDOaxH
        emAvTZExiElXu1/vffTTSqRvptRRVwhVVzWu2A==
X-Google-Smtp-Source: ABdhPJx4OPw80y5Vq18KcxUsCYgPq2jDdE5mSLmC2vx51PsGs+75ealL5rRfaLmZWL1VA67CEKvpatgngkV2u3nJHg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:ee45:0:b0:2d6:ec15:4f89 with SMTP
 id x66-20020a0dee45000000b002d6ec154f89mr5460513ywe.372.1645760700677; Thu,
 24 Feb 2022 19:45:00 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:51 -0800
In-Reply-To: <20220225033548.1912117-1-kaleshsingh@google.com>
Message-Id: <20220225033548.1912117-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 6/8] KVM: arm64: Add hypervisor overflow stack
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
        Andrew Scull <ascull@google.com>,
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

Changes in v4:
  - Update comment to clarify resetting the SP to the top of the stack
    only happens if CONFIG_NVHE_EL2_DEBUG is disabled, per Fuad

 arch/arm64/kvm/hyp/nvhe/host.S   | 11 ++++++++---
 arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 749961bfa5ba..2c04f3e6b3f0 100644
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
2.35.1.574.g5d30c73bfb-goog

