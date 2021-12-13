Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7991473308
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbhLMRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbhLMRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7DC06173F;
        Mon, 13 Dec 2021 09:35:04 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:35:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6YKt+SnEn2ClAdR57mrg7AZ6isjNAwxr64dsUf7xF0=;
        b=u9ozfOzFrjW/ouxNEsnmrwmttNtxvoqSIrcOD9vNcBChb5la7519QRl3n/rrUO+YKImWP6
        AxPXWBMbuT3yMoTaoSxJyDULRcUch2FLwHZ7lPHjn9MtCiR09lZTQe/LBzkHMUykMc0hQF
        NglpYbP8RTKMetaIPYsBrk9if42Ho9f2jxVwDeyrn3j42hmd3MjRy/bKpemcnhr1ZOFE5m
        oeDrbyFXbW9xrwkHnD6XcuZ2Dd6KWfDfALy4Ule6+CB33nEmn/zjDmhIIIjqm9FSBTeO9J
        PkammN66sl9HYgHuRmAdkNid6CLkQjBXvJq2EeckwKDiFPYdxcf7FdXVjInMhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6YKt+SnEn2ClAdR57mrg7AZ6isjNAwxr64dsUf7xF0=;
        b=7mnEKwJBELfett1qN31wJzESKG1fmTdLJ6Vkndw6O0x5EMru/uI+M18o0Vdby9xQeuIhLj
        VGmdepw9pwz4m7CA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark mce_timed_out() noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-12-bp@alien8.de>
References: <20211208111343.8130-12-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690206.23020.5000091738604021815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     edb3d07e2403abd13fc664e8b6f23ea7efb52747
Gitweb:        https://git.kernel.org/tip/edb3d07e2403abd13fc664e8b6f23ea7efb52747
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 02 Nov 2021 22:25:12 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:13:54 +01:00

x86/mce: Mark mce_timed_out() noinstr

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x482: call to mce_timed_out() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-12-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 044c94b..7023d65 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -883,8 +883,13 @@ static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
-static int mce_timed_out(u64 *t, const char *msg)
+static noinstr int mce_timed_out(u64 *t, const char *msg)
 {
+	int ret = 0;
+
+	/* Enable instrumentation around calls to external facilities */
+	instrumentation_begin();
+
 	/*
 	 * The others already did panic for some reason.
 	 * Bail out like in a timeout.
@@ -903,12 +908,17 @@ static int mce_timed_out(u64 *t, const char *msg)
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		return 1;
+		ret = 1;
+		goto out;
 	}
 	*t -= SPINUNIT;
+
 out:
 	touch_nmi_watchdog();
-	return 0;
+
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
