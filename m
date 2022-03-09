Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8795F4D29D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCIH4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiCIHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ACD163072;
        Tue,  8 Mar 2022 23:54:49 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NafiBD3z6QzC6vWSq0SQ+YQ2bdAauU7/CA9UA5/XyHE=;
        b=DqkDnsuF3o/GNh0vkaMWORSDZSd8KGSBmu3M9ugQjbBnJ7KhH3KmiaPlOqv86WjUvwee/c
        vWO0ZvEtL6BPcV6VV6x3b2TXLlVB0LNaPLyWKrYjmPGzV8hunzcy70fi/RPMBuemCoDN25
        dCOFG+83cbl2hLrpUG2m4cb3rOojkQAS4kQbGVxFED0gMBvX61WD9WQN4okgqlzAVMXDgH
        Q8J9r+j2z2DpXQFJzuEEoHZua6PavmoTykUJOXN4fVypx2poDQxW38UWzPBHhV+jG1VkOX
        6vvodiMPl5o0C2qfFnEgcMDxU8zLu5zlaVXWKyai6J0iurpjbwIzDuuJQkh/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NafiBD3z6QzC6vWSq0SQ+YQ2bdAauU7/CA9UA5/XyHE=;
        b=ybkFIzWUzgdmKXRu6GjupCnFEzBKPBCmq4IU43nAjsoa/CSdlPj6ovauROSVubSN9vepMm
        /w98zErNBvdu76AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] exit: Mark do_group_exit() __noreturn
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.351270711@infradead.org>
References: <20220308154319.351270711@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248681.16921.8811229951116541293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fb604370c4b1c1c17fa9c3f0d60bbe8c9494edd9
Gitweb:        https://git.kernel.org/tip/fb604370c4b1c1c17fa9c3f0d60bbe8c9494edd9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:37 +01:00

exit: Mark do_group_exit() __noreturn

vmlinux.o: warning: objtool: get_signal()+0x108: unreachable instruction

0000 000000000007f930 <get_signal>:
...
0103    7fa33:  e8 00 00 00 00          call   7fa38 <get_signal+0x108> 7fa34: R_X86_64_PLT32   do_group_exit-0x4
0108    7fa38:  41 8b 45 74             mov    0x74(%r13),%eax

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.351270711@infradead.org
---
 include/linux/sched/task.h | 2 +-
 kernel/exit.c              | 2 +-
 tools/objtool/check.c      | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e84e54d..719c9a6 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -79,7 +79,7 @@ static inline void exit_thread(struct task_struct *tsk)
 {
 }
 #endif
-extern void do_group_exit(int);
+extern __noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25b..b71f9df 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -906,7 +906,7 @@ SYSCALL_DEFINE1(exit, int, error_code)
  * Take down every thread in the group.  This is called by fatal signals
  * as well as by sys_exit_group (below).
  */
-void
+void __noreturn
 do_group_exit(int exit_code)
 {
 	struct signal_struct *sig = current->signal;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c3ddcec..9896562 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -181,6 +181,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
 		"cpu_bringup_and_idle",
+		"do_group_exit",
 		"stop_this_cpu",
 	};
 
