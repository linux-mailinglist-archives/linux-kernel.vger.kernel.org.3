Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA85002CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiDMXwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiDMXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:52:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6D3E0CB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so4022248pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne4qFtf3GJQipO4FTbwSt0HMIWWwnK+WNSFq5/MGiNw=;
        b=eUWAx4I43h3LKG4CVs0awq/ZvXdxGpOnQoYb7Jiob3NtEDVwvuzVKWXPtg52U64GeD
         8Ag/ew99NyVY+qEqe21x0EyFawjZn268tpE9ddhAUFM+MjBMsOvPKukBY6EkGzB/DA7r
         Jb01y0XfTEg1nZnl6+N5s7jp7g14PaebsalyqID6BPamXtLsnmVxltkahMqaWEDEGrcR
         ByZAE7gi5bUbuWg3gCMWutFo0HNkoPh1P95ku3dVCvjhZapcbnVEzxe36Kb0fSde1PYz
         1FaUtYBxHbO0xopyePD8tjhlG412Gb5KCYmpkHyigYc7sDMq7yH89bA0fAuG5eslDCSr
         tMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne4qFtf3GJQipO4FTbwSt0HMIWWwnK+WNSFq5/MGiNw=;
        b=IQlmF6uhtQD4aVnxgIp67vLYpNh+LagG5+c2pUIC5+LDpA+0hYh5v0hhVVcE9bV26f
         PrjA3inD+mPunlCTwgfcPTZwtwXMpvtlwdYZzD+XnOzAAEvmhSGRZ0F/qf/mIRbEas58
         BxsvDbBBvL3zHHf4Bpw80lujRxN7mOhcTkwNvZ+P6kTQeOaULItT+0GtiQGPQmNWmEXB
         LFMsWYlK/FtSD1RZUzFunUeV3JXKXiZI6zwi6BUGSUsu3vDWQhh4J8T6KCyYcpp/sThO
         P8ilVsebOPSttFPQ2ZumoQwL+YtumTgd2U0N9aQaiZ+oOjCCF3u5lkXmrkuZSMz2LPy5
         7iLQ==
X-Gm-Message-State: AOAM531udQhZ6Prj33pz9RE8Ycok+iLDxZHSx5i6r22+yCMS5eMn6CUW
        tRpO0wr+4CEpWsTGiVZkrHhGwNJYtFg=
X-Google-Smtp-Source: ABdhPJySI1UgQSjJ9AdU1Npg9rukCpn/j8CTf+vbtoBN4O7BT2AXT/Jz0Aoh/H4004jmXb9+SfXNrA==
X-Received: by 2002:a17:90b:1b44:b0:1cd:49b8:42b8 with SMTP id nv4-20020a17090b1b4400b001cd49b842b8mr683013pjb.102.1649893790370;
        Wed, 13 Apr 2022 16:49:50 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:389b:6ba3:7cbd:d8d])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm197075pfl.176.2022.04.13.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:49:49 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/3] xtensa: noMMU: allow handling protection faults
Date:   Wed, 13 Apr 2022 16:49:30 -0700
Message-Id: <20220413234930.1212335-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
References: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many xtensa CPU cores without full MMU still have memory protection
features capable of raising exceptions for invalid instruction
fetches/data access. Allow handling such exceptions. This improves
behavior of processes that pass invalid memory pointers to syscalls in
noMMU configs: in case of exception the kernel instead of killing the
process is now able to return -EINVAL from a syscall.

Introduce CONFIG_PFAULT that controls whether protection fault code is
enabled and register handlers for common memory protection exceptions
when it is enabled.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig        | 11 +++++++++++
 arch/xtensa/kernel/traps.c | 20 ++++++++++----------
 arch/xtensa/mm/Makefile    |  3 ++-
 arch/xtensa/mm/fault.c     |  4 ++++
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index bd113bc6e192..bca2763495a1 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -79,6 +79,7 @@ config STACKTRACE_SUPPORT
 
 config MMU
 	def_bool n
+	select PFAULT
 
 config HAVE_XTENSA_GPIO32
 	def_bool n
@@ -178,6 +179,16 @@ config XTENSA_FAKE_NMI
 
 	  If unsure, say N.
 
