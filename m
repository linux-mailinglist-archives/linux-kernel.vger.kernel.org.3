Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAF5B09E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIGQPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIGQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502EE7968F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB19619C5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A28C43144;
        Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVxik-00CsW4-0H;
        Wed, 07 Sep 2022 12:16:10 -0400
Message-ID: <20220907161609.915329087@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Sep 2022 12:15:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [for-linus][PATCH 4/7] tracepoint: Allow trace events in modules with TAINT_TEST
References: <20220907161511.694486342@goodmis.org>
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

From: Alison Schofield <alison.schofield@intel.com>

Commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
introduced a new taint type, TAINT_TEST, to signal that an
in-kernel test module has been loaded.

TAINT_TEST taint type defaults into a 'bad_taint' list for
kernel tracing and blocks the creation of trace events. This
causes a problem for CXL testing where loading the cxl_test
module makes all CXL modules out-of-tree, blocking any trace
events.

Trace events are in development for CXL at the moment and this
issue was found in test with v6.0-rc1.

Link: https://lkml.kernel.org/r/20220829171048.263065-1-alison.schofield@intel.com

Fixes: 2852ca7fba9f7 ("panic: Taint kernel if tests are run")
Reported-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..ef42c1a11920 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
 bool trace_module_has_bad_taint(struct module *mod)
 {
 	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
-			       (1 << TAINT_UNSIGNED_MODULE));
+			       (1 << TAINT_UNSIGNED_MODULE) |
+			       (1 << TAINT_TEST));
 }
 
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
@@ -647,7 +648,7 @@ static int tracepoint_module_coming(struct module *mod)
 	/*
 	 * We skip modules that taint the kernel, especially those with different
 	 * module headers (for forced load), to make sure we don't cause a crash.
-	 * Staging, out-of-tree, and unsigned GPL modules are fine.
+	 * Staging, out-of-tree, unsigned GPL, and test modules are fine.
 	 */
 	if (trace_module_has_bad_taint(mod))
 		return 0;
-- 
2.35.1
