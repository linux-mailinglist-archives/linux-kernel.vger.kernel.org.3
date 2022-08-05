Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305D58AEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiHERa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiHERag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:30:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3471CFCC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659720627; x=1691256627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dM1WuVb6OYAaV0IBScAMcULpTf1F1saRBlYGODMl4Y=;
  b=O5NQFTmWrIh3RahCydOgJk4XM95UBTpl1FJzoA2lIfaeXtzKEqJZim0Y
   R99n+uoeLEnIBj9hLQCqjjBrCiyYPzwAoYiyvpHt5sN3PTPh/M1I7M5lJ
   dnH+am/nvT1wVZ7OecFSNyuyQBCDoSn8T0Mz97uM4l8Kk/vLVhQm8Hk0j
   ANFbj9PRCZnjGFKc62+ZZSZ25H09b9FceMULrN4w6YaMPozUw/He6zj/K
   KLThPCnZlVxievzZ8T/NTuCZHW492AWBHA6E9X+VtshR2+D+EFAjMdzNz
   D9lAc/3nAn8WQgYDzjSbl6MTHL8MX1DP9JI3Z7585aLoMgzVlpFkRUseX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270634129"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270634129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706678695"
Received: from amecham-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.242])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:26 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Jones <dsj@fb.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 4/5] x86,mm: print likely CPU at segfault time
Date:   Fri,  5 Aug 2022 10:30:08 -0700
Message-Id: <20220805173009.3128098-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220805173009.3128098-1-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

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
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 971977c438fc..82cf23975aa1 100644
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
2.35.3

