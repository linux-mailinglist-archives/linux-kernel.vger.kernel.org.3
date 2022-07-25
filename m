Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36657F957
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiGYGYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:24:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05FBC99;
        Sun, 24 Jul 2022 23:24:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h14so5213879ilq.12;
        Sun, 24 Jul 2022 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5/JypyxvVlxlidcsWJKdXpWO2vAS4k2kNj6OGsjgtI=;
        b=mVER7Gx/6qOnFKLkcXvc2BsbuEhsXApDnOU4vF9Ecf6OJPnU82XZeB3UTjEmQ9V4cQ
         gFuv0MNlCjxsir8JFw91Dpi+bcaSd2NWGIxl2sAbIPXo7dgMWnj2d46t3wvDlUHrQk4K
         xkarz1VQayYCLA5+wWwxbDshXU/3EPzrQw3WI6nyMdiavF0sipzrK6nFhEcQqrQ+ioo6
         dklGJOU62cwoJgSr/HfkK7BpOSYDQ9+BOnKL+MDKtMgoL7WNcG157tTkCcSOumyAoxmJ
         HPinChTlQWrz5/gCXxghUP/8LjQvw7LW3yRNSLx5RKz86bHQOGDLGFeiisc5LwashyLh
         KSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5/JypyxvVlxlidcsWJKdXpWO2vAS4k2kNj6OGsjgtI=;
        b=u6+q7wNKiy69y/XeZhIbwq6iIMVjRk5CXFMQTCnQ5uAVKXSlBrWAWlAfWf6ZnAebdo
         u0Vxo/kjQpQ77iM0Zh061xwVbVGaVC7gVyzETdViZbTSYRBqpaZ/bwmHA8FMurnCuljq
         rNOw+jE6G7A1nYUdjKXw4pi2YwhLuolUNe2NK2tkhYYSRWgHkxWUkeQoYIkACGE4NCHo
         V016l1AmmE5XkWf5q44RoMB0B7wrJzOBzT7R4cANgacKJOWGQISM96YGeRMcJtAKslio
         vzpUp4HaqS+exTRnvCwp/UQZUMQM30tEOH/3cX05RciJXFibhIeyQw6oiYVLUWNr8sSx
         O4gQ==
X-Gm-Message-State: AJIora8MazGG5lb/e2/8ZNlW1w9qmjS80wf7v2h7pjT9nmyV1T4z3r44
        7P7EJvMJaW7tmCQmMkvbYRo=
X-Google-Smtp-Source: AGRyM1tE5y9nmeYAd42dHV2NoF4w5sW/npfaEaTkd9UJyp7vUUAf204njZYbdlgbf1YfADrLkC7+/A==
X-Received: by 2002:a05:6e02:194d:b0:2dc:6c56:a522 with SMTP id x13-20020a056e02194d00b002dc6c56a522mr4300954ilu.203.1658730248484;
        Sun, 24 Jul 2022 23:24:08 -0700 (PDT)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-18-118-36-142.us-east-2.compute.amazonaws.com. [18.118.36.142])
        by smtp.googlemail.com with ESMTPSA id c1-20020a929401000000b002dd0d081fcesm4356616ili.0.2022.07.24.23.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:24:08 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
To:     corbet@lwn.net, rostedt@goodmis.org, mingo@redhat.com
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] tracing/kprobes: Add method to display private kprobes in tracefs
Date:   Mon, 25 Jul 2022 06:23:34 +0000
Message-Id: <20220725062334.1778-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The private kprobes are not added to the global list dyn_event_list,
so there is a missing interface to show probe hit and probe miss.
This patch adds a profiling interface to check the number of hits or
misses for private kprobes.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
v2: update commit message
---
 Documentation/trace/kprobetrace.rst |  6 +++-
 kernel/trace/trace_dynevent.c       | 20 +++++++++++
 kernel/trace/trace_dynevent.h       | 37 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c         | 54 +++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index b175d88f31eb..8815d64dd8a6 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -146,7 +146,11 @@ trigger:
 Event Profiling
 ---------------
 You can check the total number of probe hits and probe miss-hits via
