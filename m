Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600D52DFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiESV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiESV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F60338A5;
        Thu, 19 May 2022 14:57:01 -0700 (PDT)
Date:   Thu, 19 May 2022 21:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdWuXze9gcxL84bfrGVJBQzWPBrU68xlmX5mr1x0iSs=;
        b=bZP5qKSBWuUco8qx2FX96jMkP5AFp4uqJr6bhr1C6MUYPY6sF9Hxc4kXViTNIraWAnR1qn
        sNYBd+WS9ua9NCoN4R6g7Ib6jA4fmMj6RZI4up0K1fsSwJkUlzMWfML1KktGJg5VhQ6BTk
        pLcdrOIW8aGr3q+Jn2GSW8Xx9olMrX8blYW7e1kuWgsiYujKAXCoNGmKvOuYK7z7Ar3xeQ
        b3seeTKrUUwYGepWVPYBLt8wt1wOo6xkAHVpOAOAg6nMhu7rnY2w0zSfk2QdWauvz7wjen
        M5PAuoqPT1Q6w0Jha8pQ1Pn4FORPreO84IRLBaklDVEklaX9weD/rKCB2fJKHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdWuXze9gcxL84bfrGVJBQzWPBrU68xlmX5mr1x0iSs=;
        b=/c4IOQQQ4/qMaUlrUypLvick6pgDEU+lyQP0QFjv3zrJAmtFLsAri33jE6rL7qIKTmvn2c
        SzzV40s31wd45tCg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Fix reloading events for SVM
Cc:     Like Xu <likexu@tencent.com>, Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220518084327.464005-1-sandipan.das@amd.com>
References: <20220518084327.464005-1-sandipan.das@amd.com>
MIME-Version: 1.0
Message-ID: <165299741919.4207.12319617114014672063.tip-bot2@tip-bot2>
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

Commit-ID:     bae19fdd7e9e759580ac4693d2df3bc23ab415d7
Gitweb:        https://git.kernel.org/tip/bae19fdd7e9e759580ac4693d2df3bc23ab415d7
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Wed, 18 May 2022 14:13:27 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:14 +02:00

perf/x86/amd/core: Fix reloading events for SVM

Commit 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only
counting with SVM disabled") addresses an issue in which the
Host-Only bit in the counter control registers needs to be
masked off when SVM is not enabled.

The events need to be reloaded whenever SVM is enabled or
disabled for a CPU and this requires the PERF_CTL registers
to be reprogrammed using {enable,disable}_all(). However,
PerfMonV2 variants of these functions do not reprogram the
PERF_CTL registers. Hence, the legacy enable_all() function
should also be called.

Fixes: 9622e67e3980 ("perf/x86/amd/core: Add PerfMonV2 counter control")
Reported-by: Like Xu <likexu@tencent.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220518084327.464005-1-sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 3eee59c..9ac3718 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1472,6 +1472,24 @@ __init int amd_pmu_init(void)
 	return 0;
 }
 
+static inline void amd_pmu_reload_virt(void)
+{
+	if (x86_pmu.version >= 2) {
+		/*
+		 * Clear global enable bits, reprogram the PERF_CTL
+		 * registers with updated perf_ctr_virt_mask and then
+		 * set global enable bits once again
+		 */
+		amd_pmu_v2_disable_all();
+		amd_pmu_enable_all(0);
+		amd_pmu_v2_enable_all(0);
+		return;
+	}
+
+	amd_pmu_disable_all();
+	amd_pmu_enable_all(0);
+}
+
 void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1479,8 +1497,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
-	amd_pmu_disable_all();
-	x86_pmu_enable_all(0);
+	amd_pmu_reload_virt();
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
 
@@ -1497,7 +1514,6 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	/* Reload all events */
-	amd_pmu_disable_all();
-	x86_pmu_enable_all(0);
+	amd_pmu_reload_virt();
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
