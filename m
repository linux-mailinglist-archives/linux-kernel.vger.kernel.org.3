Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0479A511E96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbiD0RLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbiD0RLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:11:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4B2F01F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p4so2743614edx.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLh+ycGxoaHmPKTcUcTA+KBn17ZH9Xl0EK9Vq7S0llg=;
        b=XvLiZvVD/w9uq+CjPd24vGOPjfQuHim7dqyaVX2XUnFTxrHi+2X8SL+3rOHyue7vbD
         DudOOYQ7I0VPZaW3bMJrymheR/rpM6CEx+EIzMhVPQWvGOaGujTs90aftEmV0/T/obC5
         cysaGWk2Is1kkC441R4GaM28/aXpBcQnPgez0Okm2QilYMVKUvlD1zPgysgPrAuJspN7
         vaoj64J8POP2QQZdjIHEsAARiUArUcSp1J0AROuw9m7Ut3gNz0S45amgamOBuHbblFhO
         iocvbG4IkTTzOi005i5XjJ+7u07oGWeG6UFed6l1RAn6Iim3q2qdScRKiaYR/79uADrW
         AAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLh+ycGxoaHmPKTcUcTA+KBn17ZH9Xl0EK9Vq7S0llg=;
        b=vExb4e9kDu/eLTMgsiYx01WnwbBtSifAzU86Bopib/I4sA0LTSuektxS4CEW0CmrfI
         HXppgUIU2HKAdxD5SrlUUwPJHm1DP2v1lt2lJcjcBgifTSCK/CsBaaZbtkGV1n+Mjs4t
         cc9BH3uz4ZPZ8z4QAfFa39V3eYI54Cvo+uF/t68ymGp1FViHaCah6BaQUBXKK5FAcqdk
         Fu36vu2H/qu6oW4/7Dzr1UxMfFb0Tq9Tkt+pnH8uKx8etN82ixrNctA84AWnIfhkrPEa
         afIh9GbXgzFVQmimZt1ghRpRbrpuKUW3egwe0EWDQiUmBG3XvVNfHY3mc9+lFadMCi0w
         dFQA==
X-Gm-Message-State: AOAM531tOB/iDKAf0VB6ZFvzL+9OstFPSowKT6kgtXGIJb43XI7agV/O
        W9ZFz4Ih2gg+Mfl5+i+2MbTcKKyy+THRO14210g=
X-Google-Smtp-Source: ABdhPJwLWRpKq9gAjysvaJP4IdGzPUqPzRB1ziV3vsByW/3u3Ag30ZXAh01vGp0jYB6Tec2wua0dxA==
X-Received: by 2002:a05:6402:524d:b0:425:fae3:732d with SMTP id t13-20020a056402524d00b00425fae3732dmr10550228edd.398.1651079297439;
        Wed, 27 Apr 2022 10:08:17 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm6694359edi.97.2022.04.27.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:08:17 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 4/4] tracing: Remove check of list iterator against head past the loop body
Date:   Wed, 27 Apr 2022 19:07:34 +0200
Message-Id: <20220427170734.819891-5-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/ftrace.c       | 20 ++++++++++++--------
 kernel/trace/trace_eprobe.c | 14 ++++++++------
 kernel/trace/trace_events.c | 12 ++++++------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..5c465e70d146 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4560,8 +4560,8 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 			       struct ftrace_probe_ops *probe_ops,
 			       void *data)
 {
+	struct ftrace_func_probe *probe = NULL, *iter;
 	struct ftrace_func_entry *entry;
-	struct ftrace_func_probe *probe;
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *old_hash;
 	struct ftrace_hash *hash;
@@ -4580,11 +4580,13 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
-	list_for_each_entry(probe, &tr->func_probes, list) {
-		if (probe->probe_ops == probe_ops)
+	list_for_each_entry(iter, &tr->func_probes, list) {
+		if (iter->probe_ops == probe_ops) {
+			probe = iter;
 			break;
+		}
 	}
-	if (&probe->list == &tr->func_probes) {
+	if (!probe) {
 		probe = kzalloc(sizeof(*probe), GFP_KERNEL);
 		if (!probe) {
 			mutex_unlock(&ftrace_lock);
@@ -4702,9 +4704,9 @@ int
 unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 				      struct ftrace_probe_ops *probe_ops)
 {
+	struct ftrace_func_probe *probe = NULL, *iter;
 	struct ftrace_ops_hash old_hash_ops;
 	struct ftrace_func_entry *entry;
-	struct ftrace_func_probe *probe;
 	struct ftrace_glob func_g;
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *old_hash;
@@ -4732,11 +4734,13 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 	mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
-	list_for_each_entry(probe, &tr->func_probes, list) {
-		if (probe->probe_ops == probe_ops)
+	list_for_each_entry(iter, &tr->func_probes, list) {
+		if (iter->probe_ops == probe_ops) {
+			probe = iter;
 			break;
+		}
 	}
-	if (&probe->list == &tr->func_probes)
+	if (!probe)
 		goto err_unlock_ftrace;
 
 	ret = -EINVAL;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 541aa13581b9..63e901a28425 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -650,7 +650,7 @@ static struct trace_event_functions eprobe_funcs = {
 static int disable_eprobe(struct trace_eprobe *ep,
 			  struct trace_array *tr)
 {
-	struct event_trigger_data *trigger;
+	struct event_trigger_data *trigger = NULL, *iter;
 	struct trace_event_file *file;
 	struct eprobe_data *edata;
 
@@ -658,14 +658,16 @@ static int disable_eprobe(struct trace_eprobe *ep,
 	if (!file)
 		return -ENOENT;
 
-	list_for_each_entry(trigger, &file->triggers, list) {
-		if (!(trigger->flags & EVENT_TRIGGER_FL_PROBE))
+	list_for_each_entry(iter, &file->triggers, list) {
+		if (!(iter->flags & EVENT_TRIGGER_FL_PROBE))
 			continue;
-		edata = trigger->private_data;
-		if (edata->ep == ep)
+		edata = iter->private_data;
+		if (edata->ep == ep) {
+			trigger = iter;
 			break;
+		}
 	}
-	if (list_entry_is_head(trigger, &file->triggers, list))
+	if (!trigger)
 		return -ENODEV;
 
 	list_del_rcu(&trigger->list);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e4a442060707..78f313b7b315 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2279,8 +2279,8 @@ static struct dentry *
 event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
+	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	struct event_subsystem *system;
 	struct dentry *entry;
 
 	/* First see if we did not already create this dir */
@@ -2294,13 +2294,13 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	}
 
 	/* Now see if the system itself exists. */
-	list_for_each_entry(system, &event_subsystems, list) {
-		if (strcmp(system->name, name) == 0)
+	system = NULL;
+	list_for_each_entry(iter, &event_subsystems, list) {
+		if (strcmp(iter->name, name) == 0) {
+			system = iter;
 			break;
+		}
 	}
-	/* Reset system variable when not found */
-	if (&system->list == &event_subsystems)
-		system = NULL;
 
 	dir = kmalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
-- 
2.25.1

