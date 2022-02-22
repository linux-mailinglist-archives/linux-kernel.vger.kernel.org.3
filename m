Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5C4C03FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiBVVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiBVVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:42:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FEE4D9F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C786174A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A105DC340E8;
        Tue, 22 Feb 2022 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645566117;
        bh=lQWGDmjym1t9W1fxIjFLKEG+Suv88Oidof53AVBOqNU=;
        h=Date:From:To:Cc:Subject:From;
        b=iG47F9vFWE+KspktK2ECpk2XWmsNsi0t8ME1vxrVDb9kl27lZDcyURF8+8yCMpOqp
         dAfFRcgt8rp9jzt+rJ0y0KPbBtbB4sPabP1u5C6B4Vn58t7wEN35kJwCvCoLXS3Yuh
         XLfC+znNrs74x62rqjFzKYv+va64oYO/1VIX+Ixxge+ZZghGF2FNu4h/NdoOqfm8IW
         DtfKxLOv+f5nTwxpcXH9xWPQKWUTESLZQY5Tg3RFGzh+CmcBSxFTuknExe2qOiiKlm
         FMBhq/Tfk490NcCgig3TnMcKsiurH7+fVXPyBGkBsLc/awwsSCgyy9iaq9OHW4sDsK
         N6Ryd8NYj+jPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3216400FE; Tue, 22 Feb 2022 18:41:53 -0300 (-03)
Date:   Tue, 22 Feb 2022 18:41:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <YhVKxaft+z8rpOfy@kernel.org>
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

Just FYI, I'm carrying this on my perf/urgent branch, resent to have
lkml on CC list so that I can add a Link: to the commit.

- Arnaldo

--

To pick up the changes in:

  3915035282573c5e ("KVM: x86: SVM: move avic definitions from AMD's spec to svm.h")

Addressing these tools/perf build warnings:

    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'

That makes the beautification scripts to pick some new entries:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2022-02-22 17:35:36.996271430 -0300
  +++ after	2022-02-22 17:35:46.258503347 -0300
  @@ -287,6 +287,7 @@
   	[0xc0010114 - x86_AMD_V_KVM_MSRs_offset] = "VM_CR",
   	[0xc0010115 - x86_AMD_V_KVM_MSRs_offset] = "VM_IGNNE",
   	[0xc0010117 - x86_AMD_V_KVM_MSRs_offset] = "VM_HSAVE_PA",
  +	[0xc001011b - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SVM_AVIC_DOORBELL",
   	[0xc001011e - x86_AMD_V_KVM_MSRs_offset] = "AMD64_VM_PAGE_FLUSH",
   	[0xc001011f - x86_AMD_V_KVM_MSRs_offset] = "AMD64_VIRT_SPEC_CTRL",
   	[0xc0010130 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SEV_ES_GHCB",
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

  # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=AMD64_SVM_AVIC_DOORBELL && msr<=AMD64_SEV_ES_GHCB"
  ^C#

If we use -v (verbose mode) we can see what it does behind the scenes:

  # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=AMD64_SVM_AVIC_DOORBELL && msr<=AMD64_SEV_ES_GHCB"
  Using CPUID AuthenticAMD-25-21-0
  0xc001011b
  0xc0010130
  New filter for msr:read_msr: (msr>=0xc001011b && msr<=0xc0010130) && (common_pid != 1019953 && common_pid != 3629)
  0xc001011b
  0xc0010130
  New filter for msr:write_msr: (msr>=0xc001011b && msr<=0xc0010130) && (common_pid != 1019953 && common_pid != 3629)
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3faf0f97edb1bcd3..a4a39c3e0f196747 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -476,6 +476,7 @@
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
+#define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
-- 
2.34.1


----- End forwarded message -----

-- 

- Arnaldo
