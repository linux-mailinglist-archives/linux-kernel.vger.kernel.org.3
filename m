Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E424EE443
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiCaWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiCaWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:40:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233A1B60AD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:38:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i16so2152030ejk.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=loXqWj4uMAO1VS+XUp0ej1qAVC5SGwAOzlph5uEBBt4=;
        b=hIccM7ZvBux6z+dq7fyIKt7MvqW+/OkCehMLxmaHiwsH9PFNPN0U0r8IaB6tY9Af+4
         hu+j7N6urB6UvJznyqg2YWE8Ix3cE1oaqwCyq0nRHMORw4lfOdmUpStAlmKDegPL8XEU
         8f9mHPDOzUlx3bSKFn/tb0N1k0Rfs4+1uvMl8xrkxoxstwpYhCLlNtZ/2MmSQ3Om25GW
         TOqz7HWO1RWraerbG61S5W4eQ23+rBJ+CrNT8saz/gNWXEl4dWXL0hxzcH7ZFaXpkQAQ
         XAaAnRyrvXbmw6wf4MlmMGvec2SOXWK4x1Xz77r5dROr5W0uyVVB1aQaW4pZ+v5/pVRT
         4gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=loXqWj4uMAO1VS+XUp0ej1qAVC5SGwAOzlph5uEBBt4=;
        b=dLRzI3+5WCubZcmaoQyGnhefrLRC9IYYiKugWj+gs8rhadtTExPGhnVrdv6uE52EZ9
         PlTYgTELTFv+MuZIjo4A/jj2LZ78S2GP/QEB/Xcbow2/jA0cbv6KKFEOnsLnXGMYetm6
         0wBk4XBctya8SHfMY8hTAq/NzvNDCL7FU/tPZkaImGvrEXe+7rltkop6Bwsin0KDJZ80
         riclHNxXt04Caa7/+bxr46v+GB9Ok8eMDiNEc0zPauq9CGUx3dvvEN/xXZb9PMMmEIOO
         fiW6JdAAaE77AOwH9unDyyNf4LhYNkqwa0sRhCHgtuPOciw9vo8RqdAjVIn3BiaVDz2x
         pNEQ==
X-Gm-Message-State: AOAM533CPa0GJd+BGeFqm24DLpHc0micLnAZMORqvrY2ZklHIwR8TTNK
        TQ1Iwvezsx0jSdbdTZhWogzT0nPJQ5WpaWkq
X-Google-Smtp-Source: ABdhPJyZkEzSA2Op6EKd061v/sPJhRCXYGfrbTfRC0pWtNdKWfRojCEIsX6kGnjC6XtltnFKR74YTg==
X-Received: by 2002:a17:907:72cc:b0:6e0:2d3:bcba with SMTP id du12-20020a17090772cc00b006e002d3bcbamr6851260ejc.642.1648766319450;
        Thu, 31 Mar 2022 15:38:39 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm280321ejc.120.2022.03.31.15.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:38:39 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] ftrace: remove check of list iterator against head past the loop body
Date:   Fri,  1 Apr 2022 00:37:52 +0200
Message-Id: <20220331223752.902726-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 kernel/trace/ftrace.c       | 20 ++++++++++++--------
 kernel/trace/trace_eprobe.c | 14 ++++++++------
 kernel/trace/trace_events.c | 12 ++++++------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..096f5a83358d 100644
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
@@ -4704,7 +4706,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 {
 	struct ftrace_ops_hash old_hash_ops;
 	struct ftrace_func_entry *entry;
-	struct ftrace_func_probe *probe;
+	struct ftrace_func_probe *probe = NULL, *iter;
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
index e11e167b7809..fe3dc157e635 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2281,7 +2281,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
 	struct trace_subsystem_dir *dir;
-	struct event_subsystem *system;
+	struct event_subsystem *system, *iter;
 	struct dentry *entry;
 
 	/* First see if we did not already create this dir */
@@ -2295,13 +2295,13 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
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

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

