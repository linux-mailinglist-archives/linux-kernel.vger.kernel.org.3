Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF13449EDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbiA0Vof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41256 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbiA0Voc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D652BB823BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFCC36AE5;
        Thu, 27 Jan 2022 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319870;
        bh=dXyvj+UOzqsnuv2jFkIooa+KgNI/r1Unhz4tJnUXJuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PuiV9uH6NEYXCZlVxiAH1G3gBs51PNIuYNUOU/0Ci2GQ2tgrQk+WCpKWoGupUpvMB
         uv7rVKbVJKNaGyevTnNgk7zxyIIRuIUl8cSj/sLcNqUVSdkt6dP4qu5BW5JYdPM607
         3OXikBpP2ZkSAcAubBQGExvJgXb1xrQGbHmXZGlMKrThzOulUwqkZguxtwuNzo4NHw
         JzTE5S//dG+nncQyOIqV4bFXyVSd2CtynnHtFi//p5Z7y3huklcRg7DTiT6AGK9VSQ
         UPhGqRZ58kFKUmJLSse0BqN40+BqmXy9OQwWb1Co8WT72lXbxsGV3vG2petdauMl/y
         uZM7abVi1xvSQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/7] tracing: Fix smatch warning for do while check in event_hist_trigger_parse()
Date:   Thu, 27 Jan 2022 15:44:16 -0600
Message-Id: <a1d4c79766c0cf61e20438dc35244d216633fef6.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch ec5ce0987541: "tracing: Allow whitespace to surround hist
trigger filter" from Jan 15, 2018, leads to the following Smatch
static checker warning:

    kernel/trace/trace_events_hist.c:6199 event_hist_trigger_parse()
    warn: 'p' can't be NULL.

Since p is always checked for a NULL value at the top of loop and
nothing in the rest of the loop will set it to NULL, the warning
is correct and might as well be 1 to silence the warning.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

