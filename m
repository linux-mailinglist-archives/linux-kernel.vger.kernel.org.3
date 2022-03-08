Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B34D1CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiCHQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbiCHQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:08:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575D10FDD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4067F61714
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0600DC340EB;
        Tue,  8 Mar 2022 16:07:37 +0000 (UTC)
Date:   Tue, 8 Mar 2022 11:07:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Fix last_cmd_set() string management in histogram
 code
Message-ID: <20220308110736.479e3cc9@gandalf.local.home>
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
2.34.1

