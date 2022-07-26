Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC96580E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiGZHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiGZHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A472B631
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b129-20020a25e487000000b0066e1c52ac55so10471144ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=KintJzFkc3fGk0PZThBnEs9+mVIkzS8MGNi7+4hHocM=;
        b=F99U/GyUMm86I5hhUPAEh3i37Efs41f+NjVsXrba2/WKPQPyfrqe2tZkqcM8WLdn4N
         tjoyQVaWZBceiGc+IiYE68nlfbCinUJe03/UFDa39xJ3UpbZdD9kbzr1fXgF94y52jEV
         rS8Lbe7khCJnAGE3uuqPQYZcwfmKGiiahXSgT5hnhAxspgLgUZwx2XcFjsYvNHIlG4TO
         Kz3pafuhE8xSvKeQKTkBbd6h7vha4xx8mVypWM60J3ynB/E+WPGvUVSThWgp4tikyd+6
         meIxa9eGPMfqTbQzFurHAAv657oZE/ifKVL3Y5P3LVWtokWYf79sEL7M95vb7JRmvBTK
         wWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=KintJzFkc3fGk0PZThBnEs9+mVIkzS8MGNi7+4hHocM=;
        b=QULUVCu0PVe0m/uTPYGuDup9Gh8N0s1E66zyiVArJPjJUScIf0+c0AMxOkg3GKEAfE
         Tik1cOBpmJRu6gIy3KDwswG+nXseoG3V35m29G+ba2lyG8ycNcNmNxRf57lknkB3VK4H
         SPMA27C6wYmyWeEb+iUPT4aMIR4QP0O76A4ifAiuWTqKzyC453NxpvG81iAmYQf1EPF2
         pIdpbzXV5hxQoc87Dc0mPyfpcKH2Uua0uZUEDFM0pkHcuFfbndt91aMs7rJt+HBN07Ek
         ToT1kuSSxjSXxwWkqu8uc8yQZ/IG36602V0s+f9qyQE/pFTG9d4QJbpltkFtz0Mm1uiG
         NQsA==
X-Gm-Message-State: AJIora+4uANsdhACRwErLGlB7gt/epZ3EzwEWloXCNiKtCvR8fe0y+uF
        Hkhyyf3QNBgyCrM4J23ZkPRSv2/YMhfOUPxxZw==
X-Google-Smtp-Source: AGRyM1tViIgbjsnsd0F2wwzY/mHFi+V+awQaQAAf7taOX+okajo7NRVMTiuzJzRWy3+FHjR02RHuf/ccxOBvmI+klQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d796:0:b0:671:6696:d824 with SMTP
 id o144-20020a25d796000000b006716696d824mr3624037ybg.52.1658821085312; Tue,
 26 Jul 2022 00:38:05 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:37 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 04/17] arm64: stacktrace: Handle frame pointer from
 different address spaces
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unwinder code is made reusable so that it can be used to
unwind various types of stacks. One usecase is unwinding the
nVHE hyp stack from the host (EL1) in non-protected mode. This
means that the unwinder must be able to translate HYP stack
addresses to kernel addresses.

Add a callback (stack_trace_translate_fp_fn) to allow specifying
the translation function.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Fix typo in comment, per Fuad
  - Add Fuad=E2=80=99s Reviewed-by tag and Tested-by tags

Changes in v5:
  - Fix typo in commit text, per Fuad
  - Update unwind_next_common() to not have side effects on failure, per Fu=
ad
  - Use regular comment instead of doc comments, per Fuad

 arch/arm64/include/asm/stacktrace/common.h | 29 +++++++++++++++++++---
 arch/arm64/kernel/stacktrace.c             |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/includ=
e/asm/stacktrace/common.h
index 0c5cbfdb56b5..b241edba5c76 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -124,11 +124,25 @@ static inline void unwind_init_common(struct unwind_s=
tate *state,
 	state->prev_type =3D STACK_TYPE_UNKNOWN;
 }
=20
+/*
+ * stack_trace_translate_fp_fn() - Translates a non-kernel frame pointer t=
o
+ * a kernel address.
+ *
+ * @fp:   the frame pointer to be updated to its kernel address.
+ * @type: the stack type associated with frame pointer @fp
+ *
+ * Returns true and success and @fp is updated to the corresponding
+ * kernel virtual address; otherwise returns false.
+ */
+typedef bool (*stack_trace_translate_fp_fn)(unsigned long *fp,
+					    enum stack_type type);
+
 static inline int unwind_next_common(struct unwind_state *state,
-				     struct stack_info *info)
+				     struct stack_info *info,
+				     stack_trace_translate_fp_fn translate_fp)
 {
+	unsigned long fp =3D state->fp, kern_fp =3D fp;
 	struct task_struct *tsk =3D state->task;
-	unsigned long fp =3D state->fp;
=20
 	if (fp & 0x7)
 		return -EINVAL;
@@ -139,6 +153,13 @@ static inline int unwind_next_common(struct unwind_sta=
te *state,
 	if (test_bit(info->type, state->stacks_done))
 		return -EINVAL;
=20
+	/*
+	 * If fp is not from the current address space perform the necessary
+	 * translation before dereferencing it to get the next fp.
+	 */
+	if (translate_fp && !translate_fp(&kern_fp, info->type))
+		return -EINVAL;
+
 	/*
 	 * As stacks grow downward, any valid record on the same stack must be
 	 * at a strictly higher address than the prior record.
@@ -163,8 +184,8 @@ static inline int unwind_next_common(struct unwind_stat=
e *state,
 	 * Record this frame record's values and location. The prev_fp and
 	 * prev_type are only meaningful to the next unwind_next() invocation.
 	 */
-	state->fp =3D READ_ONCE(*(unsigned long *)(fp));
-	state->pc =3D READ_ONCE(*(unsigned long *)(fp + 8));
+	state->fp =3D READ_ONCE(*(unsigned long *)(kern_fp));
+	state->pc =3D READ_ONCE(*(unsigned long *)(kern_fp + 8));
 	state->prev_fp =3D fp;
 	state->prev_type =3D info->type;
=20
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.=
c
index 834851939364..eef3cf6bf2d7 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -87,7 +87,7 @@ static int notrace unwind_next(struct unwind_state *state=
)
 	if (fp =3D=3D (unsigned long)task_pt_regs(tsk)->stackframe)
 		return -ENOENT;
=20
-	err =3D unwind_next_common(state, &info);
+	err =3D unwind_next_common(state, &info, NULL);
 	if (err)
 		return err;
=20
--=20
2.37.1.359.gd136c6c3e2-goog

