Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DF4C4B62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiBYQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbiBYQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4E223209
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CB061CFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E508FC340F2;
        Fri, 25 Feb 2022 16:52:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpM-00B8Na-32;
        Fri, 25 Feb 2022 11:52:20 -0500
Message-ID: <20220225165219.928332768@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:52:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [for-linus][PATCH 10/13] tracing: Fix selftest config check for function graph start up test
References: <20220225165151.824659113@goodmis.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is required to test
direct tramp.

Link: https://lkml.kernel.org/r/bdc7e594e13b0891c1d61bc8d56c94b1890eaed7.1640017960.git.christophe.leroy@csgroup.eu

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index afd937a46496..abcadbe933bb 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,9 +784,7 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
-#if defined(CONFIG_DYNAMIC_FTRACE) && \
-    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
-#define TEST_DIRECT_TRAMP
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 noinline __noclone static void trace_direct_tramp(void) { }
 #endif
 
@@ -849,7 +847,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-#ifdef TEST_DIRECT_TRAMP
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
-- 
2.34.1
