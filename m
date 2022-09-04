Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A15AC240
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIDEMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiIDEMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:12:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846A4AD5C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 148FFB80C9E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889B9C433D6;
        Sun,  4 Sep 2022 04:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264753;
        bh=tu/uBFTcTkD8ciezaLIOud2OqZdulEjwj2vtD/px5uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3krUUwZyDHVYmtOAfdpwCbD3cNTV7riPHLvp+r5I/xkefZHN5pr/kebn6G7QHhCV
         xgvlp7TTcQ8G+wAk48cFInW/bzYJNPFjZi7ksEr+afZQIzLmsSRjnHhpsQOrjQ27PS
         SbotkMUUImvErJmgpf0ogxvq7BMk7TErbkA9sbM1vFTXTjolIkXHuiCpf4MJ+etlfG
         HbiqICGUfaciYjo+8+RFL5nzEEU8Gp2tRTeSCqTmgXU//EnFVAXJ6EkbelyzE0Vp5J
         H2TNwpbU+EBE+AQODjpb3YGU+J/AIG8FwUDpfB92rUHq0Z5biN0CBDySQa5qIGXYzJ
         lhYTGOyYqTArQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] tracing: Fix to check event_mutex is held while accessing trigger list
Date:   Sun,  4 Sep 2022 13:12:29 +0900
Message-Id: <166226474977.223837.1992182913048377113.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166226473132.223837.9011128463174539022.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
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

