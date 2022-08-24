Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC859F851
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiHXLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiHXLEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:04:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946FA82863;
        Wed, 24 Aug 2022 04:03:59 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661339036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdNgLL0A/P6ZvzEWCRAA/ux/k6HbducHT1qttsle6qQ=;
        b=LRJU4H9RnIJFoLmBfCB2eUUjPqyWrVZCJ8MLDo+lAikKC38sHXsCAUlqji4ntrFiUJAjie
        AXlnW3gX0RtTmuE8daKKha+jBv+nnuH1lPlAC6gmYiqBjztUb8NrtUkZCFC2hRuhhphY5v
        dx723Vx2Tao7XJI9P4UYYMI9krAsliFu9dIaTtMkNRxdYfd4RKRFu1VpU82ey25RMx8lPk
        /one52ulhrU6X9pLg/qm3HbPnhrixMn3EWAxwGmAfHhI0e+4aXKsFVQzjdWHq2+F+A0X6L
        XlcXOX1Q56lql+m5+5r2y0WwxrxnnMyRUm4afYMNBXqVZNle0bJFkuUeB5ZIpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661339036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdNgLL0A/P6ZvzEWCRAA/ux/k6HbducHT1qttsle6qQ=;
        b=LZHP/LCNjzV0CSwqi1VPt0NxzyIUEMs2POs8KPEQj0vceha7I00QnPzNQwg0Vft3YL4Wet
        RHlJLKycu3cDkkCw==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Print likely CPU at segfault time
Cc:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220805101644.2e674553@imladris.surriel.com>
References: <20220805101644.2e674553@imladris.surriel.com>
MIME-Version: 1.0
Message-ID: <166133903521.401.14260536257655968606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c926087eb38520b268515ae1a842db6db62554cc
Gitweb:        https://git.kernel.org/tip/c926087eb38520b268515ae1a842db6db62554cc
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 05 Aug 2022 10:16:44 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 24 Aug 2022 12:48:05 +02:00

x86/mm: Print likely CPU at segfault time

In a large enough fleet of computers, it is common to have a few bad CPUs.
Those can often be identified by seeing that some commonly run kernel code,
which runs fine everywhere else, keeps crashing on the same CPU core on one
particular bad system.

However, the failure modes in CPUs that have gone bad over the years are
often oddly specific, and the only bad behavior seen might be segfaults
in programs like bash, python, or various system daemons that run fine
everywhere else.

Add a printk() to show_signal_msg() to print the CPU, core, and socket
at segfault time.

This is not perfect, since the task might get rescheduled on another
CPU between when the fault hit, and when the message is printed, but in
practice this has been good enough to help people identify several bad
CPU cores.

For example:

  segfault[1349]: segfault at 0 ip 000000000040113a sp 00007ffc6d32e360 error 4 in \
	  segfault[401000+1000] likely on CPU 0 (core 0, socket 0)

This printk can be controlled through /proc/sys/debug/exception-trace.

  [ bp: Massage a bit, add "likely" to the printed line to denote that
    the CPU number is not always reliable. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220805101644.2e674553@imladris.surriel.com
---
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa71a5d..a498ae1 100644
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
+	printk(KERN_CONT " likely on CPU %d (core %d, socket %d)", cpu,
+	       topology_core_id(cpu), topology_physical_package_id(cpu));
+
+
 	printk(KERN_CONT "\n");
 
 	show_opcodes(regs, loglvl);
