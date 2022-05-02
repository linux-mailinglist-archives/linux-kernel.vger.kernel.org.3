Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9730517735
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387037AbiEBTQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiEBTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:16:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4500B7F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:12:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso13895613ybm.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=SbkfFHwtj6LDfXcNEKyNCOiQxOwKu8gDiCPd3B2piLM=;
        b=EDJR3DTAX2eHb+n+nXs3NyHOQJ5iRpUPyz9W4sVPdLTKifwIuceSm9nqbUt+EAUjs8
         Uy7YZCVBjsQZMuZZcYGoCTs3O2Q/0PWU1nemxTVCkyltR+Pfraxqcm/Mij0yMMW/vQpX
         7o+MND69tDg8pttIB2MbNlqW61RbtG5ybH/CaNOoZlcGKOazY5whaBWWiNA+qS9nBW32
         lGox+qsH97d8T7BvUlXqz4iiarm8kZeWQnrhNR/mPh4JMvWU2LVL4KaXwOnrglgIsYjJ
         4umG8AwCaxD8GgaeNHACi79kPhW7xzf/d4gjHIFvgZyqSBDCJJIazbd++y+qCRLqv5Go
         POdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=SbkfFHwtj6LDfXcNEKyNCOiQxOwKu8gDiCPd3B2piLM=;
        b=DFQoNZb6utY1UXkGoIfWmbnJXkl4SAhWYszRlXozlXoNIHwk/Z2oivht02S2BPZr5w
         44wtum654iY3wCTwLQGNeiPEh3HPuZplM47dlBqo4biSWIotShIymiUesZUfwIXUb5jF
         bfl1SNXy2Z4XSMlks4yjIt3oBAV6wzMUeqepNXRBWp8vqS6WiPihnt/QP/pdQUNMvnGt
         eR+0F0HImT6ZPDuhpDZcf89ntaDxeBDCOP/dylyFEL+W4NVY7GnHsSETgxhhQ1y9iLf2
         lKfPNv+/VuIgjLmd1QhGnDvykfAQhGh2JMMHHbipdPYiWNjuDMc0DQkcz2k7pJ/8jCKL
         k9zQ==
X-Gm-Message-State: AOAM531ygQAvqLGMDKwCirNO7VN/XqTZJ6NDbraJqCSgvL9xU3UEtRdb
        ItnrUrcjMLm+YbXPVBGI/X5TBgG5tjeZSIkxhQ==
X-Google-Smtp-Source: ABdhPJxP2xIlP7KifAzH0zbmoPkFGlaCnGx7XBRgqtsRS8QtrsuRrH/CX2j863LkhO0OA3feG1oXuqpQ/Sp0DoMkEA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:55c:7548:7073:c14f])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:e8c7:0:b0:2f4:cd95:76d8 with SMTP
 id r190-20020a0de8c7000000b002f4cd9576d8mr12025072ywe.55.1651518771017; Mon,
 02 May 2022 12:12:51 -0700 (PDT)
Date:   Mon,  2 May 2022 12:12:01 -0700
In-Reply-To: <20220502191222.4192768-1-kaleshsingh@google.com>
Message-Id: <20220502191222.4192768-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220502191222.4192768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 1/5] KVM: arm64: Factor out common stack unwinding logic
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Keir Fraser <keirf@google.com>, Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Factor out the stack unwinding logic common to both the host kernel and
the nVHE hypersivor into __unwind_next(). This allows for reuse in the
nVHE hypervisor stack unwinding (later in this series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kernel/stacktrace.c | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 0467cb79f080..ee60c279511c 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -81,23 +81,19 @@ NOKPROBE_SYMBOL(unwind_init);
  * records (e.g. a cycle), determined based on the location and fp value of A
  * and the location (but not the fp value) of B.
  */
-static int notrace unwind_next(struct task_struct *tsk,
-			       struct unwind_state *state)
+static int notrace __unwind_next(struct task_struct *tsk,
+				 struct unwind_state *state,
+				 struct stack_info *info)
 {
 	unsigned long fp = state->fp;
-	struct stack_info info;
-
-	/* Final frame; nothing to unwind */
-	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
-		return -ENOENT;
 
 	if (fp & 0x7)
 		return -EINVAL;
 
-	if (!on_accessible_stack(tsk, fp, 16, &info))
+	if (!on_accessible_stack(tsk, fp, 16, info))
 		return -EINVAL;
 
-	if (test_bit(info.type, state->stacks_done))
+	if (test_bit(info->type, state->stacks_done))
 		return -EINVAL;
 
 	/*
@@ -113,7 +109,7 @@ static int notrace unwind_next(struct task_struct *tsk,
 	 * stack to another, it's never valid to unwind back to that first
 	 * stack.
 	 */
-	if (info.type == state->prev_type) {
+	if (info->type == state->prev_type) {
 		if (fp <= state->prev_fp)
 			return -EINVAL;
 	} else {
@@ -127,7 +123,25 @@ static int notrace unwind_next(struct task_struct *tsk,
 	state->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	state->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 	state->prev_fp = fp;
-	state->prev_type = info.type;
+	state->prev_type = info->type;
+
+	return 0;
+}
+NOKPROBE_SYMBOL(__unwind_next);
+
+static int notrace unwind_next(struct task_struct *tsk,
+			       struct unwind_state *state)
+{
+	struct stack_info info;
+	int err;
+
+	/* Final frame; nothing to unwind */
+	if (state->fp == (unsigned long)task_pt_regs(tsk)->stackframe)
+		return -ENOENT;
+
+	err = __unwind_next(tsk, state, &info);
+	if (err)
+		return err;
 
 	state->pc = ptrauth_strip_insn_pac(state->pc);
 
-- 
2.36.0.464.gb9c8b46e94-goog

