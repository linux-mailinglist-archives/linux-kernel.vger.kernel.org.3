Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653B4B2FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353753AbiBKV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350911AbiBKV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:56:18 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7499C6E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PtMlshHbNxasevngHJdiFI6D7HMUQyFJhAWUz3+d4n8=; b=mARjGR9Z4bLB3DupptZilz2/S3
        Z77rx5kF7RcM68boT+q9M+vAF3aFle0F4Wmtqf3bk+ZhCBkFuN84i99YA0Erhb6T5br+4wmz2bbEI
        eXgGW1otGXdJwDKE1HlAUYaL2j4Or33LDkI3M4fkxWwoAS05a79y8RrYnZ4gN8xqcNfyKEWTYan6k
        dCkI3uFM25ug6Aek/dO6GRKbmYUXYy9gB7B9htDablQtL2tp3D0Y49U5H6m/x2JIkY3prUfPYJQH/
        jCAPhTH0rGgdieZFws6cXa9Y1sxXqRMRUZVJLpXuFM727CvV7TT+2INcFmwFIhwp5rUjMf8MymHh+
        i0JLHx2g==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nIdtZ-0000U9-Uj; Fri, 11 Feb 2022 22:56:04 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com
Cc:     gpiccoli@igalia.com, akpm@linux-foundation.org, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, tony.luck@intel.com,
        vgoyal@redhat.com
Subject: [PATCH V5] panic: Move panic_print before kmsg dumpers
Date:   Fri, 11 Feb 2022 18:55:39 -0300
Message-Id: <20220211215539.822466-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is an interesting debug mechanism, but currently the print event
happens *after* kmsg_dump(), meaning that pstore, for example, cannot
collect a dmesg with the panic_print extra information.

This patch changes that in 2 ways:

(a) The panic_print setting allows to replay the existing kernel log
buffer to the console (bit 5), besides the extra information dump.
This functionality makes sense only at the end of the panic() function.
So, we hereby allow to distinguish the two situations by a new boolean
parameter in the function panic_print_sys_info().

(b) With the above change, we can safely call panic_print_sys_info()
before kmsg_dump(), allowing to dump the extra information when using
pstore or other kmsg dumpers.

The additional messages from panic_print could overwrite the oldest
messages when the buffer is full. The only reasonable solution is to
use a large enough log buffer, hence we added an advice into the kernel
parameters documentation about that.

Cc: Baoquan He <bhe@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V5:
* Rebased against next-20220211.
* Removed code dealing with kdump, based on Baoquan concerns.
  This was possible after asking Stephen to remove a patch from
  linux-next[0] to address Baoquan sugestions, so this version
  is more simple and doesn't ever panic_print before kdump, unless
  "crash_kexec_post_notifiers" is passed in the kernel cmdline.

[0] https://lore.kernel.org/lkml/c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com/

V4: https://lore.kernel.org/lkml/20220124203101.216051-1-gpiccoli@igalia.com/


 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/panic.c                                  | 13 +++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3c2b3e24e8f5..2cf7078eaa95 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3766,6 +3766,10 @@
 			bit 4: print ftrace buffer
 			bit 5: print all printk messages in buffer
 			bit 6: print all CPUs backtrace (if available in the arch)
+			*Be aware* that this option may print a _lot_ of lines,
+			so there are risks of losing older messages in the log.
+			Use this option carefully, maybe worth to setup a
+			bigger log buffer with "log_buf_len" along with this.
 
 	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
diff --git a/kernel/panic.c b/kernel/panic.c
index 3c3fb36d8d41..eb4dfb932c85 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(void)
+static void panic_print_sys_info(bool console_flush)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	if (console_flush) {
+		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+			console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		return;
+	}
 
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
@@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.35.0

