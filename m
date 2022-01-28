Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8E49FDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbiA1QXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:23:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59244 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350069AbiA1QXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E60161F2F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8FAC340EE;
        Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2K-00AT2U-Sf;
        Fri, 28 Jan 2022 11:23:44 -0500
Message-ID: <20220128162344.722992572@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 08/10] tracing: Fix smatch warning for do while check in
 event_hist_trigger_parse()
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The patch ec5ce0987541: "tracing: Allow whitespace to surround hist
trigger filter" from Jan 15, 2018, leads to the following Smatch
static checker warning:

    kernel/trace/trace_events_hist.c:6199 event_hist_trigger_parse()
    warn: 'p' can't be NULL.

Since p is always checked for a NULL value at the top of loop and
nothing in the rest of the loop will set it to NULL, the warning
is correct and might as well be 1 to silence the warning.

Link: https://lkml.kernel.org/r/a1d4c79766c0cf61e20438dc35244d216633fef6.1643319703.git.zanussi@kernel.org

Fixes: ec5ce09875410 ("tracing: Allow whitespace to surround hist trigger filter")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e0860146dd39..b894d68082ea 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6199,7 +6199,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 			continue;
 		}
 		break;
-	} while (p);
+	} while (1);
 
 	if (!p)
 		param = NULL;
-- 
2.33.0
