Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D68596E49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiHQMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHQMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:13:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D3BCAA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F5CB81D90
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF83C433D6;
        Wed, 17 Aug 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660738386;
        bh=xX7CZcwx16zQ5npVToI6lwOByIx2441xlG+tSU5KC64=;
        h=Date:From:To:Cc:Subject:From;
        b=CCIFAYj8LzB+JtgWLSQjc/JIhOOFH49b/MpZId7t6ebX31+nXeYJl5pYoiGQu2Nv3
         rUbZM0Vvg42yBxmwsPcy2D1W9y99ZJq86e61tmETK+CDSUOUL+Gsu0cVElpeCEYX5X
         l8eAzDRoE0qCVn/FwBKtg4RiqiWsxdXoxf5WRzrpPj+fnCYCppPJ9uGUhsEMwYTduo
         y61XMBZQ1y271yFJI/Mynb9ankK3ZOYx3ltmsbNuYXprP05oYdZF0/D/A+iJCz2Eu2
         MYDsb/4aB1WyLWoUbBzy9cY+igFD0LQnsoD0Ov/qpctt5x1qe58KSOoxuPmetiQWgv
         Xe9GpuNw7JoUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 454644035A; Wed, 17 Aug 2022 09:13:03 -0300 (-03)
Date:   Wed, 17 Aug 2022 09:13:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Like Xu <like.xu@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Hoo <robert.hu@linux.intel.com>
Subject: [PATCH FYI 1/1] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YvzbT24m2o5U/7+q@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick up the changes in:

  2b1299322016731d ("x86/speculation: Add RSB VM Exit protections")
  4af184ee8b2c0a69 ("tools/power turbostat: dump secondary Turbo-Ratio-Limit")
  4ad3278df6fe2b08 ("x86/speculation: Disable RRSBA behavior")
  d7caac991feeef1b ("x86/cpu/amd: Add Spectral Chicken")
  6ad0ad2bf8a67e27 ("x86/bugs: Report Intel retbleed vulnerability")
  c59a1f106f5cd484 ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
  465932db25f36648 ("x86/cpu: Add new VMX feature, Tertiary VM-Execution control")
  027bbb884be006b0 ("KVM: x86/speculation: Disable Fill buffer clear within guests")
  51802186158c74a0 ("x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-08-17 09:05:13.938246475 -0300
  +++ after	2022-08-17 09:05:22.221455851 -0300
  @@ -161,6 +161,7 @@
   	[0x0000048f] = "IA32_VMX_TRUE_EXIT_CTLS",
   	[0x00000490] = "IA32_VMX_TRUE_ENTRY_CTLS",
   	[0x00000491] = "IA32_VMX_VMFUNC",
  +	[0x00000492] = "IA32_VMX_PROCBASED_CTLS3",
   	[0x000004c1] = "IA32_PMC0",
   	[0x000004d0] = "IA32_MCG_EXT_CTL",
   	[0x00000560] = "IA32_RTIT_OUTPUT_BASE",
  @@ -212,6 +213,7 @@
   	[0x0000064D] = "PLATFORM_ENERGY_STATUS",
   	[0x0000064e] = "PPERF",
   	[0x0000064f] = "PERF_LIMIT_REASONS",
  +	[0x00000650] = "SECONDARY_TURBO_RATIO_LIMIT",
   	[0x00000658] = "PKG_WEIGHTED_CORE_C0_RES",
   	[0x00000659] = "PKG_ANY_CORE_C0_RES",
   	[0x0000065A] = "PKG_ANY_GFXE_C0_RES",
  $

Now one can trace systemwide asking to see backtraces to where those
MSRs are being read/written, see this example with a previous update:

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
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Like Xu <like.xu@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Hoo <robert.hu@linux.intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index e057e039173cb627..6674bdb096f346d9 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -235,6 +235,12 @@
 #define PERF_CAP_PT_IDX			16
 
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
+#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
+#define PERF_CAP_ARCH_REG              BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT           0xf00
+#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
+#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
 
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
@@ -392,6 +398,7 @@
 #define MSR_TURBO_ACTIVATION_RATIO	0x0000064C
 
 #define MSR_PLATFORM_ENERGY_STATUS	0x0000064D
+#define MSR_SECONDARY_TURBO_RATIO_LIMIT	0x00000650
 
 #define MSR_PKG_WEIGHTED_CORE_C0_RES	0x00000658
 #define MSR_PKG_ANY_CORE_C0_RES		0x00000659
@@ -1022,6 +1029,7 @@
 #define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
+#define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
 /* VMX_BASIC bits and bitmasks */
 #define VMX_BASIC_VMCS_SIZE_SHIFT	32
-- 
2.37.1

