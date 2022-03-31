Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04544ED63A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiCaIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiCaIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEBD496BB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EDC54CE20D7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D44C340EE;
        Thu, 31 Mar 2022 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648716596;
        bh=6vdyoQjwpV7r2hRyShWcXBmnOHhJS2KSz+S81lCGn9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5ZEKmp+Kl6F25RLj7q/Qjv0H9abT1GhXMlE3HCH6mF2K1fgavpYhFRaBmeWbtbQT
         58s+As1jBgTvUv1F1dIel+wRQiN/cwhNuwIbPzZP/8FV1m6KnCcAuY+zCfrEFZCNIj
         8tQGMoO/zICfzRp8/jFblej2GFz1xemAZQfUy774GydEIiWfvIx+2JyJlJTUJk0iCj
         KiymVkyBbZcb9IkLeKU+ReBCOp1tL9raMJGtOcMQWlJSv/EQZmYBBoDsMNK7XQLfte
         BgXQwoyhVTiKFPxNGBBVBt69QtVxYy3jMv1sKniOLJ6OzRvUSWUKG1xwe14ClrxTaj
         pqss+DFFy3IUg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm 3/3] arch/arm64: Set HAVE_SHADOW_STACKTRACE depends on SHADOW_CALL_STACK
Date:   Thu, 31 Mar 2022 08:49:39 +0000
Message-Id: <20220331084939.26749-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331084939.26749-1-sj@kernel.org>
References: <20220331084939.26749-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 implementation of arch_stack_walk_shadow(), which is
introduced by commit 8cdc580c5ca2 ("arm64: implement
stack_trace_save_shadow") of -mm, uses task_scs(), which depends on
SHADOW_CALL_STACK, but arm64 Kconfig unconditionally sets
HAVE_SHADOW_STACKTRACE.  As a result, below build error happens when
SHADOW_CALL_STACK is unset.

    /linux/arch/arm64/kernel/stacktrace.c: In function 'arch_stack_walk_shadow':
    /linux/arch/arm64/kernel/stacktrace.c:289:13: error: implicit declaration of function 'task_scs'; did you mean 'task_lock'? [-Werror=implicit-function-declaration]
      289 |  scs_base = task_scs(current);
          |             ^~~~~~~~
          |             task_lock

This commit fixes the error by making HAVE_SHADOW_STACKTRACE depends on
SHADOW_CALL_STACK and impelmentation of arch_stack_walk_shadow() depends
on HAVE_SHADOW_STACKTRACE.

Fixes: 8cdc580c5ca2 ("arm64: implement stack_trace_save_shadow") of -mm
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 arch/arm64/Kconfig             | 2 +-
 arch/arm64/kernel/stacktrace.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9325dd95eba..67358860d51e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -201,7 +201,7 @@ config ARM64
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
-	select HAVE_SHADOW_STACKTRACE
+	select HAVE_SHADOW_STACKTRACE if CONFIG_SHADOW_CALL_STACK
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 89daa710d91b..7e824aeb06f9 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -213,6 +213,8 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
 
+#ifdef CONFIG_HAVE_SHADOW_STACKTRACE
+
 static const struct {
 	unsigned long ** __percpu saved;
 	unsigned long ** __percpu base;
@@ -293,3 +295,5 @@ noinline notrace int arch_stack_walk_shadow(unsigned long *store,
 	preempt_enable();
 	return len;
 }
+
+#endif /* CONFIG_HAVE_SHADOW_STACKTRACE */
-- 
2.17.1

