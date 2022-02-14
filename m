Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571D4B52FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355018AbiBNOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:16:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiBNOQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:16:32 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4AC72
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V57R5a2O0zZ5gdcp4vIHQbVgGyyROcq/YIatDbB3aUU=; b=Bodhw4C6EJx6HuM+psJGR5tvbD
        2Z5aAwckyx0vclVEQnNQ9PK7h9WuPQGpAcdnDxpZa2g4/Se0JdrlxspAJF2HWaZLOTSqbzsdEDFaW
        IVidNF9bHmtvWXCKjo5pXFdUjoRRaKolsPRWhZE8S2agSZfpehediA1XPrX0jfbr20Cub0IKW3lOF
        fKN5XF9pnMkWMHxSoCMBUCl9DUT+Gh/UktxnK2fgYsmegLpV1YNNagi8RJ5pJCMDg7TIPbrMcm5L/
        X/xSUgG/gTDuZSqkZLdHlNmIojs+6C01U+6Pt4zIwPZiln9jHA6Q4eYnkZuFM9eUNNAY2wphft9oa
        4YNYBT7A==;
Received: from 201-27-34-205.dsl.telesp.net.br ([201.27.34.205] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nJc9G-0003w2-2s; Mon, 14 Feb 2022 15:16:14 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org
Cc:     gpiccoli@igalia.com, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
Date:   Mon, 14 Feb 2022 11:13:09 -0300
Message-Id: <20220214141308.841525-1-gpiccoli@igalia.com>
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

This patch changes that in 2 steps:

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

Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V6: Implemented a small suggestion from Baoquan in the commit
message; with that, added his Acked-By. (Thanks Baoquan!)
Notice that this is rebased against linux-next (next-20220211 branch).

V5: https://lore.kernel.org/lkml/20220211215539.822466-1-gpiccoli@igalia.com/

V4: https://lore.kernel.org/lkml/20220124203101.216051-1-gpiccoli@igalia.com/


Andrew, can we get that merged in the mm-tree, after getting [0]
removed from there? This one replaces [0]. Thanks!!

[0] https://ozlabs.org/~akpm/mmots/broken-out/panic-allow-printing-extra-panic-information-on-kdump.patch


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

