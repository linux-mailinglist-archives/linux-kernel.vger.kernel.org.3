Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382A6536A54
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355651AbiE1CxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355549AbiE1Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042FE1271A9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7758361D49
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA3C341CF;
        Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LQa-0k;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025250.861004876@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        liqiong <liqiong@nfschina.com>
Subject: [for-next][PATCH 12/23] tracing: Change "char *" string form to "char []"
References: <20220528025028.850906216@goodmis.org>
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

From: liqiong <liqiong@nfschina.com>

The "char []" string form declares a single variable. It is better
than "char *" which creates two variables in the final assembly.

Link: https://lkml.kernel.org/r/20220512143230.28796-1-liqiong@nfschina.com

Signed-off-by: liqiong <liqiong@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4825883b2ffd..e38a7ca4cdd0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4252,7 +4252,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "            ";
+	static const char space[] = "            ";
 	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c6a65738feb3..48e82e141d54 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4165,7 +4165,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
 }
 
-static const char *no_comm = "(no comm)";
+static const char no_comm[] = "(no comm)";
 
 static u64 hist_field_execname(struct hist_field *hist_field,
 			       struct tracing_map_elt *elt,
-- 
2.35.1
