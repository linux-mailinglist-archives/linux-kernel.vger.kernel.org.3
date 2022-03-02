Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5C4C9C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiCBEgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiCBEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B93B10A5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9s7ebt5G6ChAio+CfHim1dBptzEdmn/x8MknWstJb20=; b=X9rkuo48pxsIEMMJqPgl4wyd2W
        /xwEKHxag/qrgDKFcU0UXZVGErl0lDsmDZQe3Ogm5g6JTFanfqBfXaAZwBYk7Etmgte3WqAo0xVks
        IZq5pqShliUkoIzQXBBsEMV/lzRvxlF5/1NiQwR+rSSTOz8pcJ2YZPf2kUd3rvRdctBDjs4fpVa8s
        eYRl7eY89Tqls4wwU8iGREKJJba2n2wTayGWdueLKdAI7mZMdozsjxSdd40+WhIIu81AXmbwWeCsv
        gjlCNBVBeC/rn7AK7a3Yyoh6FVG9Ad5/vqB0DsJtk3ibfK1pLlGHhxLdbmXp0bqqnRnhLNq9QfIC4
        nCWP4QQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF77-4M; Wed, 02 Mar 2022 04:34:54 +0000
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
Subject: [PATCH 05/19] wait: Parameterize the return variable to __wait_event_timeout()
Date:   Wed,  2 Mar 2022 04:34:37 +0000
Message-Id: <20220302043451.2441320-6-willy@infradead.org>
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
 include/linux/wait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 890cce3c0f2e..b34d36001fd2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -385,7 +385,7 @@ do {										\
 	__ret;									\
 })
 
-#define __wait_event_timeout(wq_head, condition, timeout)			\
+#define __wait_event_timeout(wq_head, condition, timeout, __ret)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_UNINTERRUPTIBLE, 0, timeout,				\
 		      __ret = schedule_timeout(__ret))
@@ -414,7 +414,7 @@ do {										\
 	long __ret = timeout;							\
 	might_sleep();								\
 	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_timeout(wq_head, condition, timeout);	\
+		__ret = __wait_event_timeout(wq_head, condition, timeout, __ret); \
 	__ret;									\
 })
 
-- 
2.34.1

