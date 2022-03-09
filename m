Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9B4D27D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiCIEK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCIEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:10:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFE12D91B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:09:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w4so871964ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDJ/41RHMLJzc98gGAPcQbU38m8lJtFcZEeAQmDlWXg=;
        b=iQ1Xu9+KRLGk0BykNH8il9ywJGSsmPyAQqOlV3l/pxf4PFQLoBoKwwD/HStlelSUii
         MI0YwU75WlO+H7tV3Bs4IEQlMb2qoq056pREkMc0OmlGLbzstdVLayMfyYu5hvcBRMAh
         faPWPDEy2VsZfAWsut2EOLCLGKsP3K6U4PC4tTSdEL+BRsJdaAndwE5ncg0t5/xy1Iit
         cafsMw5cxGkPgrb50e0dVmnQLZmCtT+u7AMB+lJ2SSTrHI/nl2Q022svPS6Uwr0e9k8J
         IP2T7SwAGuumvLldrrZ+VqjcKCAkedc4gNXJHLlAJ5ezRxV2PsBsnPdjp+tVQfyyGXLu
         lrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDJ/41RHMLJzc98gGAPcQbU38m8lJtFcZEeAQmDlWXg=;
        b=1nIRwtUb54k1xKTqqxg3oeosRV3zCEjES3bHpj301Vv98CiYH1ezGlXNP4JhC54e8l
         pXQIhVljrS5mjCjdYa1xfxIksBWXWDCa220lPovbQKu/3RnxTFixWv8rXWVxJaKbNrQ9
         i6f2Tb4hHZgEajX5S5McZX0nM5taZvvj77Gb8u68rjiz32AeLgR045KlGCWv9TWfDS3l
         9tQhhKD5gZByvv4riTXLAi8h6TxgvT/seQXELqdkwMWsLIW9szyunHIp+7YcONWioYvH
         9Ggeo+9mcPZhrmKrCQcXL+n79WtBRDQBlb2mgEx807Rn7DzI9Y7H3BOBhiLvpsr7bwFC
         WtTQ==
X-Gm-Message-State: AOAM5336q6m5vpG1Hg/X4Spy3GLJuMULRUOaSc3s5vkv5SEnSgUprg0J
        VW7jn27c/nRjbkRNjJiDVPc=
X-Google-Smtp-Source: ABdhPJzT3DRsIcsG+zRTkFd04b8ZK+tnf7HVmnYglGEMoJ6nd7BlbRxOAMSBiiWHUImJ5P/hcidTlQ==
X-Received: by 2002:a17:90b:4c43:b0:1bf:8585:9baa with SMTP id np3-20020a17090b4c4300b001bf85859baamr8400928pjb.60.1646798995695;
        Tue, 08 Mar 2022 20:09:55 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm604343pgr.24.2022.03.08.20.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:09:55 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v3 1/5] x86: Detection of Knights Landing A/D leak
Date:   Tue,  8 Mar 2022 20:10:39 -0800
Message-Id: <20220309041043.302261-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309041043.302261-1-namit@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Knights Landing has a issue that a thread setting A or D bits may not do
so atomically against checking the present bit.  A thread which is going
to page fault may still set those bits, even though the present bit was
already atomically cleared.

This implies that when the kernel clears present atomically, some time
later the supposed to be zero entry could be corrupted with stray A or D
bits.

Since the PTE could be already used for storing a swap index, or a NUMA
migration index, this cannot be tolerated. Most of the time the kernel
detects the problem, but in some rare cases it may not.

This patch adds an interface to detect the bug, which will be used in a
following patch.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Link: https://lore.kernel.org/lkml/1465919919-2093-1-git-send-email-lukasz.anaczkowski@intel.com/
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/intel.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 67ef0e81c7dc..184b299dbf12 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -442,5 +442,6 @@
 #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
+#define X86_BUG_PTE_LEAK		X86_BUG(25) /* PTE may leak A/D bits after clear */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..74780fef3f12 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -296,6 +296,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		}
 	}
 
+	if (c->x86_model == INTEL_FAM6_XEON_PHI_KNL) {
+		pr_info_once("Enabling PTE leaking workaround\n");
+		set_cpu_bug(c, X86_BUG_PTE_LEAK);
+	}
+
 	/*
 	 * Intel Quark Core DevMan_001.pdf section 6.4.11
 	 * "The operating system also is required to invalidate (i.e., flush)
-- 
2.25.1

