Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B750C536A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355631AbiE1CxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352917AbiE1Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6212B03D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC42860FBD
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8BAC34118;
        Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZN-000LKz-6e;
        Fri, 27 May 2022 22:52:49 -0400
Message-ID: <20220528025249.038653861@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [for-next][PATCH 02/23] tracing: Reset the function filter after completing trampoline/graph
 selftest
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

From: Li Huafei <lihuafei1@huawei.com>

The direct trampoline and graph coexistence test sets global_ops to
trace only 'trace_selftest_dynamic_test_func', but does not reset it
after the test is completed, resulting in the function filter being set
already after the system starts. Although it can be reset through the
tracefs interface, it is more or less confusing to the user, and we
should reset it to trace all functions after the trampoline/graph test
completes.

Link: https://lkml.kernel.org/r/20220427034119.24668-1-lihuafei1@huawei.com
Link: https://lore.kernel.org/all/20220418073958.104029-1-lihuafei1@huawei.com/

Fixes: 130c08065848 ("tracing: Add trampoline/graph selftest")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index abcadbe933bb..a2d301f58ced 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -895,6 +895,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		ret = -1;
 		goto out;
 	}
+
+	/* Enable tracing on all functions again */
+	ftrace_set_global_filter(NULL, 0, 1);
 #endif
 
 	/* Don't test dynamic tracing, the function tracer already did */
-- 
2.35.1
