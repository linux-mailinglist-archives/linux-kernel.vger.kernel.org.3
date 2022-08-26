Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAA5A31E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHZWQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345096AbiHZWQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DD26DAEB;
        Fri, 26 Aug 2022 15:15:59 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAqfOh7trbubky+i0lJYTyEOgpDw3LjWHn47A9brgUc=;
        b=4GK9EIrMXhvQfW40w1YlCEex1r4zbq5aVaTSd2twUFoK2uzyESZAFrdU0cQnoC/zUDE78+
        0c/ZTWUIGeGADA6CnyIXrBeprWzYWXBdjInHelzbKjssLmHHvH/mcGJ/aLeuwAkKLDzsX4
        hrzjaGz7KtWZWkLzGodmY7zqiMEjs2fs2n2yxANAFy+FpduBAR1dacBQ83U38cc9PrY3Sz
        PcBOJadcCOgaTxAYYwd2vvX2fnTrTBmxiOnLZ8leYUiYcf74oHJtm8p3GWaBZPOeyoVGvD
        +8YnHDCx579BRnYAgKdWemhbERWWBfX8ASI9ejzG6KovBcxXjDEtc8cfzSNcLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAqfOh7trbubky+i0lJYTyEOgpDw3LjWHn47A9brgUc=;
        b=mxsum7A6325E28dWi6oY71qljYcC1FG/TRZddrm9tLyKSszylGvPEBpfuNsJ4h68ChtPbH
        RlrZXvdncIkCOeCA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Use fusion-aware branch classifier
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc324d2d0a9c3976da30b9563d09e50bfee0f264d=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cc324d2d0a9c3976da30b9563d09e50bfee0f264d=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155215563.401.523345441927122642.tip-bot2@tip-bot2>
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

Commit-ID:     245268c19f701c7222dedcb6a383bc73d63925d4
Gitweb:        https://git.kernel.org/tip/245268c19f701c7222dedcb6a383bc73d63925d4
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:59 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:45 +02:00

perf/x86/amd/lbr: Use fusion-aware branch classifier

AMD Last Branch Record Extension Version 2 (LbrExtV2) can report a branch
from address that points to an instruction preceding the actual branch by
several bytes due to branch fusion and further optimizations in Zen4
processors.

In such cases, software should move forward sequentially in the instruction
stream from the reported address and the address of the first branch
encountered should be used instead. Hence, use the fusion-aware branch
classifier to determine the correct branch type and get the offset for
adjusting the branch from address.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/c324d2d0a9c3976da30b9563d09e50bfee0f264d.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/lbr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 1a8d27e..eb84f19 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -97,7 +97,7 @@ static __always_inline u64 sign_ext_branch_ip(u64 ip)
 static void amd_pmu_lbr_filter(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int br_sel = cpuc->br_sel, type, i, j;
+	int br_sel = cpuc->br_sel, offset, type, i, j;
 	bool compress = false;
 	u64 from, to;
 
@@ -109,7 +109,15 @@ static void amd_pmu_lbr_filter(void)
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
-		type = branch_type(from, to, 0);
+		type = branch_type_fused(from, to, 0, &offset);
+
+		/*
+		 * Adjust the branch from address in case of instruction
+		 * fusion where it points to an instruction preceding the
+		 * actual branch
+		 */
+		if (offset)
+			cpuc->lbr_entries[i].from += offset;
 
 		/* If type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type) {
