Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202C147330D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbhLMRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbhLMRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF45C061574;
        Mon, 13 Dec 2021 09:35:04 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:35:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1FQ+6DBhbJk6y3CYUZup+Q5bEfyhfek5LAwVSpFXYg=;
        b=Rh61Mqoc4Fm1HjhoDTUe4zFU5SvB/93LCcW/Uy0IbHP1ajG/vWW60kX69jFxLM+8UmjPKb
        a1YJfNBsJjQ8eSG4/fyjSQ9gsP1AW8nwjGLZ9VWVSj7UvDK2x2zl1SPr2aMkBjn2Yc1LU6
        umNNxVKz+udEjSuUjhdaWUNtv0rI8mXFF3lRwyoz1ZLCNwRQSNoduJ6wkW4K1tiGK44xAN
        jYdEPrZv5Kh2YTb0F6hXOipQscalLrF3+fn6ZmyFeZ6F1u64V4z3TXOzxdeUUsgcctmVGM
        Bmvz/b2a9WlT9xpDT0/6QMJXxQauoIokR8ZJrJ2S7nmAyouexlmBQ5FCU9Ntkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1FQ+6DBhbJk6y3CYUZup+Q5bEfyhfek5LAwVSpFXYg=;
        b=hRdsO52F0ZFWn4xeGHv7PeNVtQvTVXlhTLDMfO2Xv90puXS+9mAKBmpRfMTTGnUK/bu8Qa
        B8VI0Gto8/ABSSBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark mce_start() noinstr
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-13-bp@alien8.de>
References: <20211208111343.8130-13-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690127.23020.3906222687033378135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e3d72e8eee53c55835ab4664920d83400ff5d6c2
Gitweb:        https://git.kernel.org/tip/e3d72e8eee53c55835ab4664920d83400ff5d6c2
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 03 Nov 2021 10:30:29 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:14:05 +01:00

x86/mce: Mark mce_start() noinstr

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x4ae: call to __const_udelay() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-13-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7023d65..5818b83 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1007,13 +1007,13 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static noinstr int mce_start(int *no_way_out)
 {
-	int order;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+	int order, ret = -1;
 
 	if (!timeout)
-		return -1;
+		return ret;
 
 	atomic_add(*no_way_out, &global_nwo);
 	/*
@@ -1023,6 +1023,9 @@ static int mce_start(int *no_way_out)
 	order = atomic_inc_return(&mce_callin);
 	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
+	/* Enable instrumentation around calls to external facilities */
+	instrumentation_begin();
+
 	/*
 	 * Wait for everyone.
 	 */
@@ -1030,7 +1033,7 @@ static int mce_start(int *no_way_out)
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
-			return -1;
+			goto out;
 		}
 		ndelay(SPINUNIT);
 	}
@@ -1056,7 +1059,7 @@ static int mce_start(int *no_way_out)
 			if (mce_timed_out(&timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
 				atomic_set(&global_nwo, 0);
-				return -1;
+				goto out;
 			}
 			ndelay(SPINUNIT);
 		}
@@ -1067,7 +1070,12 @@ static int mce_start(int *no_way_out)
 	 */
 	*no_way_out = atomic_read(&global_nwo);
 
-	return order;
+	ret = order;
+
+out:
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
