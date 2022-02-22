Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5D4BFF84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiBVRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiBVRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:01:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061016C4EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:00:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p21-20020a631e55000000b00372d919267cso11653224pgm.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=5qb5Zh5e8x0hA/HCW8SK7letHwHax9Wce8Hz1k3JTdg=;
        b=ITgvGI+DDxrws5QD+aqNmanS1XXPkR5OB1mc/GjeEFKe1PUFInLivQOj2yo7QUg+Ms
         jiQqEBIgx8+pm/kTGUv4kJbSou6k/zNoYhVYDkZAoPQcycS+1hRaIFS0LySP1N6gBZzN
         UaUG12NsYuyKvxTJaL6deitrMeqYZr6WLyZD3VhFhAjEtFzDl9XHbYq3JslYm4d8OYjz
         X/npdOM7xhWI6vlrhC6uIMRYM7xjLfG1ykah3QVJqU0WAp7G1+U7twKq7GAqvOV9yNkk
         pKJSH3usycLKHhOjCm8vwteuS3A7gapZDcF2n0sPj1Iupc/Hz3asBMWMKtVvwjT0Yhf5
         /1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=5qb5Zh5e8x0hA/HCW8SK7letHwHax9Wce8Hz1k3JTdg=;
        b=1vYKjfxTpGnw50sdbPPfeoDZAK1X6gmopRE2UuKaNCdEjem2Lx8JND5w37qTH0/j+h
         Vlceo89YYJO8sUnSfjt3VsWJLVan2Z0einAVgdjSehZ7y+21pT4xFrGsgk8xbd/CZoUX
         yOBMfEhbm7bdFF4zklGCMPrJJTJUjkZjxE55JWJM01a0zHijNvYEwd2Xi2LauyvlEFKf
         CUNqzwKvBcU7hviVHpJuLzzfYd3TAsfN2B6LtCDEMjM3dljaB3PIpvxwVVwzlh0ORuVd
         saTpa90ITFJuo4m4ZPNr0Bs0T/RiLeSOzO4wQrhQGrXWxqlS0BR2XageHu0LTkqA5gji
         YdtA==
X-Gm-Message-State: AOAM533enYHbduRE82RGsLiajDPehIoqXDMIhZJWv0P0mPRoST0J4D9/
        0ww7ZUJJni/psHdU6qiCdXrqV4TCYSUC5yR7qw==
X-Google-Smtp-Source: ABdhPJzH5Lfs/f/UpeVcOR5FEQsrODh9JTFqCt6nAPQwaG7BkrPBoWZU4Etxumn3mAF9Ju4JlTfm2YcSMf2h76tr4w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:2296:b0:4e1:3029:ee2 with
 SMTP id f22-20020a056a00229600b004e130290ee2mr25396129pfe.22.1645549239077;
 Tue, 22 Feb 2022 09:00:39 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:08 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 7/9] KVM: arm64: Add hypervisor overflow stack
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
index 78e4b612ac06..751a4b9e429f 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -171,6 +171,10 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
+#else
 	/*
 	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
 	 * This corrupts the stack but is ok, since we won't be attempting
@@ -178,6 +182,7 @@ SYM_FUNC_END(__host_hvc)
 	 */
 	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
 	mov	sp, x0
+#endif
 
 	bl	hyp_panic_bad_stack
 	ASM_BUG()
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 5a2e1ab79913..2accc158210f 100644
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

