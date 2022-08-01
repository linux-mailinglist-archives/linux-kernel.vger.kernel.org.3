Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70A5862A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiHACcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiHACcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072212D3E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F9261218
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE2DC433D6;
        Mon,  1 Aug 2022 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321149;
        bh=TZqKC9i8D5iV3DKzWvU7wGOtxzIeg45/o3i8PitTRhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C31B1wZpU5POUc7Am3Gd5B0Af2nueE7qMl3fBppGDif2WSGCkc1pci21vpU7KmZqd
         FAtqko59eKZjK7htm+Ariz4sIeFlYNp9s3v1FMFT2Nj2fehCIc6sdH8SrSwccLZd53
         mJgPwU/IkYJan7S6yEPlb3IEiAkESasZbe8EIS/4rokCD3JE1ZNFYbh672W5hUgBoU
         az/E60VUN2AYxpP83EKpA+BEdVBl8ZHBEDpqw8tkRqdAER6gYs3ptZmB3oxr7ZMKyO
         EUv26fzwHKBO4Y6Hdvne0oy63h9xbD0/vJ5BCSiz63KzBeTfALrCoIuVj+bb488WTo
         D28Kf1P0/6FiA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] tracing/eprobe: Add eprobe filter support
Date:   Mon,  1 Aug 2022 11:32:25 +0900
Message-Id: <165932114513.2850673.2592206685744598080.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <165932112555.2850673.7704483936633223533.stgit@devnote2>
References: <165932112555.2850673.7704483936633223533.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add the filter option to the event probe. This is useful if user wants
to derive a new event based on the condition of the original event.

E.g.
 echo 'e:egroup/stat_runtime_4core sched/sched_stat_runtime \
        runtime=$runtime:u32 if cpu < 4' >> ../dynamic_events

Then it can filter the events only on first 4 cores.
Note that the fields used for 'if' must be the fields in the original
events, not eprobe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |  104 ++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_probe.h  |    3 +
 2 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 4a0e9d927443..8b32d1a3b9c7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -26,6 +26,9 @@ struct trace_eprobe {
 	/* tracepoint event */
 	const char *event_name;
 
+	/* filter string for the tracepoint */
+	char *filter_str;
+
 	struct trace_event_call *event;
 
 	struct dyn_event	devent;
@@ -589,14 +592,15 @@ static struct event_trigger_data *
 new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 {
 	struct event_trigger_data *trigger;
+	struct event_filter *filter = NULL;
 	struct eprobe_data *edata;
+	int ret;
 
 	edata = kzalloc(sizeof(*edata), GFP_KERNEL);
 	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
 	if (!trigger || !edata) {
-		kfree(edata);
-		kfree(trigger);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto error;
 	}
 
 	trigger->flags = EVENT_TRIGGER_FL_PROBE;
@@ -611,13 +615,25 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 	trigger->cmd_ops = &event_trigger_cmd;
 
 	INIT_LIST_HEAD(&trigger->list);
-	RCU_INIT_POINTER(trigger->filter, NULL);
+
+	if (ep->filter_str) {
+		ret = create_event_filter(file->tr, file->event_call,
+					ep->filter_str, false, &filter);
+		if (ret)
+			goto error;
+	}
+	RCU_INIT_POINTER(trigger->filter, filter);
 
 	edata->file = file;
 	edata->ep = ep;
 	trigger->private_data = edata;
 
 	return trigger;
+error:
+	free_event_filter(filter);
+	kfree(edata);
+	kfree(trigger);
+	return ERR_PTR(ret);
 }
 
 static int enable_eprobe(struct trace_eprobe *ep,
@@ -651,6 +667,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
 {
 	struct event_trigger_data *trigger = NULL, *iter;
 	struct trace_event_file *file;
+	struct event_filter *filter;
 	struct eprobe_data *edata;
 
 	file = find_event_file(tr, ep->event_system, ep->event_name);
@@ -677,6 +694,10 @@ static int disable_eprobe(struct trace_eprobe *ep,
 	/* Make sure nothing is using the edata or trigger */
 	tracepoint_synchronize_unregister();
 
+	filter = rcu_access_pointer(trigger->filter);
+
+	if (filter)
+		free_event_filter(filter);
 	kfree(edata);
 	kfree(trigger);
 
@@ -848,12 +869,62 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 	return ret;
 }
 
+static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
+{
+	struct event_filter *dummy;
+	int i, ret, len = 0;
+	char *p;
+
+	if (argc == 0) {
+		trace_probe_log_err(0, NO_EP_FILTER);
+		return -EINVAL;
+	}
+
+	/* Recover the filter string */
+	for (i = 0; i < argc; i++)
+		len += strlen(argv[i]) + 1;
+
+	ep->filter_str = kzalloc(len, GFP_KERNEL);
+	if (!ep->filter_str)
+		return -ENOMEM;
+
+	p = ep->filter_str;
+	for (i = 0; i < argc; i++) {
+		ret = snprintf(p, len, "%s ", argv[i]);
+		if (ret < 0)
+			goto error;
+		if (ret > len) {
+			ret = -E2BIG;
+			goto error;
+		}
+		p += ret;
+		len -= ret;
+	}
+	p[-1] = '\0';
+
+	/*
+	 * Ensure the filter string can be parsed correctly. Note, this
+	 * filter string is for the original event, not for the eprobe.
+	 */
+	ret = create_event_filter(top_trace_array(), ep->event, ep->filter_str,
+				  true, &dummy);
+	free_event_filter(dummy);
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	kfree(ep->filter_str);
+	ep->filter_str = NULL;
+	return ret;
+}
+
 static int __trace_eprobe_create(int argc, const char *argv[])
 {
 	/*
 	 * Argument syntax:
-	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS]
-	 * Fetch args:
+	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS] [if FILTER]
+	 * Fetch args (no space):
 	 *  <name>=$<field>[:TYPE]
 	 */
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
@@ -863,8 +934,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	char buf1[MAX_EVENT_NAME_LEN];
 	char buf2[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
-	int ret = 0;
-	int i;
+	int ret = 0, filter_idx = 0;
+	int i, filter_cnt;
 
 	if (argc < 2 || argv[0][0] != 'e')
 		return -ECANCELED;
@@ -894,6 +965,15 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		event = buf1;
 	}
 
+	for (i = 2; i < argc; i++) {
+		if (!strcmp(argv[i], "if")) {
+			filter_idx = i + 1;
+			filter_cnt = argc - filter_idx;
+			argc = i;
+			break;
+		}
+	}
+
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
 	ep = alloc_event_probe(group, event, event_call, argc - 2);
@@ -909,6 +989,14 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto error;
 	}
 
+	if (filter_idx) {
+		trace_probe_log_set_index(filter_idx);
+		ret = trace_eprobe_parse_filter(ep, filter_cnt, argv + filter_idx);
+		if (ret)
+			goto parse_error;
+	} else
+		ep->filter_str = NULL;
+
 	argc -= 2; argv += 2;
 	/* parse arguments */
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 3b3869ae8cfd..de38f1c03776 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -445,7 +445,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(SAME_PROBE,		"There is already the exact same probe event"),\
 	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
 	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
-	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),
+	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
+	C(NO_EP_FILTER,		"No filter rule after 'if'"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

