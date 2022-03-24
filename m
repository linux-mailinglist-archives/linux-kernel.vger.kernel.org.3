Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D904E69F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiCXUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354833AbiCXUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:50:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DEDF3F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BB5B825FF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AEFC340EE;
        Thu, 24 Mar 2022 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648154947;
        bh=o2DnHfbiYo/RfzdxtXGVhztEJcR3M8hBRo4Tp+yYudE=;
        h=Date:From:To:Cc:Subject:From;
        b=g2d/GC1VOUmIruFciu1VuvIwlPYeebu2jcHqEi8lD9sN0NHzDpJqsEpb/MpzJasY/
         kW5q90vma0PglgbjkMgxQbS1EDhpkxEU5v6ruQ2XN/6TLPBRhdkWkUjUYWE9fFEulg
         nDjCJap8/CyFPc+WBz4kHaUuFKTwEgayGZSbOfETMMKXc22Mh2rMPrkuWsQgRm0hxK
         LNkK92d23wycDyA9v4oepLk4B27HLanCfk+oU12VZcQWOAPOlZndtQWc+mxiUL88sO
         qhfrwQOYTe7EqTpRPAe35d0zUp95zgMP/ZHkXbGi0UbPwfooGRRqPpk6LyxPdkn56T
         dkzKBA3LpBEVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AEE3A40407; Thu, 24 Mar 2022 17:49:03 -0300 (-03)
Date:   Thu, 24 Mar 2022 17:49:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>, Jim Mattson <jmattson@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers cpufeatures: Sync with the kernel sources
Message-ID: <YjzZPxdyLjf76gM+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree:

---

To pick the changes from:

  fa31a4d669bd471e ("x86/cpufeatures: Put the AMX macros in the word 18 block")
  7b8f40b3de75c971 ("x86/cpu: Add definitions for the Intel Hardware Feedback Interface")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Borislav Petkov <bp@suse.de>
Cc: Jim Mattson <jmattson@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 65d147974f8d95e6..3edf05e98e58625c 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -299,9 +299,6 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
-#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
-#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -330,6 +327,7 @@
 #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
+#define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* Nested Page Table support */
@@ -390,7 +388,10 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-- 
2.35.1

