Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE96658AC45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiHEORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiHEOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:16:58 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F517E2D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:16:57 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJy8A-0001eC-DC;
        Fri, 05 Aug 2022 10:16:50 -0400
Date:   Fri, 5 Aug 2022 10:16:44 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <20220805101644.2e674553@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a large enough fleet of computers, it is common to have a few bad CPUs.
Those can often be identified by seeing that some commonly run kernel code,
which runs fine everywhere else, keeps crashing on the same CPU core on one
particular bad system.

However, the failure modes in CPUs that have gone bad over the years are
often oddly specific, and the only bad behavior seen might be segfaults
in programs like bash, python, or various system daemons that run fine
everywhere else.

Add a printk() to show_signal_msg() to print the CPU, core, and socket
at segfault time. This is not perfect, since the task might get rescheduled
on another CPU between when the fault hit, and when the message is printed,
but in practice this has been good enough to help us identify several bad
CPU cores.

segfault[1349]: segfault at 0 ip 000000000040113a sp 00007ffc6d32e360 error 4 in segfault[401000+1000] on CPU 0 (core 0, socket 0)

This printk can be controlled through /proc/sys/debug/exception-trace

Signed-off-by: Rik van Riel <riel@surriel.com>
CC: Dave Jones <dsj@fb.com>
---
v3: READ_ONCE around raw_smp_processor_id() does not work, lets just omit that
    instead of making the code harder to read

 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fad8faa29d04..c7a5bbf40367 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
 	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
+	/* This is a racy snapshot, but it's better than nothing. */
+	int cpu = raw_smp_processor_id();
 
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
@@ -782,6 +784,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 	print_vma_addr(KERN_CONT " in ", regs->ip);
 
+	/*
+	 * Dump the likely CPU where the fatal segfault happened.
+	 * This can help identify faulty hardware.
+	 */
+	printk(KERN_CONT " on CPU %d (core %d, socket %d)", cpu,
+	       topology_core_id(cpu), topology_physical_package_id(cpu));
+
+
 	printk(KERN_CONT "\n");
 
 	show_opcodes(regs, loglvl);
-- 
2.37.1


