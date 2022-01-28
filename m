Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCA49FDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350220AbiA1QYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbiA1QXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C85C061749
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9956B824EA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA25C340EA;
        Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2K-00AT1v-Mj;
        Fri, 28 Jan 2022 11:23:44 -0500
Message-ID: <20220128162344.534971664@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 07/10] tracing: Fix smatch warning for null glob in
 event_hist_trigger_parse()
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The recent rename of event_hist_trigger_parse() caused smatch
re-evaluation of trace_events_hist.c and as a result an old warning
was found:

    kernel/trace/trace_events_hist.c:6174 event_hist_trigger_parse()
    error: we previously assumed 'glob' could be null (see line 6166)

glob should never be null (and apparently smatch can also figure that
out and skip the warning when using the cross-function DB (but which
can't be used with a 0day build as it takes too much time to
generate)).

Nonetheless for clarity, remove the test but add a WARN_ON() in case
the code ever changes.

Link: https://lkml.kernel.org/r/96925e5c1f116654ada7ea0613d930b1266b5e1c.1643319703.git.zanussi@kernel.org

Fixes: f404da6e1d46c ("tracing: Add 'last error' error facility for hist triggers")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cd9610688ddc..e0860146dd39 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6164,7 +6164,9 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	lockdep_assert_held(&event_mutex);
 
-	if (glob && strlen(glob)) {
+	WARN_ON(!glob);
+
+	if (strlen(glob)) {
 		hist_err_clear();
 		last_cmd_set(file, param);
 	}
-- 
2.33.0
