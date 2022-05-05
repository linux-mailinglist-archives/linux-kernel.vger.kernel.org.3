Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F451C4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381691AbiEEQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiEEQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D55C377;
        Thu,  5 May 2022 09:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC09361DCB;
        Thu,  5 May 2022 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A889C385A4;
        Thu,  5 May 2022 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766849;
        bh=1Um1v2pbsXWVzfuOFhwnCRlaKUyCQMuNW2iqZGU5beE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMOE3D4fCNUykHj6y7vqEfSS6w2+oXfDFbPRaC053ASaXrHFIdImGUjfIalRHKWSZ
         xBuzFWi6ucvPhO4kUZMTlHRoc8D7+P0Bemq8qX256sUzj3hsyLPOQr8ZRUyF4DUi1x
         IdcuGXr0FzZlMG/6tQtj8SFXvPYCrgdA6WqJp+LCKyQ7flLMaExjJ7/BOYCPya1Jol
         FjZo7jBgT83rqlWeBi0q4AieWOZB0zyAFUA9YnmOnZRMB/bN3cB09F9E6bDvIsjnIh
         vdUYOTxf9e6mkQh7OKGAfs7ZzNYJeRkDHzQ0WSUksbPXKw5/lHrVVgnAVQfWFc+msc
         jXzCnMcj4YUcA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 02/20] rv: Add runtime reactors interface
Date:   Thu,  5 May 2022 18:06:42 +0200
Message-Id: <c4ec12dbc54faf148e40bdf154402e56d7d3f0dd.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A runtime monitor can cause a reaction to the detection of an
exception on the model's execution. By default, the monitors have
tracing reactions, printing the monitor output via tracepoints.
But other reactions can be added (on-demand) via this interface.

The user interface resembles the kernel tracing interface and
presents these files:

"available_reactors"
  - Reading shows the available reactors, one per line.

   For example:
   [root@f32 rv]# cat available_reactors
   nop
   panic
   printk

 "reacting_on"
   - It is an on/off general switch for reactors, disabling
   all reactions.

 "monitors/MONITOR/reactors"
   - List available reactors, with the select reaction for the given
   MONITOR inside []. The default one is the nop (no operation)
   reactor.
   - Writing the name of a reactor enables it to the given
   MONITOR.

   For example:
   [root@f32 rv]# cat monitors/wip/reactors
   [nop]
   panic
   printk
   [root@f32 rv]# echo panic > monitors/wip/reactors
   [root@f32 rv]# cat monitors/wip/reactors
   nop
   [panic]
   printk

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/rv.h       | 13 +++++++++++++
 kernel/trace/rv/Kconfig  | 14 ++++++++++++++
 kernel/trace/rv/Makefile |  1 +
 kernel/trace/rv/rv.c     | 18 ++++++++++++++++--
 kernel/trace/rv/rv.h     | 20 ++++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 205e65f57637..1e48c6bb74bf 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -8,6 +8,13 @@
  */
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
+
+struct rv_reactor {
+	char			*name;
+	char			*description;
+	void			(*react)(char *msg);
+};
+
 struct rv_monitor {
 	const char		*name;
 	const char		*description;
@@ -15,9 +22,15 @@ struct rv_monitor {
 	int			(*start)(void);
 	void			(*stop)(void);
 	void			(*reset)(void);
+	void			(*react)(char *msg);
+
 };
 
 extern bool monitoring_on;
 int rv_unregister_monitor(struct rv_monitor *monitor);
 int rv_register_monitor(struct rv_monitor *monitor);
+
+extern bool reacting_on;
+int rv_unregister_reactor(struct rv_reactor *reactor);
+int rv_register_reactor(struct rv_reactor *reactor);
 #endif /* _LINUX_RV_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6d127cdb00dd..560408fec0c8 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -10,3 +10,17 @@ menuconfig RV
 	  theorem proving). RV works by analyzing the trace of the system's
 	  actual execution, comparing it against a formal specification of
 	  the system behavior.
+
+if RV
+
+config RV_REACTORS
+	bool "Runtime verification reactors"
+	default y if RV
+	help
+	  Enables the online runtime verification reactors. A runtime
+	  monitor can cause a reaction to the detection of an exception
+	  on the model's execution. By default, the monitors have
+	  tracing reactions, printing the monitor output via tracepoints,
+	  but other reactions can be added (on-demand) via this interface.
+
+endif # RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index fd995379df67..8944274d9b41 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RV) += rv.o
+obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 11735e431a09..ea013dec93d8 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -362,8 +362,13 @@ static int create_monitor_dir(struct rv_monitor_def *mdef)
 		retval = -ENOMEM;
 		goto out_remove_root;
 	}
+#ifdef CONFIG_RV_REACTORS
+	retval = reactor_create_monitor_files(mdef);
+	if (retval)
+		goto out_remove_root;
+#endif
 
-	return retval;
+	return 0;
 
 out_remove_root:
 	rv_remove(mdef->root_d);
@@ -674,7 +679,11 @@ int rv_register_monitor(struct rv_monitor *monitor)
 
 	r->monitor = monitor;
 
-	create_monitor_dir(r);
+	retval = create_monitor_dir(r);
+	if (retval) {
+		kfree(r);
+		goto out_unlock;
+	}
 
 	list_add_tail(&r->list, &rv_monitors_list);
 
@@ -732,6 +741,11 @@ int __init rv_init_interface(void)
 	rv_create_file("monitoring_on", 0600, rv_root.root_dir, NULL,
 		       &monitoring_on_fops);
 
+#ifdef CONFIG_RV_REACTORS
+	init_rv_reactors(rv_root.root_dir);
+	reacting_on = true;
+#endif
+
 	monitoring_on = true;
 
 	return 0;
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 0796867a7b1e..6d43f52d72a9 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -15,14 +15,28 @@ struct rv_interface {
 #define rv_remove			tracefs_remove
 
 #define MAX_RV_MONITOR_NAME_SIZE	32
+#define MAX_RV_REACTOR_NAME_SIZE	32
 
 extern struct mutex rv_interface_lock;
 
+#ifdef CONFIG_RV_REACTORS
+struct rv_reactor_def {
+	struct list_head list;
+	struct rv_reactor *reactor;
+	/* protected by the monitor interface lock */
+	int counter;
+};
+#endif
+
 struct rv_monitor_def {
 	struct list_head list;
 	struct rv_monitor *monitor;
+#ifdef CONFIG_RV_REACTORS
+	struct rv_reactor_def *rdef;
+#endif
 	struct dentry *root_d;
 	bool enabled;
+	bool reacting;
 	bool task_monitor;
 };
 
@@ -32,3 +46,9 @@ void reset_all_monitors(void);
 int init_rv_monitors(struct dentry *root_dir);
 int get_task_monitor_slot(void);
 void put_task_monitor_slot(int slot);
+
+#ifdef CONFIG_RV_REACTORS
+extern bool reacting_on;
+int reactor_create_monitor_files(struct rv_monitor_def *mdef);
+int init_rv_reactors(struct dentry *root_dir);
+#endif
-- 
2.35.1

