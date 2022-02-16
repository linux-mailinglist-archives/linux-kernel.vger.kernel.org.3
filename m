Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B84B8084
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiBPF4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:56:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBPF4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:56:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F07D2BD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:56:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id gj12-20020a17090b108c00b001b89b5f3dd4so3967616pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWCPHuvmykwKjsv2qEv0NYBKpjfSaiNe18aUeDcPqSY=;
        b=qAmfOgdfUQ0U78IkwH/VzkPhNb8yOQUGV+Berr4Yg1DFnO3NpJJMTHqd/+6ThqD6Fg
         rsBLyp5TGFLrZN6d5lxQ9VehP+3SCx/W4hZygKAjEO8f5M17BIz+GmVxgSoLPgYEY8X6
         wv4qh11/2ywygdwUasTizKoL8Py/2wBNdVoIYaiJ9kRWKAtTyL+cn3l/YBCnM1zRN+pa
         Ghk8/rv8ohz9DixVUcYTGBw5RHzkFAoTG1q9iMtals/6uxJdVGCyEcovGw9P/84KUU6A
         Y8aSW99CZjrZIjJH0nlXPeM3FOdT0tantJOEXIZFc1hcV5+g/IJx4YHwtEWePqeZzNJJ
         9WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWCPHuvmykwKjsv2qEv0NYBKpjfSaiNe18aUeDcPqSY=;
        b=o1oiSXxoepkYCGdT8BKBhvhCFYZLJFjS9727ebRHNucGZbgZ3up9uCd1j5Nu7jCzyf
         MWVbuuxvDU3UYjBDhLKwYsmmROr3aHd6N68e1SP7MJttjHeM5rvzc9Kwb8c/atcriKEa
         K/H7J45zwfsGlHj9YIAY9iNLPCXsdjzLu8UQ5C4WXt2NRncnWZLPYdqdcHUONbKTlI8C
         gRM0H80vAiqNi2VBjhQZBsqdAG+Bsr4+eDQM0DiNiYxp5ynXqhUQySErvDvDrdHsM1EN
         /3Dx+LSDNr+qIKGzXLq0F0YPlmQsyQDY2/3NGPfk8wxsGBvcIFTI7CIIE/J81XQAzwdS
         goyw==
X-Gm-Message-State: AOAM532GfGGVIKIcNyStgjoVrrsYCU9GLgdYqARSzH1R5hZ2MnKssP0Q
        XltAllQZXfDN9D4MiOQ70Hw24A8C
X-Google-Smtp-Source: ABdhPJxpjuyvYc8hvo4RI+jJ/xJwSLqOS553faFwpWdnxLj5jqPDujSMW3V6QEpIVpWWBCX0sEKqycO5
X-Received: from juew-desktop.sea.corp.google.com ([2620:15c:100:202:1f68:9e47:9464:d991])
 (user=juew job=sendgmr) by 2002:a17:902:c989:b0:14e:ff42:39b6 with SMTP id
 g9-20020a170902c98900b0014eff4239b6mr1100305plc.74.1644990993818; Tue, 15 Feb
 2022 21:56:33 -0800 (PST)
Date:   Tue, 15 Feb 2022 21:56:29 -0800
In-Reply-To: <CAPcxDJ6bDctjErv4ggtBiJsmPJb2e-3ng12f+hMuJ7SLN-SXOg@mail.gmail.com>
Message-Id: <20220216055629.1542654-1-juew@google.com>
Mime-Version: 1.0
References: <CAPcxDJ6bDctjErv4ggtBiJsmPJb2e-3ng12f+hMuJ7SLN-SXOg@mail.gmail.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH] x86/mce: work around an erratum on fast string copy instructions.
From:   Jue Wang <juew@google.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast string copy instructions ("REP; MOVS*") could consume an
uncorrectable memory error in the cache line _right after_ the
desired region to copy and raise an MCE.

Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string copy
and will avoid such spurious machine checks. However, that is less
preferable due to the permanent performance impact. Considering memory
poison is rare, it's desirable to keep fast string copy enabled until
an MCE is seen.

