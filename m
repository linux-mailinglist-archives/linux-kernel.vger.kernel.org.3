Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019BE59CEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiHWC7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHWC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EA2F64E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2288561262
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D74C433D6;
        Tue, 23 Aug 2022 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661223551;
        bh=tu/uBFTcTkD8ciezaLIOud2OqZdulEjwj2vtD/px5uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpXBeLqV5vtJX7spIw8NCgUXoIE46giPZLJWaYr/8/BgkBGBHgBGxjzuIqqkcCtif
         grYh6CR/oKI4dsu7X6CS/6ltQDX3CuOrPyl9EFz5/8e6/ZzRxMpuFqjQAYrZtbpMTF
         ofDa07b7BsGgq0iBsEG1+1qa5BQjr7NoKqUdbm8ABCGQCpi/C5bGnVSNZRGlXFioJB
         KVqnP7p+7FKAK75Zuy7+whZPIsj5UJbL9nF8YFL+wgAmHbtzcbsj4wr2QYxCsIqUX4
         51wUBvbzeFAZ6Nt1jhNPgDI46q5HWlX6nAYik3PPgyvrLp46uqzMqye8SFCwfpQ4ws
         0DskTi/XB3eSw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing: Fix to check event_mutex is held while accessing trigger list
Date:   Tue, 23 Aug 2022 11:59:06 +0900
Message-Id: <166122354657.94548.11354367471822600616.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166122353724.94548.7395770385598120122.stgit@devnote2>
References: <166122353724.94548.7395770385598120122.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the check_user_trigger() is called outside of RCU
read lock, this list_for_each_entry_rcu() caused a suspicious
RCU usage warning.

 # echo hist:keys=pid > events/sched/sched_stat_runtime/trigger
 # cat events/sched/sched_stat_runtime/trigger
[   43.167032]
[   43.167418] =============================
[   43.167992] WARNING: suspicious RCU usage
[   43.168567] 5.19.0-rc5-00029-g19ebe4651abf #59 Not tainted
[   43.169283] -----------------------------
[   43.169863] kernel/trace/trace_events_trigger.c:145 RCU-list traversed in non-reader section!!
...

However, this file->triggers list is safe when it is accessed
under event_mutex is held.
To fix this warning, adds a lockdep_is_held check to the
list_for_each_entry_rcu().

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_trigger.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cb866c3141af..918730d74932 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -142,7 +142,8 @@ static bool check_user_trigger(struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	list_for_each_entry_rcu(data, &file->triggers, list,
+				lockdep_is_held(&event_mutex)) {
 		if (data->flags & EVENT_TRIGGER_FL_PROBE)
 			continue;
 		return true;

