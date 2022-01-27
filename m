Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958FF49EDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiA0Vod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41238 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiA0Vob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60566B821D8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C973BC340E4;
        Thu, 27 Jan 2022 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319869;
        bh=sH+39cd6xOPiTG6eQ87wYHsVaBLX1flJYwtR+6Idmw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PJS5CxoaajTpPjxoXR30qHAn4GAzqsgoBQyY8FKGuJGofhu0+3uf+wDq4ljOIBcd3
         HPVOTd/WJV1+R6FEXYja+ueo8rYedsFy+aO0L6bFXuc3oR8Z3c9tq9vcS67SQi2kGi
         3lv/Nh6NE6qPqUan2D0ZB/pWZ+irDXbqUcoFNwtw6wLfWpVau+7TnBR/cfmXUHkLbk
         9yJN00/04uYl/Tqb6J6MGcXZH7mUO9WRiQrkgjPDXOo36040SYla8ZXvGFGo8MOWTt
         HtoAGhZJ7W8B/7hwgZdOdEOophcB2YTkGETKgvH+KReUAgdh4dGa6Suvg2qL6yIgOP
         P3JeBz+nPUbOw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/7] tracing: Fix smatch warning for null glob in event_hist_trigger_parse()
Date:   Thu, 27 Jan 2022 15:44:15 -0600
Message-Id: <96925e5c1f116654ada7ea0613d930b1266b5e1c.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

