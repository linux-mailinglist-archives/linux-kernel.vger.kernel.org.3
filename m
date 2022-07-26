Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F0580DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiGZHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiGZHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A155B2DA8B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e9b1be83eso87088737b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HJlaI56zFqTbz4E9QM1JRki26p1CmhrJ0ldLZAGD5Gc=;
        b=Hg/ba+twU69xuQeTauHfGh1xd/IG5mrk63mhJ8YbvAnkIYauk5mYLezBlA1CBAAwo5
         iudwXyj1NFecmdhOgDc713Mpd26tUbphRGBTx9y6x3SGfN+p2OKUD22cbjv1uK0Zs2iK
         7n537VLpecnFLR32XUyFwgB3FNRhMtF/cc8+8rqGN3vGNoImYNblyhe1sxYMZIG5lzi1
         sx9avbYpCLnTFekr6sLBtneCRMNiIRO9FkeJ79AvkazD6dHzX0TGFnDTV7OdwpiJ+6TE
         YS8w/xFCmTCZs1aYynybx790r1vSYJn2pkRV1zejr+IyokyYFn7uf1IPyeW8bkGwewTz
         uyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HJlaI56zFqTbz4E9QM1JRki26p1CmhrJ0ldLZAGD5Gc=;
        b=y+4yXYD+LkP3X+RhEJCz5plXCM9wJtI2FwHOpY90YuUMhCNi50PDBiAUfZRJyPX6gz
         IOpe1jX046CqBpJVnhdRN6YYFQUprpVoFGVtsgySEUuYh0oBlUVafL8r35pHahsrEdJx
         JuyisBnI4QTdeedoYMaW4K/dryLOmBjf85oDwkBNvaFDMtxzV12Y6UJFXQ8jTbF/+Nmf
         ro/aNwWTdKilXjqkOj2EMgJlDkqTkSoBtSjXdgeqreSYTD3/SoEn5qg6VyD4cWriKiKq
         Tp9oYAdIW6OyEDRZjcct1LX7OB341jOVI/JRE1Ef7psT9yKCpogU3ywiJmAMJva4jrTp
         21EQ==
X-Gm-Message-State: AJIora9eJ0+Wj1SSqhQNCL9Ft8juzH3A4XGT14oYl6+UR0BbSEmo+05M
        XxJlMeq76kt7+PMY2K+iV2ei9D6hQ3RVRiPngQ==
X-Google-Smtp-Source: AGRyM1sij8eAETksDM9PJQAcvuFaOFZtWgM4fTTWZ/PJWmBJUpgq02OLuiPRM+zMspwuXb4dIPzCV3Wazxh9bcMfGw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:80d3:0:b0:66f:5da5:204f with SMTP
 id c19-20020a2580d3000000b0066f5da5204fmr12492060ybm.30.1658821079950; Tue,
 26 Jul 2022 00:37:59 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:35 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 02/17] arm64: stacktrace: Factor out on_accessible_stack_common()
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common on_accessible_stack checks to stacktrace/common.h. This is
used in the implementation of the nVHE hypervisor unwinder later in
this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad's Tested-by tag

Changes in v5:
  - Add Reviewed-by tags from Mark Brown and Fuad
  - Remove random whitespace change, per Mark Brown

 arch/arm64/include/asm/stacktrace.h        |  6 ++----
 arch/arm64/include/asm/stacktrace/common.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 79f455b37c84..43f4b4a6d383 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -65,8 +65,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
 {
-	if (info)
-		info->type = STACK_TYPE_UNKNOWN;
+	if (on_accessible_stack_common(tsk, sp, size, info))
+		return true;
 
 	if (on_task_stack(tsk, sp, size, info))
 		return true;
@@ -74,8 +74,6 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 		return false;
 	if (on_irq_stack(sp, size, info))
 		return true;
-	if (on_overflow_stack(sp, size, info))
-		return true;
 	if (on_sdei_stack(sp, size, info))
 		return true;
 
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 64ae4f6b06fe..f58b786460d3 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -62,6 +62,9 @@ struct unwind_state {
 	struct task_struct *task;
 };
 
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info);
+
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -80,6 +83,21 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
 	return true;
 }
 
+static inline bool on_accessible_stack_common(const struct task_struct *tsk,
+					      unsigned long sp,
+					      unsigned long size,
+					      struct stack_info *info)
+{
+	if (info)
+		info->type = STACK_TYPE_UNKNOWN;
+
+	/*
+	 * Both the kernel and nvhe hypervisor make use of
+	 * an overflow_stack
+	 */
+	return on_overflow_stack(sp, size, info);
+}
+
 static inline void unwind_init_common(struct unwind_state *state,
 				      struct task_struct *task)
 {
-- 
2.37.1.359.gd136c6c3e2-goog

