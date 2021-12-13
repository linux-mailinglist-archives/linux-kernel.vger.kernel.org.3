Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7B472B59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhLML2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:28:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37402 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhLML2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:28:01 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB0901EC0505;
        Mon, 13 Dec 2021 12:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639394879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcxSBSqU45k/Njt3p5jtMil09vVThO25BVYEC466cyM=;
        b=IaBR1iNiyiFz9GkBebWTgO5v7DHLtPPJrt/L31OmEBrqpPk3K+WZiyFoAXEQya6mmmXv9v
        8T87fWuiKVzMTmeP+uIttCVikhz4/69crb9sk/U9SffX/gcHMoNt080pcdDJY28R/vK68Z
        6SfnRagT7TxUkvWoJp/9bw7RNxbnxdg=
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        John Dorminy <jdorminy@redhat.com>, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Subject: [PATCH 2/3] Revert "x86/boot: Pull up cmdline preparation and early param parsing"
Date:   Mon, 13 Dec 2021 12:27:56 +0100
Message-Id: <20211213112757.2612-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211213112757.2612-1-bp@alien8.de>
References: <YbcTgQdTpJAHAZw4@zn.tnic>
 <20211213112757.2612-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
---
 arch/x86/kernel/setup.c | 66 +++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be738ae7..49b596db5631 100644
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
@@ -852,23 +830,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.oem.arch_setup();
 
-	/*
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
 	/*
 	 * Do some memory reservations *before* memory is added to memblock, so
 	 * memblock allocations won't overwrite it.
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
-- 
2.29.2

