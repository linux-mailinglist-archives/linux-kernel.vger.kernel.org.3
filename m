Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEA48D9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiAMOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiAMOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:25:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080AC06173F;
        Thu, 13 Jan 2022 06:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9494761CF4;
        Thu, 13 Jan 2022 14:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAC3C36AEC;
        Thu, 13 Jan 2022 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642083902;
        bh=R7O26QARYFC2+NZtQgSc/PXXXQY3dDAFIVKM0Qllbvg=;
        h=Date:From:To:Cc:Subject:From;
        b=OkG66TkKqRTqNszT97b/LmZRUewvv11KTyGZZuhqqGnotd6VTVh4ZVyTaFJcQokZX
         XsY7HZxMKo5jDNSfCN67JOVuV3p06w86JLymXybeSazQwh9TP2PnLGA032BPo6dqzS
         EDJORS731uJP9iywevllvSawuzfQWCux1eH/XDzCOIjH2/4H2pFg35jCNlNoYC0631
         IVKke7WhJSvjs3EwfqjG3LbyuglkPamVFrthRquN2jEcfXxD5U/x1JVQYvNcgNSv+P
         oS9dJt6TuGBD8qgX5hZlbqYdjJdRy4FwPdgsM+apemR91Hk2o4CoWMg2wHdeH2KwvX
         QUunxcqGDVfZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1C97140C99; Thu, 13 Jan 2022 11:25:00 -0300 (-03)
Date:   Thu, 13 Jan 2022 11:25:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YeA2PAvHV+uHRhLj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick up the changes in:

  89aa94b4a218339b ("x86/msr: Add AMD CPPC MSR definitions")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-01-13 10:59:51.743416890 -0300
  +++ after	2022-01-13 11:00:00.776644178 -0300
  @@ -303,6 +303,11 @@
 	  [0xc0010299 - x86_AMD_V_KVM_MSRs_offset] = "AMD_RAPL_POWER_UNIT",
 	  [0xc001029a - x86_AMD_V_KVM_MSRs_offset] = "AMD_CORE_ENERGY_STATUS",
 	  [0xc001029b - x86_AMD_V_KVM_MSRs_offset] = "AMD_PKG_ENERGY_STATUS",
  +       [0xc00102b0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP1",
  +       [0xc00102b1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_ENABLE",
  +       [0xc00102b2 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP2",
  +       [0xc00102b3 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_REQ",
  +       [0xc00102b4 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_STATUS",
 	  [0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
 	  [0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
   };
  $

And this gets rebuilt:

  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  INSTALL  trace_plugins
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf

Now one can trace systemwide asking to see backtraces to where those
MSRs are being read/written with:

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<="
  Failed to set filter "(msr>=0xc00102b0 && msr<=) && (common_pid != 2612094 && common_pid != 3841)" on event msr:read_msr with 22 (Invalid argument)
  # ^C

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<=AMD_CPPC_STATUS"
  <SNIP>
  New filter for msr:read_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
  New filter for msr:write_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
  <SNIP>
  ^C[root@five ~]#

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

Cc: Huang Rui <ray.huang@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 01e2650b958591e0..3faf0f97edb1bcd3 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -486,6 +486,23 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* AMD Collaborative Processor Performance Control MSRs */
+#define MSR_AMD_CPPC_CAP1		0xc00102b0
+#define MSR_AMD_CPPC_ENABLE		0xc00102b1
+#define MSR_AMD_CPPC_CAP2		0xc00102b2
+#define MSR_AMD_CPPC_REQ		0xc00102b3
+#define MSR_AMD_CPPC_STATUS		0xc00102b4
+
+#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
+#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
+#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
+#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+
+#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
+#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
+#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
+#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.31.1


