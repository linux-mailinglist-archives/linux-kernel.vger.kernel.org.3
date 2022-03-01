Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5241F4C8EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiCAPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiCAPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546489CC9;
        Tue,  1 Mar 2022 07:24:34 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N92mGDb6GVuJsBIZDQlvKtlqd1uINgZ6thYDsWHH2gk=;
        b=u+UqpM0nwPvZwIatn7P9MLH3rQc83wtu6gY414fZfgAWbjOUf42uzWV7uZeRHF29kNTzA/
        FoXVK8908pW/4j3bcXAD5JcYixaL3oLG9fyNkHklsmQIe3KWeTrT4gG9rlemODOqEh38+T
        /H9ZKdQ0f8E+HY92/uDaqKO3vOnOO0lGU+XW0/jm2+gZ0pgvWJTOBwyKF55yS58tM2+BUR
        1mNsiLY2HchYBU+1eyr46JzQp62Ov7B5R2GvTv/RxuUh0YuXzLfkbiFyKfjR4RVFVcO5b3
        F3kBiVfarJJ53Yo6F7j/bWT5PaNuEFntdOUbw6dTKKzERLTOldcJMbPHBnEmFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N92mGDb6GVuJsBIZDQlvKtlqd1uINgZ6thYDsWHH2gk=;
        b=2GtfDlfnp0+H1fEHBMGyR3AA8cEEEcjQ9WY8NYghDrg8spzmRghjCm7hQjwur0ZP5uKBVc
        sb4FQMPMt1Ozp2Dw==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add irq and exception return branch types
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1645681014-3346-1-git-send-email-anshuman.khandual@arm.com>
References: <1645681014-3346-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <164614827120.16921.17856396164929219468.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cedd3614e5d9c80908099c19f8716714ce0610b1
Gitweb:        https://git.kernel.org/tip/cedd3614e5d9c80908099c19f8716714ce0610b1
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Thu, 24 Feb 2022 11:06:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:19:01 +01:00

perf: Add irq and exception return branch types

This expands generic branch type classification by adding two more entries
there in i.e irq and exception return. Also updates the x86 implementation
to process X86_BR_IRET and X86_BR_IRQ records as appropriate. This changes
branch types reported to user space on x86 platform but it should not be a
problem. The possible scenarios and impacts are enumerated here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1645681014-3346-1-git-send-email-anshuman.khandual@arm.com
---
 arch/x86/events/intel/lbr.c           | 4 ++--
 include/uapi/linux/perf_event.h       | 2 ++
 tools/include/uapi/linux/perf_event.h | 2 ++
 tools/perf/util/branch.c              | 4 +++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 669c2be..fe1742c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1329,10 +1329,10 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
 	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
 	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
 	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
+	PERF_BR_ERET,		/* X86_BR_IRET */
 	PERF_BR_COND,		/* X86_BR_JCC */
 	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
 	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
 	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b65042..7dc7176 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4cd39aa..d1324c4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -251,6 +251,8 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_ERET		= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 2285b1e..a9a909d 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -49,7 +49,9 @@ const char *branch_type_name(int type)
 		"SYSCALL",
 		"SYSRET",
 		"COND_CALL",
-		"COND_RET"
+		"COND_RET",
+		"ERET",
+		"IRQ"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
