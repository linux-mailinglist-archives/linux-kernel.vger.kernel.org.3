Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB94B18BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiBJWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiBJWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:46:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9D45589
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:46:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j17-20020a25ec11000000b0061dabf74012so15055269ybh.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=/IZyRrpjogHkvvKAbn/wuM+XhkmHZlGRNHWt0e5zr8A=;
        b=PBkmRwuFiGGrv5iRHo7tLluafzQlZXF9AN4cUQvrlWacXQcrnAlFwCuc/zOtvTnj3A
         eyIK8Dr7DfK8BlaH06yRYxaDcs2bvmYni1BgVFeXEqyLnH4uCPmVWvtXo1p/9EFiq8OK
         yozHbjdo5J8wCe1HRkEpfHLkD8SJn8NzBv9iKIQrno5l1WcFw65NEM8NvqQ6xCxV2EW5
         EPhU/2linown0tcJ3M3OITrVQ+B7l8BdSNdus0cc0Zg5pAix41rloxydzHuthJS8zX7p
         ctJ0Xrcr/w2hgACd8f01767tNpufMelYYz/KRWp+lszWzveeyi2sIdj7lorWwXkseetK
         RatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=/IZyRrpjogHkvvKAbn/wuM+XhkmHZlGRNHWt0e5zr8A=;
        b=HNokUAgE3UguDutcWSrsSOKsBZFjBtO96XHT9BMJGfkH0QuWP5cuJLF/UN1tki1OzI
         6IdB9koxpRLjP9gAsSvh3do8TW4u2aBLmQF5PRu/6izPi+cKCbs4041jlpxPlw+Z7BxH
         J1A9G9Twpekf6BQBE2oWpyGrxiVkzPdbcRDNl7VsgAisrfXlkbZ18NzutTFiIbZ7ASnX
         3KPD5A71H7wkVkcYECqA3rFwn3sH8dav1qTQyGJTe6sgwTQ1CVPIFtqRbHyiW6cNSoED
         r6pJMI8Vxlx+0bquI0DLtm4fHBtkH2fBKSGkKVjDXIqo/tKJTqghq0K1krLLMTGS+hZW
         a4eA==
X-Gm-Message-State: AOAM532AEJJLM+xo5hZC+t0CBqinoLuIHVmhtgB8QVgLBTuKtCfWYT8B
        4Sp8umVVK1bYYR8wIe5MB7yf8r2hfpm2EPFdrA==
X-Google-Smtp-Source: ABdhPJxltTVLo3VOurL3QnroR1cp79bh23NqnvdKXTYN3qVmilP7Lx3u//hZdXpNdmMvGA/0NZZ08lArO17mKqkodg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a81:3494:: with SMTP id
 b142mr9302016ywa.246.1644533161146; Thu, 10 Feb 2022 14:46:01 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:46 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 5/7] KVM: arm64: Add Hyp overflow stack
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
 arch/arm64/kvm/hyp/nvhe/host.S  | 5 +++++
 arch/arm64/kvm/hyp/nvhe/setup.c | 5 +++++
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
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 114053dff228..39937fa6a1b2 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -20,6 +20,11 @@
 
 unsigned long hyp_nr_cpus;
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
+	__aligned(16);
+#endif
+
 #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
 			 (unsigned long)__per_cpu_start)
 
-- 
2.35.1.265.g69c8d7142f-goog

