Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DD5A31DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbiHZWQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHZWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:15:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5597E6DAEB;
        Fri, 26 Aug 2022 15:15:54 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTlwc8FESxn2celmx+oVwm3jI0/NBhCXSKB/F3HBpWw=;
        b=4Jc3AcL45cfcUgCGiMb5bGJ4O3D3VokEJDeKNEJVQKcB83E4Y+zDeGi37tglZt1pVOxIom
        hKcKG61zaDZQgj/G5nfKjX8+DdGKnbqaEd0rlGjOHK2rTaN/gM0j9HcLnRvAKjAhtEhJi/
        DJYwh456u1wj4RW1NOCqmsmEgvQETYCJHtmGClRtru8aXCMy4kMBDWDtD/Q23dOH02GIc3
        gCVSlsvUYyNQmJdHvVbmsWBSqPautmq6djtMVLfthQy4O7/hhdcJJnv/IGoq5+Iu3l9BRE
        XhNULdb2SOrKHGWz9/wo92uCRqoWuIJoe2QPGDE9383iBIvOO/7VEzyOo9LALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTlwc8FESxn2celmx+oVwm3jI0/NBhCXSKB/F3HBpWw=;
        b=ertLHzTH9SEXaRspppptnua4yinXQJzkYDsGFu9/2hzLc5X44AtkMZL00VqGNooj6g4pxo
        C9V6IrpKZy/GBXCA==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add system error and not in transaction branch types
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-2-anshuman.khandual@arm.com>
References: <20220824044822.70230-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166155215090.401.870330359879147742.tip-bot2@tip-bot2>
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

Commit-ID:     6bc72375dd930fb7a8b71f6e5ced02b3b7cfdca1
Gitweb:        https://git.kernel.org/tip/6bc72375dd930fb7a8b71f6e5ced02b3b7cfdca1
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:15 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:46 +02:00

perf: Add system error and not in transaction branch types

This expands generic branch type classification by adding two more entries
there in i.e system error and not in transaction. This also updates the x86
implementation to process X86_BR_NO_TX records as appropriate. This changes
branch types reported to user space on x86 platform but it should not be a
problem. The possible scenarios and impacts are enumerated here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220824044822.70230-2-anshuman.khandual@arm.com
---
 arch/x86/events/utils.c         | 2 +-
 include/uapi/linux/perf_event.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index e013243..5f5617a 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -225,7 +225,7 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
 	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
 	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
-	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_NO_TX,		/* X86_BR_NO_TX */
 	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
 	PERF_BR_IND,		/* X86_BR_IND_JMP */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 30a4723..a79cc0e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -253,6 +253,8 @@ enum {
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
 	PERF_BR_ERET		= 11,	/* exception return */
 	PERF_BR_IRQ		= 12,	/* irq */
+	PERF_BR_SERROR		= 13,	/* system error */
+	PERF_BR_NO_TX		= 14,	/* not in transaction */
 	PERF_BR_MAX,
 };
 
