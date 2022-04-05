Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C134F386F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbiDELYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbiDEIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808A2B266;
        Tue,  5 Apr 2022 01:36:53 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkQm3GtvyTZptL48b9wj9XoVnDZnrbTzypjlh3EthbA=;
        b=oQukEbaAHv+PICw1epe6g3zo1wjOF0ncP88pbeza/sGBTN5I6/XMsGupXSeXJq9gXa5Q34
        fq3Gb3Cc3lOIPBc2hhhTjOOfv0TBwrYvI4O1Zyq3hofzamId04HkmpJ/x8LHohJ/xlRqY0
        LW0IJ88xuPeQXeuiXSunv0NgkTdbeR3I0bbh7BSgDZWTzMp/ji8oxBi2hNG42RX0V8otK5
        HdBp/NX6D1W/HQtL8pitFWY/ZjlErImMUWMwr1CSlMkTLZHXvv6RYlx5is7JHo/SDCj2Bx
        gMgus/zy/+xV+S9tqWtVuWisSVUDVmw1uGZFGTAqQKDa/8iVJjpos9wjNBvMcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkQm3GtvyTZptL48b9wj9XoVnDZnrbTzypjlh3EthbA=;
        b=UKZ/L3roD9j8MmKB3GrH0puOXiW4PsDzPeb6ktQ6Wiz2B9vIgkdhGroaFj8wXVQ8P36yMY
        S/2izcGYGfHWUABA==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Enable branch sampling priv level filtering
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-6-eranian@google.com>
References: <20220322221517.2510440-6-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914780085.389.2438404579704499076.tip-bot2@tip-bot2>
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

Commit-ID:     8910075d61a37e5b0d82e6c83ed9a0a31fe9ea08
Gitweb:        https://git.kernel.org/tip/8910075d61a37e5b0d82e6c83ed9a0a31fe9ea08
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:37 +02:00

perf/x86/amd: Enable branch sampling priv level filtering

The AMD Branch Sampling features does not provide hardware filtering by
privilege level. The associated PMU counter does but not the branch sampling
by itself. Given how BRS operates there is a possibility that BRS captures
kernel level branches even though the event is programmed to count only at
the user level.

Implement a workaround in software by removing the branches which belong to
the wrong privilege level. The privilege level is evaluated on the target of
the branch and not the source so as to be compatible with other architectures.
As a consequence of this patch, the number of entries in the
PERF_RECORD_BRANCH_STACK buffer may be less than the maximum (16).  It could
even be zero. Another consequence is that consecutive entries in the branch
stack may not reflect actual code path and may have discontinuities, in case
kernel branches were suppressed. But this is no different than what happens
on other architectures.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-6-eranian@google.com
---
 arch/x86/events/amd/brs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 3c13c48..40461c3 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -92,10 +92,6 @@ int amd_brs_setup_filter(struct perf_event *event)
 	if ((type & ~PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_ANY)
 		return -EINVAL;
 
-	/* can only capture at all priv levels due to the way BRS works */
-	if ((type & PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_PLM_ALL)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -195,6 +191,21 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
+static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+{
+	int type = event->attr.branch_sample_type;
+	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
+	int plm_u = PERF_SAMPLE_BRANCH_USER;
+
+	if (!(type & plm_k) && kernel_ip(to))
+		return 0;
+
+	if (!(type & plm_u) && !kernel_ip(to))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Caller must ensure amd_brs_inuse() is true before calling
  * return:
@@ -252,8 +263,6 @@ void amd_brs_drain(void)
 		if (to == BRS_POISON)
 			break;
 
-		rdmsrl(brs_from(brs_idx), from);
-
 		/*
 		 * Sign-extend SAMP_BR_TO to 64 bits, bits 61-63 are reserved.
 		 * Necessary to generate proper virtual addresses suitable for
@@ -261,6 +270,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
+		if (!amd_brs_match_plm(event, to))
+			continue;
+
+		rdmsrl(brs_from(brs_idx), from);
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
