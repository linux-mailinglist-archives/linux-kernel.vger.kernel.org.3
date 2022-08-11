Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1D58F5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiHKCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKCtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:49:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA588DE5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186147; x=1691722147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3mtdp4qN/eR4cSknUV9LCDG9yQ6A0q0qYu0240TIDMY=;
  b=m70vrNtaQunnBQWw5wKEf0HAA6i+wRygruSjT1W9pUh5enPdjkrwF1v0
   a4+1PX7g/hDzVOwJo6E2tw38wlpU7rdW2Dtek+zgYZrqeCo/GYvLJzQjh
   vw5z2GvoYXbiGrS7824ftTboeGaifqXyBra8uNxEpc2OR674tpf8Z7m1+
   zqy78XtElbqB8HmqkDgMw6CSho2qRIW5WP3bEizN+U3whGQ/cAaPcEba4
   NGhnl9aCZDykbXXH/M3V5WMtKq4rxYT+so7KlDEhcVJklz0Okfybzw62a
   lA37D+cRtITcHN2htbGL/fjsCq36JOwPIoDFfhDQN7RxXN+QCWEyfeYBi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292033819"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292033819"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="731712491"
Received: from zjoseph-mobl3.amr.corp.intel.com (HELO localhost) ([10.209.123.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:06 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jones <dsj@fb.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] x86,mm: print likely CPU at segfault time
Date:   Wed, 10 Aug 2022 19:49:01 -0700
Message-Id: <20220811024903.178925-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220811024903.178925-1-ira.weiny@intel.com>
References: <20220811024903.178925-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
CC: Dave Jones <dsj@fb.com>
---
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa71a5d12e87..dbc6a2e08a96 100644
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