-/sys/kernel/debug/tracing/kprobe_profile.
+/sys/kernel/debug/tracing/kprobe_profile or
+/sys/kernel/debug/tracing/kprobe_local_profile.
+All kprobe events created by kprobe_events will be added to the global
+list, you can get their profiling via kprobe_profile; kprobe_local_profile
+shows profiling for private kprobe events created by perf_kprobe pmu.
 The first column is event name, the second is the number of probe hits,
 the third is the number of probe miss-hits.
 
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 076b447a1b88..70ec99cd9c53 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -181,6 +181,26 @@ static const struct seq_operations dyn_event_seq_op = {
 	.show	= dyn_event_seq_show
 };
 
+#ifdef CONFIG_KPROBE_EVENTS
+LIST_HEAD(local_event_list);
+
+void *local_event_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+	return seq_list_start(&local_event_list, *pos);
+}
+
+void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &local_event_list, pos);
+}
+
+void local_event_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+#endif /* CONFIG_KPROBE_EVENTS */
+
 /*
  * dyn_events_release_all - Release all specific events
  * @type:	the dyn_event_operations * which filters releasing events
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 936477a111d3..e30193470295 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -101,6 +101,43 @@ void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
 int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
 
+#ifdef CONFIG_KPROBE_EVENTS
+extern struct list_head local_event_list;
+
+static inline
+int local_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
+{
+	if (!ev || !ops)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ev->list);
+	ev->ops = ops;
+	return 0;
+}
+
+static inline int local_event_add(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!ev || !ev->ops)
+		return -EINVAL;
+
+	list_add_tail(&ev->list, &local_event_list);
+	return 0;
+}
+
+static inline void local_event_remove(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+	list_del_init(&ev->list);
+}
+
+void *local_event_seq_start(struct seq_file *m, loff_t *pos);
+void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void local_event_seq_stop(struct seq_file *m, void *v);
+
+#endif /* CONFIG_KPROBE_EVENTS */
+
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
  * @pos:	the struct dyn_event * to use as a loop cursor
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a245ea673715..76f500b17b46 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1213,6 +1213,52 @@ static const struct file_operations kprobe_profile_ops = {
 	.release        = seq_release,
 };
 
+#ifdef CONFIG_KPROBE_EVENTS
+/* kprobe Local profile  */
+static int local_probes_profile_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+	struct trace_kprobe *tk;
+
+	if (!is_trace_kprobe(ev))
+		return 0;
+
+	tk = to_trace_kprobe(ev);
+	seq_printf(m, "  %-44s %15lu %15lu\n",
+		trace_probe_name(&tk->tp),
+		trace_kprobe_nhit(tk),
+		tk->rp.kp.nmissed);
+
+	return 0;
+}
+
+static const struct seq_operations local_profile_seq_op = {
+	.start  = local_event_seq_start,
+	.next   = local_event_seq_next,
+	.stop   = local_event_seq_stop,
+	.show   = local_probes_profile_seq_show
+};
+
+static int local_profile_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	return seq_open(file, &local_profile_seq_op);
+}
+
+static const struct file_operations kprobe_local_profile_ops = {
+	.owner          = THIS_MODULE,
+	.open           = local_profile_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+#endif /* CONFIG_KPROBE_EVENTS */
+
 /* Kprobe specific fetch functions */
 
 /* Return the length of string -- including null terminal byte */
@@ -1830,6 +1876,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	if (ret < 0)
 		goto error;
 
+	local_event_add(&tk->devent);
 	return trace_probe_event_call(&tk->tp);
 error:
 	free_trace_kprobe(tk);
@@ -1849,6 +1896,7 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 		return;
 	}
 
+	local_event_remove(&tk->devent);
 	__unregister_trace_kprobe(tk);
 
 	free_trace_kprobe(tk);
@@ -1929,6 +1977,12 @@ static __init int init_kprobe_trace(void)
 	trace_create_file("kprobe_profile", TRACE_MODE_READ,
 			  NULL, NULL, &kprobe_profile_ops);
 
+#ifdef CONFIG_KPROBE_EVENTS
+	/* kprobe Local profile */
+	tracefs_create_file("kprobe_local_profile", TRACE_MODE_READ,
+			  NULL, NULL, &kprobe_local_profile_ops);
+#endif /* CONFIG_KPROBE_EVENTS */
+
 	setup_boot_kprobe_events();
 
 	return 0;
-- 
2.25.1

