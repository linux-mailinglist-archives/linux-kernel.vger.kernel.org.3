Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10865060C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiDSAPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiDSAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451916311;
        Mon, 18 Apr 2022 17:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01536B81123;
        Tue, 19 Apr 2022 00:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC5CC385A8;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=ekqEEHkIZKPJH+WeMu+2eIAZrk4ZMTg5yBKQBCNK+yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihCPdbN3zo0cP8d3WEi8YefeEUDMZxLEo9I3SY7xDI112BGXxwNDYgWZezawexwQW
         cWtOX8xKuMQ/uZYNoiNfMl8QI0S5uirC+YALJxznLOhzf9wNfbZ+WZRssgnrGi9FAU
         zXggP660QOKKSHvWGfleilR+3OsnproDS7TtJGY5PJJyLVmly0UlGX8lOTiMam0dr8
         6AqWr8DfL5qkfNPSlrSYfVV1fAY9e6nPiUsvgfjRMPHMh1/IqGE31CAUCiwrZVg9E3
         mAwd0+irKnhl2DugPMe7H1DIHYKo7iE1vLPbnoUJ65LcGfnjHkrJ+2ne+Ce7efkF+Y
         wgJ6kYoxCL9Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4103D5C04C6; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH rcu 02/12] rcu: Make the TASKS_RCU Kconfig option be selected
Date:   Mon, 18 Apr 2022 17:12:23 -0700
Message-Id: <20220419001233.3950188-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
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

Currently, any kernel built with CONFIG_PREEMPTION=y also gets
CONFIG_TASKS_RCU=y, which is not helpful to people trying to build
preemptible kernels of minimal size.

Because CONFIG_TASKS_RCU=y is needed only in kernels doing tracing of
one form or another, this commit moves from TASKS_RCU deciding when it
should be enabled to the tracing Kconfig options explicitly selecting it.
This allows building preemptible kernels without TASKS_RCU, if desired.

This commit also updates the SRCU-N and TREE09 rcutorture scenarios
in order to avoid Kconfig errors that would otherwise result from
CONFIG_TASKS_RCU being selected without its CONFIG_RCU_EXPERT dependency
being met.

[ paulmck: Apply BPF_SYSCALL feedback from Andrii Nakryiko. ]

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

--- Update SRCU-N and TREE09 to avoid Kconfig errors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/Kconfig                                          | 1 +
 kernel/bpf/Kconfig                                    | 1 +
 kernel/rcu/Kconfig                                    | 3 ++-
 kernel/trace/Kconfig                                  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-N | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/TREE09 | 2 ++
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 29b0167c088b..1bf29ce754af 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -35,6 +35,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
+	select TASKS_RCU if PREEMPTION
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d56ee177d5f8..2dfe1079f772 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -27,6 +27,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
+	select TASKS_RCU if PREEMPTION
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index f559870fbf8b..4f665ae0cf55 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
 	  task-based RCU implementations.  Not for manual selection.
 
 config TASKS_RCU
-	def_bool PREEMPTION
+	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  only voluntary context switch (not preemption!), idle, and
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2c43e327a619..bf5da6c4e999 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -144,6 +144,7 @@ config TRACING
 	select BINARY_PRINTF
 	select EVENT_TRACING
 	select TRACE_CLOCK
+	select TASKS_RCU if PREEMPTION
 
 config GENERIC_TRACER
 	bool
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
index 2da8b49589a0..07f5e0a70ae7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
@@ -6,3 +6,5 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_RCU_EXPERT=n
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
index 8523a7515cbf..fc45645bb5f4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE09
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
@@ -13,3 +13,5 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 #CHECK#CONFIG_RCU_EXPERT=n
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
-- 
2.31.1.189.g2e36527f23

