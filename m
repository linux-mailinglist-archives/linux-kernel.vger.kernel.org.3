Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDD513E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbiD1VzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiD1VzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:55:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8546162
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D4B8CE2D7A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB35AC385B3;
        Thu, 28 Apr 2022 21:51:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC32-003Mao-PY;
        Thu, 28 Apr 2022 17:51:40 -0400
Message-ID: <20220428215140.625844927@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [for-next][PATCH 5/8] tracing: Remove usage of list iterator after the loop body
References: <20220428215102.260147624@goodmis.org>
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

From: Jakob Koschel <jakobkoschel@gmail.com>

In preparation to limit the scope of the list iterator variable to the
traversal loop, use a dedicated pointer to point to the found element
[1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the head needs to be used explicitly if the
variable is NULL.

Link: https://lkml.kernel.org/r/20220427170734.819891-2-jakobkoschel@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d89e3f7e26eb..67f47ea27921 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -692,7 +692,7 @@ static LIST_HEAD(ftrace_event_list);
 
 static int trace_search_list(struct list_head **list)
 {
-	struct trace_event *e;
+	struct trace_event *e = NULL, *iter;
 	int next = __TRACE_LAST_TYPE;
 
 	if (list_empty(&ftrace_event_list)) {
@@ -704,9 +704,11 @@ static int trace_search_list(struct list_head **list)
 	 * We used up all possible max events,
 	 * lets see if somebody freed one.
 	 */
-	list_for_each_entry(e, &ftrace_event_list, list) {
-		if (e->type != next)
+	list_for_each_entry(iter, &ftrace_event_list, list) {
+		if (iter->type != next) {
+			e = iter;
 			break;
+		}
 		next++;
 	}
 
@@ -714,7 +716,10 @@ static int trace_search_list(struct list_head **list)
 	if (next > TRACE_EVENT_TYPE_MAX)
 		return 0;
 
-	*list = &e->list;
+	if (e)
+		*list = &e->list;
+	else
+		*list = &ftrace_event_list;
 	return next;
 }
 
-- 
2.35.1
