Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673151209A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbiD0RLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiD0RLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:11:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1652E9D7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y21so2713375edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMvhtRn0jl+CJy7uX7FCi4p3mZryFp+0msE3tzv/YXk=;
        b=DdPhJtlYCHojqdyHfYy30NEwVP1mhNaC0GXK23ikMndM2xBHa/co6CIJZCRQswiWtT
         H3Bbqufp8Zo4Exbt9y0HwLObDkmv8hz0ZQ38mSsVi3nn2/6oh1YuxpkSatzA0UgTbugM
         62EwlbaxtsfrfzSMIGPYTSmPronB3QJaBvrxPzRWJxLSdg+mb4qAmmSX15i4xqMTIXQz
         I3PW8gdT4FHapom34rjciX/B2nrRigpNwCqWPyJcm3AmCOF6Ibi/XNm7p9OVa7h3m1q1
         G8b5DYjLj2dvZNcQQVYfa/JYQEcRY9ajU63tfT68EfKjZaiPXU5vBT8fwiAeUXcQFL8F
         WbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMvhtRn0jl+CJy7uX7FCi4p3mZryFp+0msE3tzv/YXk=;
        b=zNE3myo6NnJot1gDZs4yjgXT7F3IkMD7KderqTyHnWkQ9dRbzbKbYqQF/zxOu0FwhV
         ED/LjpBsRzTiXCZBEUlW1axpvPhxTp9p6flabCit4T+kKhpn0Unv2AEpqGP3S94XbNvC
         POhY/uudbwwiWIq8Cdqx7GM0xEKUTsLnA6JeCSRsmsnaVfusAaHwmxBLZe7zRgfdGJtV
         QNnvF6KREj2somM2JYkvZu56zXOof/fC8HBLhyMnMhgmRCpYbecUjF1wkVkZGhUyJbZL
         PYc7jkpWjCTDyyhWYZrOakMX5pXvXQJDcQDmhLmMwFP69h0/EUzgmyYwJuRESfbz5B8k
         tLEg==
X-Gm-Message-State: AOAM533WDnmh1JYZWIHvKqmV+2PJaBdl5ETa0U8FjNAFTMLlwEYu+1pf
        MlUWw/DH3yBg412Bfe+EoRI=
X-Google-Smtp-Source: ABdhPJxAQO0Ice/dluI4Pq3+rmr34sByp3FRLuEvhuX6HtWwor4XJmOL7ooIRyv/Zpulcdts3l5XzQ==
X-Received: by 2002:a05:6402:3587:b0:425:ffd2:8aa0 with SMTP id y7-20020a056402358700b00425ffd28aa0mr8746492edc.403.1651079296838;
        Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm6694359edi.97.2022.04.27.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 3/4] tracing: Replace usage of found with dedicated list iterator variable
Date:   Wed, 27 Apr 2022 19:07:33 +0200
Message-Id: <20220427170734.819891-4-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427170734.819891-1-jakobkoschel@gmail.com>
References: <20220427170734.819891-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/trace_events_hist.c    | 15 +++++++--------
 kernel/trace/trace_events_trigger.c | 24 +++++++++++-------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 44db5ba9cabb..65f79ac78742 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6089,20 +6089,19 @@ static void hist_unregister_trigger(char *glob,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
 {
+	struct event_trigger_data *test = NULL, *iter, *named_data = NULL;
 	struct hist_trigger_data *hist_data = data->private_data;
-	struct event_trigger_data *test, *named_data = NULL;
-	bool unregistered = false;
 
 	lockdep_assert_held(&event_mutex);
 
 	if (hist_data->attrs->name)
 		named_data = find_named_trigger(hist_data->attrs->name);
 
-	list_for_each_entry(test, &file->triggers, list) {
-		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
-			if (!hist_trigger_match(data, test, named_data, false))
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (iter->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, iter, named_data, false))
 				continue;
-			unregistered = true;
+			test = iter;
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -6110,11 +6109,11 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && test->ops->free)
+	if (test && test->ops->free)
 		test->ops->free(test->ops, test);
 
 	if (hist_data->enable_timestamps) {
-		if (!hist_data->remove || unregistered)
+		if (!hist_data->remove || test)
 			tracing_set_filter_buffering(file->tr, false);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 7eb9d04f1c2e..349195c93da1 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -614,14 +614,13 @@ static void unregister_trigger(char *glob,
 			       struct event_trigger_data *test,
 			       struct trace_event_file *file)
 {
-	struct event_trigger_data *data;
-	bool unregistered = false;
+	struct event_trigger_data *data = NULL, *iter;
 
 	lockdep_assert_held(&event_mutex);
 
-	list_for_each_entry(data, &file->triggers, list) {
-		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
-			unregistered = true;
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (iter->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
+			data = iter;
 			list_del_rcu(&data->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -629,7 +628,7 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data->ops, data);
 }
 
@@ -1976,19 +1975,18 @@ void event_enable_unregister_trigger(char *glob,
 				     struct trace_event_file *file)
 {
 	struct enable_trigger_data *test_enable_data = test->private_data;
+	struct event_trigger_data *data = NULL, *iter;
 	struct enable_trigger_data *enable_data;
-	struct event_trigger_data *data;
-	bool unregistered = false;
 
 	lockdep_assert_held(&event_mutex);
 
-	list_for_each_entry(data, &file->triggers, list) {
-		enable_data = data->private_data;
+	list_for_each_entry(iter, &file->triggers, list) {
+		enable_data = iter->private_data;
 		if (enable_data &&
-		    (data->cmd_ops->trigger_type ==
+		    (iter->cmd_ops->trigger_type ==
 		     test->cmd_ops->trigger_type) &&
 		    (enable_data->file == test_enable_data->file)) {
-			unregistered = true;
+			data = iter;
 			list_del_rcu(&data->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -1996,7 +1994,7 @@ void event_enable_unregister_trigger(char *glob,
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data->ops, data);
 }
 
-- 
2.25.1

