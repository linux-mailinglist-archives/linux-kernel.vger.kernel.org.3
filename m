Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868A55DDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbiF1KRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344873AbiF1KRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:17:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B42FFE0;
        Tue, 28 Jun 2022 03:17:36 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656411454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgrkKeUjyDISUVGC+ZEkzm6tVoShgne3hdtLt66d7Fw=;
        b=zK+TDvxno6Y+H1puM5A5Qqi9Q0cUNNdkkV8knkYiHnWM+EcfPTQYwPsJQR2XVuw1KKEG4z
        HH6ShsEv1+eZ6bQvIrKE3JcthztIp4uI3ZiQ3VAHRw3jmxF/x7gDo9Uzdky57SiYtBjYml
        FYY54aopDHxiU3MjsgccKMf5lBGdQ7Cu5cTDDf0PDdRGu2ltvywuJRjj5bc4swbf7KLFl3
        kd/3d3ROmLFanFmDRXrRqr5ZGdiHqNQWugguEtgBsYmNzUloMhp5ezY1WosU6H1yZ7VFtq
        5tKp5vZjd4G19hfn3GY1PlYlOJ3vvuzMLYHsoKjx8mnr33fVJ9hLwWfg5eC5ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656411454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgrkKeUjyDISUVGC+ZEkzm6tVoShgne3hdtLt66d7Fw=;
        b=yS9khQ7rkAxaSmcE6PmWZ6eqIiZPVYoTqRtQfJHybNYAj6ZWJqBBJfiEaHTsG9xzPwEueT
        MoTEkA7oEHc/09CQ==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Check whether writes to MCA_STATUS are
 getting ignored
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <165641145330.4207.4653680813553128202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     891e465a1bd8798d5f97c3afb99393f123817fef
Gitweb:        https://git.kernel.org/tip/891e465a1bd8798d5f97c3afb99393f123817fef
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Mon, 27 Jun 2022 20:56:46 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 28 Jun 2022 12:08:10 +02:00

x86/mce: Check whether writes to MCA_STATUS are getting ignored

The platform can sometimes - depending on its settings - cause writes
to MCA_STATUS MSRs to get ignored, regardless of HWCR[McStatusWrEn]'s
value.

For further info see

  PPR for AMD Family 19h, Model 01h, Revision B1 Processors, doc ID 55898

at https://bugzilla.kernel.org/show_bug.cgi?id=206537.

Therefore, probe for ignored writes to MCA_STATUS to determine if hardware
error injection is at all possible.

  [ bp: Heavily massage commit message and patch. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c   | 47 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ff..12cf2e7 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,6 +33,8 @@
 
 #include "internal.h"
 
+static bool hw_injection_possible = true;
+
 /*
  * Collect all the MCi_XXX settings
  */
@@ -339,6 +341,8 @@ static int __set_inj(const char *buf)
 
 	for (i = 0; i < N_INJ_TYPES; i++) {
 		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
+			if (i > SW_INJ && !hw_injection_possible)
+				continue;
 			inj_type = i;
 			return 0;
 		}
@@ -717,11 +721,54 @@ static void __init debugfs_init(void)
 				    &i_mce, dfs_fls[i].fops);
 }
 
+static void check_hw_inj_possible(void)
+{
+	int cpu;
+	u8 bank;
+
+	/*
+	 * This behavior exists only on SMCA systems though its not directly
+	 * related to SMCA.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SMCA))
+		return;
+
+	cpu = get_cpu();
+
+	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
+		u64 status = MCI_STATUS_VAL, ipid;
+
+		/* Check whether bank is populated */
+		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
+		if (!ipid)
+			continue;
+
+		toggle_hw_mce_inject(cpu, true);
+
+		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
+		rdmsrl_safe(mca_msr_reg(bank, MCA_STATUS), &status);
+
+		if (!status) {
+			hw_injection_possible = false;
+			pr_warn("Platform does not allow *hardware* error injection."
+				"Try using APEI EINJ instead.\n");
+		}
+
+		toggle_hw_mce_inject(cpu, false);
+
+		break;
+	}
+
+	put_cpu();
+}
+
 static int __init inject_init(void)
 {
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
+	check_hw_inj_possible();
+
 	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4ae0e60..7e03f5b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	if (mce_flags.smca) {
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		switch (reg) {
 		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
 		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
