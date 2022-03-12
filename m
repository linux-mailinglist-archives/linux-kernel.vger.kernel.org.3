Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4D4D718D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiCLX1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiCLX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6FD9286A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF931608C4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43458C340EE;
        Sat, 12 Mar 2022 23:25:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7O-000Wd0-7I;
        Sat, 12 Mar 2022 18:25:50 -0500
Message-ID: <20220312232550.059993796@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 01/12] tracing: Fix allocation of last_cmd in last_cmd_set()
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

The strncat() used in last_cmd_set() includes the nul byte of length of
the string being copied in, when it should only hold the size of the
string being copied (not the nul byte). Change it to subtract the length
of the allocated space and the nul byte to pass that into the strncat().

Also, assign "len" instead of initializing it to zero and its first update
is to do a "+=".

Link: https://lore.kernel.org/all/202202140628.fj6e4w4v-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e8970624bce..78788049f3d3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -744,19 +744,20 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 {
 	const char *system = NULL, *name = NULL;
 	struct trace_event_call *call;
-	int len = 0;
+	int len;
 
 	if (!str)
 		return;
 
-	len += sizeof(HIST_PREFIX) + strlen(str) + 1;
+	len = sizeof(HIST_PREFIX) + strlen(str) + 1;
 	kfree(last_cmd);
 	last_cmd = kzalloc(len, GFP_KERNEL);
 	if (!last_cmd)
 		return;
 
 	strcpy(last_cmd, HIST_PREFIX);
-	strncat(last_cmd, str, len - sizeof(HIST_PREFIX));
+	len -= sizeof(HIST_PREFIX) + 1;
+	strncat(last_cmd, str, len);
 
 	if (file) {
 		call = file->event_call;
-- 
2.35.1