+config PFAULT
+	bool "Handle protection faults" if EXPERT && !MMU
+	default y
+	help
+	  Handle protection faults. MMU configurations must enable it.
+	  noMMU configurations may disable it if used memory map never
+	  generates protection faults or faults are always fatal.
+
+	  If unsure, say Y.
+
 config XTENSA_UNALIGNED_USER
 	bool "Unaligned memory access in user space"
 	help
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 9345007d474d..82ced7b25b77 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -110,21 +110,21 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 { EXCCAUSE_UNALIGNED,		KRNL,	   fast_unaligned },
 #endif
 #ifdef CONFIG_MMU
-{ EXCCAUSE_ITLB_MISS,		0,	   do_page_fault },
-{ EXCCAUSE_ITLB_MISS,		USER|KRNL, fast_second_level_miss},
+{ EXCCAUSE_ITLB_MISS,			0,	   do_page_fault },
+{ EXCCAUSE_ITLB_MISS,			USER|KRNL, fast_second_level_miss},
+{ EXCCAUSE_DTLB_MISS,			USER|KRNL, fast_second_level_miss},
+{ EXCCAUSE_DTLB_MISS,			0,	   do_page_fault },
+{ EXCCAUSE_STORE_CACHE_ATTRIBUTE,	USER|KRNL, fast_store_prohibited },
+#endif /* CONFIG_MMU */
+#ifdef CONFIG_PFAULT
 { EXCCAUSE_ITLB_MULTIHIT,		0,	   do_multihit },
-{ EXCCAUSE_ITLB_PRIVILEGE,	0,	   do_page_fault },
-/* EXCCAUSE_SIZE_RESTRICTION unhandled */
+{ EXCCAUSE_ITLB_PRIVILEGE,		0,	   do_page_fault },
 { EXCCAUSE_FETCH_CACHE_ATTRIBUTE,	0,	   do_page_fault },
-{ EXCCAUSE_DTLB_MISS,		USER|KRNL, fast_second_level_miss},
-{ EXCCAUSE_DTLB_MISS,		0,	   do_page_fault },
 { EXCCAUSE_DTLB_MULTIHIT,		0,	   do_multihit },
-{ EXCCAUSE_DTLB_PRIVILEGE,	0,	   do_page_fault },
-/* EXCCAUSE_DTLB_SIZE_RESTRICTION unhandled */
-{ EXCCAUSE_STORE_CACHE_ATTRIBUTE,	USER|KRNL, fast_store_prohibited },
+{ EXCCAUSE_DTLB_PRIVILEGE,		0,	   do_page_fault },
 { EXCCAUSE_STORE_CACHE_ATTRIBUTE,	0,	   do_page_fault },
 { EXCCAUSE_LOAD_CACHE_ATTRIBUTE,	0,	   do_page_fault },
-#endif /* CONFIG_MMU */
+#endif
 /* XCCHAL_EXCCAUSE_FLOATING_POINT unhandled */
 #if XTENSA_HAVE_COPROCESSOR(0)
 COPROCESSOR(0),
diff --git a/arch/xtensa/mm/Makefile b/arch/xtensa/mm/Makefile
index f7fb08ae768f..44153a335951 100644
--- a/arch/xtensa/mm/Makefile
+++ b/arch/xtensa/mm/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-y			:= init.o misc.o
-obj-$(CONFIG_MMU)	+= cache.o fault.o ioremap.o mmu.o tlb.o
+obj-$(CONFIG_PFAULT)	+= fault.o
+obj-$(CONFIG_MMU)	+= cache.o ioremap.o mmu.o tlb.o
 obj-$(CONFIG_HIGHMEM)	+= highmem.o
 obj-$(CONFIG_KASAN)	+= kasan_init.o
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 01e66da4a6b0..16f0a5ff5799 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -25,6 +25,7 @@ void bad_page_fault(struct pt_regs*, unsigned long, int);
 
 static void vmalloc_fault(struct pt_regs *regs, unsigned int address)
 {
+#ifdef CONFIG_MMU
 	/* Synchronize this task's top level page-table
 	 * with the 'reference' page table.
 	 */
@@ -71,6 +72,9 @@ static void vmalloc_fault(struct pt_regs *regs, unsigned int address)
 
 bad_page_fault:
 	bad_page_fault(regs, address, SIGKILL);
+#else
+	WARN_ONCE(1, "%s in noMMU configuration\n", __func__);
+#endif
 }
 /*
  * This routine handles page faults.  It determines the address,
-- 
2.30.2

