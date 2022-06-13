Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642754820D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiFMI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiFMI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786B1571F;
        Mon, 13 Jun 2022 01:29:04 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrgTuj74HZbeRJdHYseIE+vNioY1epVUCxAMotoFmZw=;
        b=jdlfHLi4wpm7Lgsz0r5ibqg954tUIorZylMjP9jK++P5fMnP5NLy4T7K7g4T40aC4qDpf4
        G8cfWZ2yLytJpgEt+l++Ok43MFywug4tkCP5OecbkHEpjJ1xAAw+uq0bCV9SR1pmPvebIy
        hu8ridS5hKU6CtOH3JgZIjXsvu3+enwOVu6n3tDkvWFDdj5IhFsFTtxqxFEDZol5VKBoLw
        buNRCNgLv6Y2An+RFr0jHx+/61U2/YxICI/uhkuHRt+Fp3swHwjP73i/LQLVaWIA2WtGCL
        P4/9oP9aMhdafWCTTxyGM6JkT1HHh3aEAQOrZ30AOJW8f6LRm6IM3puM2Txs9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrgTuj74HZbeRJdHYseIE+vNioY1epVUCxAMotoFmZw=;
        b=xK7Iu7EhIzEtWjohy7P+0ROgci3CYQxx6+WuW6Lj/BF5Ia1FAaPdHX2y/HjNzSO0zMpH6j
        Py4vPFzfCoYBVUDg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Add PerfMonV2 RDPMC assignments
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1359379ef34da760f108b075ac138ab082caa3ba=2E16529?=
 =?utf-8?q?54372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C1359379ef34da760f108b075ac138ab082caa3ba=2E165295?=
 =?utf-8?q?4372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165510894163.4207.7762129989742173982.tip-bot2@tip-bot2>
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

Commit-ID:     f0fe9f3c7abcc946a676dfb295478c50312523c2
Gitweb:        https://git.kernel.org/tip/f0fe9f3c7abcc946a676dfb295478c50312523c2
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 19 May 2022 15:33:34 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:14 +02:00

perf/x86/amd/uncore: Add PerfMonV2 RDPMC assignments

The current RDPMC assignment scheme maps four DF PMCs and
six L3 PMCs from index 6 to 15.

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, there may be additional DF counters available
which are mapped starting from index 16 i.e. just after
the L3 counters. Update the RDPMC assignments accordingly.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/1359379ef34da760f108b075ac138ab082caa3ba.1652954372.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ff4238e..d568afc 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -158,6 +158,16 @@ out:
 	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
+	/*
+	 * The first four DF counters are accessible via RDPMC index 6 to 9
+	 * followed by the L3 counters from index 10 to 15. For processors
+	 * with more than four DF counters, the DF RDPMC assignments become
+	 * discontiguous as the additional counters are accessible starting
+	 * from index 16.
+	 */
+	if (is_nb_event(event) && hwc->idx >= NUM_COUNTERS_NB)
+		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
+
 	if (flags & PERF_EF_START)
 		amd_uncore_start(event, PERF_EF_RELOAD);
 
