Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FC540418
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbiFGQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiFGQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:51:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA52F6889
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:51:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s22-20020a252d56000000b0065d1ef35f9dso15596806ybe.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=utThYmevKONU/9m2pQGdDHA12doEH9idunElwn0Wp+Y=;
        b=gUIQMQl0JQzhYd3S4fyRf5XmWfJe5lmGtNGJawPlt9xGCh6iVfChXa73AoojCUrlbl
         IVXeOtMoTYUHDpAFH3A8brBwPVcti7T1TXiYbRGm9WL+wI2w1S/KEwaSu9WutVR9tygx
         84Kvg+VfGwL6M1f0ziUNEjgMhLSuSnn44AbVKJ9wncUs/50JTgmnIHf+wQmtrOV7M8Mt
         K4uO5mPCKZewDVjZ3Ihsg/rY8/0Ud5jqcoTKOFhCTALO+vhAlMfVTPQqBzexRVTQ5AE6
         AWpm7eIByU/UruiBwIFFfpmgXXAyJwhbholwIR4cxXKH/anXN/52PMZ9cQYrHOq/XYDw
         pDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=utThYmevKONU/9m2pQGdDHA12doEH9idunElwn0Wp+Y=;
        b=CpGyKSEn7XLH3/1dWBHr3H5NIq2OwmQSHJMomUoavH4sTtTs5p0bDEwgtDlsE1ICsR
         AV5uOWMP4mDAF8K1eJH6g/+Im3mABV+ZxJZ6HZHG8/tPPlSFeqyq17o16ADm5Xm5BUN+
         E1T1qOs8L60CZDEQo8j1Uk5iIuCrSleW6EoIdia/Slu3PFfok9Sg9Ijxd/zfcIYKX9Z0
         x0c6dZFomWU6qH27fZAQNU4Mo9uKcP6laVRaNVCdulCLbYzrvl/z0rC8X6JMGMYCahz7
         xGRTjb6GZTbo7RJ+LoUKI5fWA0PWg5le2zvQs1hevCA61F2mTLXFG+LtxAqCsM120p/D
         ZjwA==
X-Gm-Message-State: AOAM533xIr7zbEPbi9rCDmwUtdCzFC9TQXKPVzF0QLo0ppoOyxWj5x6n
        beWUsVZoYRdV6Rv2QwYV+8h9Ag1HeiUvApXSOw==
X-Google-Smtp-Source: ABdhPJzuHcHlzERjFFs10J5b1VKR548pg9LJge0vp7jHTNhan1WTvDRj/6ZH8ppj3YV0piRTv9xwQbWhp9qkOIWgBQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a81:57d6:0:b0:30c:a234:140d with SMTP
 id l205-20020a8157d6000000b0030ca234140dmr33093505ywb.269.1654620698862; Tue,
 07 Jun 2022 09:51:38 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:43 -0700
In-Reply-To: <20220607165105.639716-1-kaleshsingh@google.com>
Message-Id: <20220607165105.639716-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 1/5] KVM: arm64: Factor out common stack unwinding logic
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
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
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

Factor out the stack unwinding logic common to both the host kernel and
the nVHE hypersivor into __unwind_next(). This allows for reuse in the
nVHE hypervisor stack unwinding (later in this series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---

Changes in v3:
  - Add Mark's Reviewed-by tag

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
2.36.1.255.ge46751e96f-goog

