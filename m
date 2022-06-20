Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D405552659
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiFTVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFTVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299F1EEEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E4EB8125A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52708C3411B;
        Mon, 20 Jun 2022 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655760005;
        bh=4kXc56TAeXMy7WsIFk0raAaetVV5IC3295pxGQmXk/I=;
        h=Date:From:To:Cc:Subject:From;
        b=jRV0qc+25RSyc/r7q5gijX5VKcIVtLtgB7+WE0qEDCPuCL3NPmQWg0W5F1ovTrskQ
         F1/I5v59LITPZRL4FEVmX2Brw0QYhz9m2E5QN2fHa+YvDslZutB1BQ25MOK1KhMEN7
         LZbyCvpR8dlwyxKpYvVCn7xRP4y9gm42XYS5Td8RV0ugytKlle+6ll7v90w8xBjht8
         6kYFKmcDnG3CKvKE6Wa/eZGLqdk6whrdE+TgXx4ks0NtjII6mh/Hk1GkwlrpkPNVts
         eJfummxD19adPtAlM2RdICt3nqEiZny20QhNKwVa5n+sOJ4oGBpVqCq3u8y8mUfkaf
         ac9V2kyayukJQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 071A84096F; Mon, 20 Jun 2022 18:20:03 -0300 (-03)
Date:   Mon, 20 Jun 2022 18:20:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <YrDkgmwhLv+nKeOo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
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

To pick the changes from:

  d6d0c7f681fda1d0 ("x86/cpufeatures: Add PerfMonV2 feature bit")
  296d5a17e793956f ("KVM: SEV-ES: Use V_TSC_AUX if available instead of RDTSC/MSR_TSC_AUX intercepts")
  f30903394eb62316 ("x86/cpufeatures: Add virtual TSC_AUX feature bit")
  8ad7e8f696951f19 ("x86/fpu/xsave: Support XSAVEC in the kernel")
  59bd54a84d15e933 ("x86/tdx: Detect running as a TDX guest in early boot")
  a77d41ac3a0f41c8 ("x86/cpufeatures: Add AMD Fam19h Branch Sampling feature")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/fill-this-up
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index e17de69faa5432db..03acc823838a7e46 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (XSAVES or XSAVEC) */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
@@ -211,7 +211,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-/* FREE!                                ( 7*32+20) */
+#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
@@ -238,6 +238,7 @@
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
+#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Intel Trust Domain Extensions Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
@@ -315,6 +316,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -405,6 +407,7 @@
 #define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
 /*
-- 
2.36.1

