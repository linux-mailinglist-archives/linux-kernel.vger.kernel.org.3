Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F64D718A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiCLX1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCLX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD199287E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2254160765
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E41DC340F6;
        Sat, 12 Mar 2022 23:25:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7O-000We6-JA;
        Sat, 12 Mar 2022 18:25:50 -0500
Message-ID: <20220312232550.431988486@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 03/12] tracing: Fix last_cmd_set() string management in histogram code
References: <20220312232525.234705244@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Using strnlen(dest, str, n) is confusing, as the size of dest must be
strlen(dest) + n + 1. Even more confusing, using sizeof(string constant)
gives you strlen(string constant) + 1 and not just strlen().

These two together made using strncat() with a constant string a bit off
in the calculations as we have:

	len = sizeof(HIST_PREFIX) + strlen(str) + 1;
	kfree(last_cmd);
	last_cmd = kzalloc(len, GFP_KERNEL);
	strcpy(last_cmd, HIST_PREFIX);
	len -= sizeof(HIST_PREFIX) + 1;
	strncat(last_cmd, str, len);

The above works if we s/sizeof/strlen/ with HIST_PREFIX (which is defined
as "hist:", but because sizeof(HIST_PREFIX) is equal to
strlen(HIST_PREFIX) + 1, we can drop the +1 in the code. But at least
comment that we are doing so.

Link: https://lore.kernel.org/all/202203082112.Iu7tvFl4-lkp@intel.com/

Fixes: 9f8e5aee93ed2 ("tracing: Fix allocation of last_cmd in last_cmd_set()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 78788049f3d3..954b19e2f196 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -749,14 +749,16 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 	if (!str)
 		return;
 
-	len = sizeof(HIST_PREFIX) + strlen(str) + 1;
+	/* sizeof() contains the nul byte */
+	len = sizeof(HIST_PREFIX) + strlen(str);
 	kfree(last_cmd);
 	last_cmd = kzalloc(len, GFP_KERNEL);
 	if (!last_cmd)
 		return;
 
 	strcpy(last_cmd, HIST_PREFIX);
-	len -= sizeof(HIST_PREFIX) + 1;
+	/* Again, sizeof() contains the nul byte */
+	len -= sizeof(HIST_PREFIX);
 	strncat(last_cmd, str, len);
 
 	if (file) {
-- 
2.35.1
