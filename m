Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9137F5121EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiD0TCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiD0TCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:02:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7DC400A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:48:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso2448835ybm.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Ukl4ZPUY8nPN3AM2d1WxIlfrlMTerAUV8TUpQy4uNBg=;
        b=MwumuTMcrRhIVZ9j7swb6gFPtCMubn8HLn1QrjGmsWx6TDamUjamppzeC7+Fpo2zsC
         Hn4bx3jBlAkmNArZrSe6MdpVTjEJg354zjO4FkLXTKbIoUVQPlCUBjO2SZCJxc5IkFM8
         cDuvx4Cjo2Ct4xWbHuhsaSXdjyU9NRnacoQoThUDFhnn0R1qKldXoHqIdeFSuyIQg2pC
         chNYgFV6zRM7TOLluFi18wIvk6VKlbVk1NgR+RDLPm9CxC6YqCUydpbanBRewfexSaQv
         7fpo7I+PJ8U4nSeyCdXBluXkIB1PCAe1DvM/MnApanh4SLKGov6OQPuc3nE3UJpm+UME
         sagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Ukl4ZPUY8nPN3AM2d1WxIlfrlMTerAUV8TUpQy4uNBg=;
        b=Mp1LLRevZL0zL1y94i4gOb9+dB5t1n4pSvJPT4sN3p6X+xMSoY6j+OQXx9F6IV0KJl
         Alz5Av/pJRu9cgiPG/z82G+OnSoukLuDwCC3e7T8WrnCT0QY67wayFwgbC2cV59G/n6g
         KmtJXm0DGJKW2vmjaK1OpqSwBr1ZXxkMnXeE7TyyIe90xIWU2l9I7RQdJKF1WmjfVZe9
         1eO7txnSjqa7fS4tu7l5yUNkom3jUb2VOBYiVhMnzs9+4EpGuTUvm/kgEwVbWnjOTxos
         JpnjGTEpejs8eyS8dejgwVArbUeN9fCFl8Us4axEZf2XXimRy4aEmFyr8pUTP3pCfLYu
         93Ow==
X-Gm-Message-State: AOAM533P8ZOZqvTYQDBimH4JrVbCT0UpbBFgB0ajW6y1T29UU8eLzxmp
        /eOyWduAPtEwnzVO7es+1rap5gQmUlhcQnK67A==
X-Google-Smtp-Source: ABdhPJxdWYMm4hIQLef81VH/XkscxGsflUx325g8OpMWgt9ADdwq/DhwrfHi07KPyxCIExLBSzRF/kaTl78lvVXnTw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:16ec:6da0:8cc5:5f24])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:44:0:b0:645:d798:590f with SMTP id
 e4-20020a5b0044000000b00645d798590fmr23864940ybp.228.1651085311643; Wed, 27
 Apr 2022 11:48:31 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:46:57 -0700
In-Reply-To: <20220427184716.1949239-1-kaleshsingh@google.com>
Message-Id: <20220427184716.1949239-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220427184716.1949239-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 2/4] KVM: arm64: Add hypervisor overflow stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index 09b5254fb497..1cd2de4f039e 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -179,13 +179,8 @@ SYM_FUNC_END(__host_hvc)
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
2.36.0.rc2.479.g8af0fa9b8e-goog

