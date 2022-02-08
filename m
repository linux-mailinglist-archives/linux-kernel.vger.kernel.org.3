Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7920A4ADC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379494AbiBHPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379485AbiBHPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:09:57 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FEC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:09:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f9-20020a170902684900b0014cd6059ecdso7632362pln.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oBocOgOG5hEYJi5DJ3NzgpgcHP4bmJC43myAYQFfF1I=;
        b=X5IFp/VWwTBd3bbcDEvruvwX8qJ0uwIhHcUKiUbbRC06PrImjXTL4VAbeNi6zZ9pIQ
         or9XhlPh32lhSREeFUUtGSN2Qin+EW7XaKpL8CzaYz+R8wmHEDJixJCYnsUvpY1AmDDW
         pwBsKi6NJx9o7wAABxZ6aLh2lTQ18QegSmSpPNyu00lU3aqIClVPzqSUT9LKIhhX+Fly
         /3syDEOPCFlTNk6142BARQn6gbnGF73hzeLGlVJw2jWAN+L5e0AWnKfj4SF5gqwAzHyh
         +MUR6YroneEJXXbR2INcuQCnPdT9+gWQ4QQczFV/v+U79wlUbLLfLb1KWW98eOyO4OVz
         Fh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oBocOgOG5hEYJi5DJ3NzgpgcHP4bmJC43myAYQFfF1I=;
        b=WL1mNyW4mkan5Wj5mzyCvcGh633dj/D1aMIldUjDO5BXvuQfbAFJzAOgJRo7OOSGoq
         yuJ8IAtotwD6uQQ/ocLMEfCF/tNvA2dYw4WEL2pI9p4kh7bmlyh6DptggNKIWzyPcE55
         rVUNO+shQrKTiwBtRaJWNnhN/kYUQqt9S+NDy667MrwcgqKwsyll8npmmA8GxC5bypMQ
         edJKSuENIw3xaJoeCPKVwXqUcMYOzvdZGX3Ws5U5vXua/cJU6yTYaubyZWn95trxi0Zx
         vLhXT5cE213egKeSK9Abgaa1/aGpIRXBXfkk9rQwSDeNANjj+2qEjyrvaLDsmlyN40b1
         HXKA==
X-Gm-Message-State: AOAM5323T0Z2qVemD05Ed5yau46Q6qfNkvIJfd8AdYexVg9aBMREBk9Y
        SuGc9jxRbiaaon8X4IiJruVTnR5K
X-Google-Smtp-Source: ABdhPJyn0yxxWqz+sRd0CyyIzfsU/suxP7Q0qIy/WVsKWfkqblYBJ8t5Blbm9+UdjToqdjmVO1KBK6sp
X-Received: from juew-desktop.sea.corp.google.com ([2620:15c:100:202:fd15:950e:f6f8:bab8])
 (user=juew job=sendgmr) by 2002:aa7:880d:: with SMTP id c13mr4835607pfo.3.1644332996167;
 Tue, 08 Feb 2022 07:09:56 -0800 (PST)
Date:   Tue,  8 Feb 2022 07:09:45 -0800
In-Reply-To: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
Message-Id: <20220208150945.266978-1-juew@google.com>
Mime-Version: 1.0
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
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

The fast string copy instructions ("rep movs*") could consume an
uncorrectable memory error in the cache line _right after_ the
desired region to copy and raise an MCE.

Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string copy
and will avoid such spurious machine checks. However, that is less
preferrable due to the permanent performance impact. Considering memory
poison is rare, it's desirable to keep fast string enabled until an MCE
is seen.

Intel has confirmed the following:
1. The CPU erratum of fast string copy only applies to
SKX/CLX/CPL generations.
2. Directly return from MCE handler will result in complete execution
of the fast string copy (rep movs*) with no data loss or corruption.
3. Directly return from MCE handler will not result in another MCE
firing on the next poisoned cache line due to rep movs*.
4. Directly return from MCE handler will resume execution from a
correct point in code.
5. Directly return from MCE handler due to any other SRAR MCEs will
result in the same instruction that triggered the MCE firing a second
MCE immediately.
6. It's not safe to directly return without disabling the fast string
copy, as the next fast string copy of the same buffer on the same CPU
would result in a PANIC MCE.

The mitigation in this patch should mitigate the erratum completely with
the only caveat that the fast string copy is disabled on the affected
hyper thread thus performance degradation.

This is still better than the OS crashes on MCEs raised on an
irrelevant process due to 'rep movs*' accesses in a kernel context,
e.g., copy_page.

Since a host drain / fail-over usually starts right after the first
MCE is signaled, which results in VM migration or termination, the
performance degradation is a transient effect.

Tested:

Injected errors on 1st cache line of 8 anonymous pages of process
'proc1' and observed MCE consumption from 'proc2' with no panic
(directly returned).

Without the fix, the host panicked within a few minutes on a
random 'proc2' process due to kernel access from copy_page.

Signed-off-by: Jue Wang <juew@google.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 53 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 ++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..abbd4936dfa8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -834,6 +834,49 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 	m->cs = regs->cs;
 }
 
+/*
+ * Disable fast string copy and return from the MCE handler upon the first SRAR
+ * MCE on bank 1 due to a CPU erratum on Intel SKX/CLX/CPL CPUs.
+ * The fast string copy instructions ("rep movs*") could consume an
+ * uncorrectable memory error in the cache line _right after_ the
+ * desired region to copy and raise an MCE with RIP pointing to the
+ * instruction _after_ the "rep movs*".
+ * This mitigation addresses the issue completely with the caveat of
+ * performance degradation on the CPU affected. This is still better
+ * than the OS crashes on MCEs raised on an irrelevant process due to
+ * 'rep movs*' accesses in a kernel context (e.g., copy_page).
+ * Since a host drain / fail-over usually starts right after the first
+ * MCE is signaled, which results in VM migration or termination, the
+ * performance degradation is a transient effect.
+ *
+ * Returns true when fast string copy on cpu should be disabled.
+ */
+static bool quirk_skylake_repmov(void)
+{
+	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
+
+	if ((mcgstatus & MCG_STATUS_LMCES) &&
+	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
+		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+
+		if ((mc1_status &
+		     (MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
+		      MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
+		      MCI_STATUS_AR|MCI_STATUS_S)) ==
+		    (MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
+		     MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S)) {
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
@@ -1403,6 +1446,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
+		return;
+
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
@@ -1858,6 +1904,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
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
2.35.0.263.gb82422642f-goog

