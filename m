Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEE4C9C80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiCBEhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiCBEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF7B0D02
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g/p7Gq9eJw6t7fsSt+jZdM0L4G/CIlvm5lHpKXfynV0=; b=ivAsAnpLxaqTQHcxdmS4duvif5
        3fOkBBjAL9cpo01RwwCrGROPead9q3ySAWdkhW5dzMt9dDSlWONxGFZbN3rEt88Uctd0/z3aL73yx
        e2inmgwXogYIY7fynsoHR8g8kuD7WOAbTXRj+BxN34R3H1G2dzVuU/YIJpTt4SDOqQbeZG/4IQ0cH
        dbCA6lZS4K0fC207hx/Qin3AHntINz1COWPWpE8ao6vNXoUEtUEuNIbpUsZ2ah5Q6XMH8I3d4nHr8
        UG5JnnKJolWpcHzAEbSaQL04P1+CTMat5/+iWvowGEhuzvEtixX/T2ac65Oj1/d0fTAtYkPdNQy51
        rSqGX6eA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhR-00AF71-TE; Wed, 02 Mar 2022 04:34:53 +0000
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
Subject: [PATCH 02/19] swait: Parameterize the return variable to __swait_event_timeout()
Date:   Wed,  2 Mar 2022 04:34:34 +0000
Message-Id: <20220302043451.2441320-3-willy@infradead.org>
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
 include/linux/swait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 5e8e9b13be2d..0ca80e31776f 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -190,7 +190,7 @@ do {									\
 	__swait_event(wq, condition);					\
 } while (0)
 
-#define __swait_event_timeout(wq, condition, timeout)			\
+#define __swait_event_timeout(wq, condition, timeout, __ret)		\
 	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		      TASK_UNINTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
@@ -199,7 +199,7 @@ do {									\
 ({									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition, __ret))			\
-		__ret = __swait_event_timeout(wq, condition, timeout);	\
+		__ret = __swait_event_timeout(wq, condition, timeout, __ret); \
 	__ret;								\
 })
 
-- 
2.34.1

