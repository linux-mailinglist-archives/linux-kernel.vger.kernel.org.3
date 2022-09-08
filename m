Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34E5B287B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIHVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIHVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:22:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F61197B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50534B82280
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890BCC433D6;
        Thu,  8 Sep 2022 21:22:37 +0000 (UTC)
Date:   Thu, 8 Sep 2022 17:23:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        "Christian A. Ehrhardt" <lk@c--e.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.0
Message-ID: <20220908172319.175164e7@gandalf.local.home>
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

Tracing fixes and updates for 6.0:

- Do not stop trace events in modules if TAINT_TEST is set

- Do not clobber mount options when tracefs is mounted a second time

- Prevent crash of kprobes in gate area

- Add static annotation to some non global functions

- Add some entries into the MAINTAINERS file

- Fix check of event_mutex held when accessing trigger list

- Add some __init/__exit annotations

- Fix reporting of what called hardirq_{enable,disable}_ip function


Please pull the latest trace-v6.0-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v6.0-rc4

Tag SHA1: 0520c4c3af80a4a8f3f8faf7c99b5e053017b470
Head SHA1: 47311db8e8f33011d90dee76b39c8886120cdda4


Alison Schofield (1):
      tracepoint: Allow trace events in modules with TAINT_TEST

Brian Norris (1):
      tracefs: Only clobber mode/uid/gid on remount if asked

Christian A. Ehrhardt (1):
      kprobes: Prohibit probes in gate area

Daniel Bristot de Oliveira (2):
      rv/monitors: Make monitor's automata definition static
      MAINTAINERS: Add Runtime Verification (RV) entry

Lukas Bulwahn (1):
      MAINTAINERS: add scripts/tracing/ to TRACING

Masami Hiramatsu (Google) (1):
      tracing: Fix to check event_mutex is held while accessing trigger list

Xiu Jianfeng (1):
      rv/reactor: add __init/__exit annotations to module init/exit funcs

Yipeng Zou (1):
      tracing: hold caller_addr to hardirq_{enable,disable}_ip

----
 MAINTAINERS                          | 12 ++++++++++++
 fs/tracefs/inode.c                   | 31 +++++++++++++++++++++++--------
 kernel/kprobes.c                     |  1 +
 kernel/trace/rv/monitors/wip/wip.h   |  2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h |  2 +-
 kernel/trace/rv/reactor_panic.c      |  4 ++--
 kernel/trace/rv/reactor_printk.c     |  4 ++--
 kernel/trace/trace_events_trigger.c  |  3 ++-
 kernel/trace/trace_preemptirq.c      |  4 ++--
 kernel/tracepoint.c                  |  5 +++--
 10 files changed, 49 insertions(+), 19 deletions(-)
---------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..93ffebc3e6c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17735,6 +17735,17 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
+RUNTIME VERIFICATION (RV)
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-trace-devel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/rv/
+F:	include/linux/rv.h
+F:	include/rv/
+F:	kernel/trace/rv/
+F:	tools/verification/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
@@ -20601,6 +20612,7 @@ F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 81d26abf486f..da85b3979195 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -141,6 +141,8 @@ struct tracefs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	/* Opt_* bitfield. */
+	unsigned int opts;
 };
 
 enum {
@@ -241,6 +243,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 	kgid_t gid;
 	char *p;
 
+	opts->opts = 0;
 	opts->mode = TRACEFS_DEFAULT_MODE;
 
 	while ((p = strsep(&data, ",")) != NULL) {
@@ -275,24 +278,36 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 		 * but traditionally tracefs has ignored all mount options
 		 */
 		}
+
+		opts->opts |= BIT(token);
 	}
 
 	return 0;
 }
 
