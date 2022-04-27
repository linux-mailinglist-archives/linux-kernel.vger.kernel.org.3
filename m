Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2F5122EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiD0Tl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiD0Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B8B65
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DC2561B44
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BDC385A9;
        Wed, 27 Apr 2022 19:36:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSs-002IyF-V1;
        Wed, 27 Apr 2022 15:36:42 -0400
Message-ID: <20220427193642.789373510@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>
Subject: [for-next][PATCH 18/21] tracing: Use WARN instead of printk and WARN_ON
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Zhengkui <guozhengkui@vivo.com>

Use `WARN(cond, ...)` instead of `if (cond)` + `printk(...)` +
`WARN_ON(1)`.

Link: https://lkml.kernel.org/r/20220424131932.3606-1-guozhengkui@vivo.com

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 8aa493d25c73..d89e3f7e26eb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -778,9 +778,8 @@ int register_trace_event(struct trace_event *event)
 
 		list_add_tail(&event->list, list);
 
-	} else if (event->type > __TRACE_LAST_TYPE) {
-		printk(KERN_WARNING "Need to add type to trace.h\n");
-		WARN_ON(1);
+	} else if (WARN(event->type > __TRACE_LAST_TYPE,
+			"Need to add type to trace.h")) {
 		goto out;
 	} else {
 		/* Is this event already used */
@@ -1571,13 +1570,8 @@ __init static int init_events(void)
 
 	for (i = 0; events[i]; i++) {
 		event = events[i];
-
 		ret = register_trace_event(event);
-		if (!ret) {
-			printk(KERN_WARNING "event %d failed to register\n",
-			       event->type);
-			WARN_ON_ONCE(1);
-		}
+		WARN_ONCE(!ret, "event %d failed to register", event->type);
 	}
 
 	return 0;
-- 
2.35.1
