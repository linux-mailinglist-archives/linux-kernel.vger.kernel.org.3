Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A119052A558
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349380AbiEQOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349358AbiEQOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:52:12 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DA1C135
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:52:07 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:c0f6:7ccf:c217:5f21])
        by baptiste.telenet-ops.be with bizsmtp
        id Xqs52700B0nFbBY01qs5MU; Tue, 17 May 2022 16:52:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nqyYP-000ht2-6h; Tue, 17 May 2022 16:52:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nqyYO-004IfE-Qv; Tue, 17 May 2022 16:52:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm64/sve: Move sve_free() into SVE code section
Date:   Tue, 17 May 2022 16:52:03 +0200
Message-Id: <cd633284683c24cb9469f8ff429915aedf67f868.1652798894.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARM64_SVE is not set:

    arch/arm64/kernel/fpsimd.c:294:13: warning: ‘sve_free’ defined but not used [-Wunused-function]

Fix this by moving sve_free() and __sve_free() into the existing section
protected by "#ifdef CONFIG_ARM64_SVE", now the last user outside that
section has been removed.

Fixes: a1259dd807192917 ("arm64/sve: Delay freeing memory in fpsimd_flush_thread()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/kernel/fpsimd.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d994bf0a6ca93984..819979398127e6f3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -281,23 +281,6 @@ static bool have_cpu_fpsimd_context(void)
 	return !preemptible() && __this_cpu_read(fpsimd_context_busy);
 }
 
-/*
- * Call __sve_free() directly only if you know task can't be scheduled
- * or preempted.
- */
-static void __sve_free(struct task_struct *task)
-{
-	kfree(task->thread.sve_state);
-	task->thread.sve_state = NULL;
-}
-
-static void sve_free(struct task_struct *task)
-{
-	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
-
-	__sve_free(task);
-}
-
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
 {
 	return task->thread.vl[type];
@@ -690,6 +673,22 @@ static void sve_to_fpsimd(struct task_struct *task)
 }
 
 #ifdef CONFIG_ARM64_SVE
+/*
+ * Call __sve_free() directly only if you know task can't be scheduled
+ * or preempted.
+ */
+static void __sve_free(struct task_struct *task)
+{
+	kfree(task->thread.sve_state);
+	task->thread.sve_state = NULL;
+}
+
+static void sve_free(struct task_struct *task)
+{
+	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
+
+	__sve_free(task);
+}
 
 /*
  * Return how many bytes of memory are required to store the full SVE
-- 
2.25.1

