Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB0475952
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhLONFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:05:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhLONFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:05:50 -0500
Date:   Wed, 15 Dec 2021 13:05:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639573549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AREgfYQ1elWlBA2GPILJxdXeZBAcNpElx1YJBu/THno=;
        b=4CryAovInLv9aydshVaOxeDs76z3Kz/WZwuFYoXe9dnL5SGyTMXoCeYI0X1oC1JRySqtYS
        eBiWefzs99EW49dvpMwfT0OHAUAJ61T2XZD+a1QLrv2BMH5DmYup4JEMv+utuYwwLL/7mi
        MFckpWVReWgh2pq+cwygLGXKD/OZ5RrAF3fMoAL9ymFv8B9aRl9wKacybWtdNK8sFWJTXB
        7qdo5E0xjFX+N2/rIy6UIg2Mr3fPwNNxDs1Ccb1rkiOTYpA6gDz3kqt2MM0jGVTOYGBss0
        a2bKwrOBykNQWPOw6pUp6N8TpeVfYiuTzdFsHJoN6wc8KIHMe3rGZFkzMjPxKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639573549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AREgfYQ1elWlBA2GPILJxdXeZBAcNpElx1YJBu/THno=;
        b=dWQYNXtP2VxK2jGY8LIUS7FeXnDKHJdCIg7YrVkCwZdrJftwNlTPAIQDq+Uu0/XUGf+gkS
        09JbV6oKmyBMzjCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/boot: Pull up cmdline preparation and
 early param parsing"
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211213112757.2612-3-bp@alien8.de>
References: <20211213112757.2612-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163957354793.23020.4763398090923789375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fbe6183998546f8896ee0b620ece86deff5a2fd1
Gitweb:        https://git.kernel.org/tip/fbe6183998546f8896ee0b620ece86deff5a2fd1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 13 Dec 2021 12:27:56 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Dec 2021 11:38:57 +01:00

Revert "x86/boot: Pull up cmdline preparation and early param parsing"

This reverts commit 8d48bf8206f77aa8687f0e241e901e5197e52423.

It turned out to be a bad idea as it broke supplying mem= cmdline
parameters due to parse_memopt() requiring preparatory work like setting
up the e820 table in e820__memory_setup() in order to be able to exclude
the range specified by mem=.

Pulling that up would've broken Xen PV again, see threads at

  https://lkml.kernel.org/r/20210920120421.29276-1-jgross@suse.com

due to xen_memory_setup() needing the first reservations in
early_reserve_memory() - kernel and initrd - to have happened already.

This could be fixed again by having Xen do those reservations itself...

Long story short, revert this and do a simpler fix in a later patch.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211213112757.2612-3-bp@alien8.de
---
 arch/x86/kernel/setup.c | 66 ++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be7..49b596d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,28 +742,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
-static char *prepare_command_line(void)
-{
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-
-	parse_early_param();
-
-	return command_line;
-}
-
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -853,23 +831,6 @@ void __init setup_arch(char **cmdline_p)
 	x86_init.oem.arch_setup();
 
 	/*
-	 * x86_configure_nx() is called before parse_early_param() (called by
-	 * prepare_command_line()) to detect whether hardware doesn't support
-	 * NX (so that the early EHCI debug console setup can safely call
-	 * set_fixmap()). It may then be called again from within noexec_setup()
-	 * during parsing early parameters to honor the respective command line
-	 * option.
-	 */
-	x86_configure_nx();
-
-	/*
-	 * This parses early params and it needs to run before
-	 * early_reserve_memory() because latter relies on such settings
-	 * supplied as early params.
-	 */
-	*cmdline_p = prepare_command_line();
-
-	/*
 	 * Do some memory reservations *before* memory is added to memblock, so
 	 * memblock allocations won't overwrite it.
 	 *
@@ -902,6 +863,33 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
+#ifdef CONFIG_CMDLINE_BOOL
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if (builtin_cmdline[0]) {
+		/* append boot loader cmdline to builtin */
+		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+#endif
+#endif
+
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
+	/*
+	 * x86_configure_nx() is called before parse_early_param() to detect
+	 * whether hardware doesn't support NX (so that the early EHCI debug
+	 * console setup can safely call set_fixmap()). It may then be called
+	 * again from within noexec_setup() during parsing early parameters
+	 * to honor the respective command line option.
+	 */
+	x86_configure_nx();
+
+	parse_early_param();
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
