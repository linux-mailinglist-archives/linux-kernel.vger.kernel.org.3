Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33EC4C9C85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiCBEgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbiCBEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8FAB0A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v11hfRoQu1fg39kUHDWK/6VsoIH8chBcL+taYJtpY1I=; b=b3jTeBOR8s3QCTWuv6CBHUmLf3
        z8wzpzwVEvqyRVgCIutXhzOx5QfDKeAjnCt89HIcqvIQqDJNm+sZ1QteCpqUtIbo8NL7H1DjG6Bz6
        GCM7oxChQdXVcUPnO7+iSBbI4bBEOk/E/cPD8J0thJ/vWo262jQupiPBg2OSz9/nEBMZheKaJbKw/
        kfHz6QTx4zNTCIMHmmCV4wyXWtlYpBsbbZwGoh8vBtXVzZ7e91OtVY4TRNHNOzLLNJzyiavcO9Nnv
        XcLBluBhIXde8S5rcLsP54n8tyvpJwm4YlyJcSY6ioS1rvk/9Jt5vY3p5vlbSbXxf9ZVOANshyePc
        fRycxEXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF7H-GV; Wed, 02 Mar 2022 04:34:54 +0000
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
Subject: [PATCH 10/19] wait: Parameterize the return variable to __wait_event_killable_timeout()
Date:   Wed,  2 Mar 2022 04:34:42 +0000
Message-Id: <20220302043451.2441320-11-willy@infradead.org>
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
 include/linux/wait.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 9089c8bde04b..524e0d1690a4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -934,9 +934,9 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
-#define __wait_event_killable_timeout(wq_head, condition, timeout)		\
-	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
-		      TASK_KILLABLE, 0, timeout,				\
+#define __wait_event_killable_timeout(wq_head, condition, timeout, __ret) \
+	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),	\
+		      TASK_KILLABLE, 0, timeout,			\
 		      __ret = schedule_timeout(__ret))
 
 /**
@@ -961,14 +961,14 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  *
  * Only kill signals interrupt this process.
  */
-#define wait_event_killable_timeout(wq_head, condition, timeout)		\
-({										\
-	long __ret = timeout;							\
-	might_sleep();								\
-	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_killable_timeout(wq_head,			\
-						condition, timeout);		\
-	__ret;									\
+#define wait_event_killable_timeout(wq_head, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	might_sleep();							\
+	if (!___wait_cond_timeout(condition, __ret))			\
+		__ret = __wait_event_killable_timeout(wq_head,		\
+					condition, timeout, __ret);	\
+	__ret;								\
 })
 
 
-- 
2.34.1

