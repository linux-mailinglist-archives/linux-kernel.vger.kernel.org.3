Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5514949E7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiA0Qmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiA0Qmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:42:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:42:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 303F461920
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836AC340E4;
        Thu, 27 Jan 2022 16:42:51 +0000 (UTC)
Date:   Thu, 27 Jan 2022 11:42:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ftrace: Have architectures opt-in for mcount build time
 sorting
Message-ID: <20220127114249.03b1b52b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

First S390 complained that the sorting of the mcount sections at build
time caused the kernel to crash on their architecture. Now PowerPC is
complaining about it too. And also ARM64 appears to be having issues.

It may be necessary to also update the relocation table for the values
in the mcount table. Not only do we have to sort the table, but also
update the relocations that may be applied to the items in the table.

If the system is not relocatable, then it is fine to sort, but if it is,
some architectures may have issues (although x86 does not as it shifts all
addresses the same).

Add a HAVE_BUILDTIME_MCOUNT_SORT that an architecture can set to say it is
safe to do the sorting at build time.

Also update the config to compile in build time sorting in the sorttable
code in scripts/ to depend on CONFIG_BUILDTIME_MCOUNT_SORT.

Link: https://lore.kernel.org/all/944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yinan Liu <yinan@linux.alibaba.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Fixes: 72b3942a173c ("scripts: ftrace - move the sort-processing in ftrace_init")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm/Kconfig     | 1 +
 arch/x86/Kconfig     | 1 +
 kernel/trace/Kconfig | 8 +++++++-
 scripts/Makefile     | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2724d986fa0..5256ebe57451 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -82,6 +82,7 @@ config ARM
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327d1eff..46080dea5dba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -186,6 +186,7 @@ config X86
 	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 752ed89a293b..7e5b92090faa 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -70,10 +70,16 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config HAVE_BUILDTIME_MCOUNT_SORT
+       bool
+       help
+         An architecture selects this if it sorts the mcount_loc section
+	 at build time.
+
 config BUILDTIME_MCOUNT_SORT
        bool
        default y
-       depends on BUILDTIME_TABLE_SORT && !S390
+       depends on HAVE_BUILDTIME_MCOUNT_SORT
        help
          Sort the mcount_loc section at build time.
 
diff --git a/scripts/Makefile b/scripts/Makefile
index b082d2f93357..cedc1f0e21d8 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -32,7 +32,7 @@ HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 endif
 
-ifdef CONFIG_DYNAMIC_FTRACE
+ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
-- 
2.33.0

