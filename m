Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3285A31E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiHZWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbiHZWP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:15:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D89754A9;
        Fri, 26 Aug 2022 15:15:56 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0mbft+punbjKDvxH9hbakvQEosO8YJTEIL95QEd4c0=;
        b=2pp//UtgI7hqF8S/8Y3wRBv/EjA9CK0h7Ad07+0QlCU2HGpXJeEAnS0xSeLuppzTQ9I6dP
        hWX265aMWK5Baw5tFrz4zYTPRQAIUOSmmCQtJChX8/tlwggHMUx8up8++YlPIftBieUylc
        90BsIaNFHBtCrLFHwsMnePqAbkaEb9EXreUCS6bWmPeqTedIaC1CkS+4YesGepoXtb4e4/
        vifpB5Ttc1tWm7g9jBCejHsWwStyUff+Bf2Zdi1u2ccV6vBJU67v/y8fTsLOgYGjJreHQX
        FSdsVpTbjcQN8TMxewDUQEvXeWjbQzP3FnwdH0aDuZ31SXhg0l4GIgvbd7nWlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0mbft+punbjKDvxH9hbakvQEosO8YJTEIL95QEd4c0=;
        b=85gVXGgtfSqq8C8c9CYopOM5vLQQVQ9OEyeL37b+2F3fPMm9QQTbk98WB9Ntv4MCZxPVww
        57YePd+7KxiZNdBA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Add LbrExtV2 branch speculation
 info support
Cc:     Stephane Eranian <eranian@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cddc02f6320464cad0e3ff5bdb2314531568a91bc=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cddc02f6320464cad0e3ff5bdb2314531568a91bc=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155215274.401.5047464816723154912.tip-bot2@tip-bot2>
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

Commit-ID:     0bc3be5b4bfd5b75086c26d63584a6f7aaea87d5
Gitweb:        https://git.kernel.org/tip/0bc3be5b4bfd5b75086c26d63584a6f7aaea87d5
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 18:00:01 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:45 +02:00

perf/x86/amd/lbr: Add LbrExtV2 branch speculation info support

Provide branch speculation information captured via AMD Last Branch Record
Extension Version 2 (LbrExtV2) by setting the speculation info in branch
records. The info is based on the "valid" and "spec" bits in the Branch To
registers.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ddc02f6320464cad0e3ff5bdb2314531568a91bc.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/lbr.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index eb84f19..2e1c157 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -146,12 +146,19 @@ static void amd_pmu_lbr_filter(void)
 	}
 }
 
+static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
+	PERF_BR_SPEC_NA,
+	PERF_BR_SPEC_WRONG_PATH,
+	PERF_BR_NON_SPEC_CORRECT_PATH,
+	PERF_BR_SPEC_CORRECT_PATH,
+};
+
 void amd_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_branch_entry *br = cpuc->lbr_entries;
 	struct branch_entry entry;
-	int out = 0, i;
+	int out = 0, idx, i;
 
 	if (!cpuc->lbr_users)
 		return;
@@ -160,8 +167,11 @@ void amd_pmu_lbr_read(void)
 		entry.from.full	= amd_pmu_lbr_get_from(i);
 		entry.to.full	= amd_pmu_lbr_get_to(i);
 
-		/* Check if a branch has been logged */
-		if (!entry.to.split.valid)
+		/*
+		 * Check if a branch has been logged; if valid = 0, spec = 0
+		 * then no branch was recorded
+		 */
+		if (!entry.to.split.valid && !entry.to.split.spec)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
@@ -170,6 +180,25 @@ void amd_pmu_lbr_read(void)
 		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
 		br[out].mispred	= entry.from.split.mispredict;
 		br[out].predicted = !br[out].mispred;
+
+		/*
+		 * Set branch speculation information using the status of
+		 * the valid and spec bits.
+		 *
+		 * When valid = 0, spec = 0, no branch was recorded and the
+		 * entry is discarded as seen above.
+		 *
+		 * When valid = 0, spec = 1, the recorded branch was
+		 * speculative but took the wrong path.
+		 *
+		 * When valid = 1, spec = 0, the recorded branch was
+		 * non-speculative but took the correct path.
+		 *
+		 * When valid = 1, spec = 1, the recorded branch was
+		 * speculative and took the correct path
+		 */
+		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
+		br[out].spec = lbr_spec_map[idx];
 		out++;
 	}
 
