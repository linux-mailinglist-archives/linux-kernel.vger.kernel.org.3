Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA78F46C6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbhLGVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53872 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbhLGVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 787C2CE1E7D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECFC341EE;
        Tue,  7 Dec 2021 21:44:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGF-000I1w-FR;
        Tue, 07 Dec 2021 16:44:31 -0500
Message-ID: <20211207214431.312363234@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [for-next][PATCH 13/13] tracing: Switch to kvfree_rcu() API
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

Link: https://lkml.kernel.org/r/20211124110308.2053-10-urezki@gmail.com

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 3 +--
 kernel/trace/trace_probe.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..4719a848bf17 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -138,8 +138,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	synchronize_rcu();
-	kfree(inst);
+	kvfree_rcu(inst);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3ed2a3f37297..8a3822818bf8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1138,8 +1138,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	synchronize_rcu();
-	kfree(link);
+	kvfree_rcu(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.33.0
