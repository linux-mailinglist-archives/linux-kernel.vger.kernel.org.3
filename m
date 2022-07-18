Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6745788DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiGRRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGRRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:52:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222482D1D0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:52:14 -0700 (PDT)
Message-ID: <20220718173924.009884744@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658166732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vwqP5WUQAW1xn/6amUsV88j6aSa5liouTB2QQnE3Fc8=;
        b=IvWSNBdDb5mdn80M75hd8rLfVq9C/fwAm2s4aT1ecYap8AuceJ6PdhqUM6+d0QBqRP0b6a
        zbRFvXizHpm8vDoBdCttiFsR/MpcXN1xJSsbjx7st821GETEzz90+4JSGOx5HcmBmcPy/V
        +YWhE93cZJalQ3qe6jo25VyA0hIx2tB6KoQ3s+Bd3OzIxSZZI2XeUEdNsJfKrAdPLFxyBS
        jvQWHMGLZWCGcChM4VBFBRV8tel275c4y6BOM680vmLOegcBx+WqMOI+r66ekBZu0QViNN
        bj8vF0K9NsQB5UqLQ18BUUm0mCjs4aCgwnCDodGeol/7QmW6UuRE0zd5Xmpd1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658166732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vwqP5WUQAW1xn/6amUsV88j6aSa5liouTB2QQnE3Fc8=;
        b=1vt93dIYdDTRge1q76xZK2RqhjiYa+tqAkLTZDgal9z1PELjA+lSR7fErTZFfl5phoLG56
        55hT+xg/tTPUXdCw==
2Message-ID: <20220718173814.731702240@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch 3/3] x86/cpu: Re-enable stackprotector
References: <20220716230952.787452088@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 18 Jul 2022 19:52:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5416c2663517 ("x86: make sure load_percpu_segment has no
stackprotector") disabled the stackprotector for cpu/common.c because of
load_percpu_segment(). Back then the boot stack canary was initialized very
early in start_kernel(). Switching the per CPU area by loading the GDT
caused the stackprotector to fail with paravirt enabled kernels as the
GSBASE was not updated yet. In hindsight a wrong change because it would
have been sufficient to ensure that the canary is the same in both per CPU
areas.

Commit d55535232c3d ("random: move rand_initialize() earlier") moved the
stack canary initialization to a later point in the init sequence. As a
consequence the per CPU stack canary is 0 when switching the per CPU areas,
so there is no requirement anymore to exclude this file.

Add a comment to load_percpu_segment().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/Makefile |    3 ---
 arch/x86/kernel/cpu/common.c |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,9 +16,6 @@ KCOV_INSTRUMENT_perf_event.o := n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
 
-# Make sure load_percpu_segment has no stackprotector
-CFLAGS_common.o		:= -fno-stack-protector
-
 obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -751,6 +751,9 @@ void __init switch_to_direct_gdt(int cpu
 	 * wrmsrl() happens the early mapping is still valid. That means
 	 * the GSBASE update will lose any prior per CPU data which was
 	 * not copied over in setup_per_cpu_areas().
+	 *
+	 * This works even with stackprotector enabled because the
+	 * per CPU stack canary is 0 in both per CPU areas.
 	 */
 	if (IS_ENABLED(CONFIG_X86_64))
 		wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));

