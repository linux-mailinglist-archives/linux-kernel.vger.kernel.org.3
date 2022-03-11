Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FA4D68EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351042AbiCKTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351030AbiCKTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:08:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8591AE650
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:04 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s42so8672574pfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDJ/41RHMLJzc98gGAPcQbU38m8lJtFcZEeAQmDlWXg=;
        b=eB2fEtFzdgN9cXc57alBRC4gluos4heUHZd/NkibI+iQkHVIgyj9X/N3a59R9POFfz
         FZAEGeEoGaP/DiE1VKnvbdnQHI9dsGk0DFE/1tJBP3Sg24jyuIIvJsZyw+uOYNNaDR5P
         62e/plny9+qhehr27OSqyhSf3wCMDRZ8k+gXY2FT3fY2V9dgrCAExF8mufrS9LbOWuWG
         ZUrU5JjD8b6cLYG9WZwCfsop5Xvm/ntnuXh5WrZOXYdeHzkZypMKytBFZb4inGRjlDos
         e0K7M+qmuOJCczhU20fTRaMNq2L8nicOYYEVQJ0yt3APiBEMLeIJacTtxNqhnQWbHep3
         AxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDJ/41RHMLJzc98gGAPcQbU38m8lJtFcZEeAQmDlWXg=;
        b=L3hZr9W9YP+n4W3DcaOmibgeuX9q9xvHO2LEtC6mbFASqpZH+RV/wUzdughr0L+87v
         Fu826DUkkpS4V1KhrWplYa+sNIkCSWLH5C/uxn35nggS8i3uJf61b0nYpk30MfffNr75
         RcgqL7diSA/qGWJdFs7AGDqfbxeAmxyUfSX3GIExlvfn1m0LydXeLa2ks86hbdHUefcG
         FWqxTDSy4jg2ODe3lciFcpe5QSY4PHemyWsgGHTFQw41HuIaizQHF/RhpNYZhv72n4v/
         IycekCM4xlLoEuP5pzFE4Gd2hvVTYV/Bf/us5vdV8LTr55+lkwFXUQnUJEfeddrOCx4c
         62Hg==
X-Gm-Message-State: AOAM531VU2rcV5J0+a9Vc/4rYGE5xSJ5IPU6YmngwAUx09BMW+8KDVF4
        FEpkJabhuxS0U2M9uJwiCgA=
X-Google-Smtp-Source: ABdhPJyTK8Dn5ndOR70NtnVBIdFNMmT84r6IAuEigLqvHxRv905ZSZ5+Jzeb5r4L2W+TCEADjvwsUg==
X-Received: by 2002:a63:f90b:0:b0:378:a292:3951 with SMTP id h11-20020a63f90b000000b00378a2923951mr9594408pgi.312.1647025624006;
        Fri, 11 Mar 2022 11:07:04 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm857329pfa.0.2022.03.11.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:07:03 -0800 (PST)
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
Subject: [RESEND PATCH v3 1/5] x86: Detection of Knights Landing A/D leak
Date:   Fri, 11 Mar 2022 11:07:45 -0800
Message-Id: <20220311190749.338281-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311190749.338281-1-namit@vmware.com>
References: <20220311190749.338281-1-namit@vmware.com>
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