-static int tracefs_apply_options(struct super_block *sb)
+static int tracefs_apply_options(struct super_block *sb, bool remount)
 {
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 
-	inode->i_mode &= ~S_IALLUGO;
-	inode->i_mode |= opts->mode;
+	/*
+	 * On remount, only reset mode/uid/gid if they were provided as mount
+	 * options.
+	 */
+
+	if (!remount || opts->opts & BIT(Opt_mode)) {
+		inode->i_mode &= ~S_IALLUGO;
+		inode->i_mode |= opts->mode;
+	}
 
-	inode->i_uid = opts->uid;
+	if (!remount || opts->opts & BIT(Opt_uid))
+		inode->i_uid = opts->uid;
 
-	/* Set all the group ids to the mount option */
-	set_gid(sb->s_root, opts->gid);
+	if (!remount || opts->opts & BIT(Opt_gid)) {
+		/* Set all the group ids to the mount option */
+		set_gid(sb->s_root, opts->gid);
+	}
 
 	return 0;
 }
@@ -307,7 +322,7 @@ static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto fail;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, true);
 
 fail:
 	return err;
@@ -359,7 +374,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_op = &tracefs_super_operations;
 
-	tracefs_apply_options(sb);
+	tracefs_apply_options(sb, false);
 
 	return 0;
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 08350e35aba2..ca9d834d0b84 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1562,6 +1562,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	/* Ensure it is not in reserved area nor out of text */
 	if (!(core_kernel_text((unsigned long) p->addr) ||
 	    is_module_text_address((unsigned long) p->addr)) ||
+	    in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index c1c47e2305ef..dacc37b62a2c 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -27,7 +27,7 @@ struct automaton_wip {
 	bool final_states[state_max_wip];
 };
 
-struct automaton_wip automaton_wip = {
+static struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
 		"non_preemptive"
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index d1afe55cdd4c..118e576b91b4 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -27,7 +27,7 @@ struct automaton_wwnr {
 	bool final_states[state_max_wwnr];
 };
 
-struct automaton_wwnr automaton_wwnr = {
+static struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
 		"running"
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index b698d05dd069..d65f6c25a87c 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -24,13 +24,13 @@ static struct rv_reactor rv_panic = {
 	.react = rv_panic_reaction
 };
 
-static int register_react_panic(void)
+static int __init register_react_panic(void)
 {
 	rv_register_reactor(&rv_panic);
 	return 0;
 }
 
-static void unregister_react_panic(void)
+static void __exit unregister_react_panic(void)
 {
 	rv_unregister_reactor(&rv_panic);
 }
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 31899f953af4..4b6b7106a477 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -23,13 +23,13 @@ static struct rv_reactor rv_printk = {
 	.react = rv_printk_reaction
 };
 
-static int register_react_printk(void)
+static int __init register_react_printk(void)
 {
 	rv_register_reactor(&rv_printk);
 	return 0;
 }
 
-static void unregister_react_printk(void)
+static void __exit unregister_react_printk(void)
 {
 	rv_unregister_reactor(&rv_printk);
 }
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
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 95b58bd757ce..1e130da1b742 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -95,14 +95,14 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 	}
 
 	lockdep_hardirqs_on_prepare();
-	lockdep_hardirqs_on(CALLER_ADDR0);
+	lockdep_hardirqs_on(caller_addr);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirqs_off(caller_addr);
 
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..ef42c1a11920 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -571,7 +571,8 @@ static void for_each_tracepoint_range(
 bool trace_module_has_bad_taint(struct module *mod)
 {
 	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
-			       (1 << TAINT_UNSIGNED_MODULE));
+			       (1 << TAINT_UNSIGNED_MODULE) |
+			       (1 << TAINT_TEST));
 }
 
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
@@ -647,7 +648,7 @@ static int tracepoint_module_coming(struct module *mod)
 	/*
 	 * We skip modules that taint the kernel, especially those with different
 	 * module headers (for forced load), to make sure we don't cause a crash.
-	 * Staging, out-of-tree, and unsigned GPL modules are fine.
+	 * Staging, out-of-tree, unsigned GPL, and test modules are fine.
 	 */
 	if (trace_module_has_bad_taint(mod))
 		return 0;