Intel has confirmed the following:
1. The CPU erratum of fast string copy only applies to Skylake,
Cascade Lake and Cooper Lake generations.

Directly return from the MCE handler:
2. Will result in complete execution of the "REP; MOVS*" with no data
loss or corruption.
3. Will not result in another MCE firing on the next poisoned cache line
due to "REP; MOVS*".
4. Will resume execution from a correct point in code.
5. Will result in the same instruction that triggered the MCE firing a
second MCE immediately for any other software recoverable data fetch
errors.
6. Is not safe without disabling the fast string copy, as the next fast
string copy of the same buffer on the same CPU would result in a PANIC
MCE.

This should mitigate the erratum completely with the only caveat that
the fast string copy is disabled on the affected hyper thread thus
performance degradation.

This is still better than the OS crashes on MCEs raised on an
irrelevant process due to "REP; MOVS*' accesses in a kernel context,
e.g., copy_page.

Tested:

Injected errors on 1st cache line of 8 anonymous pages of process
'proc1' and observed MCE consumption from 'proc2' with no panic
(directly returned).

Without the fix, the host panicked within a few minutes on a
random 'proc2' process due to kernel access from copy_page.

Signed-off-by: Jue Wang <juew@google.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 56 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 ++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..5c9d200ec4cd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -834,6 +834,52 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 	m->cs = regs->cs;
 }
 
+/*
+ * Disable fast string copy and return from the MCE handler upon the first SRAR
+ * MCE on bank 1 due to a CPU erratum on Intel Skylake/Cascade Lake/Cooper Lake
+ * CPUs.
+ * The fast string copy instructions ("REP; MOVS*") could consume an
+ * uncorrectable memory error in the cache line _right after_ the desired region
+ * to copy and raise an MCE with RIP pointing to the instruction _after_ the
+ * "REP; MOVS*".
+ * This mitigation addresses the issue completely with the caveat of performance
+ * degradation on the CPU affected. This is still better than the OS crashes on
+ * MCEs raised on an irrelevant process due to "REP; MOVS*" accesses from a
+ * kernel context (e.g., copy_page).
+ *
+ * Returns true when fast string copy on CPU should be disabled.
+ */
+static noinstr bool quirk_skylake_repmov(void)
+{
+	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
+
+	// Only applies the quirk to local machine checks, i.e., no broadcast
+	// sync is needed.
+	if ((mcgstatus & MCG_STATUS_LMCES) &&
+	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
+		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+
+		// The blob of logic below is checking for a software
+		// recoverable data fetch error.
+		if ((mc1_status &
+		     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
+		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
+		      MCI_STATUS_AR | MCI_STATUS_S)) ==
+		     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
+		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
+		      MCI_STATUS_AR | MCI_STATUS_S)) {
+			msr_clear_bit(MSR_IA32_MISC_ENABLE,
+				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
+			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
+			pr_err_once("Errata detected, disable fast string copy instructions.\n");
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
@@ -1403,6 +1449,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
+		return;
+
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
@@ -1858,6 +1907,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
 		if (c->x86 == 6 && c->x86_model == 45)
 			mce_flags.snb_ifu_quirk = 1;
+
+		/*
+		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
+		 * rep movs.
+		 */
+		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+			mce_flags.skx_repmov_quirk = 1;
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..cec227c25138 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -170,7 +170,10 @@ struct mce_vendor_flags {
 	/* SandyBridge IFU quirk */
 	snb_ifu_quirk		: 1,
 
-	__reserved_0		: 57;
+	/* Skylake, Cascade Lake, Cooper Lake rep movs quirk */
+	skx_repmov_quirk		: 1,
+
+	__reserved_0		: 56;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.35.1.265.g69c8d7142f-goog

