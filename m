Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8014BC7AC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbiBSKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbiBSKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBCD85;
        Sat, 19 Feb 2022 02:21:28 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CRasBmJo1PDlEkAqZxiN1EM8XlHdsukWFgEcQDUCZg=;
        b=dyfhTAky6mj5DSM/zNpfM1uHzUJ1BMvTj1/D2agrWZs40lmNzMxv8HSiQPZZ2II3cvdXRC
        nC4pR8ulwBHjmCDMl4E8tqjI5MIxXpBU91ZFAyK/vokXKzAR7gmevJ73wkMNR5gcUQW8v8
        QOKauNVWmMQGtBUiLOzcpYMvCwxJh6ALW+TIOVvi/6Hr7Sid9YJUaPINCjxPRZ8wQDHavD
        JFA/NnZe4rYTsXzMxv+pWTTwltdC/3Mucb8rcVNIy47rCLtScIgGyM6B3Iyj0zFSWtNx1R
        2kx7jRL8AfotmenzymW3POEoD+iDRhG8aMELJlWcQ36fxx54il+K2S/ONXSYdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CRasBmJo1PDlEkAqZxiN1EM8XlHdsukWFgEcQDUCZg=;
        b=bO2Gx9Bjn+ey3/IYbMLu7zMRyiUtFzNa6PElQirYLkxEYc3/6oQZu2rFQ0J1zA7pwbwwrP
        ERi8wsegCOFsyOBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from
 GENERIC_ENTRY
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-5-mark.rutland@arm.com>
References: <20220214165216.2231574-5-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608616.16921.6985331369063891215.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33c64734be3461222a8aa27d3dadc477ebca62de
Gitweb:        https://git.kernel.org/tip/33c64734be3461222a8aa27d3dadc477ebca62de
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:13 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:08 +01:00

sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY

Now that the enabled/disabled states for the preemption functions are
declared alongside their definitions, the core PREEMPT_DYNAMIC logic is
no longer tied to GENERIC_ENTRY, and can safely be selected so long as
an architecture provides enabled/disabled states for
irqentry_exit_cond_resched().

Make it possible to select HAVE_PREEMPT_DYNAMIC without GENERIC_ENTRY.

For existing users of HAVE_PREEMPT_DYNAMIC there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-5-mark.rutland@arm.com
---
 arch/Kconfig        | 1 -
 kernel/sched/core.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a807..601691f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1279,7 +1279,6 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
 	help
 	   Select this if the architecture support boot time preempt setting
 	   on top of static calls. It is strongly advised to support inline
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf3a97f..300c045 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8149,7 +8149,9 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
+#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
+#endif
 
 /*
  * SC:cond_resched
