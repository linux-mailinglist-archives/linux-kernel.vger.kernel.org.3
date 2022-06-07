Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19E4540420
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbiFGQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345231AbiFGQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:52:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494211C38
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:52:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30047b94aa8so153321567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x4HYk8ZXIQ3L7NS6dgOSqFvxE7Amt+Ba78KLaT8irts=;
        b=bbRfr+VLNGH5abSF72ZiMEU0zNJsQdJuZGojBmlWNAKmd1Ix07dEopbMuqAJ5xYIMb
         z01k3Ui7ONQkbcxRWF9ga19riZtMb8V7AbmCO4w39rPeR/t8TvN1l3MyXBCK/tQXXgBt
         +8NF8qc1zN7qjitT9iTsE1VPPfeXteLDvl9Ay4SBBHThXEGq/BXjsxwklqYe70WmQ8ht
         B//5R0e0lXiDLWSo1IWOJLY2QJzHyPd5V+AnnA2sqNE39mfpfPTbR7oRZ1zS2kIl3LpD
         g7cHHtq6aP+d8NyxJqCmyhVy37PTQdtOFWQ2sJus28hTcinWBTQXvWv7QiBi74k2Tz1M
         dw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x4HYk8ZXIQ3L7NS6dgOSqFvxE7Amt+Ba78KLaT8irts=;
        b=R3rJKOwZGe55LdI9KpK5zNzwHUS5A8LTa+Tbr656OzXekfNccb0ihluZgL3IlEdEUj
         fVOlmAoVPWpimaT+j78VXfsUMHqfvmUv44GYd5TZofRpuH+9NBzD/HsTAPXVgtnwD8qZ
         bOMEDgmY4QLXGgTz+cmqONmNBQ1RHK3+baFNayhpKhjCTjTK1Y+YhMexWH85lZTXMjdn
         jONhNjwGJPE4b9VmEdn2sMyLDwfd5EzYVarQHxqHpdt+BcMnqxFcMZhEoTIDJhao386h
         ch1uPG38VhWDf1Krs7YJnwCRBu9Pmq5OQF3QoYJO5mVg4dZZkC7T8bvm6Xt2LNxpvC1s
         WHbQ==
X-Gm-Message-State: AOAM532vCjwNPPTfrG6zy2GCB4ABR7gBtsUj9/lVXbkt6XgEauaaH351
        TuofOP62sNhFU0QIeMJTGcX14GqtWxQyDXCLKQ==
X-Google-Smtp-Source: ABdhPJz5cu56sG78OQqQQjV0I3/hccrWnE63JIWa21o18y/iEx0ZFYvdLKe0iAXWzw5Pfvq5YrrnFsuiy2fijwl19w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:12:0:b0:663:e4df:7bc0 with SMTP id
 a18-20020a5b0012000000b00663e4df7bc0mr2722447ybp.208.1654620745478; Tue, 07
 Jun 2022 09:52:25 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:45 -0700
In-Reply-To: <20220607165105.639716-1-kaleshsingh@google.com>
Message-Id: <20220607165105.639716-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 3/5] KVM: arm64: Add hypervisor overflow stack
From:   Kalesh Singh <kaleshsingh@google.com>
To:     mark.rutland@arm.com, broonie@kernel.org, maz@kernel.org
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, tjmercier@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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

Allocate and switch to 16-byte aligned secondary stack on overflow. This
provides us stack space to better handle overflows; and is used in
a subsequent patch to dump the hypervisor stacktrace.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kernel/stacktrace.c | 3 +++
 arch/arm64/kvm/hyp/nvhe/host.S | 9 ++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index a84e38d41d38..f346b4c66f1c 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -242,4 +242,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	unwind(task, &state, consume_entry, cookie);
 }
+#else /* __KVM_NVHE_HYPERVISOR__ */
+DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack)
+	__aligned(16);
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index ea6a397b64a6..4e3032a244e1 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -177,13 +177,8 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
-	/*
-	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
-	 * This corrupts the stack but is ok, since we won't be attempting
-	 * any unwinding here.
-	 */
-	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
-	mov	sp, x0
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, overflow_stack + PAGE_SIZE, x0
 
 	b	hyp_panic_bad_stack
 	ASM_BUG()
-- 
2.36.1.255.ge46751e96f-goog

