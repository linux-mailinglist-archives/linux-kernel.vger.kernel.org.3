Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9C4A5FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiBAPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiBAPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:21:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 07:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B554B82E8F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4592C340EB;
        Tue,  1 Feb 2022 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728905;
        bh=Jw9dh7SGjcPs5UxXQ5zECT5XJKG6nq/8nAG1Md8ePP8=;
        h=Date:From:To:Cc:Subject:From;
        b=N5Q6vxnx9iswpLaZzxfDQVP6agtfWLoWDyiXOJjxYWSTeZ83Y/bhQjqPgezwqONi7
         HjElR4XkKk4QTb92BoMqJCKCaioCe4A9oblFZTe04daghuHXH6Jft3ffabDV3gJXDx
         iShd+miZaWOAvRPt6+GW3djnx92WC9CtJ6Vyd9xWwWnA1Gfb9oGWQ2TU2lfzdhMC26
         LeeWvQZADycAGjerDi1foz5YseFLn6DDSrcAG128UmmTPMst2tx1IGSqO9RZcIHCPj
         ImHYvsLo1JhvBfElKunHZple0SF+DituaFOjS1eZDX6j+m0/2kgS4aTnGD6SoB77f9
         +4ufvf1pcZX3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1ED4840466; Tue,  1 Feb 2022 12:21:44 -0300 (-03)
Date:   Tue, 1 Feb 2022 12:21:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 fyi] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <YflQCEO9FRLeTmlB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes from:

  690a757d610e50c2 ("kvm: x86: Add CPUID support for Intel AMX")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Jing Liu <jing2.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 18de5f76f19856b1..6db4e2932b3d8657 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -299,7 +299,9 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.34.1

