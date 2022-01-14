Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6F48EFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiANSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:31:47 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:56774 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbiANSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RTzI+d+fMBcYInPYiT4CX8GwWa7IMrsmasiltAjndlM=; b=WP6rf8fS1YOOJR1rMGrP4Pzyia
        OZirfWdCjlO5B2/gvw73TjANJSM/B4pmejtWBRQwz+kRgUHriClZF4mht3/eUjW3+Fv/GPNlttNyN
        ajKcP+YkJNx6aIePUEAz4X+myaHZeRtkFwbiO+RX4IrPLXjdFtsEVDlUmIyGYB5X7D+1dYrrzheBz
        tJ1kbU6V5q97N62GD6d+SvQEW1CmGVDst07mF/3MC0yMXKqRP2iXKB/dvITUUPj8jqOcZm+oaKvul
        1z//7peftuOzsoPe0Vjzb9qrgcggcSXBrw2tHacZsxp61XPrJcWfly7W99kX1S8gCmXefw2xBHEeN
        Sb2Qo65A==;
Received: from [177.215.76.11] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1n8RMR-0003yM-Ix; Fri, 14 Jan 2022 19:31:40 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pmladek@suse.com
Cc:     gpiccoli@igalia.com, kernel@gpiccoli.net, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        feng.tang@intel.com, kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
Date:   Fri, 14 Jan 2022 15:30:46 -0300
Message-Id: <20220114183046.428796-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is a pretty interesting debug mechanism, but currently the print
event happens *after* kmsg_dump(), meaning that pstore, for example,
cannot collect a dmesg with the panic_print information.

This patch changes that in 2 ways:

(a) First, after a good discussion with Petr in the mailing-list[0],
he noticed that one specific setting of panic_print (the console replay,
bit 5) should not be executed before console proper flushing; hence we
hereby split the panic_print_sys_info() function in upper and lower
portions: if the parameter "after_kmsg_dumpers" is passed, only bit 5
(the console replay thing) is evaluated and the function returns - this
is the lower portion. Otherwise all other bits are checked and the
function prints the user required information; this is the upper/earlier
mode.

(b) With the above change, we can safely insert a panic_print_sys_info()
call up some lines, in order kmsg_dump() accounts this new information
and exposes it through pstore or other kmsg dumpers. Notice that this
new earlier call doesn't set "after_kmsg_dumpers" so we print the
information set by user in panic_print, except the console replay that,
if set, will be executed after the console flushing.
Also, worth to notice we needed to guard the panic_print_sys_info(false)
calls against double print - we use kexec_crash_loaded() helper for that
(see discussion [1] for more details).

In the first version of this patch we discussed the risks in the
mailing-list [0], and seems this approach is the least terrible,
despite still having risks of polluting the log with the bulk of
information that panic_print may bring, losing older messages.
In order to attenuate that, we've added a warning in the
kernel-parameters.txt so that users enabling this mechanism consider
to increase the log buffer size via "log_buf_len" as well.

Finally, another decision was to keep 2 panic_print_sys_info(false)
calls (instead of just bringing it up some code lines and keep a single
call) due to the panic notifiers: if kdump is not set, currently the
panic_print information is collected after the notifiers and since
it's a bit safer this way, we decided to keep it as is, only modifying
the kdump case as per the previous commit [2] (see more details about
this discussion also in thread [1]).

[0] https://lore.kernel.org/lkml/20211230161828.121858-1-gpiccoli@igalia.com
[1] https://lore.kernel.org/lkml/f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5613b7538f69

Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V3: Added a guard in the 2nd panic_print_sys_info(false) to prevent
double print - thanks for catching this Petr!

I didn't implement your final suggestion Petr, i.e., putting the first
panic_print_sys_info(false) inside the if (!_crash_kexec_post_notifiers)
block, and the reason is that when we do this, there's 4 cases to consider:

!kexec_crash_load() && !_crash_kexec_post_notifiers
kexec_crash_load() && !_crash_kexec_post_notifiers
kexec_crash_load() && _crash_kexec_post_notifiers
!kexec_crash_load() && _crash_kexec_post_notifiers

The 3rd case, which means user enabled kdump and set the post_notifiers
in the cmdline fails - we end-up not reaching panic_print_sys_info(false)
in this case, unless we add another variable to track the function call
and prevent double print. My preference was to keep the first call
as introduced by commit [2] (mentioned above) and not rely in another
variable.
Thanks again for the great reviews,

Guilherme


V2: https://lore.kernel.org/lkml/20220106212835.119409-1-gpiccoli@igalia.com



 .../admin-guide/kernel-parameters.txt         |  4 ++++
 kernel/panic.c                                | 22 ++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

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
index 41ecf9ab824a..4ae712665f75 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -148,10 +148,13 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(void)
+static void panic_print_sys_info(bool after_kmsg_dumpers)
 {
-	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+	if (after_kmsg_dumpers) {
+		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+			console_flush_on_panic(CONSOLE_REPLAY_ALL);
+		return;
+	}
 
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
@@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
 	 * show some extra information on kernel log if it was set...
 	 */
 	if (kexec_crash_loaded())
-		panic_print_sys_info();
+		panic_print_sys_info(false);
 
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
@@ -283,6 +286,15 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/*
+	 * If kexec_crash_loaded() is true and we still reach this point,
+	 * kernel would double print the information from panic_print; so
+	 * let's guard against that possibility (it happens if kdump users
+	 * also set crash_kexec_post_notifiers in the command-line).
+	 */
+	if (!kexec_crash_loaded())
+		panic_print_sys_info(false);
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -313,7 +325,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
+	panic_print_sys_info(true);
 
 	if (!panic_blink)
 		panic_blink = no_blink;
-- 
2.34.1

