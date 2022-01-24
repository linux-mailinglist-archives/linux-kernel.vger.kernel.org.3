Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3444995BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442511AbiAXUyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:54:43 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:50490 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356443AbiAXUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6pevDcO0wLh96dxOIBNDWu82Lg3rIDJDDSL1EYCM9a0=; b=pJzJFN+/OMZxc+OBdMyyIXGZ7B
        9jwOFYr5z1BrQ3FIxAjeWdRWg2z5CEkkVnE7BMnYReFxu3nMrh/i3tjkoCiD04+DSmnjQsqEs1FOL
        /3WxKUAjjBni6jNU8xD8Y5eNXmF6npv3sYl6Q17mHC3Ad2aY7WtijKAsFAlpE9LxUg7p8joMd23YK
        5XZ2PdkJO8yjj65ktc+cMPzUnDlDuROMasXHsiWBa177k1XloSgRHM4CIqkZiw+rHhiSCECk6r/CD
        Be2QjuS21lj5HfCYNs8L1qW1rPh6QVWXZK5S/eDtAvNH9UUzUl0pH15JDhvhf+LoS4CQT5P2y7sJ5
        Xhho3DKQ==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nC5zv-000Azw-CN; Mon, 24 Jan 2022 21:31:32 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com
Cc:     gpiccoli@igalia.com, akpm@linux-foundation.org, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, tony.luck@intel.com,
        vgoyal@redhat.com
Subject: [PATCH V4] panic: Move panic_print before kmsg dumpers
Date:   Mon, 24 Jan 2022 17:31:01 -0300
Message-Id: <20220124203101.216051-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Finally, some panic notifiers might reset watchdogs, like RCU or hung
task detector. Due to that, it's optimal to dump the extra information
from panic_print after the notifiers, when possible. Sometimes it's not
possible though - for example, when users have kdump set but don't pass
"crash_kexec_post_notifiers" in the kernel command-line. For this
reason, we kept 2 calls for panic_print_sys_info().

Cc: Baoquan He <bhe@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V4:
* Addressed feedback from Petr (thanks!), by refactoring the commit message
to be more direct plus his suggestions to improve code path and the comment.

* Addressed feedback from Baoquan (thanks!) about the new boolean parameter
name on panic_print_sys_info().

V3: https://lore.kernel.org/lkml/20220114183046.428796-1-gpiccoli@igalia.com

V2: https://lore.kernel.org/lkml/20220106212835.119409-1-gpiccoli@igalia.com

V1: https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli@igalia.com


 .../admin-guide/kernel-parameters.txt         |  4 +++
 kernel/panic.c                                | 34 ++++++++++++-------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a069d8fe2fee..0f5cbe141bfd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3727,6 +3727,10 @@
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
index 41ecf9ab824a..b274e6c241d9 100644
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
@@ -244,22 +247,20 @@ void panic(const char *fmt, ...)
 	 */
 	kgdb_panic(buf);
 
-	/*
-	 * If we have a kdump kernel loaded, give a chance to panic_print
-	 * show some extra information on kernel log if it was set...
-	 */
-	if (kexec_crash_loaded())
-		panic_print_sys_info();
-
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
-	 * everything else.
+	 * everything else. Also, give a chance to panic_print show some extra
+	 * information on kernel log if it was set...
+	 *
 	 * If we want to run this after calling panic_notifiers, pass
 	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
 	if (!_crash_kexec_post_notifiers) {
+		if (kexec_crash_loaded())
+			panic_print_sys_info(false);
+
 		__crash_kexec(NULL);
 
 		/*
@@ -283,6 +284,15 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/*
+	 * If a crash kernel is not loaded (or if it's loaded but we still
+	 * want to allow the panic notifiers), then we dump panic_print after
+	 * the notifiers - some notifiers disable watchdogs, for example, so
+	 * we reduce the risk of lockups/hangs or garbled output this way.
+	 */
+	if (_crash_kexec_post_notifiers || !kexec_crash_loaded())
+		panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -313,7 +323,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.34.1

