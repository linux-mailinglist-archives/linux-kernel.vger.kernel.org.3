Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980744C9C81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiCBEgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiCBEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CCAF1DD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f6xk2izn8+nMuMdCkjuVWpI3gvGKvvvwWCBTM6sEFFo=; b=LF2WGqf226h8ni7OqLCkeg8S+e
        Chpb16XHb3Vm8bkzAwbd+4tK5vlJMRXiCC5whNDwaei1j7dLNpCG7fcyWMoN+45cpCypzyluVQYj0
        NwwPCA/4STOj0L9xqy3Yb1Bcq7XjOsyeJ5WYALB/1gEoIWIhYt1VM5c/ZDUA/X9JWEeFjkQ7FyLlj
        YiQpaP2OeYisJ3AULlj8c7+Zph1TlANZ459hTaM8aLhSubfo5kaTdEk3fsi+TIvgpubkFfFbEXppK
        pGRBLQtvbyJYDhRIozk1Ra7+QN4o8/TQ0ZD8gBezEt6j0dTQIx5KoB471NUVp7hDrX1HjjoLD698j
        H2oYFilQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF7F-Dq; Wed, 02 Mar 2022 04:34:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] wait: Parameterize the return variable to __wait_event_idle_exclusive_timeout()
Date:   Wed,  2 Mar 2022 04:34:41 +0000
Message-Id: <20220302043451.2441320-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not refer to variables which aren't in their arguments.
Pass the name from its caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/wait.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 0f93cfd046bb..9089c8bde04b 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -732,7 +732,7 @@ do {										\
 	__ret;								\
 })
 
-#define __wait_event_idle_exclusive_timeout(wq_head, condition, timeout)	\
+#define __wait_event_idle_exclusive_timeout(wq_head, condition, timeout, __ret)	\
 	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_IDLE, 1, timeout,					\
 		      __ret = schedule_timeout(__ret))
@@ -760,13 +760,14 @@ do {										\
  * or the remaining jiffies (at least 1) if the @condition evaluated
  * to %true before the @timeout elapsed.
  */
-#define wait_event_idle_exclusive_timeout(wq_head, condition, timeout)		\
-({										\
-	long __ret = timeout;							\
-	might_sleep();								\
-	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_idle_exclusive_timeout(wq_head, condition, timeout);\
-	__ret;									\
+#define wait_event_idle_exclusive_timeout(wq_head, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	might_sleep();							\
+	if (!___wait_cond_timeout(condition, __ret))			\
+		__ret = __wait_event_idle_exclusive_timeout(wq_head,	\
+					condition, timeout, __ret);	\
+	__ret;								\
 })
 
 extern int do_wait_intr(wait_queue_head_t *, wait_queue_entry_t *);
-- 
2.34.1

