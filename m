Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC74E5461
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbiCWOkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbiCWOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCBC574B2;
        Wed, 23 Mar 2022 07:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E934761725;
        Wed, 23 Mar 2022 14:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FED4C340E8;
        Wed, 23 Mar 2022 14:39:13 +0000 (UTC)
Date:   Wed, 23 Mar 2022 10:39:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Subject: [PATCH] tracing: Have trace event string test handle zero length
 strings
Message-ID: <20220323103912.097ad3a8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a trace event has in its TP_printk():

 "%*.s", len, len ? __get_str(string) : NULL

It is perfectly valid if len is zero and passing in the NULL.
Unfortunately, the runtime string check at time of reading the trace sees
the NULL and flags it as a bad string and produces a WARN_ON().

Handle this case by passing into the test function if the format has an
asterisk (star) and if so, if the length is zero, then mark it as safe.

Link: https://lore.kernel.org/all/YjsWzuw5FbWPrdqq@bfoster/

Cc: stable@vger.kernel.org
Reported-by: Brian Foster <bfoster@redhat.com>
Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers for trace events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eb44418574f9..96265a717ca4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3663,12 +3663,17 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
 }
 
 /* Returns true if the string is safe to dereference from an event */
-static bool trace_safe_str(struct trace_iterator *iter, const char *str)
+static bool trace_safe_str(struct trace_iterator *iter, const char *str,
+			   bool star, int len)
 {
 	unsigned long addr = (unsigned long)str;
 	struct trace_event *trace_event;
 	struct trace_event_call *event;
 
+	/* Ignore strings with no length */
+	if (star && !len)
+		return true;
+
 	/* OK if part of the event data */
 	if ((addr >= (unsigned long)iter->ent) &&
 	    (addr < (unsigned long)iter->ent + iter->ent_size))
@@ -3854,7 +3859,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 * instead. See samples/trace_events/trace-events-sample.h
 		 * for reference.
 		 */
-		if (WARN_ONCE(!trace_safe_str(iter, str),
+		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
 			      "fmt: '%s' current_buffer: '%s'",
 			      fmt, show_buffer(&iter->seq))) {
 			int ret;
-- 
2.35.1

