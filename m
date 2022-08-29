Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7D5A442D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiH2HuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiH2HuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:50:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214EB7DA;
        Mon, 29 Aug 2022 00:50:05 -0700 (PDT)
Date:   Mon, 29 Aug 2022 07:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661759403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLE4638nTv64wZp/6SRE/1A2pFOqfrYIY3QVaFthWBY=;
        b=jG9xZaWPXgld8/+O97bihq7dwpiq3kVRMRdoc8/O7GXcgmT5XoA2S5UkgU4beoo3lAhCle
        lx1tKipJtrsD7tOBs5rJ7xWHRGwTJZjevoDjYrqshRIRrxgv67MXUTxmT5AiOSB4CdT2gF
        Uxx+LBjf5Iy3GCRfP44HubUebKn47UQ/UhiCl7OOI+0RtjfaW2/Wh3ImO45pehT6349Ocm
        1pw91oDR8sxOcwiFtL63aQ+yNCwYzXhaSyw+eQWxs711Mns08MUyaTRqMDQpNUZB7KXwfl
        dE12vP0lwSCFtUFVpGyyNJFwId+/aZr2Hay5HW/zX3eOYW+j6ymvhby1CYpo+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661759403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLE4638nTv64wZp/6SRE/1A2pFOqfrYIY3QVaFthWBY=;
        b=qjv+WgsqnZqUp3cZILYPI9QlDaj80oUNeuDUn4C/aOpF3r2e+l8MQlEyF0iFKkevAfKI+W
        ucKU3RZDy8Ea0CBA==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add system error and not in transaction branch types
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-2-anshuman.khandual@arm.com>
References: <20220824044822.70230-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166175940238.401.10445533628526721258.tip-bot2@tip-bot2>
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

Commit-ID:     a724ec82966d57e4b5d36341d3e3dc1a3c011564
Gitweb:        https://git.kernel.org/tip/a724ec82966d57e4b5d36341d3e3dc1a3c011564
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:15 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Aug 2022 09:42:41 +02:00

perf: Add system error and not in transaction branch types

This expands generic branch type classification by adding two more entries
there in i.e system error and not in transaction. This also updates the x86
implementation to process X86_BR_NO_TX records as appropriate. This changes
branch types reported to user space on x86 platform but it should not be a
problem. The possible scenarios and impacts are enumerated here.

 --------------------------------------------------------------------------
 | kernel | perf tool |                     Impact                        |
 --------------------------------------------------------------------------
 |   old  |    old    |  Works as before                                  |
 --------------------------------------------------------------------------
 |   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
 --------------------------------------------------------------------------
 |   new  |    old    |  PERF_BR_NO_TX is blocked via old PERF_BR_MAX     |
 --------------------------------------------------------------------------
 |   new  |    new    |  PERF_BR_NO_TX is recognized                      |
 --------------------------------------------------------------------------

When PERF_BR_NO_TX is blocked via old PERF_BR_MAX (new kernel with old perf
tool) the user space might throw up an warning complaining about an
unrecognized branch types being reported, but it's expected. PERF_BR_SERROR
& PERF_BR_NO_TX branch types will be used for BRBE implementation on arm64
platform.

PERF_BR_NO_TX complements 'abort' and 'in_tx' elements in perf_branch_entry
which represent other transaction states for a given branch record. Because
this completes the transaction state classification.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
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
 
