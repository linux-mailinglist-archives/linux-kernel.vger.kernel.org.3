Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8284B922B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiBPURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:17:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiBPURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:17:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABDDF18;
        Wed, 16 Feb 2022 12:16:59 -0800 (PST)
Date:   Wed, 16 Feb 2022 20:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645042616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEhkf5TFb74vC//cbREjUhKy2MSk+J4YMRW+rkjHOsw=;
        b=cTbX6PbN04iC8T8wiZ+DU8pr6pR4pvGz2oD54a1O35IsiMiaETa4C9P9lcLd6zXKynqgYr
        ulRu3Ltxga4gUB8+e529q7y8Ffr6g5Gp8crdoLYV8eNkeu4k7z+r26yBvtxzAwtp+Rnla1
        u+EtxCe86kF2D+zAUqXiK+hbXYQfDjmA5tdb1Z35QYxAzyKkGQk8In+aBpfi12hWvYN9eT
        1sNWH4bukKwmJk/zITj4XUbwEKANmdZQdOerTV1rOOgUeUkbP1V/ae3WUuqjKbFIE+0sYL
        Wokhp/qRRK/bOnJYto1R9hwm7GFPABW2mXVnaZmtXruDQk9Hs8c87ARV/GydKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645042616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEhkf5TFb74vC//cbREjUhKy2MSk+J4YMRW+rkjHOsw=;
        b=0TJgZHM/VtMcI784PqoutImJ7Wzo3sJHyjje6e9tCfp56RuP+0lxpM/kuT5yyJ3ZyEcoh9
        8rBiUeyXEeU7KGCA==
From:   "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Clear SME feature flag when not in use
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220216034446.2430634-1-mario.limonciello@amd.com>
References: <20220216034446.2430634-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Message-ID: <164504261512.16921.13135643704549193516.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     08f253ec3767bcfafc5d32617a92cee57c63968e
Gitweb:        https://git.kernel.org/tip/08f253ec3767bcfafc5d32617a92cee57c63968e
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 15 Feb 2022 21:44:46 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 16 Feb 2022 19:45:53 +01:00

x86/cpu: Clear SME feature flag when not in use

Currently, the SME CPU feature flag is reflective of whether the CPU
supports the feature but not whether it has been activated by the
kernel.

Change this around to clear the SME feature flag if the kernel is not
using it so userspace can determine if it is available and in use
from /proc/cpuinfo.

As the feature flag is cleared on systems where SME isn't active, use
CPUID 0x8000001f to confirm SME availability before calling
native_wbinvd().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220216034446.2430634-1-mario.limonciello@amd.com
---
 arch/x86/kernel/cpu/amd.c | 5 +++++
 arch/x86/kernel/process.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bad0fa4..0c0b097 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -556,6 +556,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *	      the SME physical address space reduction value.
 	 *	      If BIOS has not enabled SME then don't advertise the
 	 *	      SME feature (set in scattered.c).
+	 *	      If the kernel has not enabled SME via any means then
+	 *	      don't advertise the SME feature.
 	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
 	 *            SEV and SEV_ES feature (set in scattered.c).
 	 *
@@ -578,6 +580,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (IS_ENABLED(CONFIG_X86_32))
 			goto clear_all;
 
+		if (!sme_me_mask)
+			setup_clear_cpu_cap(X86_FEATURE_SME);
+
 		rdmsrl(MSR_K7_HWCR, msr);
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef0..e131d71 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -765,8 +765,11 @@ void stop_this_cpu(void *dummy)
 	 * without the encryption bit, they don't race each other when flushed
 	 * and potentially end up with the wrong entry being committed to
 	 * memory.
+	 *
+	 * Test the CPUID bit directly because the machine might've cleared
+	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (boot_cpu_has(X86_FEATURE_SME))
+	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
 	for (;;) {
 		/*
