Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3559B0FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiHUAIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 20:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiHUAId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1911477
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 17:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890E560C57
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7993C433D7;
        Sun, 21 Aug 2022 00:08:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oPYWC-005Djt-29;
        Sat, 20 Aug 2022 20:08:44 -0400
Message-ID: <20220821000844.510643400@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 20 Aug 2022 20:07:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings triggered by is_signed_type()
References: <20220821000737.328590235@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

Using a __bitwise type in a tracing __field() definition triggers four
sparse warnings in stage 4 of expanding the TRACE_EVENT() macro. These
warnings are triggered by the is_signed_type() macro implementation.
Since there is no known way of checking signedness of a bitwise type
without triggering sparse warnings, disable signedness checking when
verifying code with sparse.

Note: work is in progress to improve sparse but has not yet landed. See
also "[PATCH 0/5] allow -1 and compares in bitwise types"
(https://lore.kernel.org/all/20220627190540.13358-1-luc.vanoostenryck@gmail.com/ ).

Link: https://lore.kernel.org/linux-trace-devel/20220717151047.19220-1-bvanassche@acm.org

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..b60347a0ccde 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -814,7 +814,19 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
+/*
+ * There is no known way to check signedness of __bitwise types without
+ * triggering a sparse warning. Hence the #ifdef __CHECKER__.
+ *
+ * Since there is another definition of is_signed_type() in <linux/overflow.h>,
+ * undefine is_signed_type() before redefining it.
+ */
+#undef is_signed_type
+#ifdef __CHECKER__
+#define is_signed_type(type)	0
+#else
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
+#endif
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
-- 
2.35.1
