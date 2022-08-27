Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AE5A3443
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiH0EDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiH0EDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64253E3C03
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 21:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C82EE61E16
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAEBC433D6;
        Sat, 27 Aug 2022 04:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661573008;
        bh=tu/uBFTcTkD8ciezaLIOud2OqZdulEjwj2vtD/px5uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOgO/3jr3dCmERi87hkG3jw3yqWXJRMOFDLMR8bRfcR7ryZdwafXXt8Z5rHLtZTFx
         uh/P4dgzsTRlhv7pQVKMmkwEJSHiMGBPD/2Ci0hqca8T9q1s935XHo3PfalUbLWU1I
         tD2nzUxCHmjoXLIV+ISm1AROjGYb4kUJnsqU2T+btP0WBFTBRO0BNfBS4I4Gi9ieUW
         xo4F9yFYUsF2kr77G8806cl/TXGuVmuS9ZU9YVv0heXB/9nbmSEtEhWuhPwFfqTPHy
         DiajW+Nvn1xAB0oS3Cy330pmQAcS8RgCbs3hAv6hH1HADfb5hN9T8zScIIb9Lz/IbG
         ZwHA85YqOIeuA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] tracing: Fix to check event_mutex is held while accessing trigger list
Date:   Sat, 27 Aug 2022 13:03:24 +0900
Message-Id: <166157300435.348924.14755234601275629058.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166157298537.348924.2537162090505397377.stgit@devnote2>
References: <166157298537.348924.2537162090505397377.stgit@devnote2>
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

