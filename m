Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1D5351B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbiEZPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiEZPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E3DE31F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BDADB82116
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08FC385A9;
        Thu, 26 May 2022 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653580544;
        bh=AmDwzwwzxvViiCR+9UtluKLmnpAfrzdfZ3Z6Q0Tpm9s=;
        h=Date:From:To:Cc:Subject:From;
        b=m6XeCsewpGXfyagoamgya5k4ERK03s7SFl+SW5WkEEk6/BJO1B1z1QbQsXMNY1Fab
         Z66uhFvnpO2Ktk/XUpDAfgd0vU4a1r1wh2dN1xJ5qGcJSeWq4gKJU/A3OyFQkSBEoh
         L8l6KvXhcksWxCkfY85j4Xs5TpKs6PjGYAsIj2qHA9R1jtIMXVx6HIqjWZOrD1wM+7
         /qHIN3f2V7Dl1TE0aTgqzP3blELa5V2G+H7v99ExN+kzlQvZcaVIIoNmfcrfMMKMBI
         lIeVmk52X2WbvQOygpjb6a+p+2jAsm9jvfUVJB5mdXDxKFjnRNVmtB+Q5rsHtIiJJW
         0C+Q8pZZ6EQww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 381594036D; Thu, 26 May 2022 12:55:42 -0300 (-03)
Date:   Thu, 26 May 2022 12:55:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI PATCH 1/1] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <Yo+i/j5+UtE9dcix@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To pick up the changes in:

  db1af12929c99d15 ("x86/msr-index: Define INTEGRITY_CAPABILITIES MSR")
  089be16d5992dd0b ("x86/msr: Add PerfCntrGlobal* registers")
  f52ba93190457aa2 ("tools/power turbostat: Add Power Limit4 support")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-05-26 12:50:01.228612839 -0300
  +++ after	2022-05-26 12:50:07.699776166 -0300
  @@ -116,6 +116,7 @@
   	[0x0000026f] = "MTRRfix4K_F8000",
   	[0x00000277] = "IA32_CR_PAT",
   	[0x00000280] = "IA32_MC0_CTL2",
  +	[0x000002d9] = "INTEGRITY_CAPS",
   	[0x000002ff] = "MTRRdefType",
   	[0x00000309] = "CORE_PERF_FIXED_CTR0",
   	[0x0000030a] = "CORE_PERF_FIXED_CTR1",
  @@ -176,6 +177,7 @@
   	[0x00000586] = "IA32_RTIT_ADDR3_A",
   	[0x00000587] = "IA32_RTIT_ADDR3_B",
   	[0x00000600] = "IA32_DS_AREA",
  +	[0x00000601] = "VR_CURRENT_CONFIG",
   	[0x00000606] = "RAPL_POWER_UNIT",
   	[0x0000060a] = "PKGC3_IRTL",
   	[0x0000060b] = "PKGC6_IRTL",
  @@ -260,6 +262,10 @@
   	[0xc0000102 - x86_64_specific_MSRs_offset] = "KERNEL_GS_BASE",
   	[0xc0000103 - x86_64_specific_MSRs_offset] = "TSC_AUX",
   	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
  +	[0xc000010f - x86_64_specific_MSRs_offset] = "AMD_DBG_EXTN_CFG",
  +	[0xc0000300 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS",
  +	[0xc0000301 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_CTL",
  +	[0xc0000302 - x86_64_specific_MSRs_offset] = "AMD64_PERF_CNTR_GLOBAL_STATUS_CLR",
   };

   #define x86_AMD_V_KVM_MSRs_offset 0xc0010000
  @@ -318,4 +324,5 @@
   	[0xc00102b4 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_STATUS",
   	[0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
   	[0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
  +	[0xc0010300 - x86_AMD_V_KVM_MSRs_offset] = "AMD_SAMP_BR_FROM",
   };
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
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index ee15311b6be1d99e..403e83b4adc88ea3 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -76,6 +76,8 @@
 
 /* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
 #define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_INTEGRITY_CAPS_BIT	  2
+#define MSR_IA32_CORE_CAPS_INTEGRITY_CAPS	  BIT(MSR_IA32_CORE_CAPS_INTEGRITY_CAPS_BIT)
 #define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
 #define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
 
@@ -154,6 +156,11 @@
 #define MSR_IA32_POWER_CTL		0x000001fc
 #define MSR_IA32_POWER_CTL_BIT_EE	19
 
+/* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
+#define MSR_INTEGRITY_CAPS			0x000002d9
+#define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
+#define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
 #define MSR_LBR_CORE_FROM		0x00000040
@@ -312,6 +319,7 @@
 
 /* Run Time Average Power Limiting (RAPL) Interface */
 
+#define MSR_VR_CURRENT_CONFIG	0x00000601
 #define MSR_RAPL_POWER_UNIT		0x00000606
 
 #define MSR_PKG_POWER_LIMIT		0x00000610
@@ -502,8 +510,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
@@ -524,6 +534,11 @@
 #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
 #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
 
+/* AMD Performance Counter Global Status and Control MSRs */
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
@@ -688,6 +703,10 @@
 #define MSR_IA32_PERF_CTL		0x00000199
 #define INTEL_PERF_CTL_MASK		0xffff
 
+/* AMD Branch Sampling configuration */
+#define MSR_AMD_DBG_EXTN_CFG		0xc000010f
+#define MSR_AMD_SAMP_BR_FROM		0xc0010300
+
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
 
-- 
2.35.1

