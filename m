Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEE4EB41A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiC2Tag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbiC2Tac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44D51588
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 652A1615B0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631BCC340F2;
        Tue, 29 Mar 2022 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648582127;
        bh=QA66OBqsCc0mvxy3zkvoKTa+VHftZeLNnF1/dgQXJUg=;
        h=Date:From:To:Cc:Subject:From;
        b=tMrBT6/RJK7Wbk5NMR8gaopLBuIyzseKooXL6UbvFrUEU5KWYe9qhcaGAgeOivCQ5
         dGiFU17uvmwJx0mun8208UrKAAaMMSgpm607aIyad9KcBcTgBJUs87gP9T0JpdY0PX
         qzuVZKhh6mZMYGDfBgdq7iygpNrz7LUNCp2oI99goGD9YyyKnQzjZCkBUWyObVxUkf
         MbnBpaQDO8zUZQ7SO/zXmnji0uDxuKs/gU4HWuCDwkdxAmxhTn5Hkl/HZbaIf+NKoD
         ZG3kRYCCmn7VA1NiLbxiv/7n9tzJbxcm1+yHvC4aDnDzKPK0gE+j30UwZt9bCLjCkz
         kPYwJDXC2Jerw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E657640407; Tue, 29 Mar 2022 16:28:44 -0300 (-03)
Date:   Tue, 29 Mar 2022 16:28:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI PATCH 1/1] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YkNd7Ky+vi7H2Zl2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI: I'm carrying this on the perf tools tree.

- ARnaldo

---

To pick up the changes in:

  991625f3dd2cbc4b ("x86/ibt: Add IBT feature, MSR and #CP handling")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-03-29 16:23:07.678740040 -0300
  +++ after	2022-03-29 16:23:16.960978524 -0300
  @@ -220,6 +220,13 @@
   	[0x00000669] = "MC6_DEMOTION_POLICY_CONFIG",
   	[0x00000680] = "LBR_NHM_FROM",
   	[0x00000690] = "CORE_PERF_LIMIT_REASONS",
  +	[0x000006a0] = "IA32_U_CET",
  +	[0x000006a2] = "IA32_S_CET",
  +	[0x000006a4] = "IA32_PL0_SSP",
  +	[0x000006a5] = "IA32_PL1_SSP",
  +	[0x000006a6] = "IA32_PL2_SSP",
  +	[0x000006a7] = "IA32_PL3_SSP",
  +	[0x000006a8] = "IA32_INT_SSP_TAB",
   	[0x000006B0] = "GFX_PERF_LIMIT_REASONS",
   	[0x000006B1] = "RING_PERF_LIMIT_REASONS",
   	[0x000006c0] = "LBR_NHM_TO",
  $

And this gets rebuilt:

  CC      /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  LD      /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD      /tmp/build/perf/trace/beauty/perf-in.o
  CC      /tmp/build/perf/util/amd-sample-raw.o
  LD      /tmp/build/perf/util/perf-in.o
  LD      /tmp/build/perf/perf-in.o
  LINK    /tmp/build/perf/perf

Now one can trace systemwide asking to see backtraces to where those
MSRs are being read/written with:

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=IA32_U_CET && msr<=IA32_INT_SSP_TAB"
  ^C#

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=IA32_U_CET && msr<=IA32_INT_SSP_TAB"
  Using CPUID AuthenticAMD-25-21-0
  0x6a0
  0x6a8
  New filter for msr:read_msr: (msr>=0x6a0 && msr<=0x6a8) && (common_pid != 597499 && common_pid != 3313)
  0x6a0
  0x6a8
  New filter for msr:write_msr: (msr>=0x6a0 && msr<=0x6a8) && (common_pid != 597499 && common_pid != 3313)
  mmap size 528384B
  ^C#

Example with a frequent msr:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
  Using CPUID AuthenticAMD-25-21-0
  0x48
  New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  0x48
  New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
  mmap size 528384B
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
     0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       __switch_to_xtra ([kernel.kallsyms])
                                       __switch_to ([kernel.kallsyms])
                                       __schedule ([kernel.kallsyms])
                                       schedule ([kernel.kallsyms])
                                       futex_wait_queue_me ([kernel.kallsyms])
                                       futex_wait ([kernel.kallsyms])
                                       do_futex ([kernel.kallsyms])
                                       __x64_sys_futex ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
     0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       __switch_to_xtra ([kernel.kallsyms])
                                       __switch_to ([kernel.kallsyms])
                                       __schedule ([kernel.kallsyms])
                                       schedule_idle ([kernel.kallsyms])
                                       do_idle ([kernel.kallsyms])
                                       cpu_startup_entry ([kernel.kallsyms])
                                       secondary_startup_64_no_verify ([kernel.kallsyms])
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 0e7f303542bf35d6..0eb90d21049e84a2 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -205,6 +205,8 @@
 #define RTIT_CTL_DISRETC		BIT(11)
 #define RTIT_CTL_PTW_EN			BIT(12)
 #define RTIT_CTL_BRANCH_EN		BIT(13)
+#define RTIT_CTL_EVENT_EN		BIT(31)
+#define RTIT_CTL_NOTNT			BIT_ULL(55)
 #define RTIT_CTL_MTC_RANGE_OFFSET	14
 #define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
 #define RTIT_CTL_CYC_THRESH_OFFSET	19
@@ -360,11 +362,29 @@
 #define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
 #define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
 
-
 #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
 #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
 #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
 
+/* Control-flow Enforcement Technology MSRs */
+#define MSR_IA32_U_CET			0x000006a0 /* user mode cet */
+#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet */
+#define CET_SHSTK_EN			BIT_ULL(0)
+#define CET_WRSS_EN			BIT_ULL(1)
+#define CET_ENDBR_EN			BIT_ULL(2)
+#define CET_LEG_IW_EN			BIT_ULL(3)
+#define CET_NO_TRACK_EN			BIT_ULL(4)
+#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
+#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
+#define CET_SUPPRESS			BIT_ULL(10)
+#define CET_WAIT_ENDBR			BIT_ULL(11)
+
+#define MSR_IA32_PL0_SSP		0x000006a4 /* ring-0 shadow stack pointer */
+#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
+#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */
+#define MSR_IA32_PL3_SSP		0x000006a7 /* ring-3 shadow stack pointer */
+#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table */
+
 /* Hardware P state interface */
 #define MSR_PPERF			0x0000064e
 #define MSR_PERF_LIMIT_REASONS		0x0000064f
-- 
2.35.1

