Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE61558736
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiFWSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiFWSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F464781
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 209BD61EE1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FC1C385A2;
        Thu, 23 Jun 2022 17:23:42 +0000 (UTC)
Date:   Thu, 23 Jun 2022 13:23:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [GIT PULL] tracing: Minor fixes and clean ups for 5.19
Message-ID: <20220623132340.38f48aae@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Tracing fixes:

- Check for NULL in kretprobe_dispatcher()
  NULL can now be passed in, make sure it can handle it

- Clean up unneeded #endif #ifdef of the same preprocessor check in the
  middle of the block.

- Comment clean up

- Remove unneeded initialization of the "ret" variable in
  __trace_uprobe_create()


Please pull the latest trace-v5.19-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.19-rc1

Tag SHA1: 552669fd41f0f967ea7abb1e1b9138280b916208
Head SHA1: 12c3e0c92fd7cb3d3b698d84fdde7dccb6ba8822


Gautam Menghani (1):
      tracing/uprobes: Remove unwanted initialization in __trace_uprobe_create()

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Check whether get_kretprobe() returns NULL in kretprobe_dispatcher()

Xiang wangx (1):
      tracefs: Fix syntax errors in comments

sunliming (1):
      tracing: Simplify conditional compilation code in tracing_set_tracer()

----
 fs/tracefs/inode.c          |  2 +-
 kernel/trace/trace.c        |  2 --
 kernel/trace/trace_kprobe.c | 11 ++++++++++-
 kernel/trace/trace_uprobe.c |  1 -
 4 files changed, 11 insertions(+), 5 deletions(-)
---------------------------
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de7252715b12..81d26abf486f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -553,7 +553,7 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Only one instances directory is allowed.
  *
- * The instances directory is special as it allows for mkdir and rmdir to
+ * The instances directory is special as it allows for mkdir and rmdir
  * to be done by userspace. When a mkdir or rmdir is performed, the inode
  * locks are released and the methods passed in (@mkdir and @rmdir) are
  * called without locks and with the name of the directory being created
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c95992e2c71..a8cfac0611bc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6424,9 +6424,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		synchronize_rcu();
 		free_snapshot(tr);
 	}
-#endif
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	if (t->use_max_tr && !had_max_tr) {
 		ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 93507330462c..a245ea673715 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1718,8 +1718,17 @@ static int
 kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	struct kretprobe *rp = get_kretprobe(ri);
-	struct trace_kprobe *tk = container_of(rp, struct trace_kprobe, rp);
+	struct trace_kprobe *tk;
+
+	/*
+	 * There is a small chance that get_kretprobe(ri) returns NULL when
+	 * the kretprobe is unregister on another CPU between kretprobe's
+	 * trampoline_handler and this function.
+	 */
+	if (unlikely(!rp))
+		return 0;
 
+	tk = container_of(rp, struct trace_kprobe, rp);
 	raw_cpu_inc(*tk->nhit);
 
 	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..c3dc4f859a6b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -546,7 +546,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	bool is_return = false;
 	int i, ret;
 
-	ret = 0;
 	ref_ctr_offset = 0;
 
 	switch (argv[0][0]) {
