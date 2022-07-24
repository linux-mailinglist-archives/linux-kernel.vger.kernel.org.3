Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71957F44D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiGXJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiGXJL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:11:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3CFD35
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:11:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u20so6634789iob.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdJ8HLgLOawQBY3awKQe11Y4pVbDXzDsy+R7rFyi4ug=;
        b=nNTTv+RH+0n0r+i95dcBFvNyE3dg1axAtfbLLVvQ3JTGSepHC8Oq8eEzb4PwNDgqUR
         UQ8EJo3Ip9DeC+kV0RfCX0xzjSpxMYmR/0jKhcJT69YWb2iSx0c7wp2aTZJ4Vp3WR5ww
         /v+qJxSf3PQ+OkBUfbfOFwrfIBGLjC0cicjGlyyROC/mvNYwsqkr7X9pPFeb5sieVqDJ
         sIaqGXbwCtYEGS0AzJsyU4nbR/veWChKZhdlv+J/v/gbdgi6kqEJ2QBg6dK5KXQAswNL
         4c99clGM4RlvOH0+Iirr/c2CZtAjcV+fp6wF204HrDYUCbl3tDoHTkJ+LnROfC3lSAiN
         TWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdJ8HLgLOawQBY3awKQe11Y4pVbDXzDsy+R7rFyi4ug=;
        b=asFNaxM3Ncs8GObB/Cm3G9FmsjfCbbFHGIn2vX9xlX2zKcplGDiHfpZFAPsyaf4mZc
         XJekTaeQvaIP9TepwTldXVt3CVTgBYFBkyy7YcgQd6PtuNHbbrHrfeDZv5oY5awUIDjm
         se3GBaZA04a8BcKsfLFgXz/B7LFTboIdvWya10DBMG64iFl3A5xk5expgb+oUxhauKHW
         wEx0n2WklQKyEePig8To57wbYEvmdyXOgKMINAlfG0nBlB8a24lTbQ95NZTnUtYK1T8E
         63Y0u0Pncz1jzL5Mk6gnhu9BNF0lxoKACk5RJ+Wjib3H68/jZHLH7z4TMO5P5yhhbh6I
         DAbA==
X-Gm-Message-State: AJIora90N+v+z5vuTRM3ev6FQtjuh2ADC5GnHr80Mh/9yZ5QXQtLI1ob
        ntcc9vKo8YuBWIj9JNUUZCs=
X-Google-Smtp-Source: AGRyM1vtYV7Nfmch7QwNGPUbBk9+raxrcT402pJOlG3z+ZLzZlx7E/C2EG+eyztKLb/0MPvO5dt1Vw==
X-Received: by 2002:a05:6638:52b:b0:33f:5019:8e6 with SMTP id j11-20020a056638052b00b0033f501908e6mr3128213jar.184.1658653884403;
        Sun, 24 Jul 2022 02:11:24 -0700 (PDT)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-3-145-129-179.us-east-2.compute.amazonaws.com. [3.145.129.179])
        by smtp.googlemail.com with ESMTPSA id m13-20020a026a4d000000b0034161ed8fadsm4092988jaf.150.2022.07.24.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 02:11:24 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/kprobe: Add tracefs to show private kprobe
Date:   Sun, 24 Jul 2022 09:10:50 +0000
Message-Id: <20220724091050.12711-1-iecedge@gmail.com>
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

List private kprobe event to new created local_event_list;
Add tracefs file kprobe_local_profile to show events which
in local_event_list.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 kernel/trace/trace_dynevent.c | 18 +++++++++++++
 kernel/trace/trace_dynevent.h | 33 +++++++++++++++++++++++
 kernel/trace/trace_kprobe.c   | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 076b447a1b88..8411104ad6d8 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -181,6 +181,24 @@ static const struct seq_operations dyn_event_seq_op = {
 	.show	= dyn_event_seq_show
 };
 
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
+
 /*
  * dyn_events_release_all - Release all specific events
  * @type:	the dyn_event_operations * which filters releasing events
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 936477a111d3..e6413969f9ed 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -64,6 +64,7 @@ struct dyn_event {
 };
 
 extern struct list_head dyn_event_list;
+extern struct list_head local_event_list;
 
 static inline
 int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
@@ -95,12 +96,44 @@ static inline void dyn_event_remove(struct dyn_event *ev)
 	list_del_init(&ev->list);
 }
 
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
 void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
 void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
 void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
 int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
 
+void *local_event_seq_start(struct seq_file *m, loff_t *pos);
+void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void local_event_seq_stop(struct seq_file *m, void *v);
+
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
  * @pos:	the struct dyn_event * to use as a loop cursor
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a245ea673715..8fd39033d2ba 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1213,6 +1213,50 @@ static const struct file_operations kprobe_profile_ops = {
 	.release        = seq_release,
 };
 
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
+
 /* Kprobe specific fetch functions */
 
 /* Return the length of string -- including null terminal byte */
@@ -1830,6 +1874,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	if (ret < 0)
 		goto error;
 
+	local_event_add(&tk->devent);
 	return trace_probe_event_call(&tk->tp);
 error:
 	free_trace_kprobe(tk);
@@ -1849,6 +1894,7 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 		return;
 	}
 
+	local_event_remove(&tk->devent);
 	__unregister_trace_kprobe(tk);
 
 	free_trace_kprobe(tk);
@@ -1929,6 +1975,10 @@ static __init int init_kprobe_trace(void)
 	trace_create_file("kprobe_profile", TRACE_MODE_READ,
 			  NULL, NULL, &kprobe_profile_ops);
 
+	/* kprobe Local profile */
+	tracefs_create_file("kprobe_local_profile", TRACE_MODE_READ,
+			  NULL, NULL, &kprobe_local_profile_ops);
+
 	setup_boot_kprobe_events();
 
 	return 0;
-- 
2.25.1

