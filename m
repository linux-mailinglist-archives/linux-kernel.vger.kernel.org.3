Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244D24F00AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354435AbiDBKgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354399AbiDBKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:35:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B4F55C7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:34:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d10so866782edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxLyiVAe1fZmParic2Rf8qrKN3jJ4OFw0+uxZzajL5E=;
        b=nqQGArzkAlBLj5t1PKnCWmvItxL90TmoVvVLBsK/RQfOz6HeoALDrcHdCOj5I3sdOu
         OZ0xdR1182QGoFpRAsTrOppkrQa/kJ//544WWcOZWpqpaN9k9E2quTPuj9THPAMarIrr
         ak+M2vSpPkXcNv/8z5Rj/FsQ80ug17wolv4tAzwYmzhg84goFf48A7LOeZnryhcnPCrO
         aJ6zjK0mw4E8C/gZW6bD2bupGRbtGPfvy/VJApkmuNMRFkIjP09UwIv2htXat7L50bKI
         9RFH3m2PJaHKbzfJIm5L5hyfMPsJ2BwTgIJIYOlfFG29KHyORW9zriw9AC76mUkEv3bw
         vbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxLyiVAe1fZmParic2Rf8qrKN3jJ4OFw0+uxZzajL5E=;
        b=insSxrkakobDBIfj/1c1PgGAoQdj7+rODphXLFgbSxJ1KlySD72TCtGPDkRrFOi4lW
         46Ld2TlMebpFD3FmdSO23cP9OI00f3rvdx81t/oUWeHD5EjIcFB5EqefZNKFAzCM7xtH
         dBuSMr/Ca5zIlpgP+u+2I2VbTE49yYSnlAkZPG6Dh40dP0rL8AsJiewjGtjT07IbBtrS
         +16ft/+o9xdDB6K2xG7/CgThONgfKE8KgZp0bL7w6oAz+rvyqF6GyOBb2eh8PC8ixb/N
         OjO/TE57jsh5lUTSRrHZiiePo471pTI8p8Cy/QwzcbZlYbRFkuZj8D0DHk7JxcJ5pWsP
         5GNw==
X-Gm-Message-State: AOAM532A+9c8ExFgPwrXUPbI27PcdjqFHgOf6hOGHQH3tmZEOE1xUsQw
        dWl9ryNGQiuvEjvrCF5v5zKcLBzd3Q7DaA==
X-Google-Smtp-Source: ABdhPJy8bCxxNAMxlikFqLvo0tREKpqZ+r87LOf/cVQumDaHaOArO+YZeZo19fKQmO+LNy54wDMHdQ==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr24868574edt.186.1648895638550;
        Sat, 02 Apr 2022 03:33:58 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id ka22-20020a170907921600b006e4c1ab0bbdsm1886965ejb.207.2022.04.02.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:33:58 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 3/4] tracing: Replace usage of found with dedicated list iterator variable
Date:   Sat,  2 Apr 2022 12:33:40 +0200
Message-Id: <20220402103341.1763932-4-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402103341.1763932-1-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/trace/trace_events_hist.c    | 17 ++++++++---------
 kernel/trace/trace_events_trigger.c | 28 +++++++++++++---------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 44db5ba9cabb..7f60d04d5b6e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6089,32 +6089,31 @@ static void hist_unregister_trigger(char *glob,
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
-			list_del_rcu(&test->list);
+			test = iter;
+			list_del_rcu(&iter->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
 			break;
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
index 7eb9d04f1c2e..1ba54a489416 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -614,22 +614,21 @@ static void unregister_trigger(char *glob,
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
-			list_del_rcu(&data->list);
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (iter->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
+			data = iter;
+			list_del_rcu(&iter->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
 			break;
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data->ops, data);
 }
 
@@ -1976,27 +1975,26 @@ void event_enable_unregister_trigger(char *glob,
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
-			list_del_rcu(&data->list);
+			data = iter;
+			list_del_rcu(&iter->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
 			break;
 		}
 	}
 
-	if (unregistered && data->ops->free)
+	if (data && data->ops->free)
 		data->ops->free(data->ops, data);
 }
 
-- 
2.25.1

