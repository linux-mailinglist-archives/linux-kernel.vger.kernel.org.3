Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D794C9C7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiCBEgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiCBEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84100AEF3E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3PYe5ZTEq6FiwceJp1XPqk4f9qEMwtVemXWlN1yTh4Y=; b=QwZf2nkbHZ+ev7V6GIOranWja0
        tDiC3B0iHyB4fIiAnv8SFqbpBOwm6noRTFGGt67utvhkfNIXNq7kW/0f5MQakUpwgVCtA2hm+FLW3
        xU0g9/EVrg5DDJEstjwu1jMoaNNzQgldpFclWI10u74DF6EaPdMTddPtI6TBCms3hZAPe7AXE6ijV
        FrxG9qD+p+8bzpP7L9wgkkLkX/emUM9rxhKjzfJy50TW5yhjb6oyOOv53hSGTmcmf3IfYFOg+dgo0
        ZOlICzX1k4E1lYVoyqCbuHM7AWXQoOZiiJHQ0SR6kahNEmhajqK4TKX7KI+PNPm656jo5vyIME4ii
        jk8YG+Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF75-1s; Wed, 02 Mar 2022 04:34:54 +0000
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
Subject: [PATCH 04/19] swait: Parameterize the return variable to __swait_event_idle_timeout()
Date:   Wed,  2 Mar 2022 04:34:36 +0000
Message-Id: <20220302043451.2441320-5-willy@infradead.org>
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
index 4147be3a0014..1bc42967182a 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -251,7 +251,7 @@ do {									\
 	__swait_event_idle(wq, condition);				\
 } while (0)
 
-#define __swait_event_idle_timeout(wq, condition, timeout)		\
+#define __swait_event_idle_timeout(wq, condition, timeout, __ret)	\
 	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		       TASK_IDLE, timeout,				\
 		       __ret = schedule_timeout(__ret))
@@ -280,7 +280,7 @@ do {									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __swait_event_idle_timeout(wq,			\
-						   condition, timeout);	\
+					   condition, timeout, __ret);	\
 	__ret;								\
 })
 
-- 
2.34.1

