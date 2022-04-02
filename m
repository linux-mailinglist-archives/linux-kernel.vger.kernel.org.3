Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D514F00A5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354381AbiDBKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354349AbiDBKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:31:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF862A0A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:29:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id pv16so10758732ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILXjMgTh/e2skGwgvL/8l3IUSWbsB2Y7GDxe3Qujksk=;
        b=XhCmtJued5SXjp6ApdGrRtCf2Z6ExtmrVqNtT43PYteI2m0UUpAd1ZksXR40fDj3VL
         56owpncAK0qRWAmXeB/TJ8J8J9PirUu5a7mCw4Sih5LY/9Agg8Jl4hleAIja9lkO0oB8
         vn71llP+WcxvInXwk1i52brI6pNIdOk7XNTV0qCTrj2gpaCFcUty6fPMXgU/1Nqy7sxA
         Qc1F4iPzdtDtCMUce5j/b8HD6X93Swjvpy8v8+w1ECku6AI5/ppiQ5EZS5f6Q1mJu57O
         rl5fLx/SXdeORzfI2A08jAozE8ibpnbbeay8cgX0qz7fx2XK5GY5G1S4bkgF2IVDc6Fc
         vqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILXjMgTh/e2skGwgvL/8l3IUSWbsB2Y7GDxe3Qujksk=;
        b=OpalUeADdCkW2eFEedeSucivzk5feOJHBQtpLfiFtNYvMeP4Lf4uh2pGEzC4JdBHNN
         u/juBnluaE353P6GqKWAZaxJQ4MbH9awFXz3NiIQ2KrTFvahJioxoDLcSGaDIixPMUqz
         wExsKILy4KzfefGLjRvE4pN1tnmD6rgavclQqqJs9JVF+/bUz4bvZyVfTOpsQbMH6KVj
         kUDXCLeqwzawExX+oZ8YPVMIU/9MaNOQ+2FmJUamCxBUV8dmAZmjEOjWvS7fov8Fezul
         AHKSL3Zt1EazCp4MWelBjRU/EEElWsx7VSwHEB2rQQYk/bTxUPPrnpCAxIr3avV17iSa
         RC9Q==
X-Gm-Message-State: AOAM533D/gSUpXDCj9755JHRuH53se6pyEYaulW0zLbFhYyVj9/9dB3y
        gcGASSJrm0Rq5dixbm7mpIc=
X-Google-Smtp-Source: ABdhPJxieE8H+JLbNOv4pG2ULBSz0FzMMKD1H4geHfPFFKNRpO93HPd+R8ChRaPR77NczkgLmmr9CA==
X-Received: by 2002:a17:906:b102:b0:6db:1487:e73 with SMTP id u2-20020a170906b10200b006db14870e73mr3184310ejy.474.1648895376142;
        Sat, 02 Apr 2022 03:29:36 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm1952187ejc.171.2022.04.02.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:29:35 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 4/4] tracing: Remove check of list iterator against head past the loop body
Date:   Sat,  2 Apr 2022 12:28:48 +0200
Message-Id: <20220402102848.1759172-5-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402102848.1759172-1-jakobkoschel@gmail.com>
References: <20220402102848.1759172-1-jakobkoschel@gmail.com>
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
index 97c7eb2f55e5..c86cbb25879d 100644
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

